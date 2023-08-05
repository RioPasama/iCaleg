import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/app/views/views/app_bar_view.dart';
import 'package:icaleg/presentation/support_input/views/support_input_cam_view.dart';
import 'package:icaleg/presentation/support_input/views/support_input_form_view.dart';

import 'controllers/support_input.controller.dart';

class SupportInputScreen extends GetView<SupportInputController> {
  const SupportInputScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(SupportInputController());
    return Scaffold(
      appBar: appBarDefault(title: 'FORMULIR TAMBAH PENDUKUNG'),
      body: Obx(() => (controller.isOpenCam.value)
          ? SupportInputCamView()
          : SupportInputFormView()),
    );
  }
}
