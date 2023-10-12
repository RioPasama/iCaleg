import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icaleg/app/controllers/auth_controller.dart';
import 'package:icaleg/app/data/models/user_model.dart';
import 'package:icaleg/app/data/services/user_service.dart';

class MainController extends GetxController {
  AuthController authController = Get.put(AuthController());

  late PageController pageControllerMain;

  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    pageControllerMain = PageController();
    super.onInit();
  }

  @override
  void onReady() async {
    UserModel userModel = await UserService.getDataUser();
    authController.saveDataUser(userModel: userModel);
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
