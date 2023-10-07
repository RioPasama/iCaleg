import 'package:icaleg/app/data/models/dukungan_data_interval_model.dart';
import 'package:icaleg/app/data/models/dukungan_dpt_model.dart';
import 'package:icaleg/app/data/models/dukungan_map_model.dart';
import 'package:icaleg/app/data/models/potensi_dpt_model.dart';
import 'package:icaleg/app/data/models/statistik_dapil_wilayah_model.dart';
import 'package:icaleg/app/data/services/main_service.dart';

class StatisticsService {
  static Future<List<DukunganMapModel>> getDukunganMap() async {
    final result = await MainService().getAPI(url: 'statistik/dukungan/maps');

    return List<DukunganMapModel>.from(
        ((result['data'] != null) ? result['data'] : [])
            .map((e) => DukunganMapModel.fromJson(e)));
  }

  static Future<PotensiDptModel> getPotensiDPT() async {
    final result = await MainService().getAPI(url: 'statistik/potensi/get');

    return PotensiDptModel.fromJson(result['data']);
  }

  static Future<DukunganDptModel> getDukunganiDPT() async {
    final result = await MainService().getAPI(url: 'statistik/dukungan/get');

    return DukunganDptModel.fromJson(result['data']);
  }

  static Future<List<StatistikDapilWilayahModel>> getDapilPerWilayah() async {
    Map<String, String> body = {'tag': 'wilayah'};
    final result =
        await MainService().getAPI(url: 'statistik/potensi/get', body: body);

    return List<StatistikDapilWilayahModel>.from(
        ((result['data'] != null) ? result['data'] : [])
            .map((e) => StatistikDapilWilayahModel.fromJson(e)));
  }

  static Future<List<DukunganDataIntervalModel>> getDataInterval(
      {required String tag}) async {
    Map<String, String> body = {'tag': tag};
    final result =
        await MainService().getAPI(url: 'statistik/dukungan/get', body: body);

    return List<DukunganDataIntervalModel>.from(
        ((result['data'] != null) ? result['data'] : [])
            .map((e) => DukunganDataIntervalModel.fromJson(e)));
  }
}
