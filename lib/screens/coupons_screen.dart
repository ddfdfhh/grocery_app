import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:citymall/bottom_sheets/coupon_detail_sheet.dart';
import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/controllers/coupon_controller.dart';
import 'package:citymall/controllers/network_controller.dart';
import 'package:citymall/controllers/order_controller.dart';
import 'package:citymall/models/coupon.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/util.dart';
import 'package:citymall/widgets/nointernet.dart';
import 'package:citymall/widgets/search.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:coupon_uikit/coupon_uikit.dart';

class CouponsScreen extends StatelessWidget {
  CouponController couponController = Get.find();
  CartController cartController = Get.find();
  OrderController orderController = Get.find();
  final String details =
      "Purchase above 300 rs to get this offer of the mentioned product range ";
  List<String> f = ["sdsa", "Sdsds"];
  @override
  Widget build(BuildContext context) {
    NetworkController nc = Get.find();
    return Obx(() => nc.hasConnection.value
        ? Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text("Coupons"),
              leading: InkWell(
                  onTap: () => {Get.back()}, child: Icon(Icons.arrow_back)),
            ),
            body: SafeArea(
                child: DefaultTabController(
              length: 2,
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                TabBar(
                    //dividerColor: Colors.red,
                    unselectedLabelColor: Colors.grey.shade800,

                    labelColor: AppTheme(context: context).colors['primary'],
                    tabs: [
                      Tab(text: "Coupon Offers"),
                      Tab(text: "Automatic Offers"),
                    ]),
                AutoScaleTabBarView(children: [
                  if (couponController.coupons.isNotEmpty)
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: couponController.coupons.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CouponBox(
                              context, couponController.coupons[index]);
                        })
                  else
                    SizedBox(
                        height: 200,
                        child: Align(
                            alignment: Alignment.center,
                            child: Text('No Coupon Available'))),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                            'Automatic offers are applied automatically when conditions mentioned in the offer are satisfied',
                            style: AppTheme(context: context)
                                .textTheme['bodyMedium']),
                      ),
                      if (couponController.automatic_coupons.isNotEmpty)
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                couponController.automatic_coupons.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AutomaticCouponBox(context,
                                  couponController.automatic_coupons[index]);
                            })
                      else
                        SizedBox(
                            height: 200,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text('No Offer Available'))),
                    ],
                  )
                ])
              ]),
            )))
        : NoInternet(context));
  }

  Widget CouponBox(BuildContext context, Coupon coupon) {
    return Container(
        height: 100,
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, //New
                  blurRadius: 10.0,
                  offset: Offset(8, 8),
                  spreadRadius: 0)
            ],
            borderRadius: BorderRadius.circular(5)),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(flex: 1, child: leftPortion(context, coupon)),
          // Expanded/SizedBox(width: 80),
          Expanded(flex: 1, child: rightPortion(context, coupon)),
        ]));
  }

  Widget AutomaticCouponBox(BuildContext context, Coupon coupon) {
    return Container(
        // height: 100,
        margin: EdgeInsets.symmetric(vertical: 2),
        padding: EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: leftPortionForAutomtic(context, coupon));
  }

  Widget leftPortion(BuildContext context, Coupon coupon) {
    String details = coupon.details ?? '';
    details = removeAllHtmlTags(details);
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.lightGreen.withOpacity(.1),
            border: Border(right: BorderSide(width: 1, color: Colors.black12))),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${coupon.name}",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Theme.of(context).colorScheme.primary)),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                  width: 200,
                  child: Text.rich(TextSpan(
                      text: details.length > 39
                          ? details.replaceRange(40, details.length, '...')
                          : details,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.black87),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'see more',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              couponController.selectCoupon(coupon);
                              CouponDetailSheet(context, coupon);
                            },
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  decoration: TextDecoration.underline,
                                  fontSize: 12),
                        ),
                      ])))
            ]));
  }

  Widget leftPortionForAutomtic(BuildContext context, Coupon coupon) {
    String details = coupon.details ?? '';
    details = removeAllHtmlTags(details);
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            border: Border(right: BorderSide(width: 1, color: Colors.black12))),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("df${coupon.name}",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.lightGreen.shade600,
                      fontWeight: FontWeight.w500)),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                  width: double.infinity,
                  child: Text('${details}',
                      style: AppTheme(context: context)
                          .textTheme['bodySmallBold']))
            ]));
  }

  Widget rightPortion(BuildContext context, Coupon coupon) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DottedBorder(
            child: Container(
              padding: EdgeInsets.all(5),
              child: Text("${coupon.couponCode}",
                  style: Theme.of(context).textTheme.titleSmall),
            ),
          ),
          SizedBox(height: 5),
          InkWell(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              cartController.applyCoupon(
                  coupon.couponCode!, cartController.cart[0].cartSessionId!);
            },
            child: Text("Apply Coupon",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.red, decoration: TextDecoration.underline)),
          ),
        ]);
  }
}
