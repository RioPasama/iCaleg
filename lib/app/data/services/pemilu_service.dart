import 'package:icaleg/app/data/models/Koorlap_tps_model.dart';
import 'package:icaleg/app/data/models/dapil_model.dart';
import 'package:icaleg/app/data/models/data_koordinator_model.dart';
import 'package:icaleg/app/data/models/detail_koordinator_model.dart';
import 'package:icaleg/app/data/models/level_model.dart';
import 'package:icaleg/app/data/models/partai_model.dart';
import 'package:icaleg/app/data/services/main_service.dart';

class PemiluService {
  static Future<List<LevelModel>> getJob() async {
    final result = await MainService().getAPI(url: 'user/job');

    return List<LevelModel>.from(((result != null) ? result['data'] : [])
        .map((e) => LevelModel.fromJson(e)));
  }

  static Future<List<LevelModel>> getReligion() async {
    final result = await MainService().getAPI(url: 'user/religion');

    return List<LevelModel>.from(((result != null) ? result['data'] : [])
        .map((e) => LevelModel.fromJson(e)));
  }

  static Future<List<LevelModel>> getLevel() async {
    final result = await MainService().getAPI(url: 'partai/level');

    return List<LevelModel>.from(((result != null) ? result['data'] : [])
        .map((e) => LevelModel.fromJson(e)));
  }

  static Future<List<PartaiModel>> getPartai() async {
    final result = await MainService().getAPI(url: 'partai/partai');

    return List<PartaiModel>.from(((result != null) ? result['data'] : [])
        .map((e) => PartaiModel.fromJson(e)));
  }

  static Future<List<DapilModel>> getDapil({required String status}) async {
    Map<String, String> body = {'status': status};

    final result = await MainService().getAPI(url: 'partai/dapil', body: body);

    return List<DapilModel>.from(((result != null) ? result['data'] : [])
        .map((e) => DapilModel.fromJson(e)));
  }

  static Future<List<KoorlapTpsModel>> getKoorlapTps(
      {required String tps, required String fkVillage}) async {
    Map<String, String> body = {'tps': tps, 'fk_village': fkVillage};

    final result =
        await MainService().getAPI(url: 'koordinator/getKorlap', body: body);

    return List<KoorlapTpsModel>.from(((result != null) ? result['data'] : [])
        .map((e) => KoorlapTpsModel.fromJson(e)));
  }

  // static Future<List<DataKoordinatorModel>> getDataKoorlap(
  //     {required String filter}) async {
  //   Map<String, String> body = {'filter': filter};
  //   final result =
  //       await MainService().getAPI(url: 'koordinator/table', body: body);

  //   return List<DataKoordinatorModel>.from(
  //       ((result['data']['list'] != null) ? result['data']['list'] : [])
  //           .map((e) => DataKoordinatorModel.fromJson(e)));
  // }
  static Future<List<DataKoordinatorModel>> getDataKoorlap(
      {required String filter, required String q, int page = 1}) async {
    Map<String, String> body = {
      'filter': filter,
      'q': q,
      'page': '$page',
    };
    final result =
        await MainService().getAPI(url: 'koordinator/table', body: body);

    final dataList = result['data']['list'];

    if (dataList != null && dataList is List) {
      return List<DataKoordinatorModel>.from(dataList.map(
          (e) => DataKoordinatorModel.fromJson(e as Map<String, dynamic>)));
    } else {
      return []; // Return an empty list when there's no data
    }
  }

  static Future<DetailKoordinatorModel> getDataKoorlapDetail(
      {required String id}) async {
    Map<String, String> body = {'id': id};
    final result =
        await MainService().getAPI(url: 'koordinator/detail', body: body);

    return DetailKoordinatorModel.fromJson(result['data']);
  }
}
