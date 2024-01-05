import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:citymall/common_widgets/app_text.dart';
import 'package:citymall/constants.dart';
import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/dialog/dialog.dart';
import 'package:citymall/models/cart_model.dart';
import 'package:citymall/models/dicount_rule.dart';
import 'package:citymall/models/grocery_item.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/widgets/badge.dart';
import 'package:citymall/widgets/cart_button.dart';
import 'package:citymall/widgets/imageWidget.dart';
import 'package:citymall/widgets/item_counter_widget.dart';
import 'package:citymall/widgets/price_widget.dart';
import 'package:citymall/widgets/price_widget_row_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

Widget CartItemWidget(BuildContext context, CartItem item,
    Function qtyUpdateCallback, int index, Function deleteCartItemCallback) {
  CartController cartController = Get.find();
  double total_price = item.price * item.numOfItem;
  double sale_price = item.netCartAmount!;

  return Card(
      color: (item.productDiscountOfferDetail != null &&
              item.productDiscountOfferDetail!.isNotEmpty)
          ? Colors.pink.shade500
          : null,
      child: Column(children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(children: [
            Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    imageWidget(item.image, context),
                    SizedBox(height: 10),
                    OutlinedButton(
                        onPressed: () {
                          deleteCartItemCallback();
                        },
                        child: Obx(()=>cartController.isDeleting.value && cartController.isDeletingItemId.value==item.id!
                            ?const SizedBox(width:10,height:10,child:const CircularProgressIndicator(strokeWidth:2))
                            :Icon(Icons.delete_forever, color: Colors.deepOrange)))
                  ],
                )),
            Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AutoSizeText('${toBeginningOfSentenceCase(item.name)}',
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme(context: context)
                            .textTheme['titleMediumBlack']),
                    SizedBox(
                      height: 5,
                    ),
                    if (item.variantName != null)
                      AppText(
                          text:
                              '${toBeginningOfSentenceCase(item.variantName)}',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    Text('Quantity- ${item.numOfItem} ',
                        style: AppTheme(context: context)
                            .textTheme['bodyMediumColor']),
                    SizedBox(
                      height: 9,
                    ),
                  ],
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                PriceWithSalePriceRowForm(context, total_price, sale_price,
                    cart_qty: 1),
                /***1 because already multilied by qty here in top***/
                SizedBox(height: 10),

                if (item.isCombo != 'Yes')
                  SizedBox(
                      width: 90,
                      child: CartButton(
                        qtyUpdateCallback: (mode, qty) {
                          cartController.updateCartQty(
                              item.productId,
                              qty,
                              mode,
                              item.variantId != null ? item.variantId : null);
                        },
                        maxQtyAllowed: item.maxQtyAllowed!,
                        initialQty: cartController.checkProductQtyInCart(
                            item.productId,
                            item.variantId != null ? item.variantId : null),
                      ))
              ],
            )
          ]),
        ),
        if (item.isCombo == 'Yes')
          Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              child: Column(
                children: [
                  Row(children: [
                    Icon(Icons.card_giftcard, color: Colors.white, shadows: [
                      Shadow(
                        color: Colors.black, // Choose the color of the shadow
                        blurRadius:
                            2.0, // Adjust the blur radius for the shadow effect
                        offset: Offset(2.0,
                            2.0), // Set the horizontal and vertical offset for the shadow
                      )
                    ]),
                    SizedBox(width: 5),
                    Text(' Hurray!  ',
                        style: AppTheme(context: context)
                            .textTheme['titleMediumWhiteBoldShadow']),
                    Text('You\'ve got this item as Combo Offer ',
                        style: AppTheme(context: context)
                            .textTheme['titleMediumWhiteShadow'])
                  ]),
                ],
              )),
        if (item.productDiscountOfferDetail != null &&
            item.productDiscountOfferDetail!.isNotEmpty)
          Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              child: Row(children: [
                Icon(Icons.discount_outlined, color: Colors.white, shadows: [
                  Shadow(
                    color: Colors.black, // Choose the color of the shadow
                    blurRadius:
                        2.0, // Adjust the blur radius for the shadow effect
                    offset: Offset(2.0,
                        2.0), // Set the horizontal and vertical offset for the shadow
                  )
                ]),
                SizedBox(width: 10),
                Column(mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Offer Applied ',
                        style: AppTheme(context: context)
                            .textTheme['titleMediumWhiteBoldShadow']),
                     Text('${item.productDiscountOfferDetail!}',
                          maxLines:2,
                          style: AppTheme(context: context)
                              .textTheme['titleMediumWhiteShadow']),

                  ],
                )
              ]))
      ]));
}

Widget imageWidget(String? imageUrl, context) {
  return Container(
    width: 50,
    child: imageUrl != null
        ?  CachedImageWidget(Get.context as BuildContext,imageUrl, null, null,null)
        : Image.asset('${assetUrl(context)}/no-image.jpg'),
  );
}
