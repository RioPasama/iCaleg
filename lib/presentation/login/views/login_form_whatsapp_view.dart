import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/app/views/views/utils_view.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';
import 'package:icaleg/presentation/login/controllers/login.controller.dart';

class LoginFormWhatsappView extends GetView {
  LoginFormWhatsappView({Key? key}) : super(key: key);

  @override
  final LoginController controller = Get.put(LoginController());

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selamat Datang!',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 6),
          const Text('Silahkan masuk terlebih dahulu'),
          const SizedBox(height: 28),
          Form(
            key: controller.formKey,
            child: Column(
              children: [
                textFromFiled(
                  controller: controller.nomorWhatsappTextEditingController,
                  labelText: 'Isi nomor Whatsapp',
                  keyboardType: TextInputType.datetime,
                  prefixIcon: Container(
                      width: 24,
                      decoration: const BoxDecoration(
                          border:
                              Border(right: BorderSide(color: Colors.grey))),
                      alignment: Alignment.center,
                      child: const Text('+62')),
                  validator: (val) => controller.textInputValidatorController
                      .validatorNumberPhone(val),
                ),
                const SizedBox(height: 20),
                SizedBox(
                    width: Get.width,
                    child: ElevatedButton(
                        onPressed: () => controller.onTapLoginWhatsapp(),
                        child: const Text('Kirim OTP'))),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                      onPressed: () => controller.loginByWhatsapp.toggle(),
                      child: const Text('Login by Aplikasi iCaleg')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
