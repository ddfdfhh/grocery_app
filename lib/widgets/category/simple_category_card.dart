import 'package:cached_network_image/cached_network_image.dart';
import 'package:citymall/constants.dart';
import 'package:citymall/models/category.dart';
import 'package:citymall/models/content_section.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/util.dart';
import 'package:citymall/widgets/imageWidget.dart';
import 'package:flutter/material.dart';
import 'package:citymall/models/category_item.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Widget SimpleCategoryCard(
    BuildContext context, Category item, ContentSection? cs) {
  return Container(
    width: 130,
    padding: EdgeInsets.only(left: 8, right: 8, top: 8),
    decoration: BoxDecoration(
        color: Colors.white,
        //  borderRadius: BorderRadius.circular(5),
        border: Border.all(width: .5, color: Colors.black12)),
    // margin: EdgeInsets.symmetric(horizontal: 4),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          height: 110,
          decoration: BoxDecoration(
              image: cs?.wrapperImage != null
                  ? DecorationImage(
                  image: NetworkImage(Uri.encodeFull(baseUrl +
                      '/storage/content_sections/${cs?.wrapperImage!}')))
                  : (cs?.sectionBackgroundImage != null
                  ? DecorationImage(
                  image: NetworkImage(Uri.encodeFull(baseUrl +
                      '/storage/content_sections/${cs?.sectionBackgroundImage!}')))
                  : null),
              color: cs?.backgroundColor != null
                  ? getColorFromHexString(cs!.backgroundColor!)
                  : null,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          //  padding: EdgeInsets.all(10),
          child: imageWidget(item),
        ),
        Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
              height: 50,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${toBeginningOfSentenceCase(item!.name!)}',
                      textAlign: TextAlign.center,
                      style: AppTheme(context: context)
                          .textTheme['bodyLargeBold']),
                  if (item.subtitle != null)
                    Text(
                      "${toBeginningOfSentenceCase(item.subtitle)}",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme(context: context).colors['primary']),
                    )
                ],
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
      child: CachedImageWidget(
          Get.context as BuildContext,
          Uri.encodeFull(baseUrl + '/storage/categories/${item!.image!}'),
          null,
          null,
          BoxFit.fill));
}
