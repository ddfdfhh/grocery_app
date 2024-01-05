import 'package:citymall/controllers/network_controller.dart';
import 'package:citymall/controllers/product_controller.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/widgets/nointernet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:citymall/controllers/search_controller.dart';
import 'package:citymall/constants.dart';
// import 'package:hive/hive.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SearchProductController sc = Get.put(SearchProductController());
    ProductController pc = Get.find();
    NetworkController nc = Get.find();
    return Obx(() => nc.hasConnection.value
        ? Scaffold(
            appBar: AppBar(
                toolbarHeight: 80,
                leading: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back)),
                title: SizedBox(
                  height: 40,
                  child: TextField(
                    controller: sc.searchFieldController,
                    onChanged: (value) {
                      sc.startSearching();
                    },
                    autofocus: true,
                    style: AppTheme(context: context).textTheme["titleSmall"],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: Icon(Icons.search_outlined,
                          size: 22, color: Colors.white),
                      suffixStyle: AppTheme(context: context)
                          .textTheme["titleLargeWhiteBold"],
                      hintText: 'Search Your Products',
                      hintStyle: AppTheme(context: context)
                          .textTheme["titleSmallGrey"],
                      contentPadding:
                          EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                actions: [IconButton(onPressed: () {}, icon: Icon(Icons.mic))]),
            body: Obx(() => Center(
                  child: sc.isLoading.value
                      ? const CircularProgressIndicator()
                      : ListView.builder(
                          itemCount: sc.list.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> prod = sc.list[index];
                            return ListTile(
                              onTap: () {
                                pc.productId.value = prod['id'];
                                Get.toNamed(AppRoutes.product_detail);
                              },
                              leading: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Image.network(
                                      fit: BoxFit.cover,
                                      baseUrl +
                                          '/storage/products/${prod['id']}/thumbnail/${prod['thumbnail']}')),
                              title: Text("${prod['name']}"),
                              subtitle: Text("${prod['cat_name']}"),
                            );
                          }),
                )),
          )
        : NoInternet(context));
  }

  Widget product_strip() {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(shape: BoxShape.rectangle),
      ),
      title: const Text(
        'GFG title',
        textScaleFactor: 1.5,
      ),
      trailing: const Icon(Icons.done),
      subtitle: const Text('This iss subtitle'),
      selected: true,
      onTap: () {},
    );
  }
}
