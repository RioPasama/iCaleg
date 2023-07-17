import 'package:icaleg/app/data/models/dapil_model.dart';
import 'package:icaleg/app/data/models/level_model.dart';
import 'package:icaleg/app/data/models/partai_model.dart';
import 'package:icaleg/app/data/services/main_service.dart';

class PemiluService {
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

  static Future<List<DapilModel>> getDapil() async {
    final result = await MainService().getAPI(url: 'partai/dapil');

    return List<DapilModel>.from(((result != null) ? result['data'] : [])
        .map((e) => DapilModel.fromJson(e)));
  }
}
