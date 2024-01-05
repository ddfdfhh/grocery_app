import 'package:citymall/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetC extends GetMiddleware {
//   Get the auth service
 // final authService = Get.find<AuthService>();

//   The default is 0 but you can update it to any number. Please ensure you match the priority based
//   on the number of guards you have.
  @override
  int? get priority => 1;

  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async{
    bool hap= await InternetConnection().hasInternetAccess;
    if(!hap)
      Get.toNamed(AppRoutes.nointernet);
    else {
      print('nononononon');
      print(route);
     // RouteSettings(name: AppRoutes.dashboard);
    }
  }
}