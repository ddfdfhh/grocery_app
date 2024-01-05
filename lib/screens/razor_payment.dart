// import 'package:citymall/controllers/order_controller.dart';
// import 'package:citymall/controllers/payment_controller.dart';
// import 'package:citymall/service/user_service.dart';
//
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:payu_checkoutpro_flutter/payu_checkoutpro_flutter.dart';
// import 'package:payu_checkoutpro_flutter/PayUConstantKeys.dart';
// import 'dart:convert';
// class RazorPaymentScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     PaymentController pc=Get.put(PaymentController());
//     UserService us=Get.find();
//     Future.delayed(Duration.zero, () async {
//       pc.payment_amount.value = Get.arguments['amount'];
//       pc.user_id.value = Get.arguments['user_id'];
//       pc.razorpay_order_id.value=Get.arguments['orderId'];
//     });
//     return Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           foregroundColor: Colors.white,
//           title: Text(
//             "Payment",
//           ),
//           centerTitle: true,
//           leading:
//           InkWell(onTap: () => {Get.back()}, child: Icon(Icons.arrow_back)),
//         ),
//         body: SafeArea(
//             child: SingleChildScrollView(
//                 child: Column(children: [
//                   SizedBox(
//                     height: 20,
//                   ),
//                  ElevatedButton(
//                     child: const Text("Start Payment"),
//                     onPressed: ()  {
//                       var options = {
//                         'key': 'rzp_test_MjpXyppePxzjKO',
//                         'amount': pc.payment_amount.value,
//                         'name': 'Online Mart & Gift Hub',
//                         'description': 'Online order',
//                         "orderId":pc.razorpay_order_id.value,
//                         'prefill': {
//                           'contact':us.user?.phone_number,
//                           'email': us.user?.email
//                         }
//                       };
//                       print('show ordr opriod');
//                       print(options);
//                       pc.razorpay.open(options);
//                     },
//                   ),
//                 ]))));
//   }
// }
