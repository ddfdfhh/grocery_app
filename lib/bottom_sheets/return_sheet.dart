import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:citymall/controllers/return_controller.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/styles/theme.dart';
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

ReturnSheet(BuildContext context) {
  ReturnController rc = Get.put(ReturnController());
  return showModalBottomSheet<void>(
    enableDrag: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(  minChildSize: .9,
          initialChildSize: .9,
          maxChildSize: .9,
          builder: (context, scrollController) => SingleChildScrollView(
          child:Padding(
        padding: MediaQuery.of(context).viewInsets,
        child:  Obx(
            () => Container(
                height: rc.where_to_refund.value == 'Bank Account' ? 830 : 530,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text('Details',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          OutlinedInput(
                              context, ' reasons ', null, rc.detailsController,
                              lines: 3),
                          SizedBox(height: 15),
                          Text('Upload images(Upto 4 images)',
                              style: AppTheme(context: context)
                                  .textTheme['titleMediumBold']),
                          SizedBox(height: 15),
                          SizedBox(
                            height: 100,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: DottedBorder(
                                        color: Colors.black26,
                                        dashPattern: [2, 4],
                                        child: GestureDetector(
                                          onTap: () async {
                                            XFile? pickedFile =
                                                await rc.singleImagePicker();
                                            if (pickedFile != null) {
                                              rc.imageFile1.value =
                                                  File(pickedFile.path);
                                            }
                                          },
                                          child: Container(
                                              // color: Colors.lightGreen.shade50,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .25,
                                              height: 100,
                                              child: rc.imageFile1.value != null
                                                  ? Image.file(
                                                      rc.imageFile1.value!,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Center(
                                                      child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(Icons.upload,color:Colors.black26),
                                                        Text('Upload Image'),
                                                      ],
                                                    ))),
                                        )),
                                  ),
                                  Expanded(
                                      child: DottedBorder(
                                          color: Colors.black26,
                                          dashPattern: [2, 4],
                                          child: GestureDetector(
                                            onTap: () async {
                                              XFile? pickedFile =
                                                  await rc.singleImagePicker();
                                              if (pickedFile != null) {
                                                rc.imageFile2.value =
                                                    File(pickedFile.path);
                                              }
                                            },
                                            child: Container(
                                                //  color: Colors.lightGreen.shade50,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .25,
                                                height: 100,
                                                child: rc.imageFile2.value !=
                                                        null
                                                    ? Image.file(
                                                        rc.imageFile2.value!,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Center(
                                                        child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(Icons.upload,color:Colors.black26),
                                                          Text('Upload Image'),
                                                        ],
                                                      ))),
                                          ))),
                                  Expanded(
                                      child: DottedBorder(
                                          color: Colors.black26,
                                          dashPattern: [2, 4],
                                          child: GestureDetector(
                                            onTap: () async {
                                              XFile? pickedFile =
                                                  await rc.singleImagePicker();
                                              if (pickedFile != null) {
                                                rc.imageFile3.value =
                                                    File(pickedFile.path);
                                              }
                                            },
                                            child: Container(
                                                //color: Colors.grey.shade50,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .25,
                                                height: 100,
                                                child: rc.imageFile3.value !=
                                                        null
                                                    ? Image.file(
                                                        rc.imageFile3.value!,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Center(
                                                        child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(Icons.upload,color:Colors.black26),
                                                          Text('Upload Image'),
                                                        ],
                                                      ))),
                                          ))),
                                  Expanded(
                                      child: DottedBorder(
                                          color: Colors.black26,
                                          dashPattern: [2, 4],
                                          child: GestureDetector(
                                            onTap: () async {
                                              XFile? pickedFile =
                                                  await rc.singleImagePicker();
                                              if (pickedFile != null) {
                                                rc.imageFile4.value =
                                                    File(pickedFile.path);
                                              }
                                            },
                                            child: Container(
                                                // color: Colors.lightGreen.shade50,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .25,
                                                height: 100,
                                                child: rc.imageFile4.value !=
                                                        null
                                                    ? Image.file(
                                                        rc.imageFile4.value!,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Center(
                                                        child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(Icons.upload,color:Colors.black26),
                                                          Text('Upload Image'),
                                                        ],
                                                      ))),
                                          ))),
                                ]),
                          ),
                          SizedBox(height: 15),
                          Text('Details To deposit Refund Amount',
                              style: AppTheme(context: context)
                                  .textTheme['titleMediumBold']),
                          SizedBox(height: 15),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             /* Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          rc.where_to_refund.value =
                                              'Bank Account';
                                        },
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: <Widget>[
                                            Container(
                                              height: 40,

                                              decoration: BoxDecoration(
                                                border:
                                                    rc.where_to_refund.value !=
                                                            'Bank Account'
                                                        ? Border.all(
                                                            width: 2,
                                                            color: Colors.grey.shade100)
                                                        : null,
                                                color: rc.where_to_refund.value ==
                                                        'Bank Account'
                                                    ? AppTheme(context: context).colors['primary']
                                                    : Colors.white,
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Radio<String>(
                                                  activeColor: AppTheme(context: context).colors['primary'],
                                                  focusColor: Colors.white,
                                                  value: 'Bank Account',
                                                  groupValue:
                                                      rc.where_to_refund.value,
                                                  onChanged: (value) {
                                                    rc.where_to_refund.value =
                                                        value!;
                                                  },
                                                ),
                                                Text(
                                                  "Bank Account",
                                                  style: TextStyle(
                                                    color:rc.where_to_refund.value=='Bank Account'?Colors.white:Colors.black87,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child:InkWell(
                                      onTap: () {
                                        rc.where_to_refund.value = 'Wallet';
                                      },
                                      child: Stack(alignment: Alignment.center,
                                        children: <Widget>[
                                          Container(
                                            height: 40,

                                            decoration: BoxDecoration(
                                              border:
                                                  rc.where_to_refund.value !=
                                                          'Wallet'
                                                      ? Border.all(
                                                          width: 2,
                                                          color: Colors.grey.shade100)
                                                      : null,
                                              color: rc.where_to_refund.value ==
                                                      'Wallet'
                                                  ?AppTheme(context: context).colors['primary']
                                                  : Colors.white,
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Radio<String>(
                                                activeColor: AppTheme(context: context).colors['primary'],
                                                focusColor: Colors.white,
                                                value: 'Wallet',
                                                groupValue:
                                                    rc.where_to_refund.value,
                                                onChanged: (value) {
                                                  rc.where_to_refund.value =
                                                      value!;
                                                },
                                              ),
                                              Text(
                                                "Wallet",
                                                style: TextStyle(
                                                    color:rc.where_to_refund.value=='Wallet'?Colors.white:Colors.black87,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                                  ]),*/
                              if (rc.where_to_refund.value == 'Bank Account')
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    OutlinedInput(context, 'Bank Name', null,
                                        rc.bankNameController,
                                        lines: 1),
                                    SizedBox(height: 5),
                                    OutlinedInput(
                                        context,
                                        'Account Holder name',
                                        null,
                                        rc.bankAcHolderController,
                                        lines: 1),
                                    SizedBox(height: 5),
                                    OutlinedInput(context, 'Account Number',
                                        null, rc.bankAcNoController,
                                        lines: 1),
                                    SizedBox(height: 5),
                                    OutlinedInput(context, 'IFSC', null,
                                        rc.ifscController,
                                        lines: 1),
                                    SizedBox(height: 5),
                                    // OutlinedInput(
                                    //     context, 'Upi', null, rc.upiController,
                                    //     lines: 1),
                                    Center(
                                      child: DottedBorder(
                                          color: Colors.black26,
                                          dashPattern: [2, 4],
                                          child: GestureDetector(
                                            onTap: () async {
                                              XFile? pickedFile =
                                              await rc.singleImagePicker();
                                              if (pickedFile != null) {
                                                rc.qrCodeImage.value =
                                                    File(pickedFile.path);
                                              }
                                            },
                                            child: Container(
                                              //  color: Colors.lightGreen.shade50,
                                                width:150,
                                                height: 100,
                                                child: rc.qrCodeImage.value !=
                                                    null
                                                    ? Image.file(
                                                  rc.qrCodeImage.value!,
                                                  fit: BoxFit.cover,
                                                )
                                                    : Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                      children: [
                                                        Icon(Icons.upload,color:Colors.black26),
                                                        Text('Upload Qr Code Image'),
                                                      ],
                                                    ))),
                                          )),
                                    )
                                  ],
                                )
                            ],
                          ),
                        //  SizedBox(height:20),
                          Expanded(
                            child: Center(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: Size(100, 50),
                                        padding: const EdgeInsets.all(5.0)),
                                    onPressed: () async {
                                      rc.uploadImage(context);
                                    },
                                    child: rc.isLoading.value
                                        ? const CircularProgressIndicator(
                                            backgroundColor: Colors.lightGreen,
                                            color: Colors.white)
                                        : const Text('Submit'))),
                          )
                        ],
                      )),
                )),
          ),

      )));
    },
  ).whenComplete(() {
    //Get.back();
    Get.offNamed(AppRoutes.return_order_item_list, arguments: {
      'order': rc.single_order_id.value,
      'return_type': rc.order_return_type.value
    });
  });
}
