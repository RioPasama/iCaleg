import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/app/views/views/app_bar_view.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';
import 'package:icaleg/presentation/forget_password/views/forget_password_change_password_view.dart';
import 'package:icaleg/presentation/forget_password/views/forget_password_identivication_view.dart';

import 'controllers/forget_password.controller.dart';

class ForgetPasswordScreen extends GetView<ForgetPasswordController> {
  const ForgetPasswordScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ForgetPasswordController());
    return Scaffold(
        appBar: appBarDefault(title: 'LUPA PASSWORD'),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: marginHorizontal),
          child: Obx(() => (controller.tag.value == 0)
              ? ForgetPasswordIdentivicationView()
              : ForgetPasswordChangePasswordView()),
        ));
  }
}
