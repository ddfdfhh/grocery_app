import 'package:flutter/material.dart';

Widget TextBadge({height,text,radius=10,color=Colors.lightGreen}){
  return Container(
      height: height.toDouble(),
     
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(bottom:5),
      decoration: BoxDecoration(
          color: color.withOpacity(.2),
          borderRadius: BorderRadius.circular(radius.toDouble())),
      child: Center(
        child: IntrinsicWidth(
          child: Text(
              text.toString(),
              style: TextStyle(fontWeight:FontWeight.bold,color: Colors.green)),
        ),
      ));
}
Widget NormalBadge({text}){
  return FilterChip(
    label: Text(text),
    selectedColor:Colors.orange.shade50,
    //labelStyle: TextStyle(color: Colors.white),
    //backgroundColor:Colors.orange.shade100,
    selected: true, onSelected: (bool value) {  },


  );
}