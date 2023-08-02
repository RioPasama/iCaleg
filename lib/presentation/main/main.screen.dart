import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';
import 'package:icaleg/presentation/screens.dart';
import 'package:ionicons/ionicons.dart';

import 'controllers/main.controller.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    return Obx(
      () => Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: controller.pageControllerMain,
            onPageChanged: (index) => controller.onPageChangedPageView(index),
            children: const [
              HomeScreen(),
              SupportScreen(),
              StatisticsScreen(),
              ProfileScreen()
            ],
          ),
        ),
        extendBody: true,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 24, bottom: 16, right: 24),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(28)),
            child: BottomNavyBar(
              selectedIndex: controller.selectedIndex.value,
              onItemSelected: (index) =>
                  controller.onItemSelectedBottomNavyBar(index),
              backgroundColor: colorPrimary,
              items: [
                BottomNavyBarItem(
                  activeColor: Colors.white,
                  title: const Text('Beranda'),
                  icon: const Icon(Ionicons.home_outline),
                ),
                BottomNavyBarItem(
                  activeColor: Colors.white,
                  title: const Text('Dukungan'),
                  icon: const Icon(Ionicons.people_outline),
                ),
                BottomNavyBarItem(
                  activeColor: Colors.white,
                  title: const Text('Statistik'),
                  icon: const Icon(Ionicons.trending_up_outline),
                ),
                BottomNavyBarItem(
                  activeColor: Colors.white,
                  title: const Text('Profil'),
                  icon: const Icon(Ionicons.person_outline),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
