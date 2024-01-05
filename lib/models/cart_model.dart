import 'dart:convert';

import 'package:citymall/models/dicount_rule.dart';
import 'package:flutter/material.dart';
// import 'package:xid/xid.dart';
import 'grocery_item.dart';

class CartItem {
  int? id;
  String? cartSessionId;
  late final int productId;
  late final int categoryId;
  int? variantId;
  int numOfItem = 0;
  String name = '';
  double price = 0.0;
  double salePrice = 0.0;
  String? variantName;
  List<DiscountRule>? discountRules;

  double? sgst = 0;
  double? cgst = 0;
  double? igst = 0;
  String? image;
  String? unit;
  String? isCombo = 'No';
  String? discountType;
  double? discount = 0;
  int? maxQtyAllowed;
  int? discountAppliesOnQty;
  String? productDiscountOfferDetail;
  double? netCartAmount;
  double? totalDiscount;
  double? totalTax;
  CartItem(
      {this.id,
      required this.productId,
      this.variantId,
      this.cartSessionId,
      required this.name,
      this.variantName,
      required this.numOfItem,
      required this.price,
      required this.categoryId,
      required this.salePrice,
      this.discountRules,
      required this.sgst,
      required this.cgst,
      required this.igst,
      required this.image,
      required this.unit,
      this.isCombo,
      this.maxQtyAllowed,
      this.discountType,
      this.discount,
      this.netCartAmount,
      this.totalDiscount,
      this.totalTax,
      this.productDiscountOfferDetail});
  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    productId = json['product_id'];
    variantId = json['variant_id'];
    variantName = json['variant_name'];
    maxQtyAllowed = json['max_qty_allowed'];
    categoryId = json['category_id'];

    cartSessionId = json['cart_session_id'];
    numOfItem = json['qty'];

    price = json['price'].runtimeType==int?json['price'].toDouble():double.parse(json['price']);
    salePrice = json['sale_price'].runtimeType==int?json['sale_price'].toDouble():double.parse(json['sale_price']);
    sgst = json['sgst'].runtimeType==int?json['sgst'].toDouble():double.parse(json['sgst']);
    cgst = json['cgst'].runtimeType==int?json['cgst'].toDouble():double.parse(json['cgst']);
    igst = json['igst'].runtimeType==int?json['igst'].toDouble():double.parse(json['igst']);
    image = json['image'];
    unit = json['unit'];
    productDiscountOfferDetail = json['product_discount_offer_detail'];
    isCombo = json['is_combo'];
    discountType = json['discount_type'];
    productDiscountOfferDetail = json['product_discount_offer_detail'];
    discount = json['discount'].runtimeType==int?json['discount'].toDouble():double.parse(json['discount']);
    totalTax=json['total_tax'].runtimeType==int?json['total_tax'].toDouble():double.parse(json['total_tax']);
    netCartAmount = json['net_cart_amount'].runtimeType==int?json['net_cart_amount'].toDouble():double.parse(json['net_cart_amount']);
    totalDiscount = json['total_discount'].runtimeType==int?json['total_discount'].toDouble():double.parse(json['total_discount']);

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id != null ? this.id.toString() : '';
    data['product_id'] = this.productId.toString();
    data['category_id'] = this.categoryId.toString();
    data['variant_id'] =
        this.variantId != null ? this.variantId.toString() : '';
    data['variant_name'] = this.variantName ?? '';
    data['name'] = this.name;
    data['cart_session_id'] = this.cartSessionId ?? '';
    data['qty'] = this.numOfItem.toString();
    data['price'] = this.price.toString();
    data['max_qty_allowed'] = this.maxQtyAllowed.toString();
   data['total_tax']=this.totalTax.toString();
    if (this.discountRules != null) {
      data['discount_rules'] =
          jsonEncode(this.discountRules!.map((v) => v.toJson()).toList());
    }
    data['net_cart_amount'] = this.netCartAmount.toString();
    data['total_discount'] = this.totalDiscount.toString();
    data['sale_price'] =
        this.salePrice != null ? this.salePrice.toString() : '0.0';
    data['sgst'] = this.sgst.toString();
    data['cgst'] = this.cgst.toString();
    data['igst'] = this.igst.toString();
    data['image'] = this.image;
    data['unit'] = this.unit ?? '';
    data['is_combo'] = this.isCombo ?? 'No';
    data['discount_type'] = this.discountType ?? '';
    data['discount'] = this.discount.toString();
    data['total_tax'] = this.totalTax.toString();
    data['product_discount_offer_detail'] =
        this.productDiscountOfferDetail ?? '';
    //  data['discount_applies_on_qty'] = this.discountAppliesOnQty ?? '';

    return data;
  }
}

// Demo data for our cart
