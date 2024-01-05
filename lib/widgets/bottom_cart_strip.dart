import 'package:citymall/components/button.dart';
import 'package:citymall/constants.dart';
import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/controllers/product_controller.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/widgets/badge.dart';
import 'package:citymall/widgets/button_with_icon_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomCartStrip extends StatelessWidget {
  CartController cartController = Get.put(CartController());
  ProductController productController = Get.find();
  @override
  Widget build(BuildContext context) {
    // CartController cartController=Get.find();
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
            // boxShadow:[ BoxShadow(
            //   color:Colors.grey.shade200,blurRadius: 20,spreadRadius: 2
            //
            // )],
            color: AppTheme(context: context).colors['primary'],
            borderRadius: BorderRadius.circular(20)),
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Obx(() =>
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(children: [
                Text(" ${cartController.cart_count.value} item(s) . ",
                    style: AppTheme(context: context)
                        .textTheme['titleMediumWhite']),
                SizedBox(width: 10),
                Text("${currency}${cartController.cart_amount.value}",
                    style: AppTheme(context: context)
                        .textTheme['titleMediumWhite']),
               // Expanded(child: SizedBox(width:1)),
                Expanded(
                  child: TextButton.icon(
                      onPressed: () {
                        Get.toNamed(AppRoutes.cart,arguments:{
                          'category':productController.categoryId.value
                        });
                      },
                      icon: Text('View Cart',
                          style: AppTheme(context: context)
                              .textTheme['titleMediumWhite']),
                      label: Icon(Icons.keyboard_double_arrow_right,
                          color: Colors.white)),
                )
              ]),
            ])),
      ),
    );
  }
}
