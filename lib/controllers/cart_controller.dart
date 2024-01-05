import 'dart:convert';
import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:citymall/constants.dart';
import 'package:citymall/controllers/dashboard_controller.dart';
import 'package:citymall/controllers/product_controller.dart';
import 'package:citymall/dialog/dialog.dart';
import 'package:citymall/dialog/loading_dialog.dart';
import 'package:citymall/models/cart_model.dart';
import 'package:citymall/models/coupon.dart';
import 'package:citymall/models/dicount_rule.dart';
import 'package:citymall/models/get_api_response_model.dart';
import 'package:citymall/models/product.dart';
import 'package:citymall/service/api_service.dart';
import 'package:citymall/service/setting_service.dart';
import 'package:citymall/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class CartController extends GetxController {
  var cart_count = 0.obs;

  var cart_amount = 0.0.obs;
  /***inclusive of tax and all product combo,bulk discout**/
  var cart_amount_without_offer = 0.0.obs;
  var total_tax = 0.0.obs;
  var isDeleting=false.obs;
  Rx<int?> isDeletingItemId=(null as int?).obs;
  var isUpdatingCart=false.obs;

  var offer_discount = 0.0.obs;
  var cart_level_discount = 0.0.obs;
  var shipping_discount = 0.0.obs;
  /***roduct Discount rule* wale***/
  var current_timestamp = DateTime.now().millisecondsSinceEpoch.obs;
  /***bulk discount rules wale***/
  var total_saving = 0.0.obs;
  var cart_updated = false.obs;
  var is_coupon_code_applied = false.obs;
  var coupon_code_applied = (null as String?).obs;
  var applicable_offers = <Map<String, dynamic>>[].obs;
  var applied_coupon_names = <Map<String, dynamic>>[].obs;
  /****includes all plied couon names including automatic****/
  TextEditingController couponCodeInputController = TextEditingController();

  Rx<Coupon?> applied_coupon = (null as Coupon?).obs;
  /***Used when clicked on one of the list***/
  var applied_coupon_code_response_tex = ''.obs;
  var isApplyginCoupon = false.obs;
  var delivery_charge = 0.0.obs;
  var cart_session_id = (null as String?).obs;
  var current_cart_offer_text = (null as String?).obs;
  var is_removing_coupon = false.obs;
  RxList<Map<String, dynamic>> offerDiscountAr = <Map<String, dynamic>>[].obs;
  RxList<CartItem> cart = <CartItem>[].obs;
  @override
  void onInit() async {
    super.onInit();
    everAll([isUpdatingCart,isDeleting,isApplyginCoupon],(_)=>do1());

    SettingService settingService = Get.find();
    delivery_charge.value = settingService.setting != null
        ? settingService.setting!['delivery_charge'].runtimeType == String
            ? double.parse(settingService.setting!['delivery_charge'])
            : settingService.setting!['delivery_charge'].toDouble()
        : 0.0;

    await fetchCartData();
  }
 void do1(){
    if(isUpdatingCart.value || isDeleting.value)
      LoadingDialog('Updating Cart');
    else if(isApplyginCoupon.value) {
      LoadingDialog('Applying Coupon');
    }
    else
      Navigator.of(Get.context as BuildContext, rootNavigator: true).pop('dialog');
}

  void updateCart(
      Product product, int qty, String mode, Variants? variant) async {

    String imageBase = '${baseUrl}/storage/products/${product.id}';

    String image ='${imageBase}/thumbnail/${product.thumbnail?.tiny}';

    double cart_amount_val = 0;
    bool item_exist_in_cart = false;
    if (variant != null) {
      if (cart.where((element) {
        return element.productId == product.id! &&
            element.variantId == variant.id!;
      }).isNotEmpty) {
        item_exist_in_cart = true;
      }
    } else {
      if (cart
          .where((element) => element.productId == product.id!)
          .isNotEmpty) {
        item_exist_in_cart = true;
      }
    }


    if (!item_exist_in_cart) {
      double price = variant != null ? variant.price! : product.price!;
      double sale_price =
          variant != null ? variant.salePrice! : product.salePrice!;
      CartItem item = CartItem(
          productId: product.id!,
          cartSessionId: cart_session_id.value,
          name: product.name!,
          variantId: variant?.id,
          categoryId: product.categoryId!,
          variantName: variant?.name,
          numOfItem: qty,
          price: price,
          salePrice: sale_price,
          sgst: product.sgst != null ? (product.sgst!) : 0,
          cgst: product.cgst != null ? (product.cgst!) : 0,
          image: image,
          maxQtyAllowed: product.maxQuantityAllowed,
          unit: product.unit != null ? product.unit! : 'Pcs',
          igst: product.igst != null ? (product.igst!) : 0,
          discountType: product.discountType,
          discount: product.discount,
          netCartAmount: 0,
          totalDiscount: 0);

      await saveCartToServer(item);
    } else {



      int index =variant==null
          ? cart.indexWhere((el) => el.productId == product.id!)
         :cart.indexWhere((el) => el.productId == product.id! && el.variantId==variant.id!);

      CartItem found = cart[index];
      int prev = found.numOfItem;
      if (mode == 'plus')
        prev += 1;
      else
        prev -= 1;
      if (prev < 0) prev = 0;
      if (prev == 0) {
        deleteCartItem(index);
      } else {

        found.numOfItem = prev;
        cart[index] = found;
        await saveCartToServer(found);
      }
    }
  }

  void updateCartQty(
      int product_id, int qty, String mode, int? variantId) async {
    int index = variantId == null
        ? cart.indexWhere((el) => el.productId == product_id)
        : cart.indexWhere(
            (el) => el.productId == product_id && el.variantId == variantId);
    CartItem found = cart[index];
    int prev = found.numOfItem;
    if (mode == 'plus')
      prev += 1;
    else
      prev -= 1;
    if (prev < 0) prev = 0;
    if (prev == 0) {
      deleteCartItem(index);
    } else {
      found.numOfItem = prev;
      cart[index] = found;
      await saveCartToServer(found);
    }
  }

  saveCartToServer(CartItem item) async {
    isUpdatingCart(true);

    UserService userService = Get.find();

    bool showOfferSnackbar = item.productDiscountOfferDetail == null;
    Map<String, dynamic> post = item.toJson();
    post['email'] = userService.user?.email;
    post['phone'] = userService.user?.phone_number;
    ApiService.postRequest(
        ApiResponseType.Unformatted, '/save_cart', post, null, (res) {

      setCartScreen(res);
      isUpdatingCart(false);

      Get.snackbar(
        snackPosition: SnackPosition.BOTTOM,
        "Success!",
        'Cart Updated Successfully',
        colorText: Colors.white,
        backgroundColor: Colors.green,
        icon: const Icon(Icons.check_circle),
      );
    }, (res){
      isUpdatingCart(false);
    }, showRequestDetail: false);
  }

  deleteCartItem(int index) async {
    isDeleting(true);
    CartItem item = cart[index];
    isDeletingItemId.value=item.id!;
    ApiService.deleteRequest(ApiResponseType.Unformatted,'/cart/${item.id}', (res) {


      Get.delete<DashboardController>();
      cart.removeAt(index);
      //setCartAmountAndCount();
      Get.put<DashboardController>(DashboardController());
      isDeleting(false);
      setCartScreen(res);
      Get.snackbar(snackPosition:SnackPosition.BOTTOM,
        "Success",
        'Item deleted successfully',
        colorText: Colors.white,
        backgroundColor: Colors.green,
        icon: const Icon(Icons.check_circle),
      );
    }, (res){
      isDeleting(false);
    }, showRequestDetail: false);
  }

  Future<void> fetchCartData() async {
    UserService userService = Get.find();

    ApiService.postRequest(
        ApiResponseType.Unformatted,
        '/cart',
        {
          'email': userService.user?.email,
          'phone': userService.user?.phone_number
        },
        null, (res) {
      setCartScreen(res);
    }, null);
  }

  setCartScreen(var res) {
     if (cart.isNotEmpty) cart.clear();
    applicable_offers.clear();
    if (res['applicable_offers'] != null) {
      for (var s in res['applicable_offers']) {
        applicable_offers.add(s as Map<String, dynamic>);
      }
    }
    if (res['minimum_cart_amount_offer'] != null) {
      Map<String, dynamic> cur_cart_offer =
          res['minimum_cart_amount_offer'] as Map<String, dynamic>;
      var discount = cur_cart_offer['discount'];
      var discount_type = cur_cart_offer['discount_type'];
      var coupon_type = cur_cart_offer['coupon_type'];
      String dis_txt = cur_cart_offer['discount_type'] == 'Percent'
          ? '${cur_cart_offer['discount']}%'
          : 'Flat ${currency}${cur_cart_offer['discount']}';
      if (coupon_type == 'Automatic') {
        current_cart_offer_text.value =
            'Add ${currency}${cur_cart_offer['target_amount']} worth more items to get automatic discount of ${dis_txt}';
      } else {
        current_cart_offer_text.value =
            'Add ${currency}${cur_cart_offer['target_amount']} worth more items to get discount of ${dis_txt} using Coupon code ${cur_cart_offer['coupon_code']}';
      }
    } else
      current_cart_offer_text.value = null;

    var cart_data = (res['data'] as List).map((e) => e as Map<String, dynamic>).toList();

   var cart_d = res['cart_discount'];

    if (cart_d !=null) {
      cart_level_discount.value =
          cart_d.runtimeType == int ? cart_d.toDouble() : (cart_d.runtimeType == String?double.parse(cart_d):cart_d);

      offer_discount.value += cart_level_discount.value;
    }

    var ship_d = res['shipping_discount'];
   //  var ship_d= res['shipping_discount'].runtimeType == int ? res['shipping_discount'].toDouble()
   //      : (res['shipping_discount'].runtimeType == String?double.parse(res['shipping_discount']):res['shipping_discount']);
     if (ship_d !=null) {
       shipping_discount.value =ship_d.runtimeType == int ? ship_d.toDouble() : (ship_d.runtimeType == String?double.parse(ship_d):ship_d);


     }

    for (var json in cart_data) {
      List<String> keys = (json.keys).toList();
      // keys.forEach((element) {
      //   print(element);
      //   print(json[element].runtimeType);
      // });
      CartItem cartItem = CartItem.fromJson(json);
      if (cart_session_id.value == null)
        cart_session_id.value = cartItem.cartSessionId;
      cart.add(cartItem);
    }
    cart.refresh();

    applied_coupon_names.clear();
    if (res['applied_coupons'] != null) {
      for (var s in res['applied_coupons']) {
        applied_coupon_names.add(s as Map<String, dynamic>);
      }
    }
    setCartAmountAndCount();
  }

  setCartAmountAndCount() {
    double local_cart_amount_without_offer = 0;
    double local_cart_amount = 0;
    double local_discount = 0;
    double local_tax = 0;

    cart.forEach((el) {
      if (cart_session_id.value == null)
        cart_session_id.value = el.cartSessionId;
      local_discount += el.totalDiscount!;
      local_cart_amount += el.netCartAmount!;
      local_tax += el.totalTax!;
      local_cart_amount_without_offer += el.price * el.numOfItem;
    });

    cart_amount.value = local_cart_amount;
    /***inclusive of tax and all product combo,bulk discout,dont add tax ,but add delivery charge later **/
    cart_amount_without_offer.value = local_cart_amount_without_offer;
    offer_discount.value = local_discount;
    total_tax.value = local_tax;
    cart_count.value = cart.length;
  }

  checkProductQtyInCart(int productId, int? variantId) {
    int count = 0;
    cart.forEach((item) {
      if (variantId != null) {
        if (item.productId == productId && item.variantId == variantId)
          count += item.numOfItem;
      } else {
        if (item.productId == productId) count += item.numOfItem;
      }
    });
    return count;
  }

  applyCouponCode(String cartSessionId) async {
    String couponCode = couponCodeInputController.text.trim();
    if (couponCode.isEmpty && cartSessionId.isEmpty) return;
    isApplyginCoupon(true);
    UserService userService = Get.find();

    var post = {
      'cart_session_id': cartSessionId,
      'coupon_code': couponCode,
      'email': userService.user?.email,
      'phone': userService.user?.phone_number
    };

    ApiService.postRequest(
        ApiResponseType.Unformatted, '/applyCouponCode', post, null, (res) {
      setCartScreen(res);
      isApplyginCoupon(false);
      is_coupon_code_applied(false);
      showAlertDialog(Get.context as BuildContext, DialogType.success,
          res['coupon_response'], 'Success', null);
      coupon_code_applied.value = couponCode;
      couponCodeInputController.text = '';

    }, (res){
      isApplyginCoupon(false);
    });
    // isApplyginCoupon(false);
  }

  applyCoupon(String couponCode, String cartSessionId) async {
    if (couponCode.isEmpty && cartSessionId.isEmpty) return;
    UserService userService = Get.find();
    isApplyginCoupon(true);
    var post = {
      'cart_session_id': cartSessionId,
      'coupon_code': couponCode,
      'email': userService.user?.email,
      'phone': userService.user?.phone_number
    };

    ApiService.postRequest(
        ApiResponseType.Unformatted, '/applyCouponCode', post, null, (res) {
      setCartScreen(res);
      isApplyginCoupon(false);
      coupon_code_applied.value = couponCode;
      showAlertDialog(Get.context as BuildContext, DialogType.success,
          res['coupon_response'], 'Success', () {

        Get.back();
      });
    },(res){
      isApplyginCoupon(false);
    });
    // isApplyginCoupon(false);
  }

  removeCoupon(String cartSessionId) async {
    String couponCode = couponCodeInputController.text.trim();
    if (couponCode.isEmpty && cartSessionId.isEmpty) return;
    is_removing_coupon(true);
    UserService userService = Get.find();

    var post = {
      'cart_session_id': cartSessionId,
      'coupon_code': coupon_code_applied.value,
      'email': userService.user?.email,
      'phone': userService.user?.phone_number
    };

    ApiService.postRequest(
        ApiResponseType.Unformatted, '/removeCoupon', post, null, (res) {

      setCartScreen(res);
      print(res['cart_discount']);
      is_coupon_code_applied(false);

      coupon_code_applied.value = null;

      is_removing_coupon(false);
      showAlertDialog(Get.context as BuildContext, DialogType.success,
          'Coupon removed successfully', 'Success', null);
    }, (res){
      is_removing_coupon(false);
    });
    // is_removing_coupon(false);
  }
}
