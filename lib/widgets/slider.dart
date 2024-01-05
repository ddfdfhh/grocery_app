import 'package:carousel_slider/carousel_slider.dart';
import 'package:citymall/constants.dart';
import 'package:citymall/controllers/dashboard_controller.dart';
import 'package:citymall/models/slider_banner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

Widget BannerSlider(List<BannerImages> images) {
  return CarouselSlider(
      options: CarouselOptions(
          viewportFraction:1,
          height: 180.0,padEnds: false,
         // enlargeCenterPage: true,
          enableInfiniteScroll: true,
        //  reverse: true,
          autoPlay: true),
      items: images.map((i) {
        return Builder(
          builder: (BuildContext context) {
            var filename = p.basenameWithoutExtension(File(i.name!).path);
            var ext = p.extension(File(i.name!).path);
            return Container(

                decoration: BoxDecoration(
                    image: DecorationImage( fit: BoxFit.fill,alignment: Alignment.center,
                        image: NetworkImage(
                            '$baseUrl/storage/banners/thumbnail/${filename + '_large' + ext}'),
                       )));
          },
        );
      }).toList());
}
