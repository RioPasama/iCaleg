import 'dart:io';

import 'package:icaleg/app/data/models/voter_dukungan_model.dart';
import 'package:icaleg/app/data/services/main_service.dart';
import 'package:http/http.dart' as http;

class VoterService {
  static Future<List<VoterDukunganModel>> getVoterDukungan(
      {required String q}) async {
    final result =
        await MainService().getAPI(url: 'vote/getVoter', body: {'q': q});

    return List<VoterDukunganModel>.from(
        ((result != null) ? result['data']['list'] : [])
            .map((e) => VoterDukunganModel.fromJson(e)));
  }

  static Future<VoterDukunganModel> getVoterDukunganDetail(
      {required String id}) async {
    final result =
        await MainService().getAPI(url: 'vote/getVoter', body: {'id': id});

    return VoterDukunganModel.fromJson(result['data']);
  }

  static Future<int> postVoterDukungan({
    required String nik,
    required String name,
    required String religion,
    required String gender,
    required String phone,
    required String job,
    required String email,
    required String born,
    required String statusKawin,
    required String birthday,
    required String fkProvince,
    required String fkRegency,
    required String fkDistrict,
    required String fkVillage,
    required String fkKortep,
    required String tps,
    required String address,
    required double lat,
    required double lng,
    required File photoIdentity,
    required File photoKTP,
  }) async {
    final result = await MainService().postMultipartRequestAPI(
      url: 'vote/addVoter',
      fields: {
        'email': email,
        'name': name,
        'nik': nik,
        'gender': gender,
        'born': born,
        'birthday': birthday,
        'fk_province': fkProvince,
        'fk_regency': fkRegency,
        'fk_district': fkDistrict,
        'tps': tps,
        'address': address,
        'phone': phone,
        'fk_village': fkVillage,
        'fk_kortep': fkKortep,
        'job': job,
        'religion': religion,
        'status_kawin': statusKawin,
        'lat': lat,
        'lng': lng,
      },
      files: [
        await http.MultipartFile.fromPath('photo_identity', photoIdentity.path),
        await http.MultipartFile.fromPath('photo_ktp', photoKTP.path),
      ],
    );

    return result['code'];
  }
}
