import 'package:citymall/controllers/network_controller.dart';
import 'package:citymall/service/setting_service.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/util.dart';
import 'package:citymall/widgets/nointernet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class About extends StatelessWidget {

  SettingService setting=Get.put(SettingService());

  @override

  Widget build(BuildContext context) {
    setting.init();
    var name='${setting.setting?['company_name']}(${setting.setting?['tagname']})';
    var phone='${setting.setting?['phone']}';
    var address='${setting.setting?['address']}';
    var pin='${setting.setting?['pincode']}';
    var email='${setting.setting?['email']}';
    var website='${setting.setting?['website_url']}';
    var tagname='${setting.setting?['tagname']}';
    NetworkController nc=Get.find();
    return Obx(()=>nc.hasConnection.value?Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.white,
          title: Text(
            "About Us",
          ),
          centerTitle: true,
          leading:
          InkWell(onTap: () => {Get.back()}, child: Icon(Icons.arrow_back)),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text('${tagname}  is an online plateform for delivering grocery and gift items  within Faizabad City.We are '
                        'running  offline supermarket store in the city.',style:AppTheme(context: context).textTheme['titleMediumBlack']),
                    Text('${tagname} basically deals in delivery of grocery items and gift items right now .',style:AppTheme(context: context).textTheme['titleMediumBlack'])
                  ]),
                )))):NoInternet(context));
  }
}
