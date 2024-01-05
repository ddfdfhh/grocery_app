import 'package:citymall/styles/theme.dart';
import 'package:flutter/material.dart';

Widget ViewAll(BuildContext context,Function tapCallback){
  return InkWell(splashColor: Colors.transparent,hoverColor: Colors.transparent,highlightColor: Colors.transparent,
    onTap: () {
      tapCallback();
    },
    child: Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "View All",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold,color:AppTheme(context:context).colors['primary']),
        ),
        Icon(Icons.chevron_right,size: 20,color:AppTheme(context:context).colors['primary'])
      ],
    ),
  );
}
Widget ViewAllBottom(BuildContext context,Function tapCallback){
  return  SizedBox(width:100,height:40,child:ElevatedButton(
      onPressed: () {
        tapCallback();
      },
      child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "View All",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold,color:Colors.white),
          ),
          Icon(Icons.arrow_circle_right_outlined,size: 20,color:Colors.white),
        //  Icon(Icons.chevron_right,size: 20,color:Colors.white)
        ],
      ))
  );
}