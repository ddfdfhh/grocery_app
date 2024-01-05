import 'package:auto_size_text/auto_size_text.dart';
import 'package:citymall/constants.dart';
import 'package:citymall/controllers/dashboard_controller.dart';
import 'package:citymall/models/content_section.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/widgets/category/view_all.dart';
import 'package:citymall/widgets/imageWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Widget HeaderWithImage(BuildContext context, ContentSection cs,String content_type) {
  DashboardController dc=Get.find();
  return GestureDetector(
    onTap:(){
      dc.single_content_id.value = cs.id!;

      if (content_type == 'product') {
        Get.toNamed(AppRoutes.deals_products);
      } else if (content_type == 'category') {
        Get.toNamed(AppRoutes.deals_categories);
      } else {
        Get.toNamed(AppRoutes.collections);
      }
    },
      child:Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(top: 10),

      child: CachedImageWidget(context,Uri.encodeFull(
          baseUrl + '/storage/content_sections/${cs.headerImage!}'), null, null, null)));
}

Widget SimpleHeading(BuildContext context, String content_type, String title,
    String? subtitle, String position, ContentSection? cs) {
  DashboardController dc = Get.find();
  return (position == 'Left')
      ? Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AutoSizeText("${toBeginningOfSentenceCase(title)}",
                    style: AppTheme(context: context)
                        .textTheme['titleMediumBold']),
                if (subtitle != null)
                  Text("${toBeginningOfSentenceCase(subtitle)}",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color:
                              AppTheme(context: context).colors['secondary'])),
                // Image.asset('images/divider1.png',
                //     height: 10, width: 180, fit: BoxFit.fill)
              ],
            )),
            ViewAll(context, () {
              dc.single_content_id.value = cs!.id!;
              dc.single_content_title.value=cs!.sectionTitle;
              if (content_type == 'product') {
                Get.toNamed(AppRoutes.deals_products);
              } else if (content_type == 'category') {
                Get.toNamed(AppRoutes.deals_categories);
              } else {
                 Get.toNamed(AppRoutes.collections);
              }
            })
          ]),
        )
      : Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10),
          // decoration: BoxDecoration(
          //
          //     color: AppTheme(context:context).colors['primary'],
          //     borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(20),
          //         topRight: Radius.circular(20))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child:
                    Image.asset('images/1.png', height: 10, fit: BoxFit.fill),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AutoSizeText("Categories",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
                    if (subtitle != null && subtitle.isNotEmpty)
                      Text("${subtitle}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green)),
                  ],
                ),
              ),
              Expanded(
                  child:
                      Image.asset('images/2.png', height: 10, fit: BoxFit.fill))
            ],
          ),
        );
}
