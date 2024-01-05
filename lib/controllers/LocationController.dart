import 'dart:convert';

import 'package:citymall/constants.dart';
import 'package:citymall/controllers/dashboard_controller.dart';
import 'package:citymall/controllers/order_controller.dart';
import 'package:citymall/dialog/loading_dialog.dart';
import 'package:citymall/models/user_model.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/service/api_service.dart';
import 'package:citymall/service/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class LocationController extends GetxController {
  // Rx<Coupon?> selectedCoupon = (null as Coupon?).obs;
  var currentAddress = ''.obs;
  var isLoading = false.obs;
  var isUpdatingLocation = false.obs;
var permissionGranted=false.obs;
  UserService userService = Get.find();
  Rx<Position?> currentPosition = (null as Position?).obs;
  @override
  void onInit() async {
    super.onInit();
   ever(isUpdatingLocation,(_)=>do1());

  }
  @override
  void onReady() async {
    super.onReady();

    getCurrentPosition();
  }
  void do1(){
    if(isUpdatingLocation.value)
      LoadingDialog('Updating Address');

    else
      Navigator.of(Get.context as BuildContext, rootNavigator: true).pop('dialog');
  }
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.checkPermission();
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar(
            "",
            "Location permissions are denied,Please enable location  to update the shipping address",
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            icon: const Icon(Icons.add_alert),
          );

          return false;
        }else return true;
      }
      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          "",
          "Location permissions are permanently denied,Please enable location  to update the shipping address",
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.add_alert),
        );

        return false;
      }
      else return true;
    }
    else
    return true;
  }

  getCurrentPosition() async {

    Get.dialog(
      AlertDialog(
        title: Text("Location  Usage Disclosure",style:TextStyle(fontWeight: FontWeight.bold)),
        content: Text("This app usage location permission ,to access users current location to update shipping address so that"
            " order can be  shipped at accurate location.This location is needed only at the time of setting shipping address."
            "Current Location is not tracked in background. "),

        actions: <Widget>[
          TextButton(
            child: Text("OK"),
            onPressed: () async{
                 Get.back();
              isLoading.value = true;
              final hasPermission = await _handleLocationPermission();

              if (!hasPermission) {
                permissionGranted.value=false;
                return;
              }
              permissionGranted.value=true;
              await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
                  .then((Position position) {
                currentPosition.value = position;
                _getAddressFromLatLng(currentPosition.value!);
                isLoading.value = false;
              }).catchError((Exception e) {
                print('here15');
                debugPrint(e.toString());
              });
            },
          )
        ],
      ),
      barrierDismissible: false,
    );



  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            currentPosition.value!.latitude, currentPosition.value!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress.value =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
    }).catchError((e) {
      print('here1');
      debugPrint(e);
    });
  }

  updateAddress(String address, String pin) async {
    //  try {
    String? lat = currentPosition.value?.latitude.toString();
    String? lang = currentPosition.value?.longitude.toString();
    isUpdatingLocation(true);
    var body = {
      'email': userService.user?.email,
      'phone': userService.user?.phone_number,
      'address': address,
      'pin': pin,
      'lat': lat,
      'lang': lang
    };

    ApiService.postRequest(
        ApiResponseType.Unformatted, '/updateAddress', body, null, (res) async{
      Get.snackbar(
        "Success",
        "Address Updated Successfully ",
        colorText: Colors.white,
        backgroundColor: Colors.green,
        icon: const Icon(Icons.check_circle),
      );
      userService.userBox.clear();
      final UserModel cacheUser = UserModel(
        name: userService.user!.name,
        email: userService.user!.email,
        token:userService.user!.token,
        phone_number: userService.user!.phone_number,
        address: address,
        lat: lat,
        lang: lat,
      );
      await userService.userBox.put('user', cacheUser);
      userService.user = cacheUser;
      isUpdatingLocation(false);
      OrderController oc=Get.find();
      DashboardController dc=Get.find();
      dc.user_address.value=address;
      oc.current_timestamp.value=DateTime.now().millisecondsSinceEpoch;
      Future.delayed(Duration(seconds:2), () {


        Get.close(1);
      });
 }, (res){
      isUpdatingLocation(false);
    }, showRequestDetail: false);

  }
}
