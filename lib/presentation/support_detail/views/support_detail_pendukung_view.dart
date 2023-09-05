import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/app/data/services/voter_service.dart';
import 'package:icaleg/app/views/views/loading_view.dart';
import 'package:icaleg/presentation/support_detail/controllers/support_detail.controller.dart';

class SupportDetailPendukungView extends GetView {
  SupportDetailPendukungView({Key? key}) : super(key: key);

  @override
  final SupportDetailController controller = Get.put(SupportDetailController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: VoterService.getVoterDukunganDetail(id: controller.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text('data');
        } else {
          return Center(child: loadingDefault());
        }
      },
    );
  }
}
