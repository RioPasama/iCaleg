import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/app/views/views/utils_view.dart';
import 'package:icaleg/gen/assets.gen.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';
import 'package:icaleg/presentation/forget_password/controllers/forget_password.controller.dart';
import 'package:ionicons/ionicons.dart';

class ForgetPasswordChangePasswordView extends GetView {
  ForgetPasswordChangePasswordView({Key? key}) : super(key: key);

  @override
  final ForgetPasswordController controller =
      Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 1),
        Image.asset(
          Assets.images.logoIcaleg.path,
          scale: 28,
        ),
        const Spacer(flex: 2),
        Text(
          'Jangan kawatir saat Anda lupa kata sandi Anda, jangan khawatir, kami di sini untuk membantu Anda mengakses akun Anda kembali',
          style: TextStyle(
              color: colorPrimary, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const Spacer(flex: 1),
        Obx(
          () => textFromFiled(
            controller: controller.passwordTextEditingController,
            textInputAction: TextInputAction.go,
            keyboardType: TextInputType.emailAddress,
            obscureText: !controller.showPassowrd.value,
            labelText: 'Password',
            prefixIcon: Icon(
              Ionicons.key_outline,
              color: Colors.grey.shade600,
            ),
            suffixIcon: IconButton(
              onPressed: () => controller.showPassowrd.toggle(),
              icon: (controller.showPassowrd.value)
                  ? Icon(Ionicons.eye_outline, color: Colors.grey.shade600)
                  : Icon(Ionicons.eye_off_outline, color: Colors.grey.shade600),
            ),
            validator: (val) =>
                controller.textInputValidatorController.validatorPassword(val),
          ),
        ),
        const Spacer(flex: 4),
        SizedBox(
            width: Get.width,
            child: ElevatedButton(
                onPressed: () => controller.onTapNewPassword(),
                child: const Text('Ubah Password'))),
        const Spacer(flex: 1),
      ],
    );
  }
}
