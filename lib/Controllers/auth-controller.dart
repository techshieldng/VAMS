import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visitor_pass/Models/login_model.dart';
import '../Models/refreshtoken_model.dart';
import '../views/widget/bottom_nav.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import '/services/user-service.dart';
import '/services/validators.dart';
import 'package:get/get.dart';

import 'global-controller.dart';

class AuthController extends GetxController {
  UserService userService = UserService();
  final Validators _validators = Validators();
  Server server = Server();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscureText = true;
  bool loader = false;


  changeVisibility() {
    obscureText = !obscureText;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
  }



  loginOnTap({BuildContext? context, String? email, String? pass}) async {
    print('email');
    loader = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    var passValidator = _validators.validatePassword(value: pass);
    if (passValidator == null) {
      Map body = {'email': email, 'password': pass};
      String jsonBody = json.encode(body);
      server
          .postRequest(endPoint: APIList.login, body: jsonBody)
          .then((response) {
        if (response != null && response.statusCode == 200) {
          updateFcmSubscribe(email);
          final jsonResponse = json.decode(response.body);
          var loginData = LoginModel.fromJson(jsonResponse);
          var bearerToken = 'Bearer ' + "${loginData.token}";
          userService.saveBoolean(key: 'is-user', value: true);
          userService.saveString(key: 'token', value: loginData.token);
          userService.saveString(
              key: 'user-id', value: loginData.data?.id.toString());
          userService.saveString(
              key: 'email', value: loginData.data?.email.toString());
          userService.saveString(
              key: 'image', value: loginData.data!.image.toString());
          userService.saveString(
              key: 'name', value: loginData.data!.name.toString());
          userService.saveString(
              key: 'phone', value: loginData.data!.phone.toString());

          Server.initClass(token: bearerToken);
          Get.put(GlobalController()).initController();
          emailController.clear();
          passwordController.clear();
          loader = false;
          Future.delayed(const Duration(milliseconds: 10), () {
            update();
          });
          Get.off(() =>  BottomNav());
          Get.rawSnackbar(
              message: "${loginData.message}",
              backgroundColor: Colors.green,
              snackPosition: SnackPosition.TOP);

        } else {
          loader = false;
          Future.delayed(const Duration(milliseconds: 10), () {
            update();
          });
          final jsonResponse = json.decode(response.body);
          Get.rawSnackbar(
              message: "${jsonResponse['message']}",
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.TOP);
        }
      });
    } else {
      loader = false;
      Future.delayed(const Duration(milliseconds: 10), () {
        update();
      });
      Get.rawSnackbar(message: 'Please enter email address and password');
    }
  }

  refreshToken(context) async {
    server.getRequest(endPoint: APIList.refreshToken).then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        var refreshData = RefreshTokenModel.fromJson(jsonResponse);
        var newToken = 'Bearer ' + "${refreshData.data!.token}";
        userService.saveBoolean(key: 'is-user', value: true);
        userService.saveString(key: 'token', value: refreshData.data!.token);
        Server.initClass(token: newToken);
        Get.put(GlobalController()).initController();
        Get.off(() =>  BottomNav());
        return true;
      } else {
        Get.find<GlobalController>().userLogout(context:context );
        return false;
      }
    });
  }

  updateFcmSubscribe(email) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    var deviceToken = storage.getString('deviceToken');
    Map body = {
      "device_token": deviceToken,
      "topic": email,
    };
    String jsonBody = json.encode(body);
    server
        .postRequest(endPoint: APIList.fcmSubscribe, body: jsonBody)
        .then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print('responseBody===========>');
        print(jsonResponse);
      }
    });
  }

}
