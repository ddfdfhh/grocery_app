import 'package:cached_network_image/cached_network_image.dart';
import 'package:citymall/constants.dart';
import 'package:citymall/models/category.dart';
import 'package:citymall/models/collection.dart';
import 'package:citymall/models/content_section.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/util.dart';
import 'package:citymall/widgets/imageWidget.dart';
import 'package:flutter/material.dart';
import 'package:citymall/models/category_item.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Widget SimpleCollectionCard(
    BuildContext context, Collection item, ContentSection? cs) {
  return Container(
    width: 150,
    padding: EdgeInsets.only(left: 8, right: 8, top: 8),
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: .5, color: Colors.black12)),
    // margin: EdgeInsets.symmetric(horizontal: 4),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          // width: 110,
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
                  : Colors.blueGrey.shade50,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          // padding: EdgeInsets.all(10),
          child: imageWidget(item),
        ),
        Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (item!.title!.isNotEmpty)
                Text('${toBeginningOfSentenceCase(item!.title!)}',
                    textAlign: TextAlign.center,
                    style:
                        AppTheme(context: context).textTheme['bodyLargeBold']),
              if (item.subtitle!.isNotEmpty)
                Text(
                  "${toBeginningOfSentenceCase(item.subtitle)}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme(context: context).colors['primary']),
                )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget imageWidget(Collection item) {
  var url = Uri.encodeFull(baseUrl + '/storage/collections/${item!.image}');
  return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: CachedImageWidget(
          Get.context as BuildContext, url, null, null, BoxFit.fill));
}
