
import 'package:citymall/models/product.dart';
import 'package:citymall/models/thumbnail.dart';

class Collection {
  int? id;
   String? title;
   String? name;

  String? image;

  String? subtitle;
  int productCount=0;
 //List<Product>? products;
  Collection(
      {
         this.id,
         this.title,
         this.name,
        this.image,
        this.subtitle,
       required this.productCount
       });

  Collection.fromJson(Map<String, dynamic> json) {
    id = json['id']!=null?(json['id']):null;
    title = json['name']!=null?json['name']:'';

    image = json['image'];
    subtitle=json['subtitle']!=null?json['subtitle']:'';



  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subtitle']=this.subtitle;
    data['image'] = this.image;

    return data;
  }
}

