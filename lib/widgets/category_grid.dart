import 'package:citymall/controllers/category_controller.dart';
import 'package:citymall/controllers/product_controller.dart';
import 'package:citymall/models/category.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/widgets/category/simple_category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

Widget CategoryGrid(BuildContext context, List<Category>? categories) {
  CategoryController categoryController=Get.find();
  ProductController productController=Get.find();
  return MasonryGridView.count(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    scrollDirection: Axis.vertical,
    itemCount: categories!.length,
    itemBuilder: (context, index) => InkWell(
      //You need to make my child interactive
        onTap: () {
          var cur_cat =categories![index]!;

          if (cur_cat!.childrenCount > 0) {
            categoryController.categoryId.value = cur_cat.id!;

            Get.toNamed(AppRoutes.categories);
          } else {
            productController.categoryId.value = cur_cat.id!;

            Get.toNamed(AppRoutes.products);
          }
        },
        child: SimpleCategoryCard(context,categories![index]!, null)),
    crossAxisCount: 3,
  );
}