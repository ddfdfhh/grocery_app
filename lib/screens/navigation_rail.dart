import 'package:citymall/constants.dart';
import 'package:citymall/controllers/category_controller.dart';
import 'package:citymall/models/category.dart';
import 'package:citymall/models/category_item.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/widgets/bottom_nav.dart';
import 'package:citymall/widgets/category/child.dart';
import 'package:citymall/widgets/category/simple_category_card.dart';
import 'package:citymall/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';

class CategoriesListScreen extends StatelessWidget {
  CategoryController categoryController = Get.put(CategoryController());
  ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      categoryController.categoryId.value = Get.arguments['category'];
    });

    return Scaffold(
        bottomNavigationBar: BottomNavBar(),
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
          leading:
              InkWell(onTap: () => {Get.back()}, child: Icon(Icons.arrow_back)),
        ),
        body: SafeArea(
            child: Obx(
          () => categoryController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: MediaQuery.of(context).size.height),
                          child: Theme(
                            data: ThemeData(
                                //highlightColor: Colors.transparent,
                                splashFactory: NoSplash.splashFactory,
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                colorScheme:
                                    ColorScheme.light(primary: Colors.white)),
                            child: IntrinsicHeight(
                              child: NavigationRail(
                                selectedIndex:
                                    categoryController.selectedIndex.value,
                                onDestinationSelected: (int index) {
                                  int child_count = categoryController.category!
                                      .value!.children![index].childrenCount;
                                  if (child_count == 0) {
                                    categoryController.subCategoryId.value =
                                        categoryController.category!.value!
                                            .children![index].id!;
                                    categoryController.selectedIndex.value =
                                        index;
                                  } else {
                                    Get.toNamed(AppRoutes.products, arguments: {
                                      'category': categoryController
                                          .category!.value!.children![index].id
                                    });
                                  }
                                },
                                labelType: NavigationRailLabelType.all,
                                destinations:
                                    List<NavigationRailDestination>.generate(
                                        categoryController.category!.value!
                                            .children!.length, (index) {
                                  Children child = categoryController
                                      .category!.value!.children![index];
                                  return NavigationRailDestination(
                                    icon: Container(
                                      padding: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                                  width: 4,
                                                  color: Colors.transparent))),
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor:
                                                  Colors.grey.shade100,
                                              radius: 34,
                                              child: Image.network(
                                                Uri.encodeFull(baseUrl +
                                                    '/storage/categories/${child?.image!}'),
                                              )),
                                          SizedBox(height: 5),
                                          Text("${child.name}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge)
                                        ],
                                      ),
                                    ),
                                    selectedIcon: Container(
                                      padding: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                                  width: 4,
                                                  color:
                                                      Colors.green.shade500))),
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor:
                                                  Colors.lightGreen.shade300,
                                              radius: 34,
                                              child: Image.network(
                                                Uri.encodeFull(baseUrl +
                                                    '/storage/categories/${child?.image!}'),
                                              )),
                                          SizedBox(height: 5),
                                          Text("${child.name}",
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge)
                                        ],
                                      ),
                                    ),
                                    label: Text(''),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                      ),

                      VerticalDivider(thickness: 1, width: 1),
                      // This is the main content.
                      Expanded(
                        child: Obx(
                          () => categoryController.isLoadingSub.value &&
                                  categoryController.subCategory != null
                              ? Center(child: CircularProgressIndicator())
                              : (categoryController
                                      .subCategory.value!.children!.isNotEmpty
                                  ? Wrap(
                                      children: List<Widget>.generate(
                                          categoryController.subCategory.value!
                                              .children!.length, (index) {
                                      return ChildCategoryCard(
                                          context,
                                          categoryController.subCategory.value!
                                              .children![index],
                                          null);
                                    }))
                                  : Center(
                                      child: Text(
                                          'No More Categories Available'))),
                        ),
                      )
                    ],
                  ),
                ),
        )));
  }
}
