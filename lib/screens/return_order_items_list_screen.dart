import 'package:cached_network_image/cached_network_image.dart';
import 'package:citymall/bottom_sheets/return_qty_sheet.dart';
import 'package:citymall/bottom_sheets/return_sheet.dart';
import 'package:citymall/common_widgets/app_button.dart';
import 'package:citymall/constants.dart';
import 'package:citymall/controllers/network_controller.dart';

import 'package:citymall/controllers/order_controller.dart';
import 'package:citymall/controllers/return_controller.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/util.dart';

import 'package:citymall/widgets/expansion.dart';
import 'package:citymall/widgets/nointernet.dart';
import 'package:citymall/widgets/order_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ReutrnOrderItemsListScreen extends StatelessWidget {
  ReturnController returnController = Get.put(ReturnController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      returnController.single_order_id.value = Get.arguments['order'];
      returnController.order_return_type.value = Get.arguments['return_type'];
     });
    NetworkController nc=Get.find();
    return Obx(()=>nc.hasConnection.value?Scaffold(
        bottomNavigationBar: Container(
            height: 56,
            margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: ElevatedButton(onPressed: () {

            }, child: Text('Return'))),
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.white,
          title: Text(
            "Returnable Items",
          ),
          centerTitle: true,
          leading:
              InkWell(onTap: () => {Get.back()}, child: Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top:10.0,left:20),
                child: Text('Select Items to return',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ),
              Obx(()=>returnController.single_order!=null && returnController.single_order.value!=null && returnController.single_order.value['items']!=null
              ?SizedBox(height:MediaQuery.of(context).size.height,
                child: ListView.builder(
                  shrinkWrap: true,physics: NeverScrollableScrollPhysics(),
                    itemCount: returnController.single_order.value['items'].length,
                    itemBuilder: (BuildContext context, int index) {
                    Map<String,dynamic> item=returnController.single_order.value['items'][index];
                      return Card(child:Column(
                        children: [
                          ListTile(contentPadding: EdgeInsets.all(20),
                            onTap: (){
                              // Get.toNamed(AppRoutes.return_order,arguments:{
                              //  'item_id':returnController.single_order.value['items'][index]['id']
                              // });
                              returnController.selected_item_id.value=returnController.single_order.value['items'][index]['id'];
                              ReturnQtySheet(context, returnController.single_order.value['items'][index]['qty']);
                            },
                            title: Text(
                                '${toUpperCase(returnController.single_order.value['items'][index]['name'])}',
                                style:AppTheme(context:context).textTheme['titleLargeBlack']),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${returnController.single_order.value['items'][index]['variant_name'] ?? ''}'),
                                Text(
                                    'Quantity-${returnController.single_order.value['items'][index]['qty']}',
                                    style:AppTheme(context:context).textTheme['bodyMediumBlack']),
                              ],
                            ),
                            leading:imageWidget(context,returnController.single_order.value['items'][index]['image']),
                            trailing: Obx(() => Radio<int>(
                                  value: returnController.single_order.value['items']
                                      [index]['id'],
                                  groupValue: returnController.selected_item_id.value,
                                  onChanged: (value) {
                                    returnController.selected_item_id.value=returnController.single_order.value['items'][index]['id'];
                                    ReturnQtySheet(context, returnController.single_order.value['items'][index]['qty']);
                                    // ReturnSheet(context);
                                  },
                                )),
                          ),
                          SizedBox(height:20),
                          if (item['returned_qty'] > 0)
                            Container(width:double.infinity,height:40,
                              decoration: BoxDecoration(
                                  color:AppTheme(context: context).colors['primary'],
                                  borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10))

                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(CupertinoIcons.refresh_thick,size:15,color:Colors.white),
                                  Text('Requested Return Quantity -', style: TextStyle(color: Colors.white)),
                                  Text('${item['returned_qty']}',
                                      style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize:18)),
                                ],
                              ),
                            ),
                        ],
                      ));
                    }),
              )
                  :const Center(child:const CircularProgressIndicator())
              ),
            ],
          ),
        )):NoInternet(context));
  }
  Widget imageWidget(BuildContext context,String imageUrl) {

    return Container(
      width: 50,
      child: imageUrl != null
          ? CachedNetworkImage(
        imageUrl: imageUrl,
        errorWidget: (context, url, error) =>
         Image.asset('${assetUrl(context)}/no-image.jpg'),
      )
          : Image.asset('${assetUrl(context)}/no-image.jpg'),
    );
  }
}
