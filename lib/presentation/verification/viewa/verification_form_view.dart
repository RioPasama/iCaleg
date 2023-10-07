import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';
import 'package:icaleg/presentation/verification/controllers/verification.controller.dart';
import 'package:pinput/pinput.dart';

class VerificationFormView extends GetView {
  VerificationFormView({Key? key}) : super(key: key);

  @override
  final VerificationController controller = Get.put(VerificationController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(27),
          boxShadow: [boxShadow]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Verifikasi OTP',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
              text: 'Kami telah mengirimkan OTP ke ',
              style: TextStyle(color: colorTextGray),
            ),
            TextSpan(
                text: controller.indentity,
                style: TextStyle(color: colorTextPrimary)),
            TextSpan(
              text: ' . Silahkan masukan kode yang telah kami kirimkan.',
              style: TextStyle(color: colorTextGray),
            ),
          ])),
          const SizedBox(height: 10),
          Pinput(controller: controller.otpTextEditingController, length: 6),
          const SizedBox(height: 10),
          SizedBox(
              width: Get.width,
              child: ElevatedButton(
                  onPressed: () => controller.onTapSendOTP(),
                  child: const Text('Validasi OTP'))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Get.width / 2 - (64),
                child: const Divider(thickness: 1),
              ),
              const Text(
                ' atau ',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                width: Get.width / 2 - (64),
                child: const Divider(thickness: 1),
              ),
            ],
          ),
          SizedBox(
              width: Get.width,
              child: Obx(
                () => ElevatedButton(
                    onPressed: (controller.setSeconds.value == 0)
                        ? () => controller.onTapResendOtp()
                        : null,
                    child: const Text('Kirim Ulang OTP')),
              )),
          Obx(
            () => RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Kirim Ulang Kode OTP Dalam ',
                    style: TextStyle(color: colorTextGray),
                  ),
                  TextSpan(
                    text: controller.countdownText.value,
                    style: TextStyle(color: colorTextPrimary),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
