import 'package:citymall/controllers/category_controller.dart';
import 'package:citymall/controllers/product_controller.dart';
import 'package:citymall/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CategoryController productController = Get.find();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.white,
          title: Text(
            "Coupons",
          ),
          centerTitle: true,
          leading:
          InkWell(onTap: () => {Get.back()}, child: Icon(Icons.arrow_back)),
        ),
        body: SafeArea(
            child:Obx(
                  () => productController.isLoading.value
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : ListView.builder(
                  itemCount: productController.categories?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(
                            productController.categories![index].name ??
                                'no name'),
                        subtitle: Text( productController.categories![index].name ??
                            'no description'),
                        leading:  productController.categories![index].image ==
                            null
                            ? Icon(Icons.image)
                            : Image.network('http://grocery.test/storage/products/1/download_1698557572.jpg'),
                        onTap: () {

                    });
                  }),
            )
        ));
  }
}
