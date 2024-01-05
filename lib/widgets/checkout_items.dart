import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:citymall/common_widgets/app_text.dart';
import 'package:citymall/constants.dart';
import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/models/cart_model.dart';
import 'package:citymall/models/grocery_item.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/widgets/badge.dart';
import 'package:citymall/widgets/imageWidget.dart';
import 'package:citymall/widgets/item_counter_widget.dart';
import 'package:citymall/widgets/price_widget.dart';
import 'package:citymall/widgets/price_widget_row_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckoutItemWidget extends StatefulWidget {
  CheckoutItemWidget({Key? key, required this.item}) : super(key: key);
  final CartItem item;

  @override
  _CheckoutItemWidgetState createState() => _CheckoutItemWidgetState();
}

class _CheckoutItemWidgetState extends State<CheckoutItemWidget> {
  final double height = 110;

  final Color borderColor = Color(0xffE2E2E2);

  final double borderRadius = 18;

  int amount = 1;

  @override
  Widget build(BuildContext context) {
    CartItem item = widget.item;
    CartController cartController = Get.find();
    double total_price = item.netCartAmount!;
    return Card(
      color:  (item.productDiscountOfferDetail != null &&
          item.productDiscountOfferDetail!.isNotEmpty)
          ? Colors.pink.shade500
          : null,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
                leading: imageWidget(item),
                title: AutoSizeText('${toBeginningOfSentenceCase(item.name)}',
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme(context: context)
                        .textTheme['titleMediumBlack']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    if (item.variantName != null)
                      AppText(
                          text: item.variantName != null
                              ? item.variantName!
                              : item.name!,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    AppText(
                        text: 'Quantity- ${item.numOfItem}',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppTheme(context: context).colors['primary']),
                  ],
                ),
                trailing: Container(
                  width: 70,
                  child: total_price > 0
                      ? PriceWithSalePrice(context,item.price,item.netCartAmount)
                      : TextBadge(height: 30, text: 'Free'),
                )),
          ),
          if (item.isCombo == 'Yes')
            Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                decoration: BoxDecoration(
                    color: Colors.transparent,
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
                      Expanded(
                        child: Text('You\'ve got this item as Combo Offer ',
                            style: AppTheme(context: context)
                                .textTheme['titleMediumWhiteShadow']),
                      )
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
                child: Row(mainAxisSize:MainAxisSize.min,children: [
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
                  Column(mainAxisAlignment:MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(' Offer Applied ',
                          style: AppTheme(context: context)
                              .textTheme['titleMediumWhiteBoldShadow']),
                     Text('${item.productDiscountOfferDetail!}',
                          style: AppTheme(context: context)
                              .textTheme['titleMediumWhiteShadow']),
                    ],
                  )
                ]))
        ],
      ),
    );
  }

  Widget imageWidget(CartItem item) {
    var imageUrl = item.image;
    return Container(
      width: 50,
      child: imageUrl != null
          ? CachedImageWidget(Get.context as BuildContext,imageUrl,null,null,null)
          : Image.asset('${assetUrl(context)}/no-image.jpg'),
    );
  }
}
