class DiscountRule {
  double? discount;
  String? ruleName;
  String? discountType;

  DiscountRule({this.discount, this.ruleName, this.discountType});

  DiscountRule.fromJson(Map<String, dynamic> json) {
    discount = double.parse(json['discount']);
    ruleName = json['rule_name'];
    discountType = json['discount_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['discount'] = this.discount.toString();
    data['rule_name'] = this.ruleName;
    data['discount_type'] = this.discountType;
    return data;
  }
}
