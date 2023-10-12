class PotensiDptModel {
  final String namaWilayah;
  final int jumlahKecamatan;
  final int jumlahDesa;
  final int jumlahTps;
  final Dpt dpt;

  PotensiDptModel({
    required this.namaWilayah,
    required this.jumlahKecamatan,
    required this.jumlahDesa,
    required this.jumlahTps,
    required this.dpt,
  });

  factory PotensiDptModel.fromJson(Map<String, dynamic> json) =>
      PotensiDptModel(
        namaWilayah: json['nama_wilayah'],
        jumlahKecamatan: json['jumlah_kecamatan'],
        jumlahDesa: json['jumlah_desa'],
        jumlahTps: json['jumlah_tps'],
        dpt: Dpt.fromJson(json['dpt']),
      );

  Map<String, dynamic> toJson() => {
        'nama_wilayah': namaWilayah,
        'jumlah_kecamatan': jumlahKecamatan,
        'jumlah_desa': jumlahDesa,
        'jumlah_tps': jumlahTps,
        'dpt': dpt.toJson(),
      };
}

class Dpt {
  final int dptLaki;
  final int dptPerempuan;
  final double presentasePerempuan;
  final double presentaseLaki;
  final int totalDpt;

  Dpt({
    required this.dptLaki,
    required this.dptPerempuan,
    required this.presentasePerempuan,
    required this.presentaseLaki,
    required this.totalDpt,
  });

  factory Dpt.fromJson(Map<String, dynamic> json) => Dpt(
        dptLaki: json['dpt_laki'],
        dptPerempuan: json['dpt_perempuan'],
        presentasePerempuan:
            double.tryParse(json['presentase_perempuan'].toString()) ?? 0,
        presentaseLaki:
            double.tryParse(json['presentase_laki'].toString()) ?? 0,
        totalDpt: json['total_dpt'],
      );

  Map<String, dynamic> toJson() => {
        'dpt_laki': dptLaki,
        'dpt_perempuan': dptPerempuan,
        'presentase_perempuan': presentasePerempuan,
        'presentase_laki': presentaseLaki,
        'total_dpt': totalDpt,
      };
}
