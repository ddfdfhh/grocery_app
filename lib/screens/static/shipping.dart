import 'package:citymall/controllers/network_controller.dart';
import 'package:citymall/service/setting_service.dart';
import 'package:citymall/util.dart';
import 'package:citymall/widgets/nointernet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingPolicy extends StatelessWidget {
  SettingService setting=Get.put(SettingService());

  @override
  Widget build(BuildContext context) {
    setting.init();
    var name='${setting.setting?['company_name']}(${setting.setting?['tagname']})';
    var phone='${setting.setting?['phone']}';
    var address='${setting.setting?['address']}';
    var pin='${setting.setting?['pincode']}';
    var email='${setting.setting?['email']}';
    NetworkController nc=Get.find();
    return Obx(()=>nc.hasConnection.value?Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.white,
          title: Text(
            "Shipping Policy",
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
                          PolicyParagraph(context,
                              'Thank you for visiting and shopping at https://dornish.felxipattern.biz. The following terms and conditions constitute our Shipping Policy.'
                                  'Domestic Shipping Policy'),
                          SizedBox(height: 16),
                          PolicyHeading(context, 'Shipping Timelines'),
                          SizedBox(height: 16),
                          PolicyParagraph(context, 'The items will be shipped within 2 hours to 24 hrs from the date of receiving the Order.'
                              'Customers are given chioce of slot and date when they are comfortable to receieve the delivery .We are commited to deliver the product within the time slot choosen by customer.'
                              'If we are receiving a large volume of orders, expect a few days delay in shipping. '
                              'We will keep you informed via email or call, during such events.'
                              '${name} will have no liability for any delivery delays due to conditions that are beyond our control, such as:'),
                          SizedBox(height: 16),
                          PolicyBulletLine('Natural calamities'),
                          SizedBox(height: 16),
                          PolicyBulletLine('Riots') ,
                          SizedBox(height: 16),
                          PolicyBulletLine('Weather conditions') ,
                          SizedBox(height: 16),
                          PolicyBulletLine('Pandemic'),
                          SizedBox(height: 16),
                          PolicyBulletLine('War'),
                          SizedBox(height: 16),
                          PolicyParagraph(context, 'If your Order is delayed beyond 2 days of the estimated Delivery Time due to above reasons, We will get in touch with you to check if you would still like to continue with'
                              'your Order.'),
                          SizedBox(height: 16),
                          PolicyHeading(context, 'SHIPPING COST/DELIVERY COST'),
                          SizedBox(height: 16),
                          PolicyParagraph(context, 'The shipping charges/Delivery Charges are notified at the time of checkout, and customers will know about this before making the payment.'
                              'We will be providing free delivery to customers for purchase limit beyond that it is chargeable.'
                              'But as our busines grows and we  start getting huge traffic of orders then we may ask for delivery charges from customer to provide timed delivery and prioritize orders'),
                          SizedBox(height: 16),
                          PolicyHeading(context, 'DAMAGES'),
                          SizedBox(height: 16),
                          PolicyParagraph(context, '${name} is  not liable for any product damaged or lost after  delivery. If You still have nay query then write to us with your Order number at  ${email} or contact at +91${phone} .'),
                          // SizedBox(height: 16),
                          // PolicyParagraph(context, 'Please save all packaging materials and damaged goods before filing a claim.'),
                          SizedBox(height: 16),
                          PolicyHeading(context, 'RETURNS, REPLACEMENTS, AND REFUNDS'),
                          SizedBox(height: 16),
                          PolicyParagraph(context, 'f the packaging is found tampered with or damaged, do not accept the goods. Write to us '
                              'with your Order number at  ${email} or contact at +91${phone} .'
                              'We will ensure that a replacement delivery is made to you at the earliest.'
                              '${name} are not responsible for any damage or loss of the Goods once it is delivered.'
                              'Customers can return the item within 2 days  from the date of delivery.'
                              'In the rare instance that you are unhappy with our product, you can drop us an email at ${email} with your '
                              'Order number and a convenient time to call.'
                              'One of our customer service executives will call you within 24 hrs  to understand the issue better and provide you with instructions on returning the item back to us.'),
                          SizedBox(height: 16),
                          PolicyHeading(context, 'DOMESTIC LOGISTIC PARTNERS'),
                          SizedBox(height: 16),
                          PolicyParagraph(context, 'No Courier service from third party will be used in product delivery in starting stage.We will employe own delivery boys to ship orders within city.But as the business expands in other city ,'
                              'we can opt for third party delivery services also.'),
                          SizedBox(height: 16),
                          PolicyHeading(context, 'HOW TO TRACK YOUR ORDER?'),
                          SizedBox(height: 16),
                          PolicyParagraph(context, 'Customer can see the order status within order history section of app.All the status of order will be updated within app time to time to keep the customer updated of their order delivery status.'),
                          SizedBox(height: 16),
                          PolicyHeading(context, 'CONTACT US'),
                          SizedBox(height: 16),
                          PolicyParagraph(context, 'If you have any questions regarding our shipping policy, feel free to send us an inquiry email at ${email}'),
                        ]),
                  ),
                ),
              ),


                ])))):NoInternet(context));
  }
}
