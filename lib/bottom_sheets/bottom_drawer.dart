import 'package:cached_network_image/cached_network_image.dart';
import 'package:citymall/constants.dart';
import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/util.dart';
import 'package:citymall/widgets/cart_button.dart';
import 'package:citymall/widgets/counter.dart';
import 'package:citymall/widgets/imageWidget.dart';
import 'package:citymall/widgets/price_widget.dart';
import 'package:citymall/widgets/price_widget_row_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/product.dart';

BottomDrawer(BuildContext context, Product item) {
  //AppTheme appTheme = Get.find<AppTheme>();

  return showModalBottomSheet<void>(
    //   isScrollControlled:true,
    // context and builder are
    // required properties in this widget
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15))),
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select Variant',
                    style: Theme.of(context)
                        .textTheme
                        ?.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text(' ${toUpperCase(item.name!)}',
                    style: Theme.of(context).textTheme?.titleLarge),
                SizedBox(height: 15),
                SizedBox(
                  // height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: item.variants!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductStrip(
                            context, item, item.variants![index]);
                      }),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget ProductStrip(BuildContext context, Product item, Variants variant) {
  CartController cartController = Get.find();

  return ListTile(
    leading: SizedBox(
      height: 40,
      width: 40,
      child: item.thumbnail != null
          ?CachedImageWidget(context, '${baseUrl}/storage/products/${item.id!}/thumbnail/${item.thumbnail!.tiny}', null, null, null)
          : Image.asset('${assetUrl(context)}/no-image.jpg'),
    ),
    title: Text("${variant!.name!}",
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontWeight: FontWeight.bold)),
    trailing: SizedBox(
        width: 120,
        height: 30,
        child:
            //CartButton(qtyUpdateCallback: (mode, qty) {})
            variant.quantity!> 0
                ? CartButton(
                    qtyUpdateCallback: (mode, qty) {
                      cartController.updateCart(item, qty, mode, variant);
                    },
                    maxQtyAllowed: variant.maxQuantityAllowed!,
                    initialQty: cartController.checkProductQtyInCart(
                        item.id!, variant.id),
                  )
                : const Text('Out Of Stock',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold))),
    subtitle: PriceWithSalePriceRowForm(
        align: MainAxisAlignment.start,
        context,
        variant.price! as double,
        variant.salePrice as double?),
    selected: true,
    onTap: () {},
  );
}
