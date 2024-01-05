import 'package:citymall/constants.dart';
import 'package:citymall/controllers/category_controller.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/widgets/category/circular_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//List<String> categories=["Cat1","Cat2","Cat1","Cat2","Cat1","Cat2","Cat1","Cat2"];
Widget HorizontallScrollingCategry(CategoryController catController){
  catController = Get.find();
  return  Obx(()=>ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: catController.categories.length,
      itemBuilder: (BuildContext context, int index) {
        var cat=catController.categories[index];
        var img=baseUrl+'/storage/categories/${cat.image}';
        return GestureDetector( //You need to make my child interactive
            onTap: () =>{
                if(cat.childrenCount!>0)
                Get.toNamed(AppRoutes.categories,arguments: {'category':cat.id})
               else
                  Get.toNamed(AppRoutes.products,arguments: {'category':cat.id})
            },
          child: Text("df"));
      }
  ));
}