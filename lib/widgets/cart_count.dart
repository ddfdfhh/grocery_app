import 'package:citymall/controllers/cart_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CartCount extends StatelessWidget {
  final Color? iconColor;
CartCount({this.iconColor});
  @override
  Widget build(BuildContext context) {
    CartController c = Get.find();
    print(c.cart_count);
    // TODO: implement build
    return Badge(
      child: SvgPicture.asset(
        "assets/icons/cart_icon.svg",color:iconColor!=null?iconColor:Colors.black
      ),
      label: Obx(() => Text(c.cart_count.toString())),
    );
  }
}
