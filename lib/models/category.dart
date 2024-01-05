
import 'package:citymall/models/thumbnail.dart';

class Category {
  int? id;
   String? name;

  String? image;
  String? bannerImage;
  String? subtitle;

  double? sgst;
  double? cgst;
  double? igst;
  String? status;
  // Thumbnail? thumbnail;
  List<Children>? children=[];
  late int childrenCount;
  String? discountType;
  double? discount;
  Category(
      {
         this.id,
         this.name,
        this.image,
  this.subtitle,
        this.sgst,
        this.cgst,
        this.igst,
        this.status,
        //this.thumbnail,
        this.children,
        required this.childrenCount,
        this.discountType,
        this.discount
      });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id']!=null?(json['id']):null;
    name = json['name'];
    image = json['image'];  bannerImage = json['banner_image'];
    subtitle=json['subtitle'];

    sgst = json['sgst']!=null?double.parse(json['sgst']):0;
    cgst = json['cgst']!=null?double.parse(json['cgst']):0;
    igst = json['igst']!=null?double.parse(json['igst']):0;
    status = json['status'];
    // thumbnail = json['thumbnail'] != null
    //     ? new Thumbnail.fromJson(json['thumbnail'])
    //     : null;
    if (json['children'] != null) {
      children = <Children>[];

      json['children'].forEach((v) {
        children!.add(new Children.fromJson(v));
      });
    }
   childrenCount=json['children_count']!=null?json['children_count']:0;
    discountType = json['discount_type'];
    discount = json['discount']!=null?double.parse(json['discount']):0.0;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['subtitle']=this.subtitle;
    data['image'] = this.image;
    data['banner_image'] = this.bannerImage;

    data['sgst'] = this.sgst;
    data['cgst'] = this.cgst;
    data['igst'] = this.igst;
    data['status'] = this.status;
    // if (this.thumbnail != null) {
    //   data['thumbnail'] = this.thumbnail!.toJson();
    // }
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    data['children_count']=this.childrenCount;
    return data;
  }
}


class Children {
  int? id;
 late String name;

  String? image; String? bannerImage;


  double? sgst;
  double? cgst;
  double? igst;
  String? status;
  String? subtitle;
  // Thumbnail? thumbnail;
  late int childrenCount;
  Children(
      {this.id,
       required this.name,

        this.image,


        this.sgst,
        this.cgst,
        this.igst,
        this.status,
    this.subtitle,
        // this.thumbnail,
        required this.childrenCount
      });

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

    image = json['image'];
   bannerImage=json['banner_image'] ;
    sgst = double.parse(json['sgst']);
    cgst = double.parse(json['cgst']);
    igst = double.parse(json['igst']);
    status = json['status'];
    subtitle=json['subtitle']??'';
    // thumbnail = json['thumbnail'] != null
    //     ? new Thumbnail.fromJson(json['thumbnail'])
    //     : null;
    childrenCount=json['children_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;

    data['image'] = this.image;
    data['banner_image'] = this.bannerImage;

    data['sgst'] = this.sgst;
    data['cgst'] = this.cgst;
    data['igst'] = this.igst;
    data['subtitle'] = this.subtitle;
    data['status'] = this.status;
    // if (this.thumbnail != null) {
    //   data['thumbnail'] = this.thumbnail!.toJson();
    // }
    data['children_count']=this.childrenCount;
    return data;
  }
}