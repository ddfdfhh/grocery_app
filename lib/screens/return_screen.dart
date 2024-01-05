import 'package:citymall/bottom_sheets/return_sheet.dart';
import 'package:citymall/common_widgets/app_button.dart';
import 'package:citymall/constants.dart';

import 'package:citymall/controllers/order_controller.dart';
import 'package:citymall/controllers/return_controller.dart';

import 'package:citymall/widgets/expansion.dart';
import 'package:citymall/widgets/order_items.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ReutrnOrderScreen extends StatelessWidget {
  ReturnController returnController = Get.put(ReturnController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      returnController.selected_item_id.value = Get.arguments['item_id'];
      print('item_id');
      print(Get.arguments['item_id']);
    });
    return Scaffold(
        bottomNavigationBar: Container(
            height: 56,
            margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: ElevatedButton(onPressed: () {}, child: Text('Return'))),
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.white,
          title: Text(
            "Return",
          ),
          centerTitle: true,
          leading:
              InkWell(onTap: () => {Get.back()}, child: Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Select Reasons',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ),
              SizedBox(height:600,
                child: ListView.builder(
                    itemCount: returnController.reasons_list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title:
                            Text('${returnController.reasons_list[index]}'),
                        leading: Obx(() => Radio<int>(
                              value: index,
                              groupValue:
                                  returnController.selected_reason.value ??
                                      -1,
                              onChanged: (value) {
                                returnController.selected_reason.value =
                                    value!;
                                ReturnSheet(context);
                              },
                            )),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
