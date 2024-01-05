import 'package:auto_size_text/auto_size_text.dart';
import 'package:citymall/constants.dart';
import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/controllers/product_controller.dart';
import 'package:citymall/models/product.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/bottom_sheets/bottom_drawer.dart';
import 'package:citymall/widgets/cart_button.dart';
import 'package:citymall/widgets/counter.dart';
import 'package:citymall/widgets/imageWidget.dart';
import 'package:citymall/widgets/price_widget.dart';
import 'package:citymall/widgets/price_widget_row_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Widget VegetableCardWidget({
  required BuildContext context,
  required Function onTapCallback,
  required Product item,
  Function? onVariantTapCallback,
}) {
  CartController cartController = Get.find();
  ProductController pc = Get.find();
  double discount_percent =
      ((item.price! - item.salePrice!) * 100) / item.price!;
  String discount_text = item.discountType != null
      ? (item.discountType == 'Flat'
          ? '${currency}${item.discount}'
          : '${item.discount!.ceil()}%')
      : '${discount_percent.ceil()}%';

  return Card(
      //color: Color(0xffF3F5F7),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(6.0),
      //   side:BorderSide(color:Colors.black12)
      // ),
      // elevation: 5,
      child: Stack(clipBehavior: Clip.none, children: [
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              height: 120,
              child: GestureDetector(
                  onTap: () {
                    pc.productId.value = item.id!;
                    pc.isLoading.value = true;
                    Future.delayed(Duration(milliseconds: 600), () async {
                      Get.toNamed(AppRoutes.product_detail);
                    });
                  },
                  child: CachedImageWidget(context,baseUrl +
                      '/storage/products/${item!.id}/${item!.image!}',null,null,null))),
          Center(
              child: GestureDetector(
            onTap: () => {
              Get.toNamed(AppRoutes.detail, arguments: {'product': item.id!})
            },
            child: AutoSizeText(maxLines:1,overflow:TextOverflow.ellipsis,
              '${toBeginningOfSentenceCase(item!.name!)}',
              textAlign: TextAlign.center,
              style: AppTheme(context: context).textTheme['bodyLargeBold'],
            ),
          )),
          Container(
              height: 60,
              child: Column(mainAxisSize: MainAxisSize.min,
                children: [
                  if (item.variants!.isNotEmpty)
                    GestureDetector(
                        onTap: () {
                          if (onVariantTapCallback != null)
                            onVariantTapCallback(item);
                        },
                        child: Container(
                            //height: 30,
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 4),
                            margin: EdgeInsets.only(top: 6, bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: .4, color: Colors.black26)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  AutoSizeText("${item.variants![0].name}",
                                      style: AppTheme(context: context)
                                          .textTheme['bodyMediumBold']),
                                  AutoSizeText(
                                      "(${currency}${item.variants![0].salePrice})",
                                      style: AppTheme(context: context)
                                          .textTheme['light']),
                                  Icon(Icons.keyboard_arrow_down, size: 10)
                                ]))),
                  if (item.perQuantityOf! > 0 &&
                      item.perUnit!.isNotEmpty &&
                      item.perPrice! > 0)
                    Text(
                        "(₹${item.perPrice ?? '0.0'!}/${item.perQuantityOf!}${item.perUnit!})",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12)),
                ],
              )),
         // SizedBox(height: 5),
          PriceWithSalePriceRowForm(context, item.price!, item.salePrice),
          SizedBox(height: 10),
          CartButton(
            qtyUpdateCallback: (mode, qty) {
              cartController.updateCart(
                  item,
                  qty,
                  mode,
                  item.variants != null && item.variants!.isNotEmpty
                      ? item.variants![0]
                      : null);
            },
            maxQtyAllowed:item.variants != null && item.variants!.isNotEmpty
                ? item.variants![0].maxQuantityAllowed!
                :(item.maxQuantityAllowed != null ? item.maxQuantityAllowed! : 5),
            initialQty: cartController.checkProductQtyInCart(item.id!, null),
          ),
        ],
      ),
    ),
    if (item.quantity != null && item.quantity! < 1)
      Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
              color: Colors.white.withOpacity(.5),
              child: Image.asset('${assetUrl(context)}/out_of_stock.png'))),
    if (discount_text.isNotEmpty)
      Positioned(
          top: 0,
          left: 1,
          child: Container(
              height: 23,
              width: 80,
              decoration: BoxDecoration(
                  color: AppTheme(context: context).colors['secondary'],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(50),
                  )),
              child: Center(
                  child: AutoSizeText('${discount_text} OFF',
                      style: AppTheme(context: context)
                          .textTheme['bodySmallWhite']))))
  ]));
}
