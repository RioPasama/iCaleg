import 'package:icaleg/app/data/models/app_model.dart';
import 'package:icaleg/app/data/services/main_service.dart';

class AppService {
  static Future<AppModel> getAppSetting() async {
    final result = await MainService().getAPI(url: 'partai/color');

    return AppModel.fromJson(result['data']);
  }
}
