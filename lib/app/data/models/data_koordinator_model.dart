import 'package:meta/meta.dart';
import 'dart:convert';

class DataKoordinatorModel {
  final String id;
  final String nik;
  final String name;
  final String dataKoordinatorModelAs;
  final String duty;
  final String phone;
  final String jumlahPendukung;
  final String image;
  final String address;
  final dynamic kortep;
  final dynamic kordus;
  final dynamic kordes;
  final dynamic korcam;
  final String namaAtasan;

  DataKoordinatorModel({
    required this.id,
    required this.nik,
    required this.name,
    required this.dataKoordinatorModelAs,
    required this.duty,
    required this.phone,
    required this.jumlahPendukung,
    required this.image,
    required this.address,
    required this.kortep,
    required this.kordus,
    required this.kordes,
    required this.korcam,
    required this.namaAtasan,
  });

  factory DataKoordinatorModel.fromRawJson(String str) =>
      DataKoordinatorModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataKoordinatorModel.fromJson(Map<String, dynamic> json) =>
      DataKoordinatorModel(
        id: json["id"],
        nik: json["nik"],
        name: json["name"],
        dataKoordinatorModelAs: json["as"],
        duty: json["duty"],
        phone: json["phone"],
        jumlahPendukung: json["jumlah_pendukung"],
        image: json["image"],
        address: json["address"],
        kortep: json["kortep"],
        kordus: json["kordus"],
        kordes: json["kordes"],
        korcam: json["korcam"],
        namaAtasan: json["nama_atasan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nik": nik,
        "name": name,
        "as": dataKoordinatorModelAs,
        "duty": duty,
        "phone": phone,
        "jumlah_pendukung": jumlahPendukung,
        "image": image,
        "address": address,
        "kortep": kortep,
        "kordus": kordus,
        "kordes": kordes,
        "korcam": korcam,
        "nama_atasan": namaAtasan,
      };
}
