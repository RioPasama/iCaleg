import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/statistics.controller.dart';

class StatisticsScreen extends GetView<StatisticsController> {
  const StatisticsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StatisticsScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StatisticsScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
