import 'package:citymall/screens/filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

FilterSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    enableDrag: true,
    isScrollControlled:true,
    context: context,
    builder: (BuildContext context) {
      return FractionallySizedBox(
          heightFactor: 0.7,child: FilterScreen());
    },
  );
}
