import 'package:auto_size_text/auto_size_text.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/widgets/counter.dart';
import 'package:citymall/widgets/expansion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:citymall/models/coupon.dart';

OfferListDetailSheet(BuildContext context, List<Map<String, dynamic>> offers) {
  return showModalBottomSheet<void>(
    // context and builder are
    // required properties in this widget
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15))),
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Applicable Offers',
                            style: AppTheme(context: context)
                                .textTheme['titleLargeBoldColor']),
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.coupons);
                            //OfferListDetailSheet(context, cartController.applicable_offers.value);
                          },
                          child: Text('View All Offers',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: offers.length,
                    itemBuilder: (BuildContext context, int index) {
                      var offer = offers[index];
                      return ExpansionTile(
                        initiallyExpanded: false,
                        expandedAlignment: Alignment.topLeft,
                        leading: Icon(Icons.discount_outlined,
                            color:
                                AppTheme(context: context).colors['primary']),
                        title: Text('${offer['coupon_name']}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold)),
                        children: [
                          Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          width: 1, color: Colors.black12))),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: offer['coupon_details'] != null
                                  ? Html(data: '${offer['coupon_details']}')
                                  : Text('')),
                        ],
                      );
                    })
              ]),
        ),
      );
    },
  );
}
