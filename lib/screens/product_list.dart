import 'package:citymall/bottom_sheets/filter_sheet.dart';
import 'package:citymall/constants.dart';
import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/controllers/category_controller.dart';
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

import '../widgets/badge.dart';

class ProductListScreen extends StatelessWidget {
  // var products = ["One", "Tow", "Three"];
  CategoryController categoryController = Get.find();
  ProductController productController = Get.find();
  CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    NetworkController nc = Get.find();
    return Obx(() => nc.hasConnection.value
        ? Scaffold(
            extendBody: true,
            backgroundColor: Colors.grey.shade100,
            bottomNavigationBar: BottomCartStrip(),
            appBar: AppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              )),
              actions: [
                ElevatedButton.icon(
                  icon: Icon(Icons.sort,
                      color: Colors.white,
                      ),
                  onPressed: () {
                    FilterSheet(context);
                  },
                  label: Text("Filter/Sort",
                      style:
                          AppTheme(context: context).textTheme['appBarTitle']),
                )
              ],
              elevation: 0,
              foregroundColor: Colors.white,
              title: Row(children: [
                Expanded(
                  child: Text(
                    /*${categoryController.categoryLocal.value!.name!}*/
                    " Products(${productController.totalItems.value})",style:TextStyle(fontSize:17)
                  ),
                ),
                SizedBox(width:20,
                  child: IconButton(onPressed: (){
                    Get.toNamed(AppRoutes.search);
                  }, icon: Icon(Icons.search,color:Colors.white)),
                )
                // Expanded(child:SizedBox(width:20)),
                // CartCount(iconColor:Colors.white)
              ]),
              centerTitle: true,
              leading: InkWell(
                  onTap: () => {Get.back()}, child: Icon(Icons.arrow_back)),
            ),
            body: SafeArea(
                child: Obx(() => productController.isListLoading.value &&
                        productController.current_timestamp.value > 0
                    ? Align(alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: productController.products.value.isNotEmpty
                          ?SingleChildScrollView(
                            controller: productController.scrollController,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (productController
                                      .isFilterApplied.value) ...[
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            'Showing Results for applied filter'),
                                        FilterChip(
                                          backgroundColor: Colors.deepOrange,
                                          label: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Clear Filter'),
                                              Icon(
                                                  CupertinoIcons
                                                      .multiply_circle_fill,
                                                  color: Colors.white)
                                            ],
                                          ),
                                          labelStyle:
                                              TextStyle(color: Colors.white),
                                          selected: false,
                                          onSelected: (bool value) {
                                            productController.clearFilter();
                                          },
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Wrap(
                                          spacing: 5,
                                          alignment: WrapAlignment.start,
                                          direction: Axis.horizontal,
                                          children: [
                                            if (productController
                                                .selectedBrands.isNotEmpty)
                                              NormalBadge(
                                                  text:
                                                      'Selected Brand(s)-${productController.selectedBrands.join(',')}'),
                                            if (productController
                                                .isSliderPriceChanged.value)
                                              NormalBadge(
                                                  text:
                                                      'Price Range-${currency}${productController.currentMinPrice.value} - ${currency}${productController.currentMaxPrice.value}'),
                                            if (productController
                                                    .priceOrder.value !=
                                                null)
                                              NormalBadge(
                                                  text:
                                                      'Sort By Price -${productController.priceOrder.value == 'ASC' ? 'Increasing  Order ' : 'Decreasing Order '}')
                                          ]),
                                    )
                                  ],

                                  ProductGrid(context, productController.products!.value!),
                                  if (productController.loadingMore.value)
                                    SizedBox(
                                        height: 30,
                                        child:
                                        Align(alignment: Alignment.center,child: const CircularProgressIndicator()))
                                ]))
                : Align(alignment:Alignment.center,
                    child: const Text("No products found")) ))))
        : NoInternet(context));
  }



}
