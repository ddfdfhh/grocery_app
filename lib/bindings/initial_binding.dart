import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/controllers/category_controller.dart';
import 'package:citymall/controllers/coupon_controller.dart';
import 'package:citymall/controllers/dashboard_controller.dart';
import 'package:citymall/controllers/network_controller.dart';
import 'package:citymall/controllers/order_controller.dart';
import 'package:citymall/controllers/product_controller.dart';
import 'package:citymall/controllers/register_controller.dart';
import 'package:citymall/service/api_service.dart';
import 'package:citymall/service/setting_service.dart';
import 'package:citymall/service/user_service.dart';

import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() async{

    NetworkController nc = Get.put<NetworkController>(NetworkController(),permanent: true);

    SettingService settingService =
    Get.put<SettingService>(SettingService(), permanent: true);
    settingService.init();
    ApiService apiService = Get.put<ApiService>(ApiService(), permanent: true);
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => RegisterationController());

    Get.lazyPut(() => ProductController());
    Get.lazyPut(() => CategoryController());
    Get.lazyPut(() => OrderController());
    Get.put(CouponController());
    Get.lazyPut(() => CategoryController());
    Get.lazyPut(() => DashboardController());

  }
}