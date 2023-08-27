import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  late PageController pageControllerMain;

  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    pageControllerMain = PageController();
    super.onInit();
  }

  @override
  void onReady() {
    //
    super.onReady();
  }

  @override
  void onClose() {
    pageControllerMain.dispose();
    super.onClose();
  }

  void onItemSelectedBottomNavyBar(int index) {
    selectedIndex.value = index;
    pageControllerMain.jumpToPage(index);
  }

  void onPageChangedPageView(int index) {
    selectedIndex.value = index;
  }
}
