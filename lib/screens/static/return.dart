import 'package:citymall/controllers/network_controller.dart';
import 'package:citymall/service/setting_service.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/util.dart';
import 'package:citymall/widgets/nointernet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReturnPolicy extends StatelessWidget {
  SettingService setting = Get.put(SettingService());

  @override
  Widget build(BuildContext context) {
    setting.init();
    var name =
        '${setting.setting?['company_name']}(${setting.setting?['tagname']})';
    var phone = '${setting.setting?['phone']}';
    var address = '${setting.setting?['address']}';
    var pin = '${setting.setting?['pincode']}';
    var email = '${setting.setting?['email']}';
    var website = '${setting.setting?['website_url']}';
    var tagname = '${setting.setting?['tagname']}';

    NetworkController nc=Get.find();
    return Obx(()=>nc.hasConnection.value?Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.white,
          title: Text(
            "Return Policy",
          ),
          centerTitle: true,
          leading:
              InkWell(onTap: () => {Get.back()}, child: Icon(Icons.arrow_back)),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.all(08),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  border: Border.all(
                    color: Colors.grey, //                   <--- border color
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(09))),
              child: SingleChildScrollView(
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        '(${tagname}) Refund Policy',
                        textAlign: TextAlign.center,
                        style: AppTheme(context: context)
                            .textTheme["titleLargeGreenBold"],
                      ),
                      Text(
                        'Thank you for shopping at (${tagname})!',
                        textAlign: TextAlign.center,
                        style: AppTheme(context: context)
                            .textTheme["titleMediumBlack"],
                      ),
                      SizedBox(height: 04),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'We offer refund and/or exchange within the first 15 days of your purchase, if 15 days have passed since your purchase, you will not be offered a refund and/or exchange of any kind.',
                              textAlign: TextAlign.justify,
                              style: AppTheme(context: context)
                                  .textTheme["titleMediumBlack"],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Eligibility for Refunds and Exchanges',
                              style: AppTheme(context: context)
                                  .textTheme["titleLargeGreenBold"],
                            ),
                            SizedBox(height: 11),
                            Text.rich(
                              textAlign: TextAlign.justify,
                              TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.greenAccent,
                                      size: 16,
                                    ),
                                  ),
                                  TextSpan(
                                      text:
                                          ' Your item must be unused and in the same condition that you received it.'),
                                ],
                              ),
                            ),
                            SizedBox(height: 04),
                            Text.rich(
                              textAlign: TextAlign.justify,
                              TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.greenAccent,
                                      size: 16,
                                    ),
                                  ),
                                  TextSpan(
                                      text:
                                          ' The item must be in the original packaging.'),
                                ],
                              ),
                            ),
                            SizedBox(height: 04),
                            Text.rich(
                              textAlign: TextAlign.justify,
                              TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.greenAccent,
                                      size: 16,
                                    ),
                                  ),
                                  TextSpan(
                                      text:
                                          ' To complete your return, we require a receipt or proof of purchase.'),
                                ],
                              ),
                            ),
                            SizedBox(height: 04),
                            Text.rich(
                              textAlign: TextAlign.justify,
                              TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.greenAccent,
                                      size: 16,
                                    ),
                                  ),
                                  TextSpan(
                                      text:
                                          ' Only regular priced items may be refunded, sale items cannot be refunded.'),
                                ],
                              ),
                            ),
                            SizedBox(height: 04),
                            Text.rich(
                              textAlign: TextAlign.justify,
                              TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.greenAccent,
                                      size: 16,
                                    ),
                                  ),
                                  TextSpan(
                                      text:
                                          ' If the item in question was marked as a gift when purchased and shipped directly to you, you will receive a gift credit for the value of your return.'),
                                ],
                              ),
                            ),
                            // Row(
                            //   children: [
                            //     Icon(Icons.arrow_forward,color: Colors.greenAccent,size: 16,),
                            //     Expanded(child: Text(' Your item must be unused and in the same condition that you received it.')),
                            //   ],
                            // )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          text: 'Exchanges',
                          style: AppTheme(context: context)
                              .textTheme["titleLargeGreenBold"],
                          children: [
                            TextSpan(
                              text: '(if applicables)',
                              style: AppTheme(context: context)
                                  .textTheme["titleMediumBlackLight"],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'We receive return and exchange request of items if they are defective or damaged. If you need to place the exchange or return request through our app and over delivery boy will pick the order from your doorstep.',
                        textAlign: TextAlign.justify,
                        style: AppTheme(context: context)
                            .textTheme["titleMediumBlack"],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Exempt Goods',
                        style: AppTheme(context: context)
                            .textTheme["titleLargeGreenBold"],
                      ),
                      SizedBox(height: 16),
                      Text('The following are exempt from refunds:'),
                      SizedBox(height: 11),
                      Text.rich(
                        textAlign: TextAlign.justify,
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.greenAccent,
                                size: 16,
                              ),
                            ),
                            TextSpan(text: ' Gift cards'),
                          ],
                        ),
                      ),
                      SizedBox(height: 04),
                      Text.rich(
                        textAlign: TextAlign.justify,
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.greenAccent,
                                size: 16,
                              ),
                            ),
                            TextSpan(
                                text: ' Some health and personal care items'),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          text: 'Partial refunds are granted',
                          style: AppTheme(context: context)
                              .textTheme["titleLargeGreenBold"],
                          children: [
                            TextSpan(
                              text: '(if applicables)',
                              style: AppTheme(context: context)
                                  .textTheme["titleMediumBlackLight"],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Text.rich(
                        textAlign: TextAlign.justify,
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.greenAccent,
                                size: 16,
                              ),
                            ),
                            TextSpan(
                                text:
                                    ' Any item not in its original condition, is damaged or missing parts for reasons not due to our error.'),
                          ],
                        ),
                      ),
                      SizedBox(height: 04),
                      Text.rich(
                        textAlign: TextAlign.justify,
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.greenAccent,
                                size: 16,
                              ),
                            ),
                            TextSpan(
                                text:
                                    ' Any item that is returned more than 30 days after delivery.'),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Once your return is received and inspected, we will send you an email to notify you that we have received your returned item. We will also notify you of the approval or rejection of your refund.',
                        textAlign: TextAlign.justify,
                        style: AppTheme(context: context)
                            .textTheme["titleMediumBlack"],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'If you are approved, then your refund will be processed, and a credit will automatically be applied to your credit card or original method of payment, within a certain amount of days.',
                        textAlign: TextAlign.justify,
                        style: AppTheme(context: context)
                            .textTheme["titleMediumBlack"],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Late or missing refunds',
                        style: AppTheme(context: context)
                            .textTheme["titleLargeGreenBold"],
                      ),
                      SizedBox(height: 16),
                      Text.rich(
                        textAlign: TextAlign.justify,
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.greenAccent,
                                size: 16,
                              ),
                            ),
                            TextSpan(
                                text:
                                    ' If you have not received a refund yet, first check your bank account again. Then contact your credit card company, it may take some time before your refund is officially posted.'),
                          ],
                        ),
                      ),
                      SizedBox(height: 04),
                      Text.rich(
                        textAlign: TextAlign.justify,
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.greenAccent,
                                size: 16,
                              ),
                            ),
                            TextSpan(
                                text:
                                    ' If you have done all of this and you still have not received your refund yet, please contact us at (email and or phone number)'),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Shipping',
                        style: AppTheme(context: context)
                            .textTheme["titleLargeGreenBold"],
                      ),
                      SizedBox(height: 16),
                      Text.rich(
                        textAlign: TextAlign.justify,
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.greenAccent,
                                size: 16,
                              ),
                            ),
                            TextSpan(
                                text:
                                    ' Please do not send the product back to the us. We will arrange for the pickup of order from doorstep.'),
                          ],
                        ),
                      ),
                      SizedBox(height: 04),
                      Text.rich(
                        textAlign: TextAlign.justify,
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.greenAccent,
                                size: 16,
                              ),
                            ),
                            TextSpan(
                                text:
                                    ' No again shipping costs will be charged  for returning your item.'),
                          ],
                        ),
                      ),
                      SizedBox(height: 04),
                      Text.rich(
                        textAlign: TextAlign.justify,
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.greenAccent,
                                size: 16,
                              ),
                            ),
                            TextSpan(
                                text:
                                    ' Shipping costs are non-refundable! If you receive a refund, the cost of return shipping will be deducted from your refund.'),
                          ],
                        ),
                      ),
                      SizedBox(height: 04),
                      Text.rich(
                        textAlign: TextAlign.justify,
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.greenAccent,
                                size: 16,
                              ),
                            ),
                            TextSpan(
                                text:
                                    ' Depending on where you live, the time it may take for your exchanged product to reach you, may vary.'),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text.rich(
                        textAlign: TextAlign.justify,
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.greenAccent,
                                size: 16,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ])))):NoInternet(context));
  }
}
