import 'package:citymall/bottom_sheets/bottom_drawer.dart';
import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/controllers/product_controller.dart';
import 'package:citymall/models/product.dart';
import 'package:citymall/widgets/vegetable_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

Widget ProductGrid(BuildContext context, List<Product?> products) {
  CartController cartController = Get.find();
  ProductController pc = Get.find();

  return LayoutBuilder(builder: (context, constraints) {
    return  MasonryGridView.count(
      shrinkWrap: true,

      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: products.length,
      itemBuilder: (context, index) {
        var product =products[index]!;
        return VegetableCardWidget(
          context:context,
          item: product,
          onVariantTapCallback: (Product item) {
            pc.selectedProduct(item);
            BottomDrawer(context, item);
          },
          onTapCallback: () {
            // Get.toNamed(AppRoutes.product_detail,
            //     arguments: {'product': '1'});
          },
        );
      },
      crossAxisCount: 2,
    );
  });
}
