import 'package:citymall/constants.dart';
import 'package:citymall/controllers/category_controller.dart';
import 'package:citymall/controllers/network_controller.dart';
import 'package:citymall/controllers/product_controller.dart';
import 'package:citymall/models/category.dart';
import 'package:citymall/models/category_item.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/widgets/category/child.dart';
import 'package:citymall/widgets/category_card.dart';
import 'package:citymall/widgets/imageWidget.dart';
import 'package:citymall/widgets/nointernet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class CategoriesListScreen extends StatelessWidget {
  CategoryController categoryController = Get.put(CategoryController());
  ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    NetworkController nc=Get.find();
    return Obx(()=>nc.hasConnection.value?Scaffold(
        extendBody: true,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          )),
          elevation: 0,
          foregroundColor: Colors.white,
          title:
              Obx(() => Text(categoryController.category?.value?.name! ?? '')),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back)),
        ),
        body: Obx(() => categoryController.category.value == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: CustomScrollView(
                  slivers: <Widget>[
                    if (categoryController.category.value != null &&
                        categoryController.category?.value?.bannerImage != null)
                      SliverToBoxAdapter(
                        child: CachedImageWidget(
                            context,
                            baseUrl +
                                '/storage/categories/${categoryController.category!.value!.bannerImage!}',
                            double.infinity,
                            200,
                            BoxFit.cover),
                      ),
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return InkWell(
                              //You need to make my child interactive
                              onTap: () {
                                var cur_cat = categoryController
                                    .category!.value!.children![index]!;
                                print("ncie eoen ");
                                if (cur_cat!.childrenCount > 0) {
                                  categoryController.categoryId.value =
                                      cur_cat.id!;
                                  categoryController.isLoading.value=true;

                                  Get.toNamed(AppRoutes.categories);
                                } else {
                                  productController.categoryId.value =
                                      cur_cat.id!;
                                  productController.current_timestamp.value =
                                      DateTime.now().millisecondsSinceEpoch;
                                  Get.toNamed(AppRoutes.products);
                                }
                              },
                              child: ChildCategoryCard(
                                  context,
                                  categoryController
                                      .category!.value!.children![index],
                                  null));
                        },
                        childCount:
                            categoryController.category!.value!.childrenCount,
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.only(bottom: 80.0),
                    )
                  ],
                ),
              ))):NoInternet(context));
  }

  Widget getGridView(
      BuildContext context, CategoryController categoryController) {
    return Obx(() => MasonryGridView.count(
          itemCount: categoryController.category!.value!.childrenCount,
          itemBuilder: (context, index) => InkWell(
              //You need to make my child interactive
              onTap: () {
                var cur_cat =
                    categoryController.category!.value!.children![index]!;
                print("ncie eoen ");
                if (cur_cat!.childrenCount > 0) {
                  Get.toNamed(AppRoutes.sub_categories, arguments: {
                    'sub_category':
                        categoryController.category!.value!.children![index].id
                  });
                } else {
                  Get.toNamed(AppRoutes.products, arguments: {
                    'category': categoryController.category!.value!.id
                  });
                }
              },
              child: ChildCategoryCard(context,
                  categoryController.category!.value!.children![index], null)),
          crossAxisCount: 2, //<-SEE HERE
          // childAspectRatio: 1.1,
          // mainAxisSpacing: 1,
          // crossAxisSpacing: 5,
        ));
  }
}
