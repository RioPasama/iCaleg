import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/app/views/views/app_bar_view.dart';
import 'package:icaleg/presentation/support_detail/views/support_detail_koor_view.dart';
import 'package:icaleg/presentation/support_detail/views/support_detail_pendukung_view.dart';

import 'controllers/support_detail.controller.dart';

class SupportDetailScreen extends GetView<SupportDetailController> {
  const SupportDetailScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(SupportDetailController());
    return Scaffold(
      appBar: appBarDefault(title: 'Detail'),
      body: (controller.isDukungan)
          ? SupportDetailPendukungView()
          : SupportDetailKoorView(),
    );
  }
}
