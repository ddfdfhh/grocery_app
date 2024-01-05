import 'package:citymall/bottom_sheets/filter_sheet.dart';
import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/controllers/category_controller.dart';
import 'package:citymall/controllers/dashboard_controller.dart';
import 'package:citymall/controllers/product_controller.dart';
import 'package:citymall/models/category_item.dart';
import 'package:citymall/models/product.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/widgets/bottom_cart_strip.dart';
import 'package:citymall/bottom_sheets/bottom_drawer.dart';
import 'package:citymall/widgets/cart_count.dart';
import 'package:citymall/widgets/category_card.dart';
import 'package:citymall/widgets/product_grid.dart';
import 'package:citymall/widgets/vegetable_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DealsProductListScreen extends StatelessWidget {

  ProductController productController = Get.find();


  @override
  Widget build(BuildContext context) {
    DashboardController dc = Get.find();

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        bottomNavigationBar: BottomCartStrip(),
        appBar: AppBar(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              )),
          foregroundColor: Colors.white,
          title: Obx(
                  () => Text('${dc.isLoading.value?'Loading..':dc.single_content_section?.value?.sectionTitle}')),
          centerTitle: true,
          leading:
              InkWell(onTap: () => {Get.back()}, child: Icon(Icons.arrow_back)),
        ),
        body: SafeArea(
            child: Obx(() => dc.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : dc.single_content_section.value!.products!.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: SingleChildScrollView(
                            child: Column(  mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                          SizedBox(
                            height: 20,
                          ),
                        ProductGrid(context,dc.single_content_section.value!.products!)
                        ])))
                    : Center(child: const Text("No products found")))));
  }


}
