import 'dart:convert';

import 'package:citymall/constants.dart';
import 'package:citymall/models/category.dart';
import 'package:citymall/models/content_section.dart';
import 'package:citymall/models/get_api_response_model.dart';
import 'package:citymall/models/product.dart';
import 'package:citymall/models/slider_banner.dart';
import 'package:citymall/models/user_model.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/service/api_service.dart';
import 'package:citymall/service/setting_service.dart';
import 'package:citymall/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportController extends GetxController {
  var isLoading = false.obs;
  UserService userService = Get.find();
  static const String baseUrl = baseApiUrl;
  var _status = ''.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var autoValidate = false.obs;
  // TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  RxList<Map<String, dynamic>> list = <Map<String, dynamic>>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchOldQueries();
    // userService.init();
  }

  fetchOldQueries() async {

  isLoading(true);


    var body = {
      'email': userService.user?.email,
      'phone': userService.user?.phone_number,
    };

    ApiService.postRequest(
        ApiResponseType.MultipleRow, '/listCustomerQueries', body, null, (res) {
      for (var item in res) {

        list.add(item as Map<String, dynamic>);
      }
      list.refresh();

      isLoading(false);
    }, (res) {
      isLoading(false);
    }, showRequestDetail: false);
  }

  submit() async {
    //  try {
    isLoading(true);

    var body = {
      'message': messageController.text.trim(),
      'email': userService.user?.email,
      'phone': userService.user?.phone_number,
    };

    ApiService.postRequest(
        ApiResponseType.PlainString, '/createQuery', body, null, (res) {
      messageController.clear();

      isLoading(false);
      Get.snackbar(
        "Success!",
        "Your query submitted Successfully,We will respond you shortly",
        colorText: Colors.black,
        backgroundColor: Colors.lightGreen.shade50,
        icon: const Icon(Icons.check_circle),
      );
    }, (res) {

      isLoading(false);
    }, showRequestDetail: false);
  }

  String? validateMessage() {
    if (messageController.text.trim().isEmpty) {
      return "Message field is required";
    }

    return null;
  }

  emailMe() async {
    SettingService sv=Get.find();

    final Email send_email = Email(
      body: 'Write message here',
      subject: 'Write subject of email',
      recipients: ['${sv.setting!['email']}'],
      isHTML: false,
    );

    await FlutterEmailSender.send(send_email);
  }

  launchCaller() async {
    SettingService sv=Get.find();
    var url = "tel:+91${sv.setting!['phone']}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
