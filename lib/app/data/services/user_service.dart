import 'dart:io';

import 'package:icaleg/app/data/services/main_service.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<void> postRegister({
    required String emial,
    required String password,
    required String name,
    required String nik,
    required String phone,
    required String fkProvince,
    required String fkRegency,
    required String fkDistrict,
    required String fkVillage,
    required String address,
    required String levelPemilihan,
    required String fkDapil,
    required String fkPartai,
    required File photoIdentity,
    required File photoKTP,
  }) async {
    await MainService().postMultipartRequestAPI(
      url: 'auth/register.php',
      fields: {
        'email': emial,
        'password': password,
        'name': name,
        'nik': nik,
        'phone': phone,
        'fk_province': fkProvince,
        'fk_regency': fkRegency,
        'fk_district': fkDistrict,
        'fk_village': fkVillage,
        'address': address,
        'level': levelPemilihan,
        'fk_dapil': fkDapil,
        'fk_partai': fkPartai
      },
      files: [
        await http.MultipartFile.fromPath('photo_identity', photoIdentity.path),
        await http.MultipartFile.fromPath('photo_ktp', photoKTP.path),
      ],
    );
  }
}
