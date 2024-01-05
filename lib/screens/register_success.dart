// ignore_for_file: prefer_const_constructors

import 'package:citymall/constants.dart';
import 'package:citymall/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../styles/theme.dart';


class RegisterSuccess extends StatelessWidget {
   RegisterSuccess({Key? key});

Color themeColor = const Color(0xFF43D19E);

  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(resizeToAvoidBottomInset:true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 80,
            //  padding: EdgeInsets.all(35),

              // child: Image.asset(
              //   "${assetUrl(context)}/check.png",
              //   fit: BoxFit.contain,
              // ),
              child:Icon(Icons.check_circle,size:50,color:AppTheme(context:context).colors['primary'])
            ),

            Text(
              "Great!",
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Your account created successfully",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),

            SizedBox(height: 10),
            Flexible(
              child: ElevatedButton(onPressed: () {
                Get.offAndToNamed(AppRoutes.login);
              }, child: Text('Login Now'),

              ),
            ),
          ],
        ),
      ),
    );
  }
}