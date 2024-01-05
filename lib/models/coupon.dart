class Coupon {
  int? id;
  String? details;
  String? name;
  String? couponCode;
  String? discountMethod;
  // String? discountType;
  // double? discount;
  // String? freeShipping;
  String? showInFront;
  // int? minimumOrderAmount;

  Coupon({
    this.details,
    this.name,
    //this.discountType,
    this.discountMethod,
    // this.couponCode,
    // this.freeShipping,
    this.showInFront,
    //  this.minimumOrderAmount
  });

  Coupon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    //discount = double.parse(json['discount']);
    name = json['name'];
    details = json['details'] ?? '';
    discountMethod = json['discount_method'];
    couponCode = json['coupon_code'] ?? '';
    // freeShipping=json['free_shipping'];
    showInFront = json['show_in_front'];
    // minimumOrderAmount=json['minimum_order_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['discount'] = this.discount.toString();
    data['name'] = this.name;
    data['discount_method'] = this.discountMethod;
    data['details'] = this.details;
    data['coupon_code'] = this.couponCode;
    data['show_in_front'] = this.showInFront;
    // data['minimum_order_amount']=this.minimumOrderAmount;
    return data;
  }
}
