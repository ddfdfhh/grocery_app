import 'package:citymall/constants.dart';
import 'package:citymall/widgets/badge.dart';
import 'package:flutter/material.dart';

Widget DiscountOfferRow(Map<String,dynamic> disItem,double cart_amount){

  double discount_amount=disItem['discount_type']=='Flat'
                           ?double.parse(disItem['discount'])
                            :cart_amount*cart_amount/100;
     return Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children:[
           TextBadge(height:30,text:disItem['rule_name']),
           Text('-${currency}${discount_amount}')

       ]
     );

}
Widget DiscountOfferRowNoCal(Map<String,dynamic> disItem){

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children:[
        TextBadge(height:30,text:disItem['name']),
        Text('-${currency}${disItem['amount']}')

    ]
  );
}