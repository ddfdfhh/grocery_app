import 'package:citymall/components/button.dart';
import 'package:citymall/controllers/network_controller.dart';
import 'package:citymall/controllers/profile_controller.dart';
import 'package:citymall/controllers/register_controller.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/service/user_service.dart';
import 'package:citymall/widgets/nointernet.dart';
import 'package:citymall/widgets/outlined_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  var show_form = true.obs;
  void toggle() {
    show_form.value = !show_form.value;
  }

  ProfileController rc = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    UserService userService = Get.find();
    NetworkController nc=Get.find();
    return Obx(()=>nc.hasConnection.value?Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.white,
          title: Text(
            "Update Profile",
          ),
          centerTitle: true,
          leading:
              InkWell(onTap: () => {Get.back()}, child: Icon(Icons.arrow_back)),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(children: [
                      SizedBox(height: 20),
                      ProfileDetail(context)
                    ]))))):NoInternet(context));
  }

  Widget ProfileDetail(BuildContext context) {
    return Column(children: [
      OutlinedInput(context, 'Fullname', Icons.people, rc.nameController),
      SizedBox(height: 10),
      // OutlinedInput(context, 'Email ', Icons.email, rc.emailController),
      // SizedBox(height: 10),
      // // OutlinedInput(context, 'Password ', Icons.email, rc.passwordController),
      // // SizedBox(height: 10),
      // OutlinedInput(context, 'Phone Number', Icons.phone, rc.phoneController),
      // SizedBox(height: 10),
      OutlinedInput(
          context, 'Address ', Icons.location_city, rc.addressController,
          lines: 2),
      SizedBox(height: 10),
      Obx(
        () => DefaultButton(context,'Save', () {
          rc.updateProfile();
        }, null, isLoading: rc.isLoading.value),
      )
    ]);
  }
}
