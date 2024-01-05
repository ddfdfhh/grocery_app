import 'package:auto_size_text/auto_size_text.dart';
import 'package:citymall/components/button.dart';
import 'package:citymall/controllers/LocationController.dart';
import 'package:citymall/controllers/network_controller.dart';
import 'package:citymall/service/user_service.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/widgets/nointernet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class LocationPage extends StatelessWidget {
  LocationController lc = Get.put(LocationController());
  @override
  Widget build(BuildContext context) {
    NetworkController nc=Get.find();
    return Obx(()=>nc.hasConnection.value?Scaffold(
      appBar: AppBar(title: const Text("Set Address ")),
      body: SafeArea(
        child: Center(
          child: Obx(() => !lc.permissionGranted.value
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 600,
                          child: Map(context)),
                    ),
                    Card(
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            )),
                            height: 80,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_on,
                                      color: AppTheme(context: context)
                                          .colors['primary']),
                                  Expanded(
                                      child: AutoSizeText(
                                          lc.currentAddress.value ?? '',
                                          style: AppTheme(context: context)
                                              .textTheme['bodySmall']))
                                ])))
                  ],
                )),
        ),
      ),
    ):NoInternet(context));
  }

  Widget Map(BuildContext context) {
    UserService us = Get.find();
    return FlutterLocationPicker(
      searchBarBackgroundColor: Colors.white,
        searchBarTextColor: Colors.black,
        initPosition: us.user?.lat == null && us.user?.lang == null
            ? LatLong(26.77, 82.14)
            : LatLong(
                double.parse(us.user!.lat!), double.parse(us.user!.lang!)),
        selectLocationButtonStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              AppTheme(context: context).colors['primary']),
        ),
        selectedLocationButtonTextstyle: const TextStyle(fontSize: 18),
        selectLocationButtonLeadingIcon: const Icon(Icons.check),
        initZoom: 11,
        minZoomLevel: 5,
        maxZoomLevel: 16,
        trackMyPosition: true,
        onError: (e) => print(e),
        onPicked: (pickedData) {

           if(pickedData!=null && pickedData.addressData!=null) {
             lc.currentAddress.value = pickedData.address;

             lc.updateAddress(
                 lc.currentAddress.value, pickedData.addressData['postcode']);
           }
           else
             {
               Get.snackbar(
                 "",
                 "Please wait ,fetching location",
                 colorText: Colors.white,
                 backgroundColor: Colors.orangeAccent,
                 icon: const Icon(Icons.add_alert),
               );
             }
        },
        onChanged: (pickedData) {

          lc.currentAddress.value = pickedData.address;

        });
  }
}
