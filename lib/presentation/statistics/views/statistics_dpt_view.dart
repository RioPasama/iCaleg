import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/app/views/views/chart_doughnut_view.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';
import 'package:icaleg/presentation/statistics/controllers/statistics.controller.dart';

class StatisticsDptView extends GetView {
  StatisticsDptView({Key? key}) : super(key: key);

  @override
  final StatisticsController controller = Get.put(StatisticsController());

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _banner(),
        _date(),
      ],
    );
  }

  Center _date() {
    return Center(
        child: Text(
      'Data Pada 06/08/2024',
      style: TextStyle(color: colorTextGray, fontStyle: FontStyle.italic),
    ));
  }

  Container _banner() {
    return Container(
      margin: EdgeInsets.fromLTRB(marginHorizontal, 28, marginHorizontal, 10),
      padding: const EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
        color: colorPrimary.withOpacity(0.6),
        borderRadius: borderRadius,
      ),
      child: Column(
        children: [
          Text(
            '12.314',
            style: TextStyle(
                color: Colors.white,
                fontSize: 38,
                shadows: [shadow],
                fontWeight: FontWeight.bold),
          ),
          Text(
            'TOTAL DPT',
            style: TextStyle(
              color: Colors.white,
              shadows: [shadow],
            ),
          ),
          SizedBox(
              width: 200,
              height: 200,
              child: CustomPaint(
                painter: ChartDoughnutView(
                  data1Value: 71.03 / 100, // Data 1 value (between 0 and 1)
                  data2Value: 28.97 / 100, // Data 2 value (between 0 and 1)
                ),
              )),
        ],
      ),
    );
  }
}
