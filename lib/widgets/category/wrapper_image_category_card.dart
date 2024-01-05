import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:citymall/constants.dart';
import 'package:citymall/models/category.dart';
import 'package:citymall/models/content_section.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Widget WrapperImageCategoryCard(
    BuildContext context,
    Category item,
    ContentSection? cs) {
  return Stack(
    alignment: Alignment.center,
    children: [
      GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.categories);
        },
        child: Container(
          margin: EdgeInsets.only(right: 10,bottom:10),
          child: Column(
            children: [
              Container(
                  width: 140,
                  height: 120,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: cs?.wrapperImage != null
                          ? DecorationImage(
                              image: NetworkImage(Uri.encodeFull(baseUrl +
                                  '/storage/content_sections/${cs?.wrapperImage}')),
                              fit: BoxFit.fill)
                          : null),
                  child: imageWidget(context, item)),
              SizedBox(height: 4),
              Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      AutoSizeText("${toBeginningOfSentenceCase(item!.name!)}",
                          textAlign: TextAlign.center,
                          style:  AppTheme(context:context).textTheme['bodyLargeBold']),
                    ],
                  ))
            ],
          ),
        ),
      ),
      if (cs?.showSaleBadge != null && cs?.showSaleBadge == 'Yes')
        Positioned(
            top: 2,
            right: 20,
            child: Container(
                color: AppTheme(context: context).colors['red'],
                width: 40,
                height: 18,
                child: Center(
                  child: AutoSizeText('Sale',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ))),
      if (item.subtitle != null)
        Positioned(
            bottom: cs?.sectionBackgroundImage!=null ? 33 : 30,
            // left:20,right:20,
            child: Container(
                width: 120,
                decoration: BoxDecoration(
                  color: AppTheme(context: context).colors['primary'],
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 18,
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                child: AutoSizeText('${toBeginningOfSentenceCase(item.subtitle)}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold))))
    ],
  );
}

Widget imageWidget(BuildContext context, Category item) {
  return SizedBox(
      child: Image.network(
    fit: BoxFit.fill,
    Uri.encodeFull(
        baseUrl + '/storage/categories/${item!.image!}'),
  ));
}
