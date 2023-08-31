import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/presentation/statistics/controllers/statistics.controller.dart';

class StatisticsSupportView extends GetView {
  StatisticsSupportView({Key? key}) : super(key: key);
  @override
  final StatisticsController controller = Get.put(StatisticsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StatisticsSupportView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StatisticsSupportView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
