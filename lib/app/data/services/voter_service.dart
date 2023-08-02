import 'dart:io';

import 'package:icaleg/app/data/models/voter_dukungan_model.dart';
import 'package:icaleg/app/data/services/main_service.dart';
import 'package:http/http.dart' as http;

class VoterService {
  static Future<List<VoterDukunganModel>> getVoterDukungan() async {
    final result = await MainService().getAPI(url: 'vote/getVoter');

    return List<VoterDukunganModel>.from(
        ((result != null) ? result['data'] : [])
            .map((e) => VoterDukunganModel.fromJson(e)));
  }

  static Future<int> postVoterDukungan({
    required String nik,
    required String name,
    required String gender,
    required String phone,
    required String email,
    required String born,
    required String birthday,
    required String fkProvince,
    required String fkRegency,
    required String fkDistrict,
    required String fkVillage,
    required File photoIdentity,
    required File photoKTP,
  }) async {
    final result = await MainService().postMultipartRequestAPI(
      url: 'vote/addVoter',
      fields: {
        'email': email,
        'name': name,
        'nik': nik,
        'phone': phone,
        'gender': gender,
        'born': born,
        'fk_province': fkProvince,
        'fk_regency': fkRegency,
        'fk_district': fkDistrict,
        'fk_village': fkVillage,
        'birthday': birthday,
      },
      files: [
        await http.MultipartFile.fromPath('photo_identity', photoIdentity.path),
        await http.MultipartFile.fromPath('photo_ktp', photoKTP.path),
      ],
    );

    return result['code'];
  }
}
