import 'dart:convert';

import 'package:citymall/constants.dart';
import 'package:citymall/controllers/register_controller.dart';
import 'package:citymall/controllers/user_controller.dart';
import 'package:citymall/models/user_model.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/service/api_service.dart';
import 'package:citymall/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  UserService userService = Get.find();
  var showPassword = false.obs;
  var isLoading = false.obs;
  var _status = ''.obs;
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    //userService.init();
  }

  @override
  void onClose() {
    emailController.dispose();
    phoneController.dispose();
  }

  String? validateEmail() {
    if (emailController.text.trim().isEmpty) {
      return "Email field is required";
    }
    if (!emailController.text.trim().isEmail) {
      return "Please enter valid email";
    }

    return null;
  }

  String? validatePassword() {
    // if (passwordController.text.trim().isEmpty) {
    //   return 'Enter password';
    // }
    // if (passwordController.text.trim().length < 7) {
    //   return 'Min Lenght of 7 is required';
    // }

    return null;
  }

  sub() async {
    isLoading(true);

    Map<String, dynamic> body = {};
    // if (emailController.text.trim().isNotEmpty)
    //   body['email'] = emailController.text.trim();
    if (phoneController.text.trim().isNotEmpty)
      body['phone'] = phoneController.text.trim();

    ApiService.postRequest(ApiResponseType.Unformatted, '/login', body, null,
        (res) {
      String email = emailController.text.trim();
      String phone = phoneController.text.trim();
      emailController.clear();

      phoneController.clear();
      isLoading(false);

      Future.delayed(
          Duration(seconds: 1),
          (){
            RegisterationController rc=Get.find();
            rc.phone.value=phone;
            Get.toNamed(AppRoutes.otp);
          });
    },(res){
          isLoading(false);
        }, showRequestDetail: false);
  }

  String? validatePhone() {
    if (phoneController.text.trim().isEmpty) {
      return "Phone Number is required";
    }

    return null;
  }

  logout() async {
    await userService.userBox.clear();
    Get.offAllNamed(AppRoutes.login);
  }
}
