import 'package:icaleg/app/data/models/potensi_dpt_model.dart';
import 'package:icaleg/app/data/services/main_service.dart';

class StatisticsService {
  static Future<PotensiDptModel> getPotensiDPT() async {
    final result = await MainService().getAPI(url: 'statistik/potensi/get');

    return PotensiDptModel.fromJson(result['data']);
  }
}
