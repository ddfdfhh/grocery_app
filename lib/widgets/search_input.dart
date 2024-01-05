import 'package:citymall/styles/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget SearchInput(BuildContext context){
  return  Container(
      height: 80,
      decoration: BoxDecoration(color:AppTheme(context:context).colors['primary'],
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(35),
          bottomLeft: Radius.circular(35),
        ),
      ),
      child:
      Padding(
        padding: EdgeInsets.all(14),
        child: TextField(
          autofocus: false,
          style: TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(Icons.search_outlined,size: 18,),
            prefixStyle:  AppTheme(context:context).textTheme["titleSmallGrey"],
            hintText: 'Search Products..',
            hintStyle: AppTheme(context:context).textTheme["titleSmallGrey"],
            contentPadding:
            EdgeInsets.only(left: 14.0, bottom: 8.0, top: 4.0),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ));
}