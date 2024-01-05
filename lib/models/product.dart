import 'dart:convert';

import 'package:citymall/models/category.dart';
import 'package:citymall/models/images.dart';
import 'package:citymall/models/thumbnail.dart';

class Product {
  int? id;
  String? name;
  String? description;
  String? features;
  String? specifications;
  double? price;
  double? salePrice;
  double? fakeSalePrice;
  String? discountType;
  double? discount;
  String? status;
  int? categoryId;
  String? image;

  String? shortDescription;

  List<Attributes>? attributes;
  List<String>? brandList;
  String? unit;
  int? maxQuantityAllowed;
  int? quantity;

  String? hasVariant;
  String? visibility;
  double? sgst;
  double? cgst;
  double? igst;
  double? perQuantityOf;
  String? perUnit;
  double? perPrice;
  // double? packageWeight;
  // String? packageWeightUnit;

  Thumbnail? thumbnail;
  String? categoryName;
  String? brandName;

  List<Variants>? variants;
  List<Image>? images;
  Product(
      {this.id,
      required this.name,
      this.description,
      this.specifications,
      this.features,
      this.price,
      this.salePrice,
      this.discountType,
      this.discount,
      this.categoryId,
      this.status,
      this.image,
      this.shortDescription,
      this.attributes,
      this.unit,
      this.maxQuantityAllowed,
      this.quantity,
      this.hasVariant,
      this.visibility,
      this.brandList,
      this.sgst,
      this.cgst,
      this.igst,
      this.perQuantityOf,
      this.perUnit,
      this.perPrice,
      // this.packageWeight,
      // this.packageWeightUnit,
      this.thumbnail,
      required this.categoryName,
      this.brandName,
      this.variants,
      this.images});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    specifications = json['specifications'];
    features = json['features'];
    price = json['price'] != null
        ? json['price'].runtimeType == int
            ? json['price'].toDouble()
            : double.parse(json['price'])
        : 0.0;
    salePrice = json['sale_price'] != null
        ? json['sale_price'].runtimeType == int
            ? json['sale_price'].toDouble()
            : double.parse(json['sale_price'])
        : 0.0;

    discountType = json['discount_type'];
    discount = json['discount'] != null
        ? json['discount'].runtimeType == int
            ? json['discount'].toDouble()
            : double.parse(json['discount'])
        : 0.0;
    status = json['status'];
    image = json['image'];
    categoryId = json['category_id'];
    shortDescription = json['short_description'];

    brandList = <String>[];
    if (json['brands_list'] != null) {
      List<dynamic> f = json['brands_list'];
      brandList = f.map((e) => e.toString()).toList();
    }
    attributes = <Attributes>[];
    if (json['attributes'] != null) {
      List<dynamic> f = (json['attributes'].runtimeType) == String
          ? jsonDecode(json['attributes'])
          : json['attributes'];

      f.forEach((v) {
        attributes!.add(new Attributes.fromJson(v));
      });
    }
    unit = json['unit'];
    maxQuantityAllowed =
        json['max_quantity_allowed'] != null ? json['max_quantity_allowed'] : 0;
    quantity = json['quantity'] != null ? json['quantity'] : 0;
    hasVariant = json['has_variant'];
    visibility = json['visibility'];
    sgst = json['sgst'].runtimeType == int
        ? json['sgst'].toDouble()
        : double.parse(json['sgst']);
    cgst = json['cgst'].runtimeType == int
        ? json['cgst'].toDouble()
        : double.parse(json['cgst']);
    igst = json['igst'].runtimeType == int
        ? json['igst'].toDouble()
        : double.parse(json['igst']);

    perQuantityOf = json['per_quantity_of'] != null
        ? json['sgst'].runtimeType == int
            ? json['per_quantity_of'].toDouble()
            : double.parse(json['per_quantity_of'])
        : 0;
    perUnit = json['per_unit'];
    perPrice = json['per_price'] != null
        ? json['per_price'].runtimeType == int
            ? json['per_price'].toDouble()
            : double.parse(json['per_price'])
        : 0;
    // packageWeight = json['package_weight'] != null
    //     ? double.parse(json['package_weight'])
    //     : 0.0;
    // packageWeightUnit = json['package_weight_unit'];
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    categoryName = json['category_name'];
    brandName = json['brand_name'];
    variants = <Variants>[];
    if (json['variants'] != null) {
      List<dynamic> f = json['variants'].runtimeType == String
          ? jsonDecode(json['variants'])
          : json['variants'];

      f.forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    }
    images = <Image>[];
    if (json['images'] != null && json['images'].length > 0) {
      json['images'].forEach((v) {
        images!.add(new Image.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['specifications'] = this.specifications;
    data['features'] = this.features;
    data['price'] = this.price;
    data['sale_price'] = this.salePrice;
    data['discount_type'] = this.discountType;
    data['discount'] = this.discount;
    data['status'] = this.status;
    data['image'] = this.image;
    data['category_id'] = this.categoryId.toString();
    data['short_description'] = this.shortDescription;

    if (this.attributes != null) {
      data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }
    data['unit'] = this.unit;
    data['max_quantity_allowed'] = this.maxQuantityAllowed;
    data['quantity'] = this.quantity;

    data['has_variant'] = this.hasVariant;
    data['visibility'] = this.visibility;
    data['sgst'] = this.sgst;
    data['cgst'] = this.cgst;
    data['igst'] = this.igst;
    data['per_quantity_of'] = this.perQuantityOf;
    data['per_unit'] = this.perUnit;
    data['per_price'] = this.perPrice;
    // data['package_weight'] = this.packageWeight;
    // data['package_weight_unit'] = this.packageWeightUnit;

    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail!.toJson();
    }
    data['category_name'] = this.categoryName;
    data['brand_name'] = this.brandName;

    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attributes {
  int? id;
  String? name;
  String? value;

  Attributes({this.id, this.name, this.value});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

class Variants {
  int? id;
  int? productId;
  double? price;
  double? salePrice;
  String? discountType;
  double? discount;
  String? image;
  int? maxQuantityAllowed;
  int? quantity;
  String? name;
  Thumbnail? thumbnail;
  List<Image>? images;

  Variants(
      {this.id,
      this.productId,
      this.price,
      this.salePrice,
      this.discountType,
      this.discount,
      this.image,
      this.name,
      this.maxQuantityAllowed,
      this.quantity,
      this.thumbnail,
      this.images});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? json['id'] : null;
    productId = json['product_id'];
    price = json['price'] != null
        ? json['price'].runtimeType == int
            ? json['price'].toDouble()
            : double.parse(json['price'])
        : 0;
    salePrice = json['sale_price'] != null
        ? json['sale_price'].runtimeType == int
            ? json['sale_price'].toDouble()
            : double.parse(json['sale_price'])
        : 0;

    discountType = json['discount_type'];
    discount = json['discount'] != null
        ? json['discount'].runtimeType == int
            ? json['discount'].toDouble()
            : double.parse(json['discount'])
        : 0;
    image = json['image'];
    maxQuantityAllowed =json['max_quantity_allowed'] != null ? json['max_quantity_allowed'] : 0;
    quantity = json['quantity'] != null ? json['quantity'] : 0;
    name = json['name'];
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    if (json['images'] != null) {
      images = <Image>[];
      json['images'].forEach((v) {
        images!.add(new Image.fromJson(v));
      });
    } else
      images = [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['price'] = this.price;
    data['sale_price'] = this.salePrice;
    data['discount_type'] = this.discountType;
    data['discount'] = this.discount;
    data['image'] = this.image;

    data['name'] = this.name;
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
