import 'package:citymall/bottom_sheets/filter_sheet.dart';
import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/controllers/category_controller.dart';
import 'package:citymall/controllers/dashboard_controller.dart';
import 'package:citymall/controllers/network_controller.dart';
import 'package:citymall/controllers/product_controller.dart';
import 'package:citymall/models/category_item.dart';
import 'package:citymall/models/product.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/widgets/bottom_cart_strip.dart';
import 'package:citymall/bottom_sheets/bottom_drawer.dart';
import 'package:citymall/widgets/cart_count.dart';
import 'package:citymall/widgets/category_card.dart';
import 'package:citymall/widgets/nointernet.dart';
import 'package:citymall/widgets/product_grid.dart';
import 'package:citymall/widgets/vegetable_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CollectionProductListScreen extends StatelessWidget {
  // var products = ["One", "Tow", "Three"];
  ProductController productController = Get.put(ProductController());
  // AppTheme appTheme=Get.put<AppTheme>(AppTheme());
  // CategoryController categoryController = Get.find();
  // ProductController productController = Get.find();
  // CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    DashboardController dc = Get.find();

    NetworkController nc = Get.find();
    return Obx(()=>nc.hasConnection.value?Scaffold(
        backgroundColor: Colors.grey.shade100,
        extendBody: true,
        bottomNavigationBar: BottomCartStrip(),
        appBar: AppBar(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              )),
          foregroundColor: Colors.white,
          title:Obx(
                  () => Text('${productController.isListLoading.value?'Loading..':productController.collectionName.value}')),
          centerTitle: true,
          leading: InkWell(
              onTap: () => {Get.back()}, child: Icon(Icons.arrow_back)),
        ),
        body: SafeArea(
            child: productController.isListLoading.value
                ? Center(
              child: CircularProgressIndicator(),
            )
                : productController.collection_products.value.isNotEmpty
                ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          ProductGrid(
                              context,
                              productController
                                  .collection_products!.value!)
                        ])))
                : Center(
                child: Text(
                    "o loaded")))):NoInternet(context));
  }
}
