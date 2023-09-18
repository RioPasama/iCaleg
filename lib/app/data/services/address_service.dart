import 'package:icaleg/app/data/models/address_model.dart';
import 'package:icaleg/app/data/services/main_service.dart';

class AddressService {
  static Future<List<AddressModel>> getAddress(
      {required String urlPath, String? id}) async {
    Map<String, dynamic> body = {'id': id};

    final result =
        await MainService().getAPI(url: 'district/$urlPath', body: body);

    return List<AddressModel>.from(
        ((result['data'] != null) ? result['data'] : [])
            .map((e) => AddressModel.fromJson(e)));
  }
}
