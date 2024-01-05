import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:citymall/constants.dart';
import 'package:citymall/models/user_model.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/service/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
//import 'package:latlong2/latlong.dart';

class RealLocationController extends GetxController {
  var isLoading = false.obs;
   MapmyIndiaMapController? controller;

  RxList<dynamic> points = <dynamic>[].obs;
  Rx<String?> distination_longitude = (null as String?).obs;
  Rx<String?> distination_latitude = (null as String?).obs;
  Rx<Position?> currentPosition = (null as Position?).obs;
  Rx<Position?> lastPosition = (null as Position?).obs;
  late double start_latitude;
  late double start_longitude;
  late double end_latitude;
  late double end_longitude;

  late StreamSubscription<Position> positionStream;
  @override
  void onInit() async {

print('on initi ca');
    ever(distination_longitude, (_) => listRoutePoints());
   // ever(currentPosition, (_) => listRoutePoints());
    ever(distination_latitude, (_) => listRoutePoints());
    await getCurrentPosition();
    print('current position');
    print(currentPosition.value?.longitude);
    print(currentPosition.value?.latitude);

    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.medium,
      distanceFilter: 100,
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((position) {
              if(position!=lastPosition.value) {
                lastPosition.value=currentPosition.value;
                currentPosition.value = position;
                if(controller!=null) {
                  controller!.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                      zoom: 13.5,
                      target: LatLng(
                        currentPosition.value!.latitude!,
                        currentPosition.value!.longitude!,
                      ),
                    ),
                  ),);
                }
              }
    });
    print('subscribed sdgsdg dfhfdb ');
    listRoutePoints();
super.onInit();
  }

  @override
  void dispose() {
    positionStream.cancel();
    super.dispose();
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
            "Location permissions are denied",
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            icon: const Icon(Icons.add_alert),
          );

          return false;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          "",
          "Location permissions are permanently denied, we cannot request permissions.",
          colorText: Colors.white,
          backgroundColor: Colors.lightBlue,
          icon: const Icon(Icons.add_alert),
        );

        return false;
      }
    }
    return true;
  }

  getCurrentPosition() async {
    isLoading.value = true;
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) {
      print('prev rp');
      // print(Get.previousRoute);
      // return;
    }
    print('serice enable');
    currentPosition.value = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
  }

  listRoutePoints() async {

     start_longitude = currentPosition.value?.longitude != null
        ? currentPosition.value!.longitude
        : 80.9921546;
     start_latitude = currentPosition.value?.latitude != null
        ? currentPosition.value!.latitude
        : 26.884403;
     end_longitude = distination_longitude.value != null
        ? double.parse(distination_longitude.value!)
        : 81.0329953;
     end_latitude = distination_latitude.value != null
        ? double.parse(distination_latitude.value!)
        : 26.8730007;
    print('listing route ponts now ');
    print(
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=5b3ce3597851110001cf62483a792f92515c4b85aea75695b02645e7'
        '&start=${start_longitude},${start_latitude}&end=${end_longitude},${end_latitude}');
    var response = await http.get(Uri.parse(
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=5b3ce3597851110001cf62483a792f92515c4b85aea75695b02645e7&start=${start_longitude},${start_latitude}&end=${end_longitude},${end_latitude}'));
    //http: //router.project-osrm.org/route/v1/driving/26.884403,80.9921546;13.397634,81.0329953;13.428555,52.523219?overview=false
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // print(data);
      List lp = data['features'][0]['geometry']['coordinates'];
      points.value = lp.map((e) => e.toList()).toList();
      points.refresh();
      print('points.value');
      print(points.value);
    } else {
      print('api error');
    }
  }
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    print('got budle re');
    print(bytes.toString());
    final Uint8List list = bytes.buffer.asUint8List();
    return controller!.addImage(name, list);
  }

  // void addMarker() async {
  //   await addImageFromAsset("icon", "assets/images/car.jpg");
  //   controller!.addSymbol(const SymbolOptions(geometry: LatLng( 26.941262,80.957288), iconImage: "icon"));
  // }

}
