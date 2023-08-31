import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';
import 'package:icaleg/presentation/statistics/views/statistics_dpt_view.dart';
import 'package:icaleg/presentation/statistics/views/statistics_support_view.dart';

import 'controllers/statistics.controller.dart';

class StatisticsScreen extends GetView<StatisticsController> {
  const StatisticsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              toolbarHeight: 0,
              elevation: 0,
              bottom: TabBar(
                labelColor: colorTextPrimary,
                unselectedLabelColor: colorTextGray,
                indicatorColor: colorPrimary,
                tabs: const [
                  Tab(text: 'DUKUNGAN'),
                  Tab(text: 'POTENSI DPT'),
                ],
              )),
          body: TabBarView(
            children: [StatisticsSupportView(), StatisticsDptView()],
          )),
    );
  }
}
