class StatistikDapilWilayahModel {
  final String namaWilayah;
  final int dptLaki;
  final int dptPerempuan;
  final int jumlahTps;
  final int jumlahDesa;
  final int jumlahKecamatan;
  final int totalDpt;

  StatistikDapilWilayahModel({
    required this.namaWilayah,
    required this.dptLaki,
    required this.dptPerempuan,
    required this.jumlahTps,
    required this.jumlahDesa,
    required this.jumlahKecamatan,
    required this.totalDpt,
  });

  factory StatistikDapilWilayahModel.fromJson(Map<String, dynamic> json) =>
      StatistikDapilWilayahModel(
        namaWilayah: json['nama_wilayah'],
        dptLaki: json['dpt_laki'],
        dptPerempuan: json['dpt_perempuan'],
        jumlahTps: json['jumlah_tps'],
        jumlahDesa: json['jumlah_desa'],
        jumlahKecamatan: json['jumlah_kecamatan'],
        totalDpt: json['total_dpt'],
      );

  Map<String, dynamic> toJson() => {
        'nama_wilayah': namaWilayah,
        'dpt_laki': dptLaki,
        'dpt_perempuan': dptPerempuan,
        'jumlah_tps': jumlahTps,
        'jumlah_desa': jumlahDesa,
        'jumlah_kecamatan': jumlahKecamatan,
        'total_dpt': totalDpt,
      };
}
