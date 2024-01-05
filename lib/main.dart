import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:citymall/bindings/initial_binding.dart';

import 'package:citymall/service/user_service.dart';
import 'package:citymall/styles/theme.dart';

import 'package:citymall/util.dart';

import 'package:citymall/routes.dart';
import 'package:citymall/size_config.dart';
import 'package:device_preview/device_preview.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:citymall/firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive/hive.dart';
void main() async {
 
  WidgetsFlutterBinding.ensureInitialized();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  var encryptionKey='Asd@123#';
  var containsEncryptionKey = await secureStorage.containsKey(key: encryptionKey);
  if (!containsEncryptionKey) {
    var key = Hive.generateSecureKey();
    await secureStorage.write(key: encryptionKey, value: base64UrlEncode(key));
  }
  Get.put<UserService>(UserService(), permanent: true);
  UserService us=Get.find();
  us.init(secureStorage,encryptionKey);
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //
  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // await FirebaseMessaging.instance.subscribeToTopic("all");
  // await FirebaseMessaging.instance.setAutoInitEnabled(true);
  //
  // us.setDeviceToken('$fcmToken');
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xe7739246),
    statusBarBrightness: Brightness.light,
  ));
 // Get.reset();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(DevicePreview(
            enabled: false,
            builder: (context) => const MyApp(), // Wrap your app
          )));

  //CartController returnController = Get.put(CartController());
  // await Hive.initFlutter();
  // Hive.registerAdConstacpter(UserModelAdapter());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return GetMaterialApp(
              // scrollBehavior: const MaterialScrollBehavior().copyWith(
              //   dragDevices: {PointerDeviceKind.mouse},
              // ),
              initialBinding: InitialBinding(),
              debugShowCheckedModeBanner: false,
              title: 'OMG Hub',
              theme: ThemeData(
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  fontFamily: GoogleFonts.robotoCondensed().fontFamily,
                  tabBarTheme: TabBarTheme(

                      labelStyle:AppTheme(context: context).textTheme['bodyLargeBoldColor'],
                      unselectedLabelStyle:AppTheme(context: context).textTheme['bodyLargeBold']
                  ),
                  appBarTheme: AppBarTheme(

                    titleTextStyle: AppTheme(context: context).textTheme['titleMediumBoldWhite'],

                  ),
                  // colorScheme: ColorScheme.fromSeed(
                  //   seedColor: AppTheme(context: context).colors['primary'],
                  // ).copyWith(
                  //   primary: Color(0xe77b9c4a),
                  // ),
                  colorScheme: ColorScheme.fromSwatch(
                      primarySwatch: getMaterialColor(Color(0xe7739246))),
                  // textTheme:
                  //     GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme),
                  sliderTheme: SliderThemeData(
                    activeTickMarkColor: Colors.green,
                    showValueIndicator: ShowValueIndicator.always,
                    overlayColor: Colors.green,
                    valueIndicatorColor: Colors.lightGreen.shade600,
                  )),
              initialRoute: AppRoutes.splash,
              getPages: AppRoutes.pages);
        });
  }
}
