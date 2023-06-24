import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/app/views/views/app_bar_view.dart';

import 'controllers/forget_password.controller.dart';

class ForgetPasswordScreen extends GetView<ForgetPasswordController> {
  const ForgetPasswordScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault(title: 'LUPA PASSWORD'),
      body: const Center(
        child: Text(
          'ForgetPasswordScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
