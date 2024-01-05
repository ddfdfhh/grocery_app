import 'package:citymall/styles/theme.dart';
import 'package:flutter/material.dart';

Widget DefaultButton(
    BuildContext context, String label, onPressed, Color? color,
    {bool isLoading = false}) {
  return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: color != null
              ? color
              : AppTheme(context: context).colors['primary'],
          minimumSize: Size(180, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          )),
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: isLoading
              ? CircularProgressIndicator(
                  backgroundColor: AppTheme(context: context).colors['primary'],
                  color: Colors.white)
              : Text(label, style: TextStyle(color: Colors.white))));
}
