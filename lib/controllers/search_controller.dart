import 'dart:convert';

import 'package:citymall/constants.dart';
import 'package:citymall/models/get_api_response_model.dart';
import 'package:citymall/service/api_service.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class SearchProductController extends GetxController {
  final searchFieldController = TextEditingController();
  var search_string = ''.obs;
  var isLoading = false.obs;
  RxList<Map<String, dynamic>> list = RxList<Map<String, dynamic>>();
  @override
  void onInit() async {
    super.onInit();
    debounce(search_string, (_) => startSearching(),time:const Duration(seconds:4));
  }

  startSearching() async {
    isLoading(true);
    var body = {'search_string': searchFieldController.text.trim()};

    ApiService.postRequest(
        ApiResponseType.MultipleRow, '/search', body, null, (res) {
      isLoading(false);
      list.clear();
      for (var json in res) {
        list.add(json);
      }
    }, (res) {
      isLoading(false);
    }, showRequestDetail: false);
  }
}
