import 'package:citymall/components/button.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginSuccessScreen extends StatelessWidget {

  static String routeName = "/login_success";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          leading: SizedBox(),
          title: Text("Login Success"),
          centerTitle: true,
        ),
        body: Center(child:Column(
          children: [
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            Image.asset(
              "assets/images/success.png",
              height: SizeConfig.screenHeight * 0.4, //40%
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.08),
            Text(
              "Login Success",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(30),
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth * 0.6,
              child: DefaultButton(context,"Go to Dashboard",
                () {
                  Get.toNamed(AppRoutes.dashboard);
                },null
              ),
            ),
            Spacer(),
          ],
        )

    ));
  }
}
