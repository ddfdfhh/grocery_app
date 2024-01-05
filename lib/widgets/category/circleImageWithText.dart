import 'package:citymall/constants.dart';
import 'package:citymall/models/content_section.dart';
import 'package:citymall/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util.dart';

Widget CirclarImageWithTitle(ContentSection cs, String url, String title,
    String? subtitle) {
  return Center(
      child: new Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 140.0,
        height: 140.0,
        padding: EdgeInsets.all(16),
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: (cs?.wrapperImage != null
              ? DecorationImage(fit: BoxFit.cover,
                  image: NetworkImage(Uri.encodeFull(baseUrl +
                      '/storage/content_sections/${cs?.wrapperImage!}')))
              : null),
          color: cs.backgroundColor != null
              ? getColorFromHexString(cs.backgroundColor!)
              : null,
        ),
        child: Container(
            width: 120.0,
            height: 120.0,padding: EdgeInsets.all(8),
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                color: cs.backgroundColor != null
                    ? getColorFromHexString(cs.backgroundColor!)
                    : null,
                image: new DecorationImage(
                    fit: BoxFit.cover, image: new NetworkImage(url)))),
      ),
      new Text(
        "${title}",
        textAlign: TextAlign.center,
        style: AppTheme(context: Get.context as BuildContext)
            .textTheme['bodyLargeBoldBlack'],
      )
    ],
  ));
}
