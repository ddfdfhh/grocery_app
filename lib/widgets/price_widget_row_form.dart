import 'package:flutter/material.dart';
import 'package:citymall/styles/theme.dart';
Widget PriceWithSalePriceRowForm(
    BuildContext context, double price, double? salePrice,
    {MainAxisAlignment align=MainAxisAlignment.center,int cart_qty=1}) {
  price=price!*cart_qty;
  salePrice=salePrice!*cart_qty;
  bool linethru = salePrice! >=0 && salePrice! < price ? true : false;
  return Row(mainAxisAlignment:align,children: [
    Text('₹${price.toStringAsFixed(2)}',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            decoration:
                linethru ? TextDecoration.lineThrough : TextDecoration.none,
            color: linethru?Colors.black54:AppTheme(context:context).colors['primary'])),
    if (salePrice < price)
      Text(
        ' ₹${salePrice != null ? salePrice.toStringAsFixed(2) : price.toStringAsFixed(2)}',
        style: TextStyle(
            color: AppTheme(context:context).colors['primary'],
            fontSize: 15,
            fontWeight: FontWeight.bold),
      )
  ]);
}
