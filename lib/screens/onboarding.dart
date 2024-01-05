import 'package:citymall/constants.dart';
import 'package:citymall/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // extendBodyBehindAppBar: true,
          backgroundColor: AppTheme(context:context).colors['bgLightGrey'],

          body: Center(

            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 20),

                  Column(
                    children: [
                      SizedBox(height:130,
                        child: Image.asset('${assetUrl(context)}/logo.png',
                            fit: BoxFit.cover),
                      ),
                      SizedBox(height: 16),
                      // SizedBox(
                      //   width: 225,
                      //   child: Text(
                      //     'GROCERPI',
                      //     textAlign: TextAlign.center,
                      //     style:
                      //     AppTheme(context:context).textTheme["titleMediumBoldColor"],
                      //   ),
                      // ),
                      SizedBox(
                        width: 225,
                        child: Text(
                          'Shop anythings from our 1000+ SKUs with 30min delivery',
                          textAlign: TextAlign.center,
                          style:
                          AppTheme(context:context).textTheme["bodyMediumLight"],
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
                          image: AssetImage('${assetUrl(context)}/bg1.png'),
                          fit: BoxFit.cover,
                          // decoration: BoxDecoration(
                          //   image: DecorationImage(
                          //       image: AssetImage('/images/av1.jpg'),
                          //       fit: BoxFit.cover),
                          // ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child:const CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                ]),
          )),
    );
  }

}
