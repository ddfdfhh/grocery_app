import 'package:cached_network_image/cached_network_image.dart';
import 'package:citymall/constants.dart';
import 'package:citymall/models/category.dart';
import 'package:citymall/models/content_section.dart';
import 'package:citymall/styles/theme.dart';

import 'package:citymall/widgets/category/circleImageWithText.dart';

import 'package:flutter/material.dart';

Widget CircluarCategory(BuildContext context, Category item,
    ContentSection cs) {
  String url = Uri.encodeFull(
      baseUrl + '/storage/categories/${item!.image!}');
  return Stack(alignment: Alignment.topRight, children: [
    CirclarImageWithTitle(cs,url, item.name!, null),
    if (cs.showSaleBadge != null && cs.showSaleBadge == 'Yes')
      Positioned(
          top: 2,
          right: 0,
          child: Container(
              color: AppTheme(context: context).colors['red'],
              width: 40,
              height: 18,
              child: Center(
                child: Text('Sale',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              )))
  ]);
}
