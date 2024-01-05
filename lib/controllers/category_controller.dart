import 'dart:convert';

import 'package:citymall/constants.dart';
import 'package:citymall/models/category.dart';
import 'package:citymall/models/get_api_response_model.dart';
import 'package:citymall/models/product.dart';
import 'package:citymall/service/api_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';

class CategoryController extends GetxController {
  var isLoading = false.obs;
  var isLoadingSub = false.obs;
  var sortOrder = 'ASC'.obs;
  var sortBy = 'name'.obs;
  var current_page = 1.obs;
  var categoryId = 0.obs;
  var subCategoryId = 0.obs;
  var selectedIndex = 0.obs;
  static const String baseUrl = baseApiUrl;
  RxList<Category> categories = <Category>[].obs;
  final Rx<Category?> category = (null as Category?).obs;
  final Rx<Category?> subCategory = (null as Category?).obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    ever(categoryId, (_) {
      isLoading(true);
      if (categoryId.value > 0)
        getCategory();
      else
        fetchData();
    });
  }

  fetchData() async {
    categories.clear();

    isLoading(true);

    ApiService.getRequest(ApiResponseType.MultipleRow, '/categories', (res) {
      for (var json in res) {

        Category category = Category.fromJson(json);

        categories.add(category);
      }
      categories.refresh();
      isLoading(false);
    }, () {
      isLoading(false);
    }, showRequestDetail: false);
  }

  getCategory() async {
    isLoading(true);
    ApiService.getRequest(
        ApiResponseType.Unformatted, '/category/${categoryId.value}', (res) {
      category.value = Category.fromJson(res);
      if (category.value != null && category.value!.children != null) {
        subCategoryId.value = category.value!.children![0].id!;

        print(subCategoryId.value);
      }
      isLoading(false);
    }, () {
      isLoading(false);
    }, showRequestDetail: false);
  }

  getSubCategory() async {
    isLoadingSub(true);
    ApiService.getRequest(
        ApiResponseType.Unformatted, '/category/${subCategoryId.value}', (res) {
      subCategory.value = Category.fromJson(res);

      isLoadingSub(false);
    }, () {
      isLoadingSub(false);
    }, showRequestDetail: false);
  }
}
