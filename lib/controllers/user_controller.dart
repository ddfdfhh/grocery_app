import 'dart:convert';

import 'package:citymall/constants.dart';
import 'package:citymall/models/category.dart';
import 'package:citymall/models/content_section.dart';
import 'package:citymall/models/get_api_response_model.dart';
import 'package:citymall/models/product.dart';
import 'package:citymall/models/slider_banner.dart';
import 'package:citymall/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:path_provider/path_provider.dart';
class UserController extends GetxController {


  Rx<UserModel?> user=(null as UserModel?).obs;
  late Box<UserModel> userBox;
  @override
   onInit()  async {
    super.onInit();
    WidgetsFlutterBinding.ensureInitialized();
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    // await Hive.initFlutter();
     Hive.registerAdapter(UserModelAdapter());
    userBox = await Hive.openBox('Usercache');
    user.value=userBox.get('user');
    print('user initlaised');
    print('${user.value?.name}');
    update();

  }


}
