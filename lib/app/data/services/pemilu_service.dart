import 'package:icaleg/app/data/models/Koorlap_tps_model.dart';
import 'package:icaleg/app/data/models/dapil_model.dart';
import 'package:icaleg/app/data/models/data_koordinator_model.dart';
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

  static Future<List<DataKoordinatorModel>> getDataKoorlap() async {
    final result = await MainService().getAPI(url: 'koordinator/table');

    return List<DataKoordinatorModel>.from(
        ((result != null) ? result['data']['list'] : [])
            .map((e) => DataKoordinatorModel.fromJson(e)));
  }
}
