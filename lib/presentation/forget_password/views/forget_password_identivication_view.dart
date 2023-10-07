import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/app/views/views/utils_view.dart';
import 'package:icaleg/gen/assets.gen.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';
import 'package:icaleg/presentation/forget_password/controllers/forget_password.controller.dart';

class ForgetPasswordIdentivicationView extends GetView {
  ForgetPasswordIdentivicationView({Key? key}) : super(key: key);

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
        textFromFiled(
          controller: controller.nomorWhatsappTextEditingController,
          labelText: 'Isi nomor Whatsapp',
          keyboardType: TextInputType.datetime,
          prefixIcon: Container(
              width: 24,
              decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.grey))),
              alignment: Alignment.center,
              child: const Text('+62')),
        ),
        const Spacer(flex: 4),
        SizedBox(
            width: Get.width,
            child: ElevatedButton(
                onPressed: () => controller.onTapVerfikasi(),
                child: const Text('Verifikasi'))),
        const Spacer(flex: 1),
      ],
    );
  }
}
