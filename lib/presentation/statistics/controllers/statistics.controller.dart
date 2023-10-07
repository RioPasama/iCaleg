import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:get/get.dart';
import 'package:icaleg/app/controllers/utils_controller.dart';
import 'package:icaleg/app/data/models/dukungan_data_interval_model.dart';
import 'package:icaleg/app/data/models/dukungan_dpt_model.dart';
import 'package:icaleg/app/data/models/dukungan_map_model.dart';
import 'package:icaleg/app/data/models/potensi_dpt_model.dart';
import 'package:icaleg/app/data/models/statistik_dapil_wilayah_model.dart';
import 'package:icaleg/app/data/services/statistics_service.dart';

class StatisticsController extends GetxController {
  UtilsController utilsController = Get.put(UtilsController());
  Rxn<PotensiDptModel> potensiDptModel = Rxn<PotensiDptModel>();
  RxList<StatistikDapilWilayahModel> statistikDapilWilayahModel =
      RxList<StatistikDapilWilayahModel>();
  Rxn<DukunganDptModel> dukunganDptModel = Rxn<DukunganDptModel>();
  RxList<DukunganDataIntervalModel> dukunganDataIntervalUsia =
      RxList<DukunganDataIntervalModel>();
  RxList<DukunganDataIntervalModel> dukunganDataIntervalAgama =
      RxList<DukunganDataIntervalModel>();
  RxList<DukunganDataIntervalModel> dukunganDataIntervalPekerjaan =
      RxList<DukunganDataIntervalModel>();
  RxList<DukunganMapModel> dukunganMapModel = RxList<DukunganMapModel>();

  final mapKey = GlobalKey<FlutterMapState>();

  String dateTimeNow = DateTime.now().toString();

  @override
  void onInit() {
    getDataDukunganDpt();
    getDataPotensiDpt();
    getDataDapilPerWilayaht();
    getDukunganMap();
    super.onInit();
  }

  @override
  void onReady() async {
    dukunganDataIntervalUsia.value = await getDataDukunganInterval(tag: 'usia');
    // dukunganDataIntervalUsia.value = <DukunganDataIntervalModel>[
    //   DukunganDataIntervalModel(key: '20', value: 100),
    //   DukunganDataIntervalModel(key: '21-30', value: 780),
    // ];
    dukunganDataIntervalAgama.value =
        await getDataDukunganInterval(tag: 'agama');
    dukunganDataIntervalPekerjaan.value =
        await getDataDukunganInterval(tag: 'pekerjaan');
    super.onReady();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }

  Future<List<DukunganDataIntervalModel>> getDataDukunganInterval(
      {required String tag}) async {
    List<DukunganDataIntervalModel> result =
        await StatisticsService.getDataInterval(tag: tag);
    return result;
  }

  Future<void> getDataDukunganDpt() async {
    dukunganDptModel.value = await StatisticsService.getDukunganiDPT();
  }

  Future<void> getDataPotensiDpt() async {
    potensiDptModel.value = await StatisticsService.getPotensiDPT();
  }

  Future<void> getDataDapilPerWilayaht() async {
    statistikDapilWilayahModel.value =
        await StatisticsService.getDapilPerWilayah();
  }

  Future<void> getDukunganMap() async {
    dukunganMapModel.value = await StatisticsService.getDukunganMap();
  }
}
