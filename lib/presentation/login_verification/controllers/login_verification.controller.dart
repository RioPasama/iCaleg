import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icaleg/app/controllers/auth_controller.dart';
import 'package:icaleg/app/data/models/user_model.dart';
import 'package:icaleg/app/data/services/user_service.dart';
import 'package:icaleg/infrastructure/navigation/routes.dart';

class LoginVerificationController extends GetxController {
  final AuthController authController = Get.put(AuthController());
  late TextEditingController otpTextEditingController;

  RxString code = ''.obs;
  String nomorWa = Get.arguments ?? '';
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
    if (otpTextEditingController.text.length < 6) {
      return;
    }
    code.value = await UserService.postLoginWhatsappVerifikasi(
        phone: nomorWa, otp: otpTextEditingController.text);

    authController.saveToken(token: code.value);

    if (code.isNotEmpty) {
      UserModel userModel = await UserService.getDataUser();
      authController.saveDataUser(userModel: userModel);
      authController.getDataUser();

      if (userModel.nik.isNotEmpty) {
        Get.offAllNamed(Routes.MAIN);
      }
    }
  }

  Future<void> onTapResendOtp() async {}
}
