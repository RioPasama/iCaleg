import 'package:meta/meta.dart';
import 'dart:convert';

class HomeModel {
  final String name;
  final String partai;
  final String level;
  final String daerahPemilihan;
  final Statistik statistik;

  HomeModel({
    required this.name,
    required this.partai,
    required this.level,
    required this.daerahPemilihan,
    required this.statistik,
  });

  factory HomeModel.fromRawJson(String str) =>
      HomeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        name: json["name"],
        partai: json["partai"],
        level: json["level"],
        daerahPemilihan: json["daerah_pemilihan"],
        statistik: Statistik.fromJson(json["statistik"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "partai": partai,
        "level": level,
        "daerah_pemilihan": daerahPemilihan,
        "statistik": statistik.toJson(),
      };
}

class Statistik {
  final int totalDukungan;
  final int totalRelawan;
  final int targetDukungan;
  final int alokasiKursi;
  final int tps;
  final int dptDapil;
  final List<Dukungan> dukungan;

  Statistik({
    required this.totalDukungan,
    required this.totalRelawan,
    required this.targetDukungan,
    required this.alokasiKursi,
    required this.tps,
    required this.dptDapil,
    required this.dukungan,
  });

  factory Statistik.fromRawJson(String str) =>
      Statistik.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Statistik.fromJson(Map<String, dynamic> json) => Statistik(
        totalDukungan: json["total_dukungan"],
        totalRelawan: json["total_relawan"],
        targetDukungan: json["target_dukungan"],
        alokasiKursi: json["alokasi_kursi"],
        tps: json["tps"],
        dptDapil: json["dpt_dapil"],
        dukungan: List<Dukungan>.from(
            json["dukungan"].map((x) => Dukungan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_dukungan": totalDukungan,
        "total_relawan": totalRelawan,
        "target_dukungan": targetDukungan,
        "alokasi_kursi": alokasiKursi,
        "tps": tps,
        "dpt_dapil": dptDapil,
        "dukungan": List<dynamic>.from(dukungan.map((x) => x.toJson())),
      };
}

class Dukungan {
  final String jumlahData;
  final DateTime tanggal;

  Dukungan({
    required this.jumlahData,
    required this.tanggal,
  });

  factory Dukungan.fromRawJson(String str) =>
      Dukungan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Dukungan.fromJson(Map<String, dynamic> json) => Dukungan(
        jumlahData: json["jumlah_data"],
        tanggal: DateTime.parse(json["tanggal"]),
      );

  Map<String, dynamic> toJson() => {
        "jumlah_data": jumlahData,
        "tanggal":
            "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
      };
}
