import 'package:citymall/controllers/network_controller.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NetworkController>(NetworkController());
  }
}