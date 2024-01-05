import 'package:citymall/constants.dart';
import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/models/product.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/bottom_sheets/bottom_drawer.dart';
import 'package:citymall/widgets/cart_button.dart';
import 'package:citymall/widgets/counter.dart';
import 'package:citymall/widgets/price_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VegetableCardGrid extends StatelessWidget {
  final VoidCallback onTapCallback;
  final Function onVariantTapCallback;
  CartController cartController = Get.find();
  final Product item;
  VegetableCardGrid({
    Key? key,
    required this.item,
    required this.onVariantTapCallback,
    required this.onTapCallback,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
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
    sale_price = price - discount;
    double discount_percent = (discount / price) * 100;

    return Card(
        color: Color(0xffF3F5F7),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
            side: BorderSide(color: Colors.lightGreen)),
        elevation: 0,
        child: Stack(clipBehavior: Clip.none, children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: [
                Flexible(
                  fit:FlexFit.tight,
                    flex: 2,
                    child: InkWell(
                        onTap: () => {Get.toNamed(AppRoutes.detail)},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                              fit: BoxFit.cover,
                              baseUrl +
                                  '/storage/products/${item!.id}/${item!.image!}'),
                        ))),
                SizedBox(
                  height: 2,
                ),
                Text(
                  item!.name!,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Flexible(
                  fit:FlexFit.tight,
                  flex: 1,
                  child: Column(
                    children: [
                      Expanded(
                          child: Row(
                              mainAxisAlignment: item.hasVariant == 'Yes' &&
                                  item.variants!.isNotEmpty?MainAxisAlignment.spaceBetween:MainAxisAlignment.center,
                              children: [
                            if (item.hasVariant == 'Yes' &&
                                item.variants!.isNotEmpty)
                              GestureDetector(
                                  onTap: () {
                                    onVariantTapCallback(item);
                                  },
                                  child: Container(
                                      height: 30,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 4),
                                      margin:
                                          EdgeInsets.only(top: 6, bottom: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              width: .4,
                                              color: Colors.black26)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("${item.variants![0].name}",
                                                style: TextStyle(fontSize: 12)),
                                            Icon(Icons.keyboard_arrow_down,
                                                size: 10)
                                          ]))),
                            if (item.perQuantityOf! > 0 &&
                                item.perUnit!.isNotEmpty &&
                                item.perPrice! > 0)
                              Text(
                                  "(₹${item.perPrice ?? '0.0'!}/${item.perQuantityOf!}${item.perUnit!})",
                                  style: TextStyle(fontSize: 12))
                          ])),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PriceWithSalePrice(context, price, sale_price),
                          Expanded(child:SizedBox(width: 10)),
                          CartButton(qtyUpdateCallback: (mode, qty) {
                            cartController.updateCart(
                                item,
                                qty,
                                mode,
                                item.variants!.isNotEmpty
                                    ? item.variants![0]
                                    : null);
                          })
                        ],
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if(discount_percent>0)Positioned(
              top: 0,
              left: 1,
              child: Container(
                  height: 23,
                  width: 80,
                  decoration: BoxDecoration(
                      color: AppTheme(context: context).colors['red'],
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )),
                  child: Center(
                      child: Text('${discount_percent} OFF',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)))))
        ]));
  }
}
