import 'dart:convert';
import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:citymall/constants.dart';
import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/controllers/payment_controller.dart';
import 'package:citymall/dialog/dialog.dart';
import 'package:citymall/dialog/loading_dialog.dart';
import 'package:citymall/models/cart_model.dart';
import 'package:citymall/models/coupon.dart';
import 'package:citymall/models/get_api_response_model.dart';
import 'package:citymall/models/product.dart';
import 'package:citymall/models/user_model.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/service/api_service.dart';
import 'package:citymall/service/setting_service.dart';
import 'package:citymall/service/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

class OrderController extends GetxController {
  // PaymentController pc = Get.put(PaymentController());
  UserService userService = Get.find();
  SettingService settingService = Get.find();
  var showDialog = false.obs;
  var isOrderListLoading = false.obs;
  var status = 'Pending'.obs;
  var isCancellingOrder = false.obs;
  var cancelled_order_id = 0.obs;
  var current_timestamp = DateTime.now().millisecondsSinceEpoch.obs;
  var payment_method = 'COD'.obs;
  var total_cart_level_discount = 0.0.obs;
  Rx<Coupon?> applied_coupon = (null as Coupon?).obs;
  var coupon_discount = 0.0.obs;
  var pending_order_count = 0.obs;
  var slot_time = (null as String?).obs;
  TextEditingController slotDateInput = TextEditingController();
  RxList<Map<String, dynamic>> cart_level_discounts =
      <Map<String, dynamic>>[].obs;
  TextEditingController addressController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController alternatePhoneController = TextEditingController();
  var net_payable = 0.0.obs;
  RxMap<String, dynamic> single_order = <String, dynamic>{}.obs;
  RxMap<String, dynamic> any_current_pending_order = <String, dynamic>{}.obs;
  var single_order_id = 2.obs;
  var shipping_cost = 0.0.obs;
  var isSaving = false.obs;
  RxList<Map<String, dynamic>> order_list = <Map<String, dynamic>>[].obs;
  @override
  void onInit() async {
    super.onInit();
    shipping_cost.value = settingService.setting != null
        ? double.parse(settingService.setting!['delivery_charge'])
        : 0.0;
    //  ever(applied_coupon, (_) => calculateCouponDiscount());
    ever(status, (_) => fetchOrders(status.value));
    ever(single_order_id,
        (_) => fetchSingleOrder(single_order_id.value.toString()));
    //fetchCartLevelOffers();
    fetchOrders(status.value);
    ever(isCancellingOrder,(_)=>do1());

  }
  void do1(){
    if(isCancellingOrder.value)
      LoadingDialog('Cancelling Order');

    else
      Navigator.of(Get.context as BuildContext, rootNavigator: true).pop('dialog');
  }

  String getFormattedDate(String date) {
    /// Convert into local date format.
    var localDate = DateTime.parse(date).toLocal();

    /// inputFormat - format getting from api or other func.
    /// e.g If 2021-05-27 9:34:12.781341 then format must be yyyy-MM-dd HH:mm
    /// If 27/05/2021 9:34:12.781341 then format must be dd/MM/yyyy HH:mm
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());

    /// outputFormat - convert into format you want to show.
    var outputFormat = DateFormat('dd-MM-yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  saveOrderToServer() async {
    CartController cartController = Get.find();
    if (slot_time.value == null || slotDateInput.text == null) {
      return showAlertDialog(Get.context as BuildContext, DialogType.error,
          'Please select date and slot of delivery', "Error", null);
    }
    List<int> cartIds = [];
    isSaving(true);
    cartController.cart.forEach((el) {
      if (el.id != null) cartIds.add(el.id!);
    });
    String? cart_session_id = cartController.cart[0].cartSessionId;

    var body = {
      'cart_session_id': cart_session_id,
      'email': userService.user?.email,
      'phone': userService.user?.phone_number,
      'payment_method': payment_method.value,
      'slot_time': slot_time.value,
      'slot_date': slotDateInput.text.trim(),
      'shipping_discount': (cartController.shipping_discount.value).toString(),
      'cart_level_discount':
          (cartController.cart_level_discount.value).toString()
    };
    ApiService.postRequest(ApiResponseType.Unformatted, '/order', body, null,
        (res) {
      isSaving(false);

      if (payment_method.value == 'Online') {
        PaymentController pc=Get.put(PaymentController());
        pc.makePayment(
           net_payable.value, res['data']['orderId'], res['data']['table_order_id']);
      } else {
        Get.delete<CartController>();
        Get.delete<OrderController>();
        Get.lazyPut(()=>CartController());
        Get.lazyPut(()=>OrderController());

        Get.toNamed(AppRoutes.order_success);
      }
      isSaving(false);
    }, (res) {
      isSaving(false);
    }, showRequestDetail: false);
  }

  cancelOrder(int id) async {
    var body = {
      'id': id.toString(),
      'email': userService.user?.email,
      'phone': userService.user?.phone_number,
    };
    isCancellingOrder(true);
    ApiService.postRequest(
        ApiResponseType.PlainString, '/order_cancel', body, null, (res) {
      isCancellingOrder(false);
      OrderController oc=Get.find();
      oc.single_order_id.value=id;
      cancelled_order_id.value = id;
    }, (res){
      isCancellingOrder(false);
    }, showRequestDetail: false);
  }

  updateShipping() async {
    String address = addressController.text.trim().toString();
    String pin = pinController.text.trim().toString();
    String alternatePhone = alternatePhoneController.text.trim().toString();

    var body = {
      'address': address,
      'pin': pin,
      'alternatePhone': alternatePhone
    };

    ApiService.postRequest(
        ApiResponseType.SingleRow, '/shipping', body, null, (res) {}, null,
        showRequestDetail: false);
  }


  fetchOrders(String? status1) async {
    isOrderListLoading(true);
    var body = {
      'email': userService.user?.email,
      'phone': userService.user?.phone_number,
      'status': status1
    };

    ApiService.postRequest(
        ApiResponseType.MultipleRow, '/order_history', body, null, (res) {
      order_list.clear();
      for (var json in res) {
        order_list.add(json);
      }
      order_list.refresh();
      isOrderListLoading(false);
      pending_order_count.value= order_list.where((c) => ['Out For Delivery','Order Placed'].contains(c['delivery_status'])).length;
      //if (status == 'Pending') pending_order_count.value = order_list.length;
    }, (res){
      isOrderListLoading(false);
    }, showRequestDetail: false);
  }

  fetchSingleOrder(String orderid) async {
    ApiService.getRequest(ApiResponseType.SingleRow, '/orders/' + orderid,
        (res) {
      single_order.value = res;

      List<dynamic> statuses =
          jsonDecode(single_order.value['order_delivery_updates']);

      List<Map<String, dynamic>> items = [];
      single_order.value['items'] = single_order.value['items']
          .map((e) => e as Map<String, dynamic>)
          .toList();
      single_order.value['user'] =
          single_order.value['user'] as Map<String, dynamic>;
      single_order.value['driver'] = single_order.value['driver_id'] != null
          ? single_order.value['driver'] as Map<String, dynamic>
          : null;
      single_order.value['order_delivery_updates'] =
          statuses.map((e) => e as Map<String, dynamic>).toList();
    }, null, showRequestDetail: false);
  }
}
