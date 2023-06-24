import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icaleg/app/controllers/text_input_validator_controller.dart';

class LoginController extends GetxController {
  final TextInputValidatorController textInputValidatorController =
      Get.put(TextInputValidatorController());

  late TextEditingController emailTextEditingController;
  late TextEditingController passwordTextEditingController;

  final formKey = GlobalKey<FormState>();

  RxBool showPassowrd = false.obs;

  @override
  void onInit() {
    emailTextEditingController = TextEditingController();
    passwordTextEditingController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.onClose();
  }
}
