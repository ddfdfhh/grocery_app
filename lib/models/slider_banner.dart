class SliderBanner {

  int? orderNumber;
  String? sectionTitle;
  List<BannerImages>? bannerImages;

  SliderBanner(
      {
        this.orderNumber,

        this.sectionTitle,
        this.bannerImages});

  SliderBanner.fromJson(Map<String, dynamic> json) {

    orderNumber = int.parse(json['order_number']);

    sectionTitle = json['section_title'];
    if (json['banner_images'] != null) {
      bannerImages = <BannerImages>[];
      json['banner_images'].forEach((v) {
        bannerImages!.add(new BannerImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['order_number'] = this.orderNumber.toString();

    data['section_title'] = this.sectionTitle;
    if (this.bannerImages != null) {
      data['banner_images'] =
          this.bannerImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerImages {

  String? name;


  BannerImages(
      {
        this.name,
       });

  BannerImages.fromJson(Map<String, dynamic> json) {

    name = json['name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;

    return data;
  }
}