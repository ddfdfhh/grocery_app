import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:citymall/controllers/return_controller.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/widgets/counter.dart';
import 'package:citymall/widgets/outlined_input.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:citymall/models/coupon.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

ReturnQtySheet(BuildContext context, int qty_limit) {
  ReturnController rc = Get.put(ReturnController());
  return showModalBottomSheet<void>(
    enableDrag: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
            //  color:Colors.white,
            width: MediaQuery.of(context).size.width,
            height: 130,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                    color: Colors.grey.shade100,
                    height: 50,
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Enter quantity to return",
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    )),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  children: [
                    SizedBox(width: 10),
                    Expanded(
                        child: SizedBox(
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(

                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10),
                            hintText: "Enter  quantity to return",
                            hintStyle: TextStyle(
                                fontSize: 14,
                                color: Color(0xff979899),
                                fontWeight: FontWeight.w500),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1.0, color: Colors.black12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1.0, color: Colors.black12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Theme.of(context).colorScheme.primary),
                            )),
                        controller: rc.qtyController,
                        keyboardType: TextInputType.number,
                        onTap: () => rc.qtyController.text = '',
                        onChanged: (val) {
                          if (val.isNotEmpty) {
                            if (int.parse(val) >= qty_limit) {
                              rc.qtyController.text = "${qty_limit}";
                            }
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        textAlign: TextAlign.start,
                      ),
                    )),
                    SizedBox(width:10),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      ),
                      onPressed: () async {
                        Get.toNamed(AppRoutes.return_order);
                      },
                      icon: Text('Proceed',style:Theme.of(context).textTheme.bodyLarge?.copyWith(color:Colors.white)),
                      label: const Icon(Icons.arrow_forward,size: 18),
                    ),
                    SizedBox(width:10),
                  ],
                ),
              ],
            )),
      );
    },
  );
}
