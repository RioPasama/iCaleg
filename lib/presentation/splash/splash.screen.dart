import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:icaleg/gen/assets.gen.dart';

import 'controllers/splash.controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Center(
        child: Container(
          height: 100,
          margin: const EdgeInsets.fromLTRB(40, 50, 40, 20),
          child: Row(
            children: [
              Image.asset(Assets.images.logoIcaleg.path),
              SvgPicture.asset(Assets.images.logoText)
            ],
          ),
        ),
      ),
    );
  }
}
