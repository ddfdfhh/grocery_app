import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget OutlinedInput(BuildContext context, String placeholder, IconData? icon ,
    TextEditingController controller,
    {int lines = 1}) {
  return TextField(
    controller: controller,
      maxLines: lines,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration( filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
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
        hintText: "Enter  ${placeholder}",
        hintStyle: TextStyle(
            fontSize: 14,
            color: Color(0xff979899),
            fontWeight: FontWeight.w500),
        prefixIcon: icon != null
            ? Icon(
                icon,
                color: Color(0xff23AA49),
              )
            : null,
      ));
}
