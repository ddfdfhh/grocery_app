import 'package:auto_size_text/auto_size_text.dart';
import 'package:citymall/widgets/counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:citymall/models/coupon.dart';
CouponDetailSheet(BuildContext context,Coupon coupon) {
  return showModalBottomSheet<void>(
    enableDrag: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            )),
        //height: 300,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Coupon Details",
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 4),
                  Text("${coupon.couponCode}",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                 const Divider(),
                  Html(data:'${coupon.details}'),

                ],
              ),
            )),
      );
    },
  );
}
