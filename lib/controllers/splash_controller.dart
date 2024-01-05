import 'package:citymall/controllers/network_controller.dart';
import 'package:citymall/controllers/user_controller.dart';
import 'package:citymall/models/user_model.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/service/user_service.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class SplashScreenController extends GetxController
{


  @override
  void onInit() async{
    super.onInit();
     UserService userService=Get.find();

    Future.delayed(
           Duration(seconds: 5),
               () {
             //  Get.offNamedUntil('home', (route) => false);
             //Get.reset();
             //Get.toNamed(AppRoutes.dashboard);
             if (userService.user != null)
               Get.offNamedUntil(AppRoutes.dashboard, (route) => false);
              else
               Get.toNamed(AppRoutes.login);
           }
       );


  }

}