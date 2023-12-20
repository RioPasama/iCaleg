import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icaleg/app/controllers/app_setting_controller.dart';
import 'package:icaleg/app/controllers/auth_controller.dart';
import 'package:icaleg/app/controllers/text_input_validator_controller.dart';
import 'package:icaleg/app/data/models/user_model.dart';
import 'package:icaleg/app/data/services/user_service.dart';
import 'package:icaleg/infrastructure/navigation/routes.dart';

class LoginController extends GetxController {
  AppSettingController appSettingController = Get.put(AppSettingController());
  final AuthController authController = Get.put(AuthController());
  final TextInputValidatorController textInputValidatorController =
      Get.put(TextInputValidatorController());

  late TextEditingController emailTextEditingController;
  late TextEditingController passwordTextEditingController;
  late TextEditingController nomorWhatsappTextEditingController;

  final formKey = GlobalKey<FormState>();

  RxBool showPassowrd = false.obs;
  RxBool loginByWhatsapp = false.obs;

  @override
  void onInit() {
    emailTextEditingController = TextEditingController();
    passwordTextEditingController = TextEditingController();
    nomorWhatsappTextEditingController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    //
    super.onReady();
  }

  @override
  void onClose() {
    // emailTextEditingController.dispose();
    // passwordTextEditingController.dispose();
    super.onClose();
  }

  Future<void> onTapLoginWhatsapp() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    String code = await UserService.postLoginWhatsapp(
        phone: '+62${nomorWhatsappTextEditingController.text}');

    Map<String, String> sendArguments = {
      'tag': '1',
      'indentity': '+62${nomorWhatsappTextEditingController.text}',
    };

    if (code == '200') {
      Get.toNamed(Routes.VERIFICATION, arguments: sendArguments);
    }
  }

  Future<void> onTapLogin() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    String token = await UserService.postLogin(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text);

    authController.saveToken(token: token);

    if (token.isNotEmpty) {
      UserModel userModel = await UserService.getDataUser();
      authController.saveDataUser(userModel: userModel);
      authController.getDataUser();

      if (userModel.nik.isNotEmpty) {
        await appSettingController.initColor();
        await Get.forceAppUpdate();
        Get.offAllNamed(Routes.MAIN);
      }
    }
  }
}
