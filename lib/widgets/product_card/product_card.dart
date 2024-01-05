import 'package:citymall/constants.dart';
import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/models/product.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/util.dart';
import 'package:citymall/bottom_sheets/bottom_drawer.dart';
import 'package:citymall/widgets/cart_button.dart';
import 'package:citymall/widgets/counter.dart';
import 'package:citymall/widgets/price_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

Widget ProductCard(
    BuildContext context,
    Product item,
    void Function() onTapCallback,
    String? showSaleBadge,
    String? borderColor,
    String? backgroundColor) {
  double price =
      item.variants != null ? (item.variants![0].price!) : (item.price!);

  double sale_price = item.variants != null
      ? (item.variants![0].salePrice!)
      : (item.salePrice! > 0 ? item.salePrice! : 0);

  double discount = item.discountType != null && item.discount != null
      ? (item.discountType == 'Flat'
          ? item.discount
          : (price * item.discount! / 100))!
      : 0;

  double final_price = price - discount;
  double discount_percent = (discount / price) * 100;
  return Card(
      color: backgroundColor != null
          ? getColorFromHexString(backgroundColor!)
          : Colors.lightGreen,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
          side: BorderSide(color: Colors.lightGreen)),
      elevation: 0,
      child: Stack(clipBehavior: Clip.none, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                  child: InkWell(
                      onTap: () => {Get.toNamed(AppRoutes.detail)},
                      child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(20),
                          color: Colors.white,
                          dashPattern: [2, 4],
                          strokeWidth: 2,
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                  child: Image.asset(
                                      'assets/images/carrots.png')))))),
              SizedBox(
                height: 1,
              ),
              Container(
                  height: 30,
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.black)),
                  child: Center(
                      child: Text(
                          'Deal Price ${currency}${final_price.toStringAsFixed(2)}',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(fontWeight: FontWeight.bold)))),
              SizedBox(height: 5),
              Text('Regular Price ${currency}${sale_price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold))
            ],
          ),
        ),
        Positioned(
            top: 0,
            left: 1,
            child: Container(
                height: 23,
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
                child: Center(
                    child: Text('${discount_percent}% OFF',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.white)))))
      ]));
}
