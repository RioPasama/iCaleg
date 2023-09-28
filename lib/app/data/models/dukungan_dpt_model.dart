class DukunganDptModel {
  final String namaWilayah;
  final int jumlahKecamatan;
  final int jumlahDesa;
  final int jumlahTps;
  final Dpt dpt;

  DukunganDptModel({
    required this.namaWilayah,
    required this.jumlahKecamatan,
    required this.jumlahDesa,
    required this.jumlahTps,
    required this.dpt,
  });

  factory DukunganDptModel.fromJson(Map<String, dynamic> json) =>
      DukunganDptModel(
        namaWilayah: json['nama_wilayah'],
        jumlahKecamatan: _parseIntValue(json['jumlah_kecamatan']),
        jumlahDesa: _parseIntValue(json['jumlah_desa']),
        jumlahTps: _parseIntValue(json['jumlah_tps']),
        dpt: Dpt.fromJson(json['dpt']),
      );

  Map<String, dynamic> toJson() => {
        "nama_wilayah": namaWilayah,
        "jumlah_kecamatan": jumlahKecamatan,
        "jumlah_desa": jumlahDesa,
        "jumlah_tps": jumlahTps,
        "dpt": dpt.toJson(),
      };

  static int _parseIntValue(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      // Hapus titik (.) jika ada dan konversi ke integer
      return int.tryParse(value.replaceAll('.', '')) ?? 0;
    } else {
      return 0; // Nilai default jika tidak dapat di-parse
    }
  }
}

class Dpt {
  final int dptLaki;
  final int dptPerempuan;
  final int totalDpt;
  final double presentasePerempuan;
  final double presentaseLaki;

  Dpt({
    required this.dptLaki,
    required this.dptPerempuan,
    required this.totalDpt,
    required this.presentasePerempuan,
    required this.presentaseLaki,
  });

  factory Dpt.fromJson(Map<String, dynamic> json) => Dpt(
        dptLaki: _parseIntValue(json['dpt_laki']),
        dptPerempuan: _parseIntValue(json['dpt_perempuan']),
        presentasePerempuan: json['presentase_perempuan'].toDouble(),
        presentaseLaki: json['presentase_laki'].toDouble(),
        totalDpt: _parseIntValue(json['total_dpt']),
      );

  Map<String, dynamic> toJson() => {
        'dpt_laki': dptLaki,
        'dpt_perempuan': dptPerempuan,
        'total_dpt': totalDpt,
        'presentase_perempuan': presentasePerempuan,
        'presentase_laki': presentaseLaki,
      };

  static int _parseIntValue(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      // Hapus titik (.) jika ada dan konversi ke integer
      return int.tryParse(value.replaceAll('.', '')) ?? 0;
    } else {
      return 0; // Nilai default jika tidak dapat di-parse
    }
  }
}
