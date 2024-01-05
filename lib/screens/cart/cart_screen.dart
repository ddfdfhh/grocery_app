import 'package:citymall/bottom_sheets/applied_list_sheet.dart';
import 'package:citymall/bottom_sheets/offer_list_sheet.dart';
import 'package:citymall/common_widgets/app_button.dart';
import 'package:citymall/components/button.dart';
import 'package:citymall/constants.dart';
import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/controllers/coupon_controller.dart';
import 'package:citymall/controllers/network_controller.dart';
import 'package:citymall/controllers/product_controller.dart';
import 'package:citymall/models/cart_model.dart';
import 'package:citymall/models/coupon.dart';
import 'package:citymall/models/grocery_item.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/service/setting_service.dart';
import 'package:citymall/util.dart';
import 'package:citymall/widgets/badge.dart';
import 'package:citymall/widgets/cart_item_widget.dart';
import 'package:citymall/widgets/nointernet.dart';
import 'package:citymall/widgets/offer_discounts_row.dart';
import 'package:citymall/widgets/outlined_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../styles/theme.dart';
import 'checkout_bottom_sheet.dart';

class CartScreen extends StatelessWidget {
  CartController cartController = Get.put(CartController());
  CouponController couponController = Get.put(CouponController());
  ProductController productController = Get.find();
  // SettingService settingService = Get.find();
  @override
  Widget build(BuildContext context) {
    NetworkController nc = Get.find();
    return Obx(() => nc.hasConnection.value
        ? Scaffold(
            bottomNavigationBar: getOrderPlaceButton(context),
            appBar: AppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              )),
              elevation: 0,
              foregroundColor: Colors.white,
              title: Text(
                "My Cart",
              ),
              centerTitle: true,
              leading: InkWell(
                  onTap: () {
                    productController.current_timestamp.value =
                        DateTime.now().millisecondsSinceEpoch;
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back)),
            ),
            body: SafeArea(
              child: Obx(() => cartController.cart.isEmpty
                  ? Center(child: const Text('Cart is empty'))
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          if (cartController.cart_level_discount.value > 0)
                            CartOfferAppliedMessage(context,
                                '${currency}${cartController.cart_level_discount.value} discount applied on cart amount as per offer'),
                          if (cartController.shipping_discount.value > 0)
                            CartOfferAppliedMessage(context,
                                '${currency}${cartController.shipping_discount.value} discount applied on delivery charge as per offer'),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cartController.cart.length,
                              itemBuilder: (BuildContext context, int index) {
                                CartItem e = cartController.cart[index];
                                return CartItemWidget(
                                    context,
                                    e,
                                    (mode, qty) {
                                      cartController.updateCartQty(
                                          e.productId!, qty, mode, e.variantId);
                                    },
                                    index,
                                    () {
                                      cartController.deleteCartItem(index);
                                    });
                              }),
                          if (couponController.coupons.isNotEmpty) ...[
                            SizedBox(height: 10),
                            if (cartController.coupon_code_applied.value ==
                                null)
                              Container(
                                  child: Card(
                                color: Colors.grey.shade100,
                                child: ApplyCoupon(context, cartController),
                              ))
                            else
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.lightGreen.shade50,
                                      border: Border.all(
                                          width: 1, color: Colors.green)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text('Code'),
                                                SizedBox(width: 5),
                                                Text(
                                                    '${cartController.coupon_code_applied.value}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15)),
                                                SizedBox(width: 5),
                                                Text('Applied Successfully'),
                                              ],
                                            ),
                                            if (!cartController
                                                .is_removing_coupon.value)
                                              InkWell(
                                                  onTap: () {
                                                    cartController.removeCoupon(
                                                        cartController
                                                            .cart_session_id
                                                            .value!);
                                                  },
                                                  child: Text('Remove',
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          color: Colors.red)))
                                            else
                                              const CircularProgressIndicator()
                                          ])
                                    ],
                                  )),
                            SizedBox(height: 10),
                            if (cartController.coupon_code_applied.value ==
                                null && cartController
                                .applicable_offers.value.isEmpty && (couponController.coupons.isNotEmpty || couponController.automatic_coupons.isNotEmpty))
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.coupons);
                                    //OfferListDetailSheet(context, cartController.applicable_offers.value);
                                  },
                                  child: Text('Coupons Available',
                                      textAlign: TextAlign.right,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                              decoration:
                                                  TextDecoration.underline,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red)),
                                ),
                              )
                          ],
                          if (cartController.current_cart_offer_text.value !=
                              null)
                            Container(
                                padding: EdgeInsets.all(11),
                                margin: EdgeInsets.all(5),
                                color: Colors.orange.shade100,
                                //height: 10,
                                child: Text(
                                    '${cartController.current_cart_offer_text.value}',
                                    style: AppTheme(context: context)
                                        .textTheme['titleMediumBoldBlack'])),

                          if (cartController
                              .applicable_offers.value.isNotEmpty) ...[
                            SizedBox(height: 10),
                            InkWell(
                              onTap: () {
                                OfferListDetailSheet(context,
                                    cartController.applicable_offers.value);
                              },
                              child: Text('View Applicable Offers',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red)),
                            )
                          ],

                          BillingDetail(context),
                          //getCheckoutButton(context)
                        ],
                      ),
                    )),
            ),
          )
        : NoInternet(context));
  }

  Widget getOrderPlaceButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.grey, blurRadius: 5, spreadRadius: 0)
                ],
                color: AppTheme(context: context).colors['primary'],
                borderRadius: BorderRadius.circular(20)),
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextButton.icon(
                onPressed: () {
                  Get.toNamed(AppRoutes.checkout);
                },
                icon: Text('Checkout',
                    style: AppTheme(context: context)
                        .textTheme['titleLargeWhite']),
                label: Icon(Icons.keyboard_double_arrow_right,
                    color: Colors.white))));
  }

  Widget getButtonPriceWidget() {
    CartController cartController = Get.find();
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Color(0xff489E67),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Obx(() => Text(
            "${currency}${cartController.cart_amount}",
            style: TextStyle(fontWeight: FontWeight.w600),
          )),
    );
  }

  Widget BillingDetail(BuildContext context) {
    CartController cartController = Get.find();

    double offerDiscount = cartController.offer_discount.value;
    /***Product Discount rule**/

    double totalTax = cartController.total_tax.value;
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Billing Details",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Obx(() => Card(
                  child: Column(children: [
                if (cartController.applied_coupon_names.value.isNotEmpty)
                  OfferAppliedWidget(context),
                BillingRow(
                    context,
                    "Price(${cartController.cart_count.value} items)",
                    '${currency}${cartController.cart_amount_without_offer.value}'),
                Divider(),
                BillingRowOffer(context, "Offer Discount",
                    '${'-'} ${currency}${offerDiscount}'),
                Divider(),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Cart Amount",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          Text(
                              "${currency}${substract(cartController.cart_amount.value, cartController.cart_level_discount.value)}",
                              style: AppTheme(context: context)
                                  .textTheme['titleLargeBold']),
                        ])),
              ])))
        ]));
  }

  Widget BillingRow(BuildContext context, String title, String amount) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          Text("Rs. ${amount}.00",
              style: Theme.of(context).textTheme.bodyLarge),
        ]));
  }

  Widget ApplyCoupon(BuildContext context, CartController oc) {
    return Row(
      children: [
        Expanded(
            flex: 3,
            child: OutlinedInput(
                context, 'Coupon Code', null, oc.couponCodeInputController)),
        Expanded(
            flex: 1,
            child: AppButton(
              label: 'Apply',
              roundness: 0,
              isLoading: oc.isApplyginCoupon.value,
              onPressed: () {
                cartController
                    .applyCouponCode(cartController.cart_session_id.value!);
              },
            ))
      ],
    );
  }

  Widget BillingRowOffer(BuildContext context, String title, String amount) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              Text("${amount}", style: Theme.of(context).textTheme.bodyLarge),
            ]),
            if (cartController.offerDiscountAr.length > 0)
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: cartController.offerDiscountAr.map((el) {
                    return DiscountOfferRowNoCal(el);
                  }).toList()),
          ],
        ));
  }

  Widget OfferAppliedWidget(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.lightGreen.shade50,
            border: Border.all(width: 1, color: Colors.green)),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Offers Applied',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              InkWell(
                  onTap: () {
                    AppliedOfferListDetailSheet(
                        context, cartController.applied_coupon_names.value);
                  },
                  child: Text('View All',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.red))),
            ])
          ],
        ));
  }

  void showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return CheckoutBottomSheet();
        });
  }

  Widget CartOfferAppliedMessage(BuildContext context, String message) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Card(
        child: Stack(clipBehavior: Clip.none, children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.lightGreen.shade50,
                  border: Border.all(width: 1, color: Colors.green)),
              padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
              width: double.infinity,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${message}',
                        style: Theme.of(context)
                            .textTheme
                            ?.titleSmall
                            ?.copyWith(
                                color: Colors.green,
                                fontWeight: FontWeight.bold)),
                  ],
                ),
              )),
          Positioned(
              top: -12,
              child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(Icons.check_circle,
                      size: 25, color: Colors.green.shade800)))
        ]),
      ),
    );
  }
}
