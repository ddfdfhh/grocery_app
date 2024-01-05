import 'package:citymall/controllers/network_controller.dart';
import 'package:citymall/controllers/support_controller.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/util.dart';
import 'package:citymall/widgets/expansion.dart';
import 'package:citymall/widgets/nointernet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/button.dart';

class SupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SupportController c = Get.put(SupportController());
    NetworkController nc = Get.find();
    return Obx(() => nc.hasConnection.value
        ? SafeArea(
            child: Scaffold(
                // extendBodyBehindAppBar: true,
                backgroundColor: Colors.white,
                appBar: AppBar(
                    centerTitle: false,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    title: Text('Help & Support Center')),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 02, vertical: 02),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        // height: 200,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: AppTheme(context: context)
                                    .colors['boxShadow'],
                                blurRadius: 2.0,
                                blurStyle: BlurStyle.normal),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Support',
                              style: AppTheme(context: context)
                                  .textTheme["titleLargeBold"],
                            ),
                            Text(
                              'Let us know your feedback and queries',
                              style: AppTheme(context: context)
                                  .textTheme["bodySmall"],
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  side: BorderSide(
                                      width: 1, color: Colors.white)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Call',
                                        style: AppTheme(context: context)
                                            .textTheme["titleLargeBlack"],
                                      ),
                                      Text(
                                        '+919803394039',
                                        style: AppTheme(context: context)
                                            .textTheme["bodySmallBlack"],
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.call_outlined,
                                    color: AppTheme(context: context)
                                        .colors["primary"],
                                  ),
                                ],
                              ),
                              onPressed: () {
                                c.launchCaller();
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  side: BorderSide(
                                      width: 1, color: Colors.white)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Email us',
                                        style: AppTheme(context: context)
                                            .textTheme["titleLargeBlack"],
                                      ),
                                      Text(
                                        'support@invo.com',
                                        style: AppTheme(context: context)
                                            .textTheme["bodySmallBlack"],
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.email,
                                    color: AppTheme(context: context)
                                        .colors["primary"],
                                  ),
                                ],
                              ),
                              onPressed: () {
                                c.emailMe();
                              },
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              'Write us',
                              style: AppTheme(context: context)
                                  .textTheme["titleLargeBold"],
                            ),
                            Text(
                              'Enter your message',
                              style: AppTheme(context: context)
                                  .textTheme["bodySmall"],
                            ),
                            SizedBox(height: 20),
                            Form(
                                key: c.formKey,
                                autovalidateMode: AutovalidateMode.always,
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        // width: 240, // <-- TextField width
                                        height: 120, // <-- TextField height
                                        child: TextField(
                                          controller: c.messageController,
                                          maxLines: null,
                                          expands: true,
                                          // keyboardType: TextInputType.multiline,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4)),
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppTheme(
                                                            context: context)
                                                        .colors['primary']),
                                              ),
                                              hintText: 'Enter a message'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Obx(() => DefaultButton(context, 'Submit',
                                              () {
                                            if (c!.formKey.currentState!
                                                .validate()) {
                                              c!.submit();
                                            } else {
                                              c.autoValidate.value = true;
                                            }
                                          }, null,
                                              isLoading: c.isLoading.value))
                                    ])),
                            SizedBox(height: 20),
                            Obx(() {
                              return c.list.length > 0
                                  ? Expansible(
                                      context,
                                      'Previous Queries',
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ConstrainedBox(
                                                constraints: BoxConstraints(
                                                    maxHeight: 500),
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: c.list.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      Map<String, dynamic>
                                                          item = c.list[index];
                                                      return Column(
                                                        children: [
                                                          ListTile(
                                                              leading: null,
                                                              title: Text(
                                                                  '${item['message']}'),
                                                              trailing: Text(
                                                                "${formatDate(item['created_at'])}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .lightGreen,
                                                                    fontSize:
                                                                        15),
                                                              )),
                                                          Divider()
                                                        ],
                                                      );
                                                    }))
                                          ]),
                                      false,
                                      null)
                                  : const Text('');
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          )
        : NoInternet(context));
  }
}
