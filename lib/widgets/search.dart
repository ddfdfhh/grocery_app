import 'package:citymall/controllers/product_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget SearchInput(BuildContext context, String placeholder,ProductController? productController) {
  return TextField(
      controller: productController?.searchInputControl,
      onChanged:(v){
        productController?.searchBrand();
      },
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1.0, color: Colors.black12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.0, color: Colors.black12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 1, color: Theme.of(context).colorScheme.primary),
        ),
        hintText: "Search ${placeholder}",
        hintStyle: TextStyle(
            fontSize: 14,
            color: Color(0xff979899),
            fontWeight: FontWeight.w500),
        prefixIcon: Icon(
          CupertinoIcons.search,
          color: Color(0xff23AA49),
        ),
      ));
}
