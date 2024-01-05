// import 'dart:convert';
// import 'package:citymall/constants.dart';
// import 'package:citymall/controllers/cart_controller.dart';
// import 'package:citymall/controllers/order_controller.dart';
// import 'package:citymall/routes.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:upi_india/upi_india.dart';
// class UpiPaymentController extends GetxController {
//   UpiIndia upiIndia = UpiIndia();
//   RxList<UpiApp> apps=<UpiApp>[].obs;
//   var is_loading_apps=false.obs;
//   String? transactionResponse;
//   @override
//   Future<void> onInit() async {
//     super.onInit();
//     is_loading_apps.value=true;
//     upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
//       is_loading_apps.value=false;
//       apps.value = value;
//
//     }).catchError((e) {
//       is_loading_apps.value=false;
//       print('error in retirivving upi apps ');
//       apps.value = [];
//     });
//
//   }
//   //  initiateTransaction(UpiApp app) async {
//   //   try {
//   //     transactionResponse= await FlutterUpi.initiateTransaction(
//   //       app: FlutterUpiApps.PayTM,
//   //       pa: "receiver@upi",
//   //       pn: "Receiver Name",
//   //       tr: "UniqueTransactionId",
//   //       tn: "This is a transaction Note",
//   //       am: "5.01",
//   //       mc: "YourMerchantId", // optional
//   //       cu: "INR",
//   //       url: "https://www.google.com",
//   //     );ctionNote: 'Not actual. Just an example.',
//   //       amount: 1.00,
//   //     );
//   //     print('upi reposme ');
//   //     print(transactionResponse);
//   //
//   //   }catch(e){
//   //     print('error found in upi app');
//   //     print(e.toString());
//   //   }
//   //   /*
//   //   *  // Data in UpiResponse can be null. Check before printing
//   //                 String txnId = transactionResponse.transactionId ?? 'N/A';
//   //                 String resCode = transactionResponse.responseCode ?? 'N/A';
//   //                 String txnRef = transactionResponse.transactionRefId ?? 'N/A';
//   //                 String status = transactionResponse.status ?? 'N/A';
//   //                 String approvalRef = transactionResponse.approvalRefNo ?? 'N/A';
//   //                 _checkTxnStatus(status);*/
//   // }
//   void _checkTxnStatus(String status) {
//     switch (status) {
//       case UpiPaymentStatus.SUCCESS:
//         print('Transaction Successful');
//         break;
//       case UpiPaymentStatus.SUBMITTED:
//         print('Transaction Submitted');
//         break;
//       case UpiPaymentStatus.FAILURE:
//         print('Transaction Failed');
//         break;
//       default:
//         print('Received an Unknown transaction status');
//     }
//   }
//
//   String _upiErrorHandler(error) {
//     switch (error) {
//       case UpiIndiaAppNotInstalledException:
//         return 'Requested app not installed on device';
//       case UpiIndiaUserCancelledException:
//         return 'You cancelled the transaction';
//       case UpiIndiaNullResponseException:
//         return 'Requested app didn\'t return any response';
//       case UpiIndiaInvalidParametersException:
//         return 'Requested app cannot handle the transaction';
//       default:
//         return 'An Unknown error has occurred';
//     }
//   }
//   makePayment(double amount, String orderId,int normal_order_id) {
//
//   }
//
//   Future<void> _handlePaymentSuccess(var rz_response) async {
//
//     print({
//       'payment_id': rz_response.paymentId,
//       'order_id':'d',
//       'razor_order_id':rz_response.orderId,
//       'signature': rz_response.signature
//     });
//     http.Response response = await http.post(
//       Uri.parse(baseApiUrl + '/storePayment'),
//       body: {
//         'payment_id': rz_response.paymentId,
//         'order_id':'d',
//         'razor_order_id':rz_response.orderId,
//         'signature': rz_response.signature
//       },
//     );
//
//     if (response.statusCode == 201) {
//       Map<String, dynamic> result = jsonDecode(response.body);
//       var res = result['data'] ;
//       print('after payment store resp response dat');
//       print(result);
//       Get.delete<CartController>();
//       Get.delete<OrderController>();
//       Get.toNamed(AppRoutes.order_success);
//     } else {
//       // If the server did not return a 201 CREATED response,
//       // then throw an exception.
//       print('payment seems to be flawd or fraud');
//       Get.toNamed(AppRoutes.order_failed);
//     }
//   }
//
//   void _handlePaymentError(Response response) {
//     // Do something when payment fails
//     print('failure');
//     //print(response.message);
//     Get.toNamed(AppRoutes.order_failed);
//   }
//
// }
