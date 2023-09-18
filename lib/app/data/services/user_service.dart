import 'dart:io';

import 'package:icaleg/app/data/models/level_model.dart';
import 'package:icaleg/app/data/models/user_model.dart';
import 'package:icaleg/app/data/services/main_service.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<String> postLogin(
      {required String email, required String password}) async {
    Map<String, String> body = {'email': email, 'password': password};
    final result = await MainService().postAPI(url: 'auth/login', body: body);
    return result['data']['token'];
  }

  static Future<String> postLoginWhatsapp(
      {required String phone, String? otp}) async {
    Map<String, String> body = {'phone': phone};
    final result = await MainService().postAPI(url: 'auth/loginv2', body: body);
    return result['code'].toString();
  }

  static Future<String> postLoginWhatsappVerifikasi(
      {required String phone, required String otp}) async {
    Map<String, String> body = {'phone': phone, 'otp': otp};
    final result = await MainService().postAPI(url: 'auth/loginv2', body: body);
    return result['data']['token'];
  }

  static Future<int> postRegister({
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
    required int userStatus,
    required String fkDapil,
    required String fkPartai,
    required String religion,
    required String gender,
    required String job,
    required String born,
    required String tps,
    required String birthday,
    required String statusKawin,
    String referalCode = '',
    required File photoIdentity,
    required File photoKTP,
  }) async {
    final result = await MainService().postMultipartRequestAPI(
      url: 'auth/register.php',
      fields: {
        'email': emial,
        'password': password,
        'name': name,
        'nik': nik,
        'phone': phone,
        'religion': religion,
        'gender': gender,
        'fk_province': fkProvince,
        'fk_regency': fkRegency,
        'fk_district': fkDistrict,
        'fk_village': fkVillage,
        'address': address,
        'job': job,
        'born': born,
        'birthday': birthday,
        'status_kawin': statusKawin,
        'user_status': userStatus.toString(),
        'level': levelPemilihan,
        'referal_code': referalCode,
        'fk_dapil': fkDapil,
        'tps': tps,
        'fk_partai': fkPartai
      },
      files: [
        await http.MultipartFile.fromPath('photo_identity', photoIdentity.path),
        await http.MultipartFile.fromPath('photo_ktp', photoKTP.path),
      ],
    );

    return result['code'];
  }

  static Future<int> postVerifikasi(
      {required String otp, required String indentity}) async {
    // Map<String, String> body = {'kode': otp, 'email': indentity};
    Map<String, String> body = {'kode': otp, 'phone': indentity};
    final result =
        // await MainService().postAPI(url: 'auth/verification', body: body);
        await MainService().postAPI(url: 'auth/verificationv2', body: body);

    return result['code'];
  }

  static Future<UserModel> getDataUser() async {
    final result = await MainService().getAPI(url: 'auth/getMe');

    return UserModel.fromJson(result['data']);
  }

  static Future<List<LevelModel>> getRole() async {
    final result = await MainService().getAPI(url: 'partai/role');

    return List<LevelModel>.from(((result != null) ? result['data'] : [])
        .map((e) => LevelModel.fromJson(e)));
  }
}
