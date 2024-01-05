import 'dart:convert';

import 'package:citymall/constants.dart';
import 'package:citymall/models/category.dart';
import 'package:citymall/models/content_section.dart';
import 'package:citymall/models/get_api_response_model.dart';
import 'package:citymall/models/product.dart';
import 'package:citymall/models/slider_banner.dart';
import 'package:citymall/models/user_model.dart';
import 'package:citymall/service/api_service.dart';
import 'package:citymall/service/user_service.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

class DashboardController extends GetxController {
  var isLoading = false.obs;
  var single_content_id = 0.obs;
  static const String baseUrl = baseApiUrl;
  var user_address=''.obs;
  RxList<SliderBanner> banners = <SliderBanner>[].obs;
UserService userService=Get.find();
  RxList<ContentSection> content_sections = <ContentSection>[].obs;
  Rx<ContentSection?> single_content_section = (null as ContentSection?).obs;
Rx<String?> single_content_title=(null as String?).obs;
  @override
  Future<void> onInit() async {
    super.onInit();
      if(userService.user!.address!.isNotEmpty)
        user_address.value=toBeginningOfSentenceCase(userService.user?.address)!;
//categoryId.value=Get.arguments ['category'] as String!=null?Get.arguments['category']:0;
    fetchContentSectionData();

    ever(single_content_id, (_) => fetchSingleContentSectionData());
  }

  fetchContentSectionData() async {
    isLoading(true);
    ApiService.getRequest(ApiResponseType.MultipleRow, '/get_content_sections',
        (res) {
      for (var json in res) {
        ContentSection cs = ContentSection.fromJson(json);

        content_sections.add(cs);
      }
      content_sections.refresh();
      isLoading(false);
    }, (res) {
      isLoading(false);
    }, showRequestDetail: false);
  }

  fetchSingleContentSectionData() async {
    isLoading(true);
    ApiService.getRequest(ApiResponseType.SingleRow,
        '/get_single_content_section/${single_content_id.value!.toString()}',
        (res) {
      if(res.keys.length>0) {
        single_content_section.value = ContentSection.fromJson(res);
       // single_content_id.value=0;
      }
      isLoading(false);

    }, (res) {
      isLoading(false);
     // single_content_id.value=0;
    }, showRequestDetail: false);
  }

   ContentSection? getSection(int order) {
    return content_sections.isNotEmpty ? content_sections[0] : null;
  }
}
