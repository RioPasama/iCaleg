import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icaleg/app/controllers/auth_controller.dart';
import 'package:icaleg/app/data/models/user_model.dart';
import 'package:icaleg/app/data/services/user_service.dart';
import 'package:icaleg/infrastructure/navigation/routes.dart';

class VerificationController extends GetxController {
  final AuthController authController = Get.put(AuthController());
  late TextEditingController otpTextEditingController;

  RxString code = ''.obs;
  String indentity = Get.arguments['indentity'] ?? '';
  String tag = Get.arguments['tag'] ?? '';
  RxInt setSeconds = 0.obs;
  RxString countdownText = '00:00:00'.obs;

  @override
  void onInit() {
    otpTextEditingController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    startCountdown(1800);
    super.onReady();
  }

  @override
  void onClose() {
    otpTextEditingController.dispose();
    super.onClose();
  }

  void startCountdown(int seconds) {
    setSeconds.value = seconds;
    update(); // Pertama kali update untuk menampilkan waktu awal

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (setSeconds.value > 0) {
        setSeconds.value--;
        updateCountdownText();
      } else {
        timer.cancel();
      }
    });
  }

  void updateCountdownText() {
    int hours = setSeconds.value ~/ 3600;
    int minutes = (setSeconds.value % 3600) ~/ 60;
    int seconds = setSeconds.value % 60;

    countdownText.value =
        '${_formatTime(hours)}:${_formatTime(minutes)}:${_formatTime(seconds)}';
  }

  String _formatTime(int time) {
    return time.toString().padLeft(2, '0');
  }

  Future<void> onTapSendOTP() async {
    switch (tag) {
      case '0':
        await onTapSendOTPRegistry();
        break;
      case '1':
        await onTapSendOTPLogin();
        break;
      case '2':
        await onTapSendOTPForgetPassword();
        break;
      default:
    }
  }

  Future<void> onTapSendOTPForgetPassword() async {
    if (otpTextEditingController.text.length < 6) {
      return;
    }
    await UserService.forgetPassword(
            noPhone: indentity, kode: otpTextEditingController.text)
        .then((value) => code.value = value.toString());
    if (code.value == '200') {
      Get.back();
    }
  }

  Future<void> onTapSendOTPLogin() async {
    if (otpTextEditingController.text.length < 6) {
      return;
    }
    await UserService.postLoginWhatsappVerifikasi(
            phone: indentity, otp: otpTextEditingController.text)
        .then((value) => code.value = value.toString());

    authController.saveToken(token: code.value);

    if (code.value == '200') {
      UserModel userModel = await UserService.getDataUser();
      authController.saveDataUser(userModel: userModel);
      authController.getDataUser();

      if (userModel.nik.isNotEmpty) {
        Get.offAllNamed(Routes.MAIN);
      }
    }
  }

  Future<void> onTapSendOTPRegistry() async {
    if (otpTextEditingController.text.length < 6) {
      return;
    }
    await UserService.postVerifikasi(
            otp: otpTextEditingController.text, indentity: indentity)
        .then((value) => code.value = value.toString());

    if (code.value == '200') {
      Future.delayed(const Duration(seconds: 4), () {
        Get.offAllNamed(Routes.LOGIN);
      });
    }
  }

  Future<void> onTapResendOtp() async {}
}
