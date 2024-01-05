import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:citymall/constants.dart';
import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/controllers/category_controller.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/service/user_service.dart';
import 'package:citymall/widgets/cart_count.dart';
// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:citymall/styles/theme.dart';

class BottomNavBar extends StatefulWidget {

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
CartController cartController=Get.find();
CategoryController categoryController=Get.find();
  int currentIndex = 0;
  String? currentPath;
  @override
  Widget build(BuildContext context) {
    UserService us=Get.find();
    currentPath=Get.currentRoute;
    print('currentIndex');
    currentIndex=us.currentIndex;
    CartController c = Get.find();
    return Container(
      decoration: BoxDecoration(
        color:Colors.lightGreen,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              spreadRadius: 0,
              blurRadius: 30,
              offset: Offset(0, 7)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: currentIndex,
          onTap: (i) {
            setState(() {
              currentIndex = i;
            });
            us.currentIndex=i;
            if (i == 0) {
              Get.offNamed(AppRoutes.dashboard);
            }
            if (i == 1) {
              categoryController.categoryId.value=0;
              Get.toNamed(AppRoutes.main_categories);
            }
            if (i == 2) {
              Get.toNamed(AppRoutes.cart);
            }
            if (i == 3) {
              Get.toNamed(AppRoutes.order_history);
            }
            if (i == 4) {
              Get.toNamed(AppRoutes.account);
            }
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppTheme(context: context).colors['primary'],
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
          unselectedItemColor: Colors.black,
          items: navigatorItems.map((e) {
            return getNavigationBarItem(
                label: e.label, index: e.index, iconPath: e.iconPath,path:e.path,userService:us);
          }).toList(),
        ),
      ),
    );
  }

  BottomNavigationBarItem getNavigationBarItem(

      {required String label,required int index, required IconData iconPath,required String path,required UserService userService}) {
    Color iconColor = userService.currentIndex == index ?
    AppTheme(context: context).colors['primary'] : Colors.grey.shade600;
    return BottomNavigationBarItem(
      label: label,
      icon: (index!=2)?Icon(iconPath,color:iconColor,size: 20):
    Obx(()=>badges.Badge(badgeStyle:BadgeStyle(badgeColor:AppTheme(context: context).colors['secondary']),
      badgeContent: Text('${cartController.cart_count.value}',style:TextStyle(color:Colors.white)),
      child: Icon(iconPath,color:iconColor,size: 20),
    )),
    );
  }
}
