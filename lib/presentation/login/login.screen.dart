import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:icaleg/gen/assets.gen.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';
import 'package:icaleg/presentation/login/views/login_from_view.dart';
import 'controllers/login.controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: Get.height - 30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 100,
                  margin: const EdgeInsets.fromLTRB(40, 50, 40, 20),
                  child: Row(
                    children: [
                      Image.asset(Assets.images.logoIcaleg.path),
                      SvgPicture.asset(Assets.images.logoText)
                    ],
                  ),
                ),
                LoginFromView(),
                SizedBox(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SvgPicture.asset(
                        Assets.images.footer1,
                        width: Get.width,
                        colorFilter: ColorFilter.mode(
                            colorPrimary.withOpacity(0.8), BlendMode.srcIn),
                      ),
                      SvgPicture.asset(
                        Assets.images.footer2,
                        width: Get.width,
                        colorFilter: ColorFilter.mode(
                            colorPrimary.withOpacity(0.8), BlendMode.srcIn),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
