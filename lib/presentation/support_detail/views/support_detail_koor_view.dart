import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/presentation/support_detail/controllers/support_detail.controller.dart';

class SupportDetailKoorView extends GetView {
  SupportDetailKoorView({Key? key}) : super(key: key);
  @override
  final SupportDetailController controller = Get.put(SupportDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SupportDetailKoorView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SupportDetailKoorView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
