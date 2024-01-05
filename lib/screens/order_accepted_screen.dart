import 'package:citymall/constants.dart';
import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/controllers/dashboard_controller.dart';
import 'package:citymall/controllers/order_controller.dart';
import 'package:citymall/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:citymall/common_widgets/app_button.dart';
import 'package:get/get.dart';

class OrderAcceptedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child:Scaffold(
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(
              flex: 10,
            ),
            Image.asset("${assetUrl(context)}/order_accepted_icon.png",width:400,height:200),
            Spacer(
              flex: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "You Order Has Been placed successfully",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Your order has been placed and now  it's on the way to being processed",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff7C7C7C),
                    fontWeight: FontWeight.w600),
              ),
            ),
            Spacer(
              flex: 8,
            ),
            AppButton(
              label: "Back To Home",
              onPressed: () {
                OrderController oc=Get.find();
                Get.put(DashboardController());
                oc.isOrderListLoading(true);
                Get.offNamed(AppRoutes.dashboard);
              },
            ),
            Spacer(
              flex: 2,
            ),

            Spacer(
              flex: 10,
            ),
          ],
        ),
      ),
    ),
        onWillPop: () async {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content:
      //     Text('Pop Screen Disabled. You cannot go to previous screen.'),
      //     backgroundColor: Colors.red,
      //   ),
      // );
      return false;
    },);
  }
}
