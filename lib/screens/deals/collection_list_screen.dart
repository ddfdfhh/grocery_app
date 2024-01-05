import 'package:citymall/constants.dart';
import 'package:citymall/controllers/category_controller.dart';
import 'package:citymall/controllers/dashboard_controller.dart';
import 'package:citymall/controllers/network_controller.dart';
import 'package:citymall/controllers/product_controller.dart';
import 'package:citymall/models/category.dart';
import 'package:citymall/models/category_item.dart';
import 'package:citymall/models/content_section.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/widgets/category/child.dart';
import 'package:citymall/widgets/category/circular_collection.dart';
import 'package:citymall/widgets/category/simple_collection_card.dart';
import 'package:citymall/widgets/category_card.dart';
import 'package:citymall/widgets/nointernet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../models/collection.dart';
import '../../widgets/category/simple_category_card.dart';

class CollectionListScreen extends StatelessWidget {
  DashboardController dc = Get.put(DashboardController());
  //CategoryController categoryController = Get.put(CategoryController());
  ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, () async {
    //   dc.single_content_id.value = Get.arguments['content_id'];
    //
    // });
    NetworkController nc=Get.find();
    return Obx(()=>nc.hasConnection.value?Scaffold(
        extendBody: true,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          )),
          elevation: 0,
          foregroundColor: Colors.white,
          title:Obx(
                  () => Text('${dc.isLoading.value?'Loading..':dc.single_content_section?.value?.sectionTitle}')),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();

              },
              child: Icon(Icons.arrow_back)),
        ),
        body: Obx(() => dc.isLoading.value
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      getGridView(
                          context,dc),
                      SizedBox(height: 60)
                    ])))
        )
    ):NoInternet(context));
  }


  Widget getGridView(BuildContext context,DashboardController dc){
    return MasonryGridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: dc.single_content_section.value!.collections!.length,
      itemBuilder: (context, index) {
        ContentSection cs=dc.single_content_section!.value!;
        Collection collection = dc.single_content_section!.value!.collections![index];
        return InkWell(
            onTap: () {
              productController.collectionId.value =
              collection.id!;
              productController.collectionName.value =
              collection.title!;
              Get.toNamed(AppRoutes.collectionProducts);
            },
            child: cs.showCategoryInCircle != 'Yes'
                ? SimpleCollectionCard(
                context, cs.collections![index]!, cs)
                : CircluarCollection(context, collection,cs));},
      crossAxisCount: 3,
    );
  }
}