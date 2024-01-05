import 'package:citymall/models/category.dart';
import 'package:citymall/models/collection.dart';
import 'package:citymall/models/product.dart';
import 'package:citymall/models/slider_banner.dart';

class ContentSection {
  int? id;
  String? sectionTitle;
  String? sectionSubtitle;
  List<Category>? categories;
  List<Product>? products;
  List<Collection>? collections;

  String? display;
  String? sectionBackgroundImage;
  String? sectionBackgroundColor;
  String? wrapperImage;
  String? headerImage;

  String? fancyHeading;
  String? headingLocation;
  String? isDeal;
  String? showSaleBadge;
  String? showCategoryInCircle;
  int? itemCount;
  String? isBannerSlider;
  String? showDetailedProductCard;
  List<BannerImages>? bannerImages;
  String? backgroundColor;
  String? borderColor;
  ContentSection(
      {this.id,
      this.sectionTitle,
      this.sectionSubtitle,
      this.categories,
      this.products,
      this.collections,
      this.display,
      this.sectionBackgroundImage,
        this.sectionBackgroundColor,
      this.wrapperImage,
      this.fancyHeading,
      this.headingLocation,
      this.isDeal,
      this.showSaleBadge,
      this.showCategoryInCircle,
      this.itemCount,
      this.bannerImages,
      this.isBannerSlider,
      this.backgroundColor,
      this.borderColor,
        this.headerImage,
      this.showDetailedProductCard});

  ContentSection.fromJson(Map<String, dynamic> json) {
    sectionTitle = json['section_title'];
    id = json['id'];
    sectionSubtitle = json['section_subtitle']!=null?json['section_subtitle']:'';
    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories'].forEach((v) {
        categories!.add(Category.fromJson(v));
      });
    }
    else
      categories=[];
    products=<Product>[];
    if (json['products'] != null) {
       json['products'].forEach((v) {

          Product p=Product.fromJson(v);

          products!.add(p);


      });

    }
if (json['collections'] != null) {
      collections = <Collection>[];
      json['collections'].forEach((v) {
        collections!.add(Collection.fromJson(v));
      });
    }else
      collections=[];

    sectionBackgroundImage = json['section_background_image'];
    sectionBackgroundColor = json['section_background_color'];
    display = json['display'];
    wrapperImage = json['wrapper_image'];
    headerImage = json['header_image'];
    fancyHeading = json['fancy_heading'];
    headingLocation = json['heading_location'];
    isDeal = json['is_deal'];
    showSaleBadge = json['show_sale_badge'];
    showCategoryInCircle = json['show_category_in_circle'];
    itemCount = json['item_count'];
    showDetailedProductCard = json['show_detailed_product_card'];
    if (json['banner_images'] != null) {
      bannerImages = <BannerImages>[];
      json['banner_images'].forEach((v) {
        bannerImages!.add(new BannerImages.fromJson(v));
      });
    }
    isBannerSlider = json['is_banner_slider'];
    backgroundColor = json['background_color'];
    borderColor = json['border_color'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['section_subtitle'] = this.sectionSubtitle;
    data['section_title'] = this.sectionTitle;
    if (this.categories != null) {
      data['category'] = this.categories!.map((v) => v).toList();
    }
    if (this.products != null) {
      data['product'] = this.products!.map((v) => v).toList();
    } if (this.collections != null) {
      data['collections'] = this.collections!.map((v) => v).toList();
    }
    data['id'] = this.id;
    data['display'] = this.display;
    data['section_background_image'] = this.sectionBackgroundImage;
    data['section_background_color'] = this.sectionBackgroundColor;
    data['wrapper_image'] = this.wrapperImage;
    data['header_image'] = this.headerImage;
    data['fancy_heading'] = this.fancyHeading;
    data['heading_location'] = this.headingLocation;
    data['is_deal'] = this.isDeal;
    data['show_sale_badge'] = this.showSaleBadge;
    data['show_detailed_product_card'] = this.showDetailedProductCard;
    return data;
  }
}
