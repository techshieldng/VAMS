// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:visitor_pass/views/pages/profile_update.dart';
import 'package:visitor_pass/views/widget/shimmer/profile_shimmer.dart';

import '../../Controllers/global-controller.dart';
import '../../Controllers/profile_controller.dart';
import '../../constants/constants.dart';
import 'change_password.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final ProfileController profileController = ProfileController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'profile'.tr,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColor.primaryColor,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<ProfileController>(
              init: ProfileController(),
              builder: (profile) => profile.profileLoader
                  ? const ProfileShimmer()
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                              width: 100,
                              height: 100,
                              child: CachedNetworkImage(
                                  imageUrl:
                                      profile.profileUser.image.toString(),
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                        radius: 40.0,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: imageProvider,
                                      ),
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                        child: const CircleAvatar(radius: 40.0),
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[400]!,
                                      ),
                                  errorWidget: (context, url, error) =>
                                      CircleAvatar(
                                        child: Image.asset(
                                          'assets/images/visitor.png',
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ))),
                          const SizedBox(
                            height: 18,
                          ),
                          Text(
                            profile.profileUser.name.toString(),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColor.primaryColor,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Column(
                            children: [
                              ListTile(
                                leading: SvgPicture.asset(
                                  Images.menuCard,
                                  height: 20,
                                  width: 20,
                                ),
                                title: Text(
                                  'user_name'.tr,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.hintColor),
                                ),
                                subtitle: Text(
                                  profile.profileUser.username.toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.nameColor),
                                ),
                              ),
                              const Divider(
                                height: 10,
                                thickness: 1,
                                indent: 70,
                                endIndent: 0,
                                color: AppColor.dividerColor,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              ListTile(
                                leading: SvgPicture.asset(
                                  Images.menuSms,
                                  height: 20,
                                  width: 20,
                                ),
                                title: Text(
                                  'email'.tr,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.hintColor),
                                ),
                                subtitle: Text(
                                  profile.profileUser.email.toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.nameColor),
                                ),
                              ),
                              const Divider(
                                height: 10,
                                thickness: 1,
                                indent: 70,
                                endIndent: 0,
                                color: AppColor.dividerColor,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              ListTile(
                                leading: SvgPicture.asset(
                                  Images.menuCall,
                                  height: 20,
                                  width: 20,
                                ),
                                title: Text(
                                  'phone'.tr,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.hintColor),
                                ),
                                subtitle: Text(
                                  '+' +
                                      profile.profileUser.countryCode
                                          .toString() +
                                      profile.profileUser.phone.toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.nameColor),
                                ),
                              ),
                              const Divider(
                                height: 10,
                                thickness: 1,
                                indent: 70,
                                endIndent: 0,
                                color: AppColor.dividerColor,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              ListTile(
                                leading: SvgPicture.asset(
                                  Images.menuLocation,
                                  height: 20,
                                  width: 20,
                                ),
                                title: Text(
                                  'address'.tr,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.hintColor),
                                ),
                                subtitle: Text(
                                  profile.profileUser.address.toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.nameColor),
                                ),
                              ),
                              const Divider(
                                height: 10,
                                thickness: 1,
                                indent: 70,
                                endIndent: 0,
                                color: AppColor.dividerColor,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  Get.to(() => ChangePassword(),
                                      duration: Duration(milliseconds: 400),
                                      transition: Transition.rightToLeft);
                                },
                                leading: SvgPicture.asset(
                                  Images.menuKey,
                                  height: 20,
                                  width: 20,
                                ),
                                //subtitle: Text('User Name'),
                                title: Text(
                                  'change_password'.tr,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.nameColor),
                                ),
                                trailing: box.read('lang') == 'ar'
                                    ? Transform.rotate(
                                        angle: pi,
                                        child: SvgPicture.asset(
                                          Images.right,
                                          height: 18,
                                          width: 18,
                                        ),
                                      )
                                    : SvgPicture.asset(
                                        Images.right,
                                        height: 18,
                                        width: 18,
                                      ),
                              ),
                              const Divider(
                                height: 10,
                                thickness: 1,
                                indent: 70,
                                endIndent: 0,
                                color: AppColor.dividerColor,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  Get.to(() => const ProfileUpdatePage(),
                                      duration: Duration(
                                          milliseconds:
                                              400), //duration of transitions, default 1 sec
                                      transition: Transition.rightToLeft);
                                },
                                leading: SvgPicture.asset(
                                  Images.menuEdit,
                                  height: 20,
                                  width: 20,
                                ),
                                title: Text(
                                  'update_profile'.tr,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.nameColor),
                                ),
                                trailing: box.read('lang') == 'ar'
                                    ? Transform.rotate(
                                        angle: pi,
                                        child: SvgPicture.asset(
                                          Images.right,
                                          height: 18,
                                          width: 18,
                                        ),
                                      )
                                    : SvgPicture.asset(
                                        Images.right,
                                        height: 18,
                                        width: 18,
                                      ),
                              ),
                              const Divider(
                                height: 10,
                                thickness: 1,
                                indent: 70,
                                endIndent: 0,
                                color: AppColor.dividerColor,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              ListTile(
                                onTap: () => {
                                  Get.find<GlobalController>().userLogout(),
                                },
                                leading: SvgPicture.asset(
                                  Images.menuLogout,
                                  height: 20,
                                  width: 20,
                                ),
                                //subtitle: Text('User Name'),
                                title: Text(
                                  'log_out'.tr,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.nameColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
        ),
      ),
    );
  }
}
