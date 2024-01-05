import 'package:cached_network_image/cached_network_image.dart';
import 'package:citymall/constants.dart';
import 'package:citymall/models/category.dart';
import 'package:citymall/models/collection.dart';
import 'package:citymall/models/content_section.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/util.dart';
import 'package:citymall/widgets/category/circleImageWithText.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget CircluarCollection(BuildContext context, Collection item,
    ContentSection cs) {
  String url = Uri.encodeFull(
      baseUrl + '/storage/collections/${item!.image!}');
  return Stack(
      alignment: Alignment.topRight,
      clipBehavior: Clip.none,
      children: [
        CirclarImageWithTitle(cs,url, item.title!, null),
        if (cs.showSaleBadge != null && cs.showSaleBadge == 'Yes')
          Positioned(
              top: 0,
              right: -10,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('${assetUrl(context)}/sale1.png'))),
                //color: AppTheme(context: context).colors['red'],
                width: 60,
                height: 38,
              ))
      ]);
}
