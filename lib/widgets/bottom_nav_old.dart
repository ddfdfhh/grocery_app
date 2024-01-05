// import 'package:citymall/constants.dart';
// import 'package:citymall/controllers/cart_controller.dart';
// import 'package:citymall/routes.dart';
// import 'package:citymall/widgets/cart_count.dart';
// // import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:citymall/styles/theme.dart';
// class BottomNavBar extends StatefulWidget {
//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }
//
// class _BottomNavBarState extends State<BottomNavBar> {
//   int currentIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     CartController c = Get.find();
//     return Obx(()=>ConvexAppBar.badge(
//       backgroundColor:  Colors.white,
//       initialActiveIndex: 2,
//         activeColor:AppTheme(context: context).colors['primary'] as Color,
//       color: AppTheme(context: context).colors['primary'] as Color,
//       {1: '${c.cart_count.toString()}'},
//       items: [
//         TabItem(
//             icon: Icons.category,
//             title: 'Explore',
//             fontFamily: GoogleFonts.nunito().fontFamily),
//         TabItem(
//             icon: Icons.shopping_cart,
//             title: 'cart',
//             fontFamily: GoogleFonts.nunito().fontFamily),
//         TabItem(
//             icon: Icons.home,
//             title: 'Home',
//             fontFamily: GoogleFonts.nunito().fontFamily),
//         TabItem(
//             icon: Icons.receipt_long,
//             title: 'My Orders',
//             fontFamily: GoogleFonts.nunito().fontFamily),
//         TabItem(
//             icon: Icons.people,
//             title: 'Profile',
//             fontFamily: GoogleFonts.nunito().fontFamily),
//       ],
//       onTap: (int i) {
//         if (i == 0) {
//           Get.toNamed(AppRoutes.main_categories);
//         }
//         if (i == 1) {
//           Get.toNamed(AppRoutes.cart);
//         }
//         if (i == 2) {
//           Get.toNamed(AppRoutes.dashboard);
//         }
//         if (i == 3) {
//           Get.toNamed(AppRoutes.order_history);
//         }
//         if (i == 4) {
//           Get.toNamed(AppRoutes.account);
//         }
//       },
//     ));
//   }
// }
