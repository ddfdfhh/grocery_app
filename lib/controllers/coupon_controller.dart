import 'dart:convert';
import 'dart:developer';

import 'package:citymall/constants.dart';
import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/models/cart_model.dart';
import 'package:citymall/models/coupon.dart';
import 'package:citymall/models/get_api_response_model.dart';
import 'package:citymall/models/product.dart';
import 'package:citymall/models/user_model.dart';
import 'package:citymall/service/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';

class CouponController extends GetxController {
  RxList<Coupon> coupons = <Coupon>[].obs;
  RxList<Coupon> automatic_coupons = <Coupon>[].obs;
  Rx<Coupon?> selectedCoupon = (null as Coupon?).obs;
  Rx<Coupon?> frontCoupon = (null as Coupon?).obs;
  @override
  void onInit() async {
    super.onInit();
    //ever(cart_level_discounts,calculateOfferDiscount());
    fetchCoupons();
  }

  selectCoupon(Coupon c) {
    selectedCoupon.value = c;

  }

  Coupon? couponForFrontDashboard() {
    int index = coupons.indexWhere((el) => el.showInFront == 'Yes');

    return index > 0 ? coupons[index] : null;
  }

  fetchCoupons() async {

    ApiService.getRequest(ApiResponseType.MultipleRow, '/coupons',
        (res) {

      for (var json in res) {
        Coupon coupon = Coupon.fromJson(json);

        if(coupon.discountMethod=='Automatic')
        automatic_coupons.add(coupon);
        else
          coupons.add(coupon);

      }

      coupons.refresh();
      automatic_coupons.refresh();

      if (coupons.isNotEmpty) {
        int index = coupons.indexWhere((el) => el.showInFront == 'Yes');
        if(index>-1)
        frontCoupon.value = coupons[index];
      }
      else{
        if (automatic_coupons.isNotEmpty) {
          int index = automatic_coupons.indexWhere((el) => el.showInFront == 'Yes');
          if(index>-1)
          frontCoupon.value = automatic_coupons[index];
        }
      }
    }, null, showRequestDetail: false);
  }
}
