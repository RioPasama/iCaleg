import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:icaleg/gen/assets.gen.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            _appBar(),
            Padding(
              padding: const EdgeInsets.only(top: 138),
              child: Column(
                children: [
                  _infoUser(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _infoUser() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
          border: Border.all(color: colorPrimary)),
      child: Row(
        children: [
          Container(
            height: Get.width / 3.8,
            width: Get.width / 3.8,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                color: colorGray,
                shape: BoxShape.circle,
                boxShadow: [boxShadow]),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width / 2,
                child: Text(
                  controller.authController.userModel.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              SizedBox(
                width: Get.width / 2,
                child: Text(
                  'CALEG DPRD KABUPATEN MAGELANG',
                  style: TextStyle(
                      color: colorTextPrimary, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: Get.width / 2,
                child: Text('PARTAI POLITIK'),
              ),
              SizedBox(
                width: Get.width / 2,
                child: Text(
                  'Partai Bahagia Selalu (PBS)',
                  style: TextStyle(
                      color: colorTextPrimary, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: Get.width / 2,
                child: Text('DAERAH PEMILIHAN'),
              ),
              SizedBox(
                width: Get.width / 2,
                child: Text(
                  'DP MAGELANG 1',
                  style: TextStyle(
                      color: colorTextPrimary, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container _appBar() {
    return Container(
      padding: const EdgeInsets.only(top: 48, bottom: 100),
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [colorPrimary, colorPrimaryGradient]),
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(60)),
          boxShadow: [boxShadow]),
      child: Row(
        children: [
          Image.asset(
            Assets.images.logoIcaleg.path,
            width: 80,
          ),
          SvgPicture.asset(
            Assets.images.logoText,
            width: 100,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          )
        ],
      ),
    );
  }
}
