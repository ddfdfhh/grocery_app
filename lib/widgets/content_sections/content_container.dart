import 'package:citymall/constants.dart';
import 'package:citymall/controllers/dashboard_controller.dart';
import 'package:citymall/models/content_section.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/widgets/category/view_all.dart';
import 'package:citymall/widgets/content_sections/deal_container.dart';
import 'package:citymall/widgets/heading/heading.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget ContentContainer(BuildContext context, ContentSection cs) {
  DashboardController dashboardController = Get.find();
  String content_type = cs!.products!.length > 0
      ? 'product'
      : (cs!.categories!.length > 0 && cs!.products!.length == 0
          ? 'category'
          : 'collecton');

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (cs.headerImage != null)
            HeaderWithImage(context,cs,content_type)
          else
            SimpleHeading(context, content_type, cs.sectionTitle!,
                cs.sectionSubtitle ?? "", cs.headingLocation!, cs),
          DealContainer(context, cs),
          if (cs.headingLocation == 'Center' || cs.headerImage != null) ...[
            Padding(
                padding: EdgeInsets.symmetric(vertical: 3),
                child: Center(
                    child: InkWell(
                  onTap: () {
                    dashboardController.single_content_id.value = cs!.id!;
                    if (content_type == 'product') {
                      Get.toNamed(AppRoutes.deals_products);
                    } else if (content_type == 'category') {
                      Get.toNamed(AppRoutes.deals_categories);
                    } else {
                      Get.toNamed(AppRoutes.collections);
                    }
                  },
                  child: Image.asset('${assetUrl(context)}/view_all.png',
                      height: 20, width: 200),
                ))),
          ]
        ]),
  );
}
