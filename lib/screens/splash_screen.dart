import 'package:citymall/bindings/custom_scaffold.dart';
import 'package:citymall/constants.dart';
import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/controllers/category_controller.dart';
import 'package:citymall/controllers/dashboard_controller.dart';
import 'package:citymall/controllers/network_controller.dart';
import 'package:citymall/controllers/product_controller.dart';
import 'package:citymall/controllers/splash_controller.dart';
import 'package:citymall/controllers/user_controller.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/widgets/nointernet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder(
            init: SplashScreenController(),
            builder: (_) {
              NetworkController nc = Get.find();
              return Obx(() => nc.hasConnection.value
                  ? Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 130,
                              width: MediaQuery.of(context).size.width,
                              child: Image.asset(
                                  '${assetUrl(context)}/splash_top.png',
                                  fit: BoxFit.cover),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 60,
                                  width: 100,
                                  child: Image.asset(
                                      '${assetUrl(context)}/logo.png',
                                      fit: BoxFit.fill),
                                ),
                                SizedBox(height: 16),
                                SizedBox(
                                  width: 250,
                                  child: Text(
                                    'Get best quality products from  OMG Hub and get it  delivered within 2 hrs.',
                                    textAlign: TextAlign.center,
                                    style: AppTheme(context: context)
                                        .textTheme["bodyMediumBold"],
                                  ),
                                ),
                              ],
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  // height: 180,
                                  child: Image(
                                    image: AssetImage(
                                        '${assetUrl(context)}/splash_bottom.png'),
                                    fit: BoxFit.cover,
                                    // decoration: BoxDecoration(
                                    //   image: DecorationImage(
                                    //       image: AssetImage('/images/av1.jpg'),
                                    //       fit: BoxFit.cover),
                                    // ),
                                  ),
                                ),
                                // Positioned(
                                //   top: 0,
                                //   child: Directionality(
                                //     textDirection: TextDirection.rtl,
                                //     child: const CircularProgressIndicator(),
                                //   ),
                                // ),
                              ],
                            ),
                          ]),
                    )
                  : NoInternet(context));
            }),
      ),
    );
  }
}
