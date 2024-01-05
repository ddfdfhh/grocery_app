import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:citymall/bottom_sheets/coupon_detail_sheet.dart';
import 'package:citymall/controllers/cart_controller.dart';
import 'package:citymall/controllers/category_controller.dart';
import 'package:citymall/controllers/coupon_controller.dart';
import 'package:citymall/controllers/dashboard_controller.dart';
import 'package:citymall/controllers/network_controller.dart';
import 'package:citymall/controllers/order_controller.dart';
import 'package:citymall/controllers/product_controller.dart';
import 'package:citymall/controllers/user_controller.dart';
import 'package:citymall/models/content_section.dart';
import 'package:citymall/models/product.dart';
import 'package:badges/badges.dart' as badges;
import 'package:citymall/models/slider_banner.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/service/setting_service.dart';
import 'package:citymall/service/user_service.dart';
import 'package:citymall/styles/theme.dart';
// import 'package:citymall/models/user_model.dart';
import 'package:citymall/widgets/best_selling.dart';
import 'package:citymall/widgets/bottom_nav.dart';
import 'package:citymall/widgets/category/circular_category.dart';
import 'package:citymall/widgets/content_sections/content_container.dart';
import 'package:citymall/widgets/nointernet.dart';

import 'package:citymall/widgets/slider.dart';
import 'package:citymall/widgets/vegetable_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'package:citymall/constants.dart';
import 'package:intl/intl.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
// import 'package:hive/hive.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.find();
    var setting = Get.find<SettingService>().setting;
    CategoryController catController = Get.find();
    OrderController orderController = Get.find();
    CouponController couponController = Get.put(CouponController());
    ProductController productController = Get.find();

    UserService userService = Get.find();

    DashboardController dashboardController = Get.put(DashboardController());
    NetworkController nc = Get.find();
    return Obx(() => nc.hasConnection.value
        ? Scaffold(
          bottomNavigationBar: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (orderController.pending_order_count.value > 0)
                  Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade200,
                        // borderRadius: BorderRadius.only(
                        //   topLeft:Radius.circular(10),
                        //   topRight:Radius.circular(10),
                        // )
                      ),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => Get.toNamed(AppRoutes.order_history),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height:30,width:20,child:Image.asset('${assetUrl(context)}/van.png')),
                              SizedBox(width: 10),
                              Text(
                                  'You have ${orderController.pending_order_count.value} Pending order(s) , yet to be delivered',
                                  overflow: TextOverflow.ellipsis,maxLines:1,
                                  style: AppTheme(context: context)
                                      .textTheme['titleSmallWhiteBold'])
                            ]),
                      )),
                if (couponController.frontCoupon.value != null)
                  Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.lightGreen.shade50,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          )),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => CouponDetailSheet(
                            context, couponController.frontCoupon.value!),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.discount, color: Colors.green),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                    '${couponController.frontCoupon.value!.name}',
                                    style: AppTheme(context: context)
                                            .textTheme[
                                        'titleSmallDarkGreen'],
                                    overflow: TextOverflow.ellipsis),
                              )
                            ]),
                      )),
                BottomNavBar(),
              ],
            ),
          ),
          appBar: AppBar(
            elevation: 0, shadowColor: Colors.transparent,
            scrolledUnderElevation: 100,
            toolbarHeight: userService.user?.address == null ? 70 : 90,

            automaticallyImplyLeading: true,
            title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(
                    height: 4,
                  ),

                  Text(
                    "Delivering to",
                    style: AppTheme(context: context)
                        .textTheme['titleMediumBoldWhite'],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Obx(()=>AutoSizeText(
                      maxLines: 2,
                      "${dashboardController.user_address.value.isNotEmpty ? toBeginningOfSentenceCase(dashboardController.user_address.value) : 'Adress not set'}",
                      style: AppTheme(context: context)
                          .textTheme['bodyMediumWhite'],
                    ),
                  ),
                ]),
            leading: IconButton(
              icon: Icon(Icons.home_outlined),
              onPressed: () {
              //  Get.toNamed(AppRoutes.map);
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: IconButton(
                  icon:  Icon(
                        Icons.edit,
                        size: 30,
                      ),

                  onPressed: () {
                    Get.toNamed(AppRoutes.map);
                  },
                ),
              )
            ],
          ),
          body: SafeArea(child:dashboardController.content_sections.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppTheme(context: context).colors['primary'],
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(35),
                            bottomLeft: Radius.circular(35),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(14),
                          child: TextField(
                            onTap: () {
                              Get.toNamed(AppRoutes.search);
                            },
                            autofocus: false,
                            style: TextStyle(
                                fontSize: 22.0, color: Color(0xFFbdc6cf)),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(
                                Icons.search_outlined,
                                size: 18,
                              ),
                              prefixStyle: AppTheme(context: context)
                                  .textTheme["titleSmallGrey"],
                              hintText: 'Search Products..',
                              hintStyle: AppTheme(context: context)
                                  .textTheme["titleSmallGrey"],
                              contentPadding: EdgeInsets.all(8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        )),
                        SizedBox(
                          height: 6,
                        ),
                        Text('Delivery is available within Ayodhya district only',style:TextStyle(fontWeight: FontWeight.w600,color:Colors.red)),

                        if (setting != null && setting['message'] != null) ...[
                          Container(padding: EdgeInsets.all(10),
                              margin:EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.deepOrange.shade50,
                                border: Border.all(color: Colors.deepOrange.shade200),

                              ),
                              width: double.infinity,
                              child: Center(child: Row(
                                children: [
                                  Icon(Icons.notifications_active_outlined,color:Colors.black87),
                                  SizedBox(width:10),
                                  Text('${setting['message']}',
                                      style:Theme.of(context).textTheme.bodyLarge?.
                                      copyWith(fontWeight:FontWeight.w600,color:Colors.black87)),
                                ],
                              ))),
                         // SizedBox(height: 10)
                        ],

                        SizedBox(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children:
                          dashboardController.content_sections.map((el) {
                        return el.isBannerSlider != null &&
                                el.isBannerSlider == 'Yes' &&
                                el.bannerImages != null
                            ? BannerSlider1(el.bannerImages!)
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ...[ContentContainer(context, el)],
                                ],
                              );
                      }).toList(),
                    )),
                    SizedBox(height: 100),
                  ]))
              : Center(child: CircularProgressIndicator()))

        )
        : NoInternet(context));
  }

  Widget BannerSlider1(List<BannerImages> bannerImages) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(10.0),
      child: bannerImages!.isNotEmpty
          ? (bannerImages!.length > 1
              ? BannerSlider(bannerImages!)
              : Image.network(
                  baseUrl + '/storage/banners/${bannerImages![0].name}',
                  height: 200,
                  fit: BoxFit.cover))
          : const CircularProgressIndicator(),
    );
  }
}
