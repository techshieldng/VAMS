// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Controllers/auth-controller.dart';
import '../../constants/constants.dart';
import '../../constants/size_config_data.dart';
import '../widget/loader.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    SizeConfigData sizeConfig = SizeConfigData();
    sizeConfig.init(context);
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (auth) => Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 0.0, bottom: 0.0),
                  child: Stack(children: [
                    Center(
                      child: SingleChildScrollView(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: SvgPicture.asset(
                              Images.logo,
                              height: 30,
                              width: 120,
                              colorFilter: ColorFilter.mode(
                                  AppColor.primaryColor, BlendMode.srcIn),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              'login_form'.tr,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: AppColor.primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 42,
                          ),
                          Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'email'.tr,
                                      style: (TextStyle(
                                          fontSize: 14,
                                          color: AppColor.nameColor,
                                          fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (_emailController.text.isEmpty) {
                                          return "this_field_can_t_be_empty".tr;
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                            width: 1,
                                            color: AppColor.redColor,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                            width: 1,
                                            color: AppColor.redColor,
                                          ),
                                        ),
                                        fillColor: Colors.red,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide: BorderSide(
                                              color: AppColor.dividerColor,
                                              width: 1.0),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            bottomLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                          ),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: AppColor.borderColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'password'.tr,
                                      style: (TextStyle(
                                          fontSize: 14,
                                          color: AppColor.nameColor,
                                          fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: _passwordController,
                                      validator: (value) {
                                        if (_passwordController.text.isEmpty) {
                                          return "this_field_can_t_be_empty".tr;
                                        }
                                        return null;
                                      },
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                            width: 1,
                                            color: AppColor.redColor,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                            width: 1,
                                            color: AppColor.redColor,
                                          ),
                                        ),
                                        fillColor: Colors.red,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide: BorderSide(
                                              color: AppColor.dividerColor,
                                              width: 1.0),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            bottomLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                          ),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: AppColor.borderColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 21,
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        checkColor: Colors.white,
                                        value: isChecked,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isChecked = value!;
                                          });
                                        },
                                      ),
                                      Text(
                                        'remember_me'.tr,
                                        style: TextStyle(
                                            color: AppColor.nameColor),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 26,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size.fromHeight(60),
                                        backgroundColor: AppColor.primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10), // <-- Radius
                                        ),
                                        // fromHeight use double.infinity as width and 40 is the height
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          auth.loginOnTap(
                                              email: _emailController.text
                                                  .toString()
                                                  .trim(),
                                              pass: _passwordController.text
                                                  .toString()
                                                  .trim());
                                        }
                                      },
                                      child: Text(
                                        "login".tr,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      )),
                    ),
                    auth.loader
                        ? Positioned(
                            child: Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white60,
                                child: const Center(child: LoaderCircle())),
                          )
                        : const SizedBox.shrink(),
                  ]),
                ),
              ),
            ));
  }
}
