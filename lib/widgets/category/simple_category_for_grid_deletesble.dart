import 'package:cached_network_image/cached_network_image.dart';
import 'package:citymall/constants.dart';
import 'package:citymall/models/category.dart';
import 'package:citymall/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:citymall/models/category_item.dart';

Widget SimpleCategoryForGrid(BuildContext context, Category item) {
  return Container(
    //width: 150,
    // decoration: BoxDecoration(
    //     image: DecorationImage(
    //         image: AssetImage('images/placeholder.jpg'))),
    margin: EdgeInsets.symmetric(horizontal: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              color:Colors.grey.shade100,
              borderRadius: BorderRadius.only(topLeft:Radius.circular(10),topRight:Radius.circular(10))),
          padding: EdgeInsets.all(10),
          height: 120,
          child: imageWidget(item),
        ),
        SizedBox(
          height: 40,
          child: SizedBox.expand(child:Container(
            // padding: EdgeInsets.only(top:10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
                width: 1,
              ),
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item!.name!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                if(item.subtitle!=null)
                  Text(
                    "${item.subtitle}",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.bold,color:AppTheme(context: context).colors['primary']),
                  )
              ],
            ),
          )),
        ),
      ],
    ),
  );
}

Widget imageWidget(Category item) {
  return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: Uri.encodeFull(baseUrl +
            '/storage/categories/${item!.image!}'),
        placeholder: (context, url) =>
            Center(child: const CircularProgressIndicator()),
        errorWidget: (context, url, error) =>
            Image.asset('images/no-image.jpg'),
      ));
}
