import 'package:citymall/bindings/custom_scaffold.dart';
import 'package:citymall/components/button.dart';
import 'package:citymall/constants.dart';
import 'package:citymall/controllers/login_controller.dart';
import 'package:citymall/controllers/network_controller.dart';
import 'package:citymall/routes.dart';
import 'package:citymall/styles/theme.dart';
import 'package:citymall/widgets/nointernet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _autovalidate = false;
  @override
  Widget build(BuildContext context) {
    final LoginController c = Get.put(LoginController());
    NetworkController nc=Get.find();
    return Scaffold(resizeToAvoidBottomInset:true,
        body: SafeArea(
          child: Obx(()=>nc.hasConnection.value?SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(height:MediaQuery.of(context).size.height,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset('${assetUrl(context)}/logo.png')),
                  SizedBox(height: 10),
                  Text("Welcome Back",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text("Sign in with your registered phone number ",
                      style: AppTheme(context: context).textTheme['light']),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: 400,
                        height: 335,
                        child: Form(
                            key: c.formKey,
                            autovalidateMode: _autovalidate
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // EmailTextField(c, context),
                                  // SizedBox(height:10),
                                  // Row(children: <Widget>[
                                  //   Expanded(child: Divider()),
                                  //   Text("OR",style:TextStyle(color:Colors.green)),
                                  //   Expanded(child: Divider()),
                                  // ]),
                                  SizedBox(height:10),
                                  PhoneField(c, context),
                                 SizedBox(height:20),
                                  Obx(
                                    () => DefaultButton(context,"Signin", () {
                                      if (c!.formKey.currentState!
                                          .validate()) {
                                        c!.sub();
                                      } else {
                                        setState(() {
                                          _autovalidate = true;
                                        });
                                      }
                                    }, null,
                                        isLoading: c.isLoading.value),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text('New Customer?',
                                          style:
                                              AppTheme(context: context)
                                                  .textTheme['light']),
                                      TextButton(
                                          onPressed: () {
                                            Get.toNamed(
                                                AppRoutes.register);
                                          },
                                          child: const Text('Signup')),
                                    ],
                                  ),
                                ]))),
                  )
                ]),
              ),
            ),
          ):NoInternet(context),
        )));
  }

  OutlineInputBorder outlineInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(width: .3));
  }

  OutlineInputBorder highlightInputBorder(BuildContext context) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
            width: .3, color: AppTheme(context: context).colors['primary']));
  }

  Widget EmailTextField(LoginController? c, BuildContext context) {
    return TextFormField(
      controller: c!.emailController,
      validator: (val) {
        return c!.validateEmail();
      },
      decoration: InputDecoration(
          enabledBorder: outlineInputBorder(),
          focusedBorder: highlightInputBorder(context),
          border: outlineInputBorder(),
          labelText: "Email",
          hintText: "Enter your email",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.email)),
    );
  }

  Widget PasswordTextField(LoginController? c, BuildContext context) {
    return Obx(
      () => TextFormField(
        controller: c!.passwordController,
        validator: (val) {
          return c!.validatePassword();
        },
        obscureText: c!.showPassword.value ? false : true,
        decoration: InputDecoration(
            enabledBorder: outlineInputBorder(),
            focusedBorder: highlightInputBorder(context),
            border: outlineInputBorder(),
            labelText: "Password",
            hintText: "Enter your password",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: IconButton(
              splashColor: Colors.white,
              icon: Icon(c!.showPassword.value
                  ? Icons.visibility
                  : Icons.visibility_off),
              onPressed: () {
                c!.showPassword.value = !c!.showPassword.value;
              },
            )),
      ),
    );
  }

  Widget PhoneField(LoginController? c, BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: c!.phoneController,
      validator: (val) {
        return c!.validatePhone();
      },
      decoration: InputDecoration(
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        border: outlineInputBorder(),
        labelText: "Phone Number",
        hintText: "Enter your  registered mobile no",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
