import 'package:citymall/common_widgets/app_button.dart';
import 'package:citymall/components/button.dart';
import 'package:citymall/constants.dart';
import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/controllers/coupon_controller.dart';
import 'package:citymall/controllers/network_controller.dart';
import 'package:citymall/controllers/order_controller.dart';
import 'package:citymall/models/grocery_item.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/service/setting_service.dart';
import 'package:citymall/service/user_service.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/widgets/badge.dart';

import 'package:citymall/widgets/checkout_items.dart';
import 'package:citymall/widgets/expansion.dart';
import 'package:citymall/widgets/nointernet.dart';
import 'package:citymall/widgets/offer_discounts_row.dart';
import 'package:citymall/widgets/outlined_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class CheckoutScreen extends StatelessWidget {
  OrderController orderController = Get.find();
  CartController cartController = Get.find();
  SettingService settingService = Get.find();
  CouponController couponController = Get.put(CouponController());
  // var show_form = true.obs;
  // void toggle() {
  //   show_form.value = !show_form.value;
  // }

  @override
  Widget build(BuildContext context) {
    NetworkController nc=Get.find();
    return Obx(()=>nc.hasConnection.value?Scaffold(
      bottomNavigationBar: getOrderPlaceButton(context),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        )),
        elevation: 0,
        foregroundColor: Colors.white,
        title: Text(
          "Checkout",
        ),
        centerTitle: true,
        leading:
            InkWell(onTap: () => {Get.back()}, child: Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 2,
              ),
              child: Obx(() => orderController.current_timestamp.value>0?Column(
                    children: [
                      if (orderController.applied_coupon.value != null)
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 5),
                            margin: EdgeInsets.only(top: 15, bottom: 0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Colors.lightGreen, width: 2)),
                            child: ListTile(
                              enabled: false,
                              leading: const Icon(Icons.check_circle,
                                  color: Colors.green),
                              title: Text(
                                  " ${orderController.applied_coupon.value?.name} Coupon Applied Successfully",
                                  style: TextStyle(color: Colors.lightGreen)),
                              onTap: () {},
                            )),

                      Expansible(context, "Items Detail", ItemsDetail(context),
                          false, Icons.house),
                      Expansible(context, "Delivery Address",
                          ShippingDetail(context), true, Icons.house_outlined),
                      // SizedBox(
                      //   height: 20,
                      // ),

                      Expansible(
                          context,
                          "Billing Detail",
                          BillingDetail(context),
                          true,
                          Icons.receipt_long_rounded),
                      Card(
                          child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Select Payment Method',
                                style: AppTheme(context: context)
                                    .textTheme['titleMediumBold']),
                            SizedBox(height: 10),
                            Mode(context, orderController),
                          ],
                        ),
                      )),
                      SizedBox(height: 10),
                      Card(
                          child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Select Delivery Slot',
                                style: AppTheme(context: context)
                                    .textTheme['titleMediumBold']),
                            SizedBox(height: 10),
                            SlotPicker(context, orderController),
                          ],
                        ),
                      )),
                    ],
                  ):Text(''))),
        ),
      ),
    ):NoInternet(context));
  }

  Widget getOrderPlaceButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.grey, blurRadius: 5, spreadRadius: 0)
                ],
                color: AppTheme(context: context).colors['primary'],
                borderRadius: BorderRadius.circular(20)),
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextButton(
              onPressed: () {
                orderController.isSaving.value
                    ? null
                    : orderController.saveOrderToServer();
              },
              child: Obx(() => orderController.isSaving.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      'Place Order ${currency}${cartController.cart_amount.value - cartController.cart_level_discount.value + (cartController.delivery_charge.value - cartController.shipping_discount.value)}',
                      style: AppTheme(context: context)
                          .textTheme['titleLargeWhite'])),
            )));
  }

  Widget ItemsDetail(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.longestSide * .40),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: cartController.cart.length,
            itemBuilder: (BuildContext context, int index) {
              return CheckoutItemWidget(
                item: cartController.cart[index],
              );
            }));
  }

  Widget getButtonPriceWidget() {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Color(0xff489E67),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Obx(() => Text(
            "${currency}${orderController.net_payable.value}",
            style: TextStyle(fontWeight: FontWeight.w600),
          )),
    );
  }

  Widget BillingDetail(BuildContext context) {
    CartController cartController = Get.find();

    return Column(children: [
      BillingRow(context, "Price(${cartController.cart_count.value} items)",
          "${cartController.cart_amount_without_offer.value}"),
      Divider(),
      BillingRowOffer(
          context, "Offer Discount", '${'-'} ${currency}${cartController.offer_discount.value}'),
      Divider(),
      BillingRowOffer(context, "Total Tax", '${'+'} ${currency}${cartController.total_tax.value}'),
      Divider(),
      BillingRowOffer(context, "Delivery Charge",
          '${'+'} ${currency}${cartController.delivery_charge.value - cartController.shipping_discount.value}'),
      Divider(),
      if (orderController.applied_coupon.value != null) ...[
        BillingRowOffer(context, "Coupon Discount Worth",
            '${'-'} ${currency}${orderController.coupon_discount.value}'),
        Divider(),
      ],
      Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Total Payable",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            Text(
                "${currency}${cartController.cart_amount.value - cartController.cart_level_discount.value + (cartController.delivery_charge.value - cartController.shipping_discount.value)}",
                style: Theme.of(context).textTheme.titleLarge),
          ])),
    ]);
  }

  Widget BillingRow(BuildContext context, String title, String amount) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          Text("${currency}${amount}",
              style: Theme.of(context).textTheme.bodyLarge),
        ]));
  }

  Widget BillingRowOffer(BuildContext context, String title, String amount) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Obx(() => Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      Text("${amount}",
                          style: Theme.of(context).textTheme.bodyLarge),
                    ]),
                if (cartController.offerDiscountAr.length > 0)
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: cartController.offerDiscountAr.map((el) {
                        return DiscountOfferRowNoCal(el);
                      }).toList()),
                if (orderController.cart_level_discounts.length > 0)
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: orderController.cart_level_discounts.map((el) {
                        return DiscountOfferRow(
                            el, cartController.cart_amount.value);
                      }).toList()),
              ],
            )));
  }

  Widget ShippingDetail(BuildContext context) {
    UserService userService = Get.find();
    return Row(children: [
      Expanded(
          child: Text(
              '${userService.user?.address == null ? 'No Address Added' : userService.user?.address}')),
      IconButton(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            Get.toNamed(AppRoutes.map);
          },
          icon: Icon(Icons.edit))
    ]);
  }

  List<Widget> getChildrenWithSeperator(
      {required List<Widget> widgets,
      required Widget seperator,
      bool addToLastChild = true}) {
    List<Widget> children = [];
    if (widgets.length > 0) {
      children.add(seperator);

      for (int i = 0; i < widgets.length; i++) {
        children.add(widgets[i]);

        if (widgets.length - i == 1) {
          if (addToLastChild) {
            children.add(seperator);
          }
        } else {
          children.add(seperator);
        }
      }
    }
    return children;
  }

  Widget Mode(BuildContext context, OrderController oc) {
    return Column(children: [
      ListTile(
          title: Text('Cash On Delivery',
              style: AppTheme(context: context).textTheme['bodyLarge']),
          leading: Radio(
            activeColor: AppTheme(context: context).colors['primary'],
            value: 'COD',
            groupValue: oc.payment_method.value,
            onChanged: (value) {
              oc.payment_method.value = value!;
            },
          ),
          trailing: SizedBox(width:20,height:20,child:Image.asset('${assetUrl(context)}/cod.png'))),
      ListTile(
          title: Text('Pay Online',
              style: AppTheme(context: context).textTheme['bodyLarge']),
          leading: Radio<String>(
            activeColor: AppTheme(context: context).colors['primary'],
            value: 'Online',
            groupValue: oc.payment_method.value,
            onChanged: (value) {
              oc.payment_method.value = value!;
            },
          ),
          trailing: Icon(Icons.payment)),
    ]);
  }

  Widget SlotPicker(BuildContext context, OrderController oc) {
    List<String> slot_times =
        List<String>.from(settingService.setting!['delivery_slots'] as List);

    return Column(
      children: [
        DatePickerInput(context),
        SizedBox(height: 10),
        Wrap(alignment: WrapAlignment.start,
            children: List.generate(slot_times.length, (index) {
          return CircularBadge(context, slot_times[index]);
        })),
      ],
    );
  }

  Widget CircularBadge(BuildContext context, String label) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () {
        orderController.slot_time.value = label;
      },
      child: Obx(
        () => Container(
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: orderController.slot_time.value == label
                    ? Colors.lightGreen.shade50
                    : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(width: 1, color: Colors.lightGreen)),
            width: 200,
            height: 40,
            padding: EdgeInsets.all(4),
            child: Center(
                child: Text(label,
                    style: TextStyle(
                        color: AppTheme(context: context).colors['primary'])))),
      ),
    );
  }

  Widget DatePickerInput(BuildContext context) {
    return TextField(
      controller:
          orderController.slotDateInput, //editing controller of this TextField
      decoration: InputDecoration(
          icon: Icon(Icons.calendar_today), //icon of text field
          labelText: "Choose Delivery Date" //label text of field
          ),
      readOnly: true, //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime.now().add(Duration(days: 4)));

        if (pickedDate != null) {
          print(
              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          orderController.slotDateInput.text = formattedDate;
          print(
              formattedDate); //formatted date output using intl package =>  2021-03-16
        } else {}
      },
    );
  }
}
