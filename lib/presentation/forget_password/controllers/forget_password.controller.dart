import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icaleg/app/controllers/text_input_validator_controller.dart';
import 'package:icaleg/app/data/services/user_service.dart';
import 'package:icaleg/app/views/views/dialog_view.dart';
import 'package:icaleg/infrastructure/navigation/routes.dart';

class ForgetPasswordController extends GetxController {
  final TextInputValidatorController textInputValidatorController =
      Get.put(TextInputValidatorController());

  late TextEditingController nomorWhatsappTextEditingController;
  late TextEditingController passwordTextEditingController;
  late TextEditingController confirmpasswordTextEditingController;

//tag 0 = idenifikasi uset, 1 = buat password baru
  RxInt tag = 0.obs;
  RxBool showPassowrd = false.obs;

  @override
  void onInit() {
    nomorWhatsappTextEditingController = TextEditingController();
    confirmpasswordTextEditingController = TextEditingController();
    passwordTextEditingController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    //
    super.onReady();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }

  Future<void> onTapVerfikasi() async {
    late String code;

    await UserService.forgetPassword(
            noPhone: nomorWhatsappTextEditingController.text)
        .then((value) => code = value.toString());

    Map<String, String> sendArguments = {
      'tag': '2',
      'indentity': '+62${nomorWhatsappTextEditingController.text}',
    };

    if (code == '200') {
      Get.toNamed(Routes.VERIFICATION, arguments: sendArguments);
      tag.value = 1;
    }
  }

  Future<void> onTapNewPassword() async {
    late String code;

    await UserService.forgetPassword(
            noPhone: nomorWhatsappTextEditingController.text,
            password: passwordTextEditingController.text)
        .then((value) => code = value.toString());

    if (code == '200') {
      Get.dialog(
          dialogView(
            title: 'Password Baru',
            content:
                'Selamat password anda berhasil diganti silahkan untuk login ulang',
            onTapOke: () => Get.offAll(Routes.LOGIN),
          ),
          barrierDismissible: false);
    }
  }
}
