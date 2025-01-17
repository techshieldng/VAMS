import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visitor_pass/views/pages/login.dart';

import '../../Controllers/auth-controller.dart';
import '../../Controllers/global-controller.dart';
import '../constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController _authController = AuthController();

  @override
  void initState() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {});
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
    FirebaseMessaging.instance.getToken().then((token) {
      update(token!);
    });
    Timer(
      const Duration(seconds: 2),
      () => ({
        logInCheck(),
      }),
    );
    super.initState();
  }

  update(String token) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('deviceToken', token);
    print('fcm token===========>');
    print(token);
  }

  logInCheck() async {
    if (Get.find<GlobalController>().isUser) {
      _authController.refreshToken(context);
    } else {
      Get.off(() => const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 60,
              width: 60,
              child: CircleAvatar(
                radius: 50,
                child: Image(
                  height: 60,
                  width: 60,
                  image: AssetImage(Images.logoIcon),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
