import 'package:citymall/constants.dart';
import 'package:citymall/controllers/category_controller.dart';
import 'package:citymall/controllers/dashboard_controller.dart';
import 'package:citymall/controllers/product_controller.dart';
import 'package:citymall/models/content_section.dart';
import 'package:citymall/models/product.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/bottom_sheets/bottom_drawer.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/util.dart';
import 'package:citymall/widgets/category/circular_category.dart';
import 'package:citymall/widgets/category/circular_collection.dart';
import 'package:citymall/widgets/category/simple_collection_card.dart';
import 'package:citymall/widgets/category/wrapper_image_category_card.dart';
import 'package:citymall/widgets/product_card/product_card.dart';
import 'package:citymall/widgets/vegetable_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../category/simple_category_card.dart';
import '../product_card/grid_vegatble_card.dart';

Widget DealContainer(BuildContext context, ContentSection cs) {
  ProductController productController = Get.find();
  DashboardController dc = Get.find();

  String content_type = cs!.products!.length > 0
      ? 'product'
      : (cs!.categories!.length > 0 ? 'category' : 'collection');

  int item_length = content_type == 'product'
      ? (cs.products!.length)
      : (content_type == 'category'
          ? cs.categories!.length
          : cs.collections!.length);
  bool showViewMore = item_length > cs!.itemCount! ? true : false;

  return cs.display == 'Vertical'
      ? Container(
          // height: content_type != 'product' ? 270 : 230,
          decoration: BoxDecoration(
              color: cs?.sectionBackgroundColor != null && cs.sectionBackgroundColor!='#000000'
                  ? getColorFromHexString(cs!.sectionBackgroundColor!)
                  : null,
              image: cs.sectionBackgroundImage != null
                  ? DecorationImage(
                      image: NetworkImage(Uri.encodeFull(baseUrl +
                          '/storage/content_sections/${cs.sectionBackgroundImage}')),
                      fit: BoxFit.fill)
                  : null),
          padding: cs.sectionBackgroundImage != null
              ? EdgeInsets.only(top: 70, bottom: 20, left: 10)
              : (cs.sectionBackgroundColor != null
                  ? EdgeInsets.only(top: 20, bottom: 20, left: 10)
                  : null),
          child: MasonryGridView.count(
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: showViewMore ? cs.itemCount! : item_length,
            itemBuilder: (BuildContext context, int index) {
              return content_type == 'product'
                  ? ShowProduct(context, cs, index, productController)
                  : (content_type == 'category'
                      ? ShowCategory(context, cs, index)
                      : ShowCollections(context, cs, index));
            },
            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: content_type == 'product' ? 2 : 3,
            // childAspectRatio: is_product ? 0.78 : 0.7,
            // crossAxisSpacing: 2 //<-SEE HERE
          ))
      : Container(
          // height: cs.sectionBackgroundImage != null
          //     ? (content_type != 'product' ? 270 : 300)
          //     : (content_type != 'product' ? 190 : 210),
          decoration: BoxDecoration(
              color: cs?.sectionBackgroundColor != null && cs.sectionBackgroundColor!='#000000'
                  ? getColorFromHexString(cs!.sectionBackgroundColor!)
                  : null,
              image: cs.sectionBackgroundImage != null
                  ? DecorationImage(
                      image: NetworkImage(Uri.encodeFull(baseUrl +
                          '/storage/content_sections/${cs.sectionBackgroundImage}')),
                      fit: BoxFit.fill)
                  : null),

          padding: cs.sectionBackgroundImage != null
              ? EdgeInsets.only(top: 70, bottom: 20, left: 10)
              : (cs.sectionBackgroundColor != null
                  ? EdgeInsets.only(top: 20, bottom: 20, left: 10)
                  : null),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                        showViewMore ? cs.itemCount! + 1 : item_length,
                        (index) {
                      return (content_type == 'product'
                          ? SizedBox(
                              width: 180,
                              //  height: 200,
                              child: ShowProduct(
                                  context, cs, index, productController),
                            )
                          : (content_type == 'category'
                              ? ShowCategory(context, cs, index)
                              : ShowCollections(context, cs, index)));
                    })),
              ),
            ],
          ),
        );
}

Widget HorizontalContent(ContentSection cs, String content_type) {
  ProductController productController = Get.find();

  int item_length = content_type == 'product'
      ? (cs.products!.length)
      : (content_type == 'category'
          ? cs.categories!.length
          : cs.collections!.length);
  return SizedBox(
      height: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: item_length > 7 ? 8 : item_length,
          itemBuilder: (BuildContext context, int index) {
            return (item_length > 7 && index > 7)
                ? InkWell(
                    onTap: () {},
                    child: Center(
                      child: RotationTransition(
                          turns: new AlwaysStoppedAnimation(90 / 360),
                          child: const Text('View More ')),
                    ))
                : (content_type == 'product'
                    ? SizedBox(
                        width: 200,
                        //  height: 200,
                        child:
                            ShowProduct(context, cs, index, productController),
                      )
                    : (content_type == 'category'
                        ? ShowCategory(context, cs, index)
                        : ShowCollections(context, cs, index)));
          }));
}

Widget GridContent(ContentSection cs, String content_type) {
  ProductController productController = Get.find();

  double factor = content_type == 'product'
      ? (cs.products!.length / 2)
      : (content_type == 'collection'
          ? cs.collections!.length / 2
          : cs.categories!.length / 2);
  return MasonryGridView.count(
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: content_type == 'product'
          ? cs.products!.length
          : (content_type == 'collection'
              ? cs.collections!.length
              : cs.categories!.length),
      itemBuilder: (BuildContext context, int index) {
        return content_type == 'product'
            ? ShowProduct(context, cs, index, productController)
            : (content_type == 'category'
                ? ShowCategory(context, cs, index)
                : ShowCollections(context, cs, index));
      },
      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: content_type == 'product' ? 2 : 3,
      // childAspectRatio: is_product ? 0.78 : 0.7,
      crossAxisSpacing: 2 //<-SEE HERE
      );
}

Widget ShowProduct(BuildContext context, ContentSection cs, int index,
    ProductController productController) {
  return VegetableCardWidget(
    context: context,
    item: cs.products![index],
    onVariantTapCallback: (Product item) {
      productController.selectedProduct(item);
      BottomDrawer(context, item);
    },
    onTapCallback: () {
      Get.toNamed(AppRoutes.product_detail, arguments: {'product': 1});
    },
  );
}

Widget ShowCategory(BuildContext context, ContentSection cs, int index) {
  CategoryController categoryController = Get.find();
  ProductController productController = Get.find();
  return GestureDetector(
    onTap: () {
      if (cs.categories![index].childrenCount < 1) {
        productController.categoryId.value = cs.categories![index].id!;
        Get.toNamed(AppRoutes.products);
      } else {
        categoryController.categoryId.value = cs.categories![index].id!;
        Get.toNamed(AppRoutes.categories);
      }
    },
    child: (cs.showCategoryInCircle != null && cs.showCategoryInCircle == 'Yes')
        ? CircluarCategory(context, cs.categories![index], cs)
        : (cs.wrapperImage != null
            ? WrapperImageCategoryCard(context, cs.categories![index], cs)
            : SimpleCategoryCard(context, cs.categories![index], cs)),
  );
}

Widget ShowCollections(BuildContext context, ContentSection cs, int index) {
  CategoryController categoryController = Get.find();
  ProductController productController = Get.find();
  return GestureDetector(
    onTap: () {
      productController.collectionId.value = cs.collections![index].id!;
      productController.collectionName.value = cs.collections![index].title!;
      Get.toNamed(AppRoutes.collectionProducts);
    },
    child: cs.showCategoryInCircle != 'Yes'
        ? SimpleCollectionCard(context, cs.collections![index]!, cs)
        : CircluarCollection(context, cs.collections![index], cs),
  );
}
