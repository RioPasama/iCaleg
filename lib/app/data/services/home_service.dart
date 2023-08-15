import 'package:icaleg/app/data/models/home_model.dart';
import 'package:icaleg/app/data/services/main_service.dart';

class HomeService {
  static Future<HomeModel> getHome() async {
    final result = await MainService().getAPI(url: 'statistik/get');

    return HomeModel.fromJson(result['data']);
  }
}
