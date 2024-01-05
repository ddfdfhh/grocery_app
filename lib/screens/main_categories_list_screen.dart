import 'package:citymall/controllers/category_controller.dart';
import 'package:citymall/controllers/main_category_controller.dart';
import 'package:citymall/controllers/network_controller.dart';
import 'package:citymall/controllers/product_controller.dart';
import 'package:citymall/models/category.dart';
import 'package:citymall/models/category_item.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/widgets/bottom_nav.dart';
import 'package:citymall/widgets/category/child.dart';
import 'package:citymall/widgets/category/simple_category_card.dart';
import 'package:citymall/widgets/category_card.dart';
import 'package:citymall/widgets/category_grid.dart';
import 'package:citymall/widgets/nointernet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class MainCategoriesListScreen extends StatelessWidget {
  CategoryController categoryController = Get.put(CategoryController());
  ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    NetworkController nc = Get.find();
    return Obx(() => nc.hasConnection.value
        ? Scaffold(
            extendBody: true,
            bottomNavigationBar: BottomNavBar(),
            appBar: AppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              )),
              elevation: 0,
              foregroundColor: Colors.white,
              title: Text('All Categories'),
              centerTitle: true,
              leading: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();

                  },
                  child: Icon(Icons.arrow_back)),
            ),
            body: categoryController.isLoading.value &&
                    categoryController.categories.value.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                          CategoryGrid(
                              context, categoryController.categories.value),
                          SizedBox(height: 60)
                        ]))))
        : NoInternet(context));
  }


}
