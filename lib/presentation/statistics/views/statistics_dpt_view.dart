import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:graphic/graphic.dart';
import 'package:icaleg/app/data/models/statistik_dapil_wilayah_model.dart';
import 'package:icaleg/app/views/views/chart_doughnut_view.dart';
import 'package:icaleg/app/views/views/loading_view.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';
import 'package:icaleg/presentation/statistics/controllers/statistics.controller.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class StatisticsDptView extends GetView {
  StatisticsDptView({Key? key}) : super(key: key);

  @override
  final StatisticsController controller = Get.put(StatisticsController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (controller.potensiDptModel.value?.namaWilayah == null)
          ? loadingDefault()
          : ListView(
              children: [
                _banner(),
                _date(),
                _koorValue(),
                // Container(
                //   margin: EdgeInsets.symmetric(
                //       horizontal: marginHorizontal, vertical: 20),
                //   padding: EdgeInsets.symmetric(
                //       horizontal: marginHorizontal, vertical: 8),
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: borderRadius,
                //       boxShadow: [boxShadow]),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         'Total Dapil',
                //         style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             color: colorTextPrimary),
                //       ),
                //       (controller.statistikDapilWilayahModel.isNotEmpty)
                //           ? ListView.builder(
                //               shrinkWrap: true,
                //               physics: const NeverScrollableScrollPhysics(),
                //               itemCount:
                //                   controller.statistikDapilWilayahModel.length,
                //               itemBuilder: (context, index) {
                //                 return Container(
                //                   decoration: BoxDecoration(
                //                       color: controller.utilsController
                //                           .getRandomColor()),
                //                   child: Text(controller
                //                       .statistikDapilWilayahModel[index]
                //                       .namaWilayah),
                //                 );
                //               },
                //             )
                //           : Center(
                //               child: Text(
                //               'Data Wilayah Tidak Ada',
                //               style: TextStyle(color: colorTextGray),
                //             )),
                //     ],
                //   ),
                // ),

                _grafigChart(
                    data: controller.statistikDapilWilayahModel,
                    labelPrimary: 'Total Dapil',
                    labelKey: 'Wilayah',
                    labelValue: 'Total DPT'),
              ],
            ),
    );
  }

  Container _koorValue() {
    return Container(
      height: 120,
      margin: const EdgeInsets.only(top: 20),
      child: Obx(
        () => ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          scrollDirection: Axis.horizontal,
          children: [
            cardValueKoor(
                title: 'JUMLAH KECAMATAN',
                value: NumberFormat.decimalPattern('id')
                    .format(controller.potensiDptModel.value?.jumlahKecamatan),
                color: Colors.blue),
            cardValueKoor(
                title: 'JUMLAH DESA',
                value: NumberFormat.decimalPattern('id')
                    .format(controller.potensiDptModel.value?.jumlahDesa),
                color: Colors.orangeAccent),
            cardValueKoor(
                title: 'JUMLAH TPS',
                value: NumberFormat.decimalPattern('id')
                    .format(controller.potensiDptModel.value?.jumlahTps),
                color: Colors.green),
          ],
        ),
      ),
    );
  }

  Container cardValueKoor(
      {required String title, required String value, required Color color}) {
    return Container(
      height: 120,
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
          color: color.withOpacity(0.4), borderRadius: borderRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 4),
          Text(
            value,
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: color),
          ),
          const Spacer(flex: 2),
          Text(
            title,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: color),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Center _date() {
    return Center(
        child: Text(
      'Data Pada ${controller.dateTimeNow.split(' ').first} ${controller.dateTimeNow.split(' ').last.split('.').first.split(':').first}:${controller.dateTimeNow.split(' ').last.split('.').first.split(':')[1]}',
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
            NumberFormat.decimalPattern('id')
                .format(controller.potensiDptModel.value?.dpt.totalDpt ?? 0),
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
                '${double.parse(controller.potensiDptModel.value?.dpt.presentaseLaki.toString() ?? '0').toStringAsFixed(0)}%',
                style: TextStyle(
                  color: Colors.white,
                  shadows: [shadow],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                '${double.parse(controller.potensiDptModel.value?.dpt.presentasePerempuan.toString() ?? '0').toStringAsFixed(0)}%',
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
                    data1Value:
                        (controller.potensiDptModel.value?.dpt.presentaseLaki ??
                                0) /
                            100, // Data 1 value (between 0 and 1)
                    data2Value: (controller.potensiDptModel.value?.dpt
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

  Widget _grafigChart({
    required RxList<StatistikDapilWilayahModel> data,
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
                  height: 300,
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
                        accessor: (StatistikDapilWilayahModel map) =>
                            map.namaWilayah,
                      ),
                      labelValue: Variable(
                        accessor: (StatistikDapilWilayahModel map) =>
                            map.totalDpt,
                      ),
                    },
                    marks: [
                      IntervalMark(
                        label: LabelEncode(
                          encoder: (tuple) => Label(
                            NumberFormat.decimalPattern('id')
                                .format(tuple[labelValue]),
                            // LabelStyle(
                            //   textStyle: TextStyle(
                            //     fontWeight: FontWeight.bold,
                            //     fontSize: 18,
                            //     color: Colors.black,
                            //   ),
                            // ),
                          ),
                        ),
                        // tag: (tuple) => tuple[labelKey].toString(),
                        // elevation: ElevationEncode(value: 0, updaters: {
                        //   labelValue: {true: (_) => 5}
                        // }),
                        // color: ColorEncode(
                        //     value: Defaults.primaryColor,
                        //     updaters: {
                        //       labelValue: {
                        //         false: (color) => color.withAlpha(100)
                        //       }
                        //     }),
                      ),
                    ],
                    axes: [
                      // Defaults.horizontalAxis..tickLine = TickLine(),
                      Defaults.horizontalAxis,
                      Defaults.verticalAxis,
                    ],
                    // selections: {
                    //   // labelValue: PointSelection(dim: Dim.y),
                    // },
                    coord: RectCoord(
                      horizontalRangeUpdater: Defaults.horizontalRangeEvent,
                    ),
                    // tooltip: TooltipGuide(),
                    // crosshair: CrosshairGuide(),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
