import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icaleg/app/controllers/auth_controller.dart';
import 'package:icaleg/app/controllers/text_input_validator_controller.dart';
import 'package:icaleg/app/data/models/user_model.dart';
import 'package:icaleg/app/data/services/user_service.dart';
import 'package:icaleg/infrastructure/navigation/routes.dart';

class LoginController extends GetxController {
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
        phone: '${nomorWhatsappTextEditingController.text}');

    if (code.isNotEmpty) {
      Get.toNamed(Routes.LOGIN_VERIFICATION,
          arguments: '${nomorWhatsappTextEditingController.text}');
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
        Get.offAllNamed(Routes.MAIN);
      }
    }
  }
}
