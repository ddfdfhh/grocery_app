import 'package:citymall/constants.dart';
import 'package:citymall/controllers/category_controller.dart';
import 'package:citymall/controllers/dashboard_controller.dart';
import 'package:citymall/controllers/network_controller.dart';
import 'package:citymall/controllers/product_controller.dart';
import 'package:citymall/models/category.dart';
import 'package:citymall/models/category_item.dart';
import 'package:citymall/models/content_section.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/widgets/category/child.dart';
import 'package:citymall/widgets/category/circular_category.dart';
import 'package:citymall/widgets/category/wrapper_image_category_card.dart';
import 'package:citymall/widgets/category_card.dart';
import 'package:citymall/widgets/category_grid.dart';
import 'package:citymall/widgets/nointernet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../widgets/category/simple_category_card.dart';

class DealsCategoriesListScreen extends StatelessWidget {
  DashboardController dc = Get.find();
  CategoryController categoryController = Get.put(CategoryController());
  ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    NetworkController nc = Get.find();
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          )),
          elevation: 0,
          foregroundColor: Colors.white,
          title: Obx(() => Text(
              '${dc.isLoading.value ? 'Loading..' : dc.single_content_section?.value?.sectionTitle}')),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back)),
        ),
        body: Obx(() => dc.isLoading.value
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
                      CategoryGrid1(
                          context,
                          dc.single_content_section?.value!.categories,
                          dc.single_content_section!.value!),
                      SizedBox(height: 60)
                    ])))));
  }

  Widget CategoryGrid1(
      BuildContext context, List<Category>? categories, ContentSection cs) {
    CategoryController categoryController = Get.find();
    ProductController productController = Get.find();
    return MasonryGridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: categories!.length,
      itemBuilder: (context, index) => InkWell(
          //You need to make my child interactive
          onTap: () {
            var cur_cat = categories![index]!;

            if (cur_cat!.childrenCount > 0) {
              categoryController.categoryId.value = cur_cat.id!;

              Get.toNamed(AppRoutes.categories);
            } else {
              productController.categoryId.value = cur_cat.id!;

              Get.toNamed(AppRoutes.products);
            }
          },
          child: (cs.showCategoryInCircle != null &&
                  cs.showCategoryInCircle == 'Yes')
              ? CircluarCategory(context, categories![index], cs)
              : (cs.wrapperImage != null
                  ? WrapperImageCategoryCard(context, categories![index], cs)
                  : SimpleCategoryCard(context, categories![index], cs))),
      crossAxisCount: 2,
    );
  }
}
