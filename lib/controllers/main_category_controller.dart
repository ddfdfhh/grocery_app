import 'dart:convert';

import 'package:citymall/constants.dart';
import 'package:citymall/models/category.dart';
import 'package:citymall/models/get_api_response_model.dart';
import 'package:citymall/models/product.dart';
import 'package:citymall/service/api_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';

class MainCategoryController extends GetxController {
  var isLoading = false.obs;

  var sortOrder = 'ASC'.obs;
  var sortBy = 'name'.obs;
  var current_page = 1.obs;

  static const String baseUrl = baseApiUrl;
  RxList<Category> categories = <Category>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    fetchData();

    //ever(categoryId,(_)=>getCategoryLocally());
  }

  fetchData() {
    isLoading(true);

    ApiService.getRequest(ApiResponseType.MultipleRow, '/categories', (res) {
      for (var json in res.data) {
        Category category = Category.fromJson(json);

        categories.add(category);
        categories.refresh();
      }
      isLoading(false);
    }, (res) {
      isLoading(false);
    }, showRequestDetail: false);
  }
}
