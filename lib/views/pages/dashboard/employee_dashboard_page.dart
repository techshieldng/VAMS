// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:visitor_pass/constants/constants.dart';
import 'package:visitor_pass/views/pages/visitor/visitor.dart';
import 'package:visitor_pass/views/widget/dashboard_card.dart';

import '../../../Controllers/dashboard_controller.dart';
import '../../../Controllers/visitor-controller.dart';
import '../../shimmer/visitor-shimmer.dart';
import '../../widget/visitor_card.dart';

class EmployeeDashboardPage extends StatefulWidget {
  const EmployeeDashboardPage({Key? key}) : super(key: key);

  @override
  State<EmployeeDashboardPage> createState() => _EmployeeDashboardPageState();
}

class _EmployeeDashboardPageState extends State<EmployeeDashboardPage> {
  DashboardController dashboardController = Get.put(DashboardController());

  Future<void> _onRefresh() {
    dashboardController.onInit();
    Get.find<VisitorController>().onInit();
    Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });

    return completer.future;
  }

  String selectedValue = "English";

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Get.rawSnackbar(
        snackPosition: SnackPosition.TOP,
        title: message.notification?.title,
        message: message.notification?.body,
        backgroundColor: AppColor.greenColor.withOpacity(.9),
        maxWidth: ScreenSize(context).mainWidth / 1.007,
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _onRefresh();
    });
    if (box.read('selectedValue') != null) {
      selectedValue = box.read('selectedValue');
    }
    return Scaffold(
        body: GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (dashboard) => RefreshIndicator(
        onRefresh: _onRefresh,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
          child: ListView(
            children: [
              //Dashboard  section
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Images.logo,
                      height: 24,
                      width: 80,
                      colorFilter: ColorFilter.mode(
                          AppColor.primaryColor, BlendMode.srcIn),
                    ),
                    Row(children: [
                      Text(selectedValue.toString()),
                      SizedBox(
                        width: 10,
                      ),
                      _languagePopupButton()
                    ])
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DashboardCard(
                    page: false,
                    topic: 'total_pre_registers'.tr,
                    count: dashboard.totalPreRegister.toString(),
                    imgUrl: Images.people2,
                    iconColor: AppColor.greenColor,
                    cardColor: AppColor.greenColor,
                  ),
                  DashboardCard(
                    page: true,
                    topic: 'total_visitors'.tr,
                    count: dashboard.totalVisitor.toString(),
                    imgUrl: Images.people,
                    cardColor: AppColor.primaryColor,
                  ),
                ],
              ),
              //Visitor card >>> section 2
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'visitors'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xff002793),
                        fontSize: 20,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (kDebugMode) {
                          print('view all visitors ------->>>');
                        }
                        Get.to(VisitorListPage());
                      },
                      child: Text(
                        'view_all'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColor.primaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: ScreenSize(context).mainHeight / 1.76,
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: dashboard.visitorList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return dashboard.loader
                        ? VisitorShimmer()
                        : VisitorCard(
                            image:
                                dashboard.visitorList[index].image.toString(),
                            name: dashboard.visitorList[index].name.toString(),
                            id: dashboard.visitorList[index].id.toString(),
                            visitorID:
                                dashboard.visitorList[index].regNo.toString(),
                            status:
                                dashboard.visitorList[index].status.toString(),
                            statusName: dashboard.visitorList[index].statusName
                                .toString(),
                            checkInAt: dashboard.visitorList[index].checkInAt
                                .toString(),
                            checkOutAt: dashboard.visitorList[index].checkOutAt
                                .toString(),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  _languagePopupButton() {
    return PopupMenuButton(
      child: Container(
        height: 28,
        width: 28,
        child: CircleAvatar(
          child: Flag.fromString(
            box.read("langKey") == null ? 'us' : box.read("langKey"),
            height: 30,
            width: 30,
            fit: BoxFit.cover,
            borderRadius: 50,
          ),
        ),
      ),
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext bc) => [
        PopupMenuItem(
          value: "en",
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Flag.fromCode(
                    FlagsCode.US,
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(width: 5.0),
                  Text("English", style: const TextStyle(fontSize: 15)),
                ],
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: "bn",
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Flag.fromCode(
                    FlagsCode.BD,
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(width: 5.0),
                  Text("Bangla", style: const TextStyle(fontSize: 15)),
                ],
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: "de",
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Flag.fromCode(
                    FlagsCode.DE,
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(width: 5.0),
                  Text("German", style: const TextStyle(fontSize: 15)),
                ],
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: "fr",
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Flag.fromCode(
                    FlagsCode.FR,
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(width: 5.0),
                  Text("France", style: const TextStyle(fontSize: 15)),
                ],
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: "ar",
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Flag.fromCode(
                    FlagsCode.SA,
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(width: 5.0),
                  Text("Arabic", style: const TextStyle(fontSize: 15)),
                ],
              ),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        if (value == "en") {
          setState(() {
            box.write('lang', value);
            box.write('langKey', 'US');
            box.write('selectedValue', 'English');
            Get.updateLocale(const Locale('en', 'US'));
          });
        } else if (value == "bn") {
          setState(() {
            box.write('lang', value);
            box.write('langKey', 'BD');
            box.write('selectedValue', 'Bangla');
            Get.updateLocale(const Locale('bn', 'BD'));
          });
        } else if (value == "de") {
          setState(() {
            box.write('lang', value);
            box.write('langKey', 'DE');
            box.write('selectedValue', 'German');
            Get.updateLocale(const Locale('de', 'DE'));
          });
        } else if (value == "fr") {
          setState(() {
            box.write('lang', value);
            box.write('langKey', 'FR');
            box.write('selectedValue', 'France');
            Get.updateLocale(const Locale('fr', 'FR'));
          });
        } else if (value == "ar") {
          setState(() {
            box.write('lang', value);
            box.write('langKey', 'SA');
            box.write('selectedValue', 'Arabic');
            Get.updateLocale(const Locale('ar', 'AR'));
          });
        }
      },
    );
  }
}
