import 'dart:convert';
import 'package:citymall/constants.dart';
import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/controllers/order_controller.dart';
import 'package:citymall/models/get_api_response_model.dart';
import 'package:citymall/models/user_model.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/service/api_service.dart';
import 'package:citymall/service/setting_service.dart';
import 'package:citymall/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentController extends GetxController {
  var payment_amount = 0.0.obs;
  var user_id = 0.obs;
  var razorpay_order_id = 0.obs;
  String? table_orderId;

  late Razorpay razorpay;
  Rx<UserModel?> user = (null as UserModel?).obs;
  late Box<UserModel> userBox;
  @override
  Future<void> onInit() async {
    super.onInit();
    razorpay = Razorpay();
    print('afain called init ');
    // checkoutPro = PayUCheckoutProFlutter(this as PayUCheckoutProProtocol);
    //
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  makePayment(double amount, String orderId, int normal_order_id) {
    UserService us = Get.find();
    SettingService sv = Get.find();
    table_orderId = normal_order_id.toString();
    var options = {
      'key': sv.setting!['razor_pay_api_key'],
      'amount': sv.setting!['razor_pay_live'] == 'Yes' ? amount * 100 : 100,
      'name': 'Online Mart & Gift Hub',
      'description': 'Online order',
      "order_id": orderId,
      'prefill': {'contact': us.user?.phone_number, 'email': us.user?.email}
    };

    razorpay.open(options);
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse rz_response) async {
    print('payment success');
    print({
      'payment_id': rz_response.paymentId,
      'order_id': table_orderId,
      'razor_order_id': rz_response.orderId,
      'signature': rz_response.signature
    });
    var body = {
      'payment_id': rz_response.paymentId,
      'order_id': table_orderId,
      'razor_order_id': rz_response.orderId,
      'signature': rz_response.signature
    };
    ApiService.postRequest(
        ApiResponseType.Unformatted, '/storePayment', body, null, (res) {
      var result = res['data'];
      print('after payment store resp response dat');
      print(res);

      Get.delete<CartController>();
      Get.delete<OrderController>();
      Get.lazyPut(() => CartController());
      Get.lazyPut(() => OrderController());

      Get.toNamed(AppRoutes.order_success);
    }, (res) {
      print(res.message);
      print('payment seems to be flawd or fraud');
      Get.toNamed(AppRoutes.order_failed);
    }, showRequestDetail: true);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print('failure');
    print(response.message);
    Get.toNamed(AppRoutes.order_failed);
  }

  void _handleExternalWallet(ExternalWalletResponse rz_response) async {
    print('external wallet');
    print(rz_response.walletName);

    var body = {
      'order_id': table_orderId,
      'walet_name': rz_response.walletName
    };

    ApiService.postRequest(
        ApiResponseType.Unformatted, '/storePayment', body, null, (res) {
      var result = res['data'];
      print('after payment store resp response dat');
      print(res);

      Get.delete<CartController>();
      Get.delete<OrderController>();
      Get.lazyPut(() => CartController());
      Get.lazyPut(() => OrderController());

      Get.toNamed(AppRoutes.order_success);
    }, (res) {
      print(res.message);
      print('payment seems to be flawd or fraud');
      Get.toNamed(AppRoutes.order_failed);
    }, showRequestDetail: true);
  }
}
