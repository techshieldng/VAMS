import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:visitor_pass/constants/constants.dart';
import 'package:get/get.dart';

import '../pages/pre-register/pre_register.dart';
import '../pages/visitor/visitor.dart';

class DashboardCard extends StatelessWidget {
  DashboardCard(
      {Key? key,
      required this.page,
      required this.topic,
      required this.count,
      required this.imgUrl,
      required this.cardColor,
      this.iconColor})
      : super(key: key);
  final bool page;
  final String topic;
  final String count;
  final String imgUrl;
  final Color cardColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (page) {
          Get.to(() => VisitorListPage(),
              duration: Duration(milliseconds: 400),
              transition: Transition.downToUp);
        } else {
          Get.to(() => PreRegisterListPage(),
              duration: Duration(milliseconds: 400),
              transition: Transition.downToUp);
        }
      },
      child: Container(
        height: ScreenSize(context).mainHeight / 6.7,
        width: ScreenSize(context).mainWidth / 2.4,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        imgUrl,
                        colorFilter: ColorFilter.mode(
                            iconColor ?? Colors.blue.shade500, BlendMode.srcIn),
                        height: 18,
                        width: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        count,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: ScreenSize(context).mainWidth / 2.7,
                        child: Text(
                          topic,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                          maxLines: 2,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
