import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:graphic/graphic.dart';
import 'package:icaleg/app/data/models/dukungan_data_interval_model.dart';
import 'package:icaleg/app/views/views/chart_doughnut_view.dart';
import 'package:icaleg/app/views/views/loading_view.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';
import 'package:icaleg/presentation/statistics/controllers/statistics.controller.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class StatisticsSupportView extends GetView {
  StatisticsSupportView({Key? key}) : super(key: key);

  @override
  final StatisticsController controller = Get.put(StatisticsController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (controller.dukunganDptModel.value?.namaWilayah == null)
          ? loadingDefault()
          : ListView(children: [
              _banner(),
              _grafigChart(
                  data: controller.dukunganDataIntervalUsia,
                  labelPrimary: 'Demografi Usia',
                  labelKey: 'Usia',
                  labelValue: 'Banyak'),
              _grafigChart(
                  data: controller.dukunganDataIntervalAgama,
                  labelPrimary: 'Demografi Agama',
                  labelKey: 'Agama',
                  labelValue: 'Banyak'),
              _grafigChart(
                  data: controller.dukunganDataIntervalPekerjaan,
                  labelPrimary: 'Demografi Pekerjaan',
                  labelKey: 'Pekerjaan',
                  labelValue: 'Banyak'),
              const SizedBox(height: 20)
            ]),
    );
  }

  Widget _grafigChart({
    required RxList<DukunganDataIntervalModel> data,
    required String labelPrimary,
    required String labelKey,
    required String labelValue,
  }) {
    return (data.isNotEmpty)
        ? Padding(
            padding: EdgeInsets.only(
                left: marginHorizontal, right: marginHorizontal, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  labelPrimary,
                  style: TextStyle(
                      color: colorTextPrimary, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 200,
                  width: Get.width,
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: borderRadius,
                    boxShadow: [boxShadow],
                  ),
                  child: Chart(
                    data: data,
                    variables: {
                      labelKey: Variable(
                        accessor: (DukunganDataIntervalModel map) => map.key,
                      ),
                      labelValue: Variable(
                        accessor: (DukunganDataIntervalModel map) => map.value,
                      ),
                    },
                    marks: [
                      IntervalMark(
                        label: LabelEncode(
                            encoder: (tuple) =>
                                Label(tuple[labelValue].toString())),
                        elevation: ElevationEncode(value: 0, updaters: {
                          labelValue: {true: (_) => 5}
                        }),
                        color: ColorEncode(
                            value: Defaults.primaryColor,
                            updaters: {
                              labelValue: {
                                false: (color) => color.withAlpha(100)
                              }
                            }),
                      ),
                    ],
                    axes: [
                      Defaults.horizontalAxis,
                      Defaults.verticalAxis,
                    ],
                    selections: {labelValue: PointSelection(dim: Dim.x)},
                    tooltip: TooltipGuide(),
                    crosshair: CrosshairGuide(),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
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
            NumberFormat.decimalPattern('id')
                .format(controller.dukunganDptModel.value?.dpt.totalDpt ?? 0),
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
          chartDoughnut(),
        ],
      ),
    );
  }

  Container chartDoughnut() {
    return Container(
        width: 200,
        height: 100,
        margin: const EdgeInsets.only(top: 10),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                '${double.parse(controller.dukunganDptModel.value?.dpt.presentaseLaki.toString() ?? '0').toStringAsFixed(0)}%',
                style: TextStyle(
                  color: Colors.white,
                  shadows: [shadow],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                '${double.parse(controller.dukunganDptModel.value?.dpt.presentasePerempuan.toString() ?? '0').toStringAsFixed(0)}%',
                style: TextStyle(
                  color: Colors.white,
                  shadows: [shadow],
                ),
              ),
            ),
            SizedBox(
              width: 200,
              height: 100,
              child: Obx(
                () => CustomPaint(
                  painter: ChartDoughnutView(
                    data1Value: (controller
                                .dukunganDptModel.value?.dpt.presentaseLaki ??
                            0) /
                        100, // Data 1 value (between 0 and 1)
                    data2Value: (controller.dukunganDptModel.value?.dpt
                                .presentasePerempuan ??
                            100) /
                        100, // Data 2 value (between 0 and 1)
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(
                  Ionicons.man,
                  color: Colors.white,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(
                  Ionicons.woman,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ));
  }
}
