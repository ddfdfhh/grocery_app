import 'dart:convert';

import 'package:citymall/constants.dart';
import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/models/get_api_response_model.dart';
import 'package:citymall/models/product.dart';
import 'package:citymall/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:pretty_http_logger/pretty_http_logger.dart';

class ProductController extends GetxController {
  CartController cartController = Get.put(CartController());
  late ScrollController scrollController;

  var isLoading = false.obs;
  var isListLoading = false.obs;
  var noMoreData = false.obs;
  var loadingMore = false.obs;
  var totalItems = 0.obs;
  var isFilterApplied = false.obs;
  var current_timestamp = DateTime.now().millisecondsSinceEpoch.obs;
  var current_page = 1.obs;

  var sortBy = 'price'.obs;
// var priceOrder=(null as String?).obs;
// var filterBrand=(null as String?).obs;
// RxMap priceRange={}.obs;
  var categoryId = 0.obs;
  var collectionId = 0.obs;
  var productId = 0.obs;
  var selectedBrandId = 0.obs;
  var selectedVariantId = 0.obs;
  Rx<Variants?> selectedVariant = (null as Variants?).obs;

  Rx<String?> priceOrder = (null as String?).obs;
  var searchInputControl = TextEditingController();
  var selectedPriceFromSlider = 0.0.obs;
  static const String baseUrl = baseApiUrl;
  RxList<Product> products = <Product>[].obs;
  RxList<Product> related_products = <Product>[].obs;
  final Rx<Product?> product = (null as Product?).obs;
  final Rx<Product?> productLocal = (null as Product?).obs;
  final Rx<Product?> selectedProduct = (null as Product?).obs;
  final RxList<Product?> collection_products = <Product>[].obs;
  num maxPrice = 0.0;

  num minPrice = 0.0;

  var selected_product_discount_text = ''.obs;
  var currentMinPrice = 0.obs;
  var currentMaxPrice = 0.obs;
  var isSliderPriceChanged = false.obs;
  RxList<String> brands = <String>[].obs;
  List<String> initialBrands = [];
  Rx<String?> collectionName=(null as String?).obs;
  RxList<String> selectedBrands = <String>[].obs;
  RxList<String> allBrands = <String>[].obs;
  RxList<Map<String, dynamic>> images = <Map<String, dynamic>>[].obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    scrollController = new ScrollController()..addListener(scrollListener);
    ever(categoryId, (_) => fetchData(null));
    ever(collectionId, (_) => fetchCollectionProduct());
    ever(productId, (_) {
      getProductLocally();
      //  getProduct();
    });
  }

  scrollListener() {

    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !noMoreData.value) {
      current_page.value = current_page.value + 1;

      loadMoreData();
    }
  }

  selectProduct(Product pr) {
    selectedProduct.value = pr;
  }

  addCartSigleProductPage(qty, mode) {
    CartController cartController = Get.find();
    if (selectedProduct.value != null) {
      if (selectedProduct.value?.variants != null &&
          selectedProduct.value!.variants!.length > 0 &&
          selectedVariantId.value == null) {
        Get.snackbar(
          "Error",
          "Please select a variant first",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
      } else {
        cartController.updateCart(
            selectedProduct.value!, qty, mode, selectedVariant?.value);
      }
    }
  }

  fetchData(String? moreFilter) async {
    totalItems.value=0;
    isListLoading(true);
    var filterString = '';

    if (categoryId.value != null) {
      filterString += '?categroy_id=${categoryId.value}';
    }
    if (moreFilter == null) {
      priceOrder.value=null;
      selectedBrands.clear();
      isSliderPriceChanged.value=false;
      searchInputControl.clear();
      isFilterApplied(false);
      filterString += '&page=${current_page}';
    }

        if (moreFilter != null && isFilterApplied.value)
          filterString += '&' + moreFilter;

    filterString=filterString.replaceAll('&&', "&");

    if (products.isNotEmpty) products.clear();
        ApiService.getRequest(
            ApiResponseType.Unformatted, '/products${filterString}', (res) {

          if (res['data'].isNotEmpty) {
            maxPrice = num.parse(res['meta']['maxPrice']) + 10;
            minPrice = num.parse(res['meta']['minPrice']) - 10;
           totalItems.value=res['meta']['total_items'];


            currentMinPrice.value = minPrice.toInt();
            currentMaxPrice.value = maxPrice.toInt();

            if (res['meta']['brands_list'].isNotEmpty) {
              var l=(res['meta']['brands_list'] as List).map((el)=> el.toString()).toList();
              // print(l.runtimeType);
              allBrands.value = l.toSet().toList();

            }

            for (var json in res['data']) {
              Product product = Product.fromJson(json);
              if (initialBrands.length <= 6){
                if(!initialBrands.contains(product.brandName!))
                  initialBrands.add(product.brandName!);}
              products.add(product);

              // products.refresh();
            }
            products.refresh();
            brands.value = initialBrands.toSet().toList();


          }
          isListLoading(false);
        }, (res) {
          isListLoading(false);
        }, showRequestDetail: false);

  }

  loadMoreData() async {
    // if (products.value.isEmpty || moreFilter != null) {

    loadingMore(true);
    var filterString = '?page=${current_page}';
    if (categoryId.value != null) {
      filterString += '&categroy_id=${categoryId.value}';
    }
    String moreFilter1 = '';
    if(priceOrder.value!=null)
      moreFilter1 +='orderByPrice=${priceOrder.value}&';
    if (selectedBrands.isNotEmpty) {
      moreFilter1 += 'filterBybrands=${jsonEncode(selectedBrands)}';
    }
    if (isSliderPriceChanged.value) {
      var range = {'min': currentMinPrice.value, 'max': currentMaxPrice.value};
      moreFilter1 += '&priceRange=${jsonEncode(range)}';
    }
    if (moreFilter1 != null && isFilterApplied.value)
      filterString += '&' + moreFilter1;
    ApiService.getRequest(
        ApiResponseType.Unformatted, '/products${filterString}', (res) {
      if (res['data'].isNotEmpty) {
        maxPrice = num.parse(res['meta']['maxPrice']) + 10;
        minPrice = num.parse(res['meta']['minPrice']) - 10;

        currentMinPrice.value = minPrice.toInt();
        currentMaxPrice.value = maxPrice.toInt();

        for (var json in res['data']) {
          Product product = Product.fromJson(json);

          products.add(product);
          if (product.brandName != null) {
            if (!initialBrands.contains(product.brandName)) {
              brands.add(product.brandName!);
              initialBrands.add(product.brandName!);
            }
          }
          products.refresh();
        }
      } else
        noMoreData.value = true;
      products.refresh();
      update();
      loadingMore(false);
    }, () {
      loadingMore(false);
    }, showRequestDetail: false);


  }

  getProductLocally() async {
    isLoading(true);
    ApiService.getRequest(
        ApiResponseType.Unformatted, '/product/${productId.value}', (res) {
      productLocal.value = Product.fromJson(res['data']);
      Product item = productLocal.value!;
      selectedProduct.value = item;
      selected_product_discount_text.value = item.discountType != null
          ? (item.discountType == 'Flat'
              ? '${currency}${item.discount}'
              : '${item.discount}%')
          : '${(((item.price! - item.salePrice!) * 100) / item.price!).round()}%';

      if (res['related_products'].isNotEmpty) {
        related_products.clear();
        for (var json in res['related_products']) {
          Product product = Product.fromJson(json);

          related_products.add(product);
        }
        related_products.refresh();
      }
      isLoading(false);
    }, () {
      isLoading(false);
    }, showRequestDetail: false);
  }

  fetchCollectionProduct() async {
    isListLoading(true);
    if (collection_products.isNotEmpty) {
      collection_products.clear();
    }
    ApiService.getRequest(ApiResponseType.MultipleRow,
        '/collection_products/${collectionId.value!}', (res) {
      if (res.isNotEmpty) {


          var list=res.map((v)=>v as Map<String,dynamic>).toList();

        for (var json in list) {
          Product product = Product.fromJson(json);

          collection_products.add(product);

          collection_products.refresh();
          isListLoading(false);
        }
      }
    }, (res) {
      isListLoading(false);
    }, showRequestDetail: false);
  }

  searchBrand() {
    String searchValue = searchInputControl.text.trim();
    if (searchValue.isNotEmpty) {
      brands.value = allBrands
          .where((i) => i.toLowerCase().contains(searchValue.toLowerCase()))
          .toSet().toList();
    } else
      brands.value = initialBrands;
    // brands.refresh();
  }

  clearFilter() {
    current_page.value = 1;
    priceOrder.value=null;
    selectedBrands.clear();
    isSliderPriceChanged.value=false;
    searchInputControl.clear();
    isFilterApplied(false);
    fetchData(null);
  }

  applyFilter() async {
    noMoreData(false);
    searchInputControl.clear();
    String moreFilter1 = '';
    if(priceOrder.value!=null)
    moreFilter1 +='orderByPrice=${priceOrder.value}&';
    if (selectedBrands.isNotEmpty) {
      moreFilter1 += 'filterBybrands=${jsonEncode(selectedBrands)}';
    }
    if (isSliderPriceChanged.value) {
      var range = {'min': currentMinPrice.value, 'max': currentMaxPrice.value};
      moreFilter1 += '&priceRange=${jsonEncode(range)}';
    }
    current_page.value=1;
    isFilterApplied(true);

    fetchData(moreFilter1);
  }
}
