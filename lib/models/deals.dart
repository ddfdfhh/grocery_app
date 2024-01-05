class Deal {
  String? name;
  String? details;
  List<Map<String,dynamic>>? category;
  List<Map<String,dynamic>>? product;
  String? startDate;
  String? endDate;
  String? discountType;
  double? discount;

  Deal(
      {
        this.name,
      this.details,
      this.category,
      this.product,
      this.startDate,
      this.endDate,
      this.discountType,
      this.discount});

  Deal.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    details = json['details'];
    if (json['category'] != null) {
      category = <Map<String,dynamic>>[];
      json['category'].forEach((v) {
        category!.add(v);
      });
    }
    if (json['product'] != null) {
      product = <Map<String,dynamic>>[];
      json['product'].forEach((v) {
        product!.add(v);
      });
    }
    startDate = json['start_date'];
    endDate = json['end_date'];
    discountType = json['discount_type'];
    discount = json['discount'];
  }

}

