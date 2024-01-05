import 'package:auto_size_text/auto_size_text.dart';
import 'package:citymall/constants.dart';
import 'package:citymall/controllers/login_controller.dart';
import 'package:citymall/controllers/network_controller.dart';
import 'package:citymall/controllers/profile_controller.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/service/user_service.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/widgets/bottom_nav.dart';
import 'package:citymall/widgets/expansion.dart';
import 'package:citymall/widgets/nointernet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../util.dart';

class AccountScreen extends StatelessWidget {
  ProfileController rc = Get.put(ProfileController());
  LoginController lc = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    UserService userService = Get.find();
    NetworkController nc=Get.find();
    return Obx(()=>nc.hasConnection.value?Scaffold(
        bottomNavigationBar: BottomNavBar(),
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          )),
          elevation: 0,
          foregroundColor: Colors.white,
          title: Text(
            "My Account",
          ),
          centerTitle: true,
          leading:
              InkWell(onTap: () => {Get.back()}, child: Icon(Icons.arrow_back)),
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          child: SingleChildScrollView(
              child: Column(children: [
            Container(
                //decoration: BoxDecoration(color: Colors.lightGreen.shade500),
                //height: 150,
                child: Column(children: [
              ListTile(
                leading: Icon(Icons.people,
                    color: AppTheme(context: context).colors['primary']),
                title: Text(
                  "${toUpperCase(userService.user?.name ?? '')}",
                ),
                subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${userService.user?.email}"),
                      Text("${userService.user?.phone_number}"),
                      userService.user != null &&
                              userService.user!.address.isNotEmpty
                          ? AutoSizeText("${userService.user?.address}")
                          : Text("No  shipping address added ",
                              style: TextStyle(color: Colors.red))
                    ]),
                trailing: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.updateProfile);
                    },
                    child: Icon(Icons.edit,
                        color: AppTheme(context: context).colors['primary'])),
              ),
            ])),
            SizedBox(height: 10),
            ListTile(
              splashColor: Colors.lightGreen.shade300,
              // hoverColor: Colors.lightGreen.shade100,
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: .5, color: Colors.black12)),
              leading: Icon(Icons.receipt_long_rounded,
                  color: AppTheme(context: context).colors['primary']),
              title: Text('My Orders',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54)),
              trailing: Icon(Icons.chevron_right,
                  color: AppTheme(context: context).colors['primary']),
              onTap: () {
                Get.toNamed(AppRoutes.order_history);
              },
            ), TileIcon(context, "About The App ",
                    Icons.medical_information, AppRoutes.about),
            TileIcon(context, "Shipping Policy ",
                Icons.local_shipping, AppRoutes.shipping),
            TileIcon(context, "Privacy Policy ", Icons.privacy_tip_outlined,
                AppRoutes.privacy),
            TileIcon(context, "Terms & Conditions ",
                Icons.control_point_duplicate_sharp, AppRoutes.terms),
            TileIcon(context, "Return & Refund Policy",
                Icons.transfer_within_a_station_outlined, AppRoutes.refund),
            Tile(context, "Customer Service",
                '${assetUrl(context)}/support.png', AppRoutes.support),
            LogoutTile(context, "Logout")
          ])),
        ))):NoInternet(context));
  }

  Widget Tile(
      BuildContext context, String title, String imagePath, String route_path) {
    return ListTile(
      splashColor: Colors.lightGreen.shade300,
      // hoverColor: Colors.lightGreen.shade100,
      shape: RoundedRectangleBorder(
          side: BorderSide(width: .5, color: Colors.black12)),
      leading: Image.asset(imagePath,
          width: 30,
          height: 30,
          color: AppTheme(context: context).colors['primary']),
      title: Text(title,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black54)),
      trailing: Icon(Icons.chevron_right,
          color: AppTheme(context: context).colors['primary']),
      onTap: () {
        Get.toNamed(route_path);
      },
    );
  }
  Widget TileIcon(
      BuildContext context, String title, IconData icon, String route_path) {
    return ListTile(
      splashColor: Colors.lightGreen.shade300,
      // hoverColor: Colors.lightGreen.shade100,
      shape: RoundedRectangleBorder(
          side: BorderSide(width: .5, color: Colors.black12)),
      leading: Icon(icon,color:AppTheme(context: context).colors['primary']),
      title: Text(title,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black54)),
      trailing: Icon(Icons.chevron_right,
          color: AppTheme(context: context).colors['primary']),
      onTap: () {
        Get.toNamed(route_path);
      },
    );
  }

  Widget LogoutTile(BuildContext context, String title) {
    return ListTile(
      splashColor: Colors.lightGreen.shade300,
      // hoverColor: Colors.lightGreen.shade100,
      shape: RoundedRectangleBorder(
          side: BorderSide(width: .5, color: Colors.black12)),
      leading: Icon(Icons.logout_outlined,
          color: AppTheme(context: context).colors['primary']),
      title: Text(title,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black54)),
      trailing: Icon(Icons.chevron_right,
          color: AppTheme(context: context).colors['primary']),
      onTap: () {
        lc.logout();
      },
    );
  }
}
