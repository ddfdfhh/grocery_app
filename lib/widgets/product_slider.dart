import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Widget ProductSlider(){
  return CarouselSlider(
    options: CarouselOptions(

      enableInfiniteScroll: true,
      reverse: true,
      autoPlay: true),
    items: [1,2,3,4,5].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(decoration:BoxDecoration(
            image:DecorationImage(
              image:AssetImage('assets/images/ginger.png'),
              fit:BoxFit.contain
          )


          ));
        },
      );
    }).toList()
  );
}