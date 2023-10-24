class AppModel {
  final String namaPartai;
  final String logoPartai;
  final String colorPrimary;
  final String colorGradient;
  final String colorSecondary;

  AppModel({
    required this.namaPartai,
    required this.logoPartai,
    required this.colorPrimary,
    required this.colorGradient,
    required this.colorSecondary,
  });

  factory AppModel.fromJson(Map<String, dynamic> json) => AppModel(
        namaPartai: json['nama_partai'],
        logoPartai: json['logo_partai'],
        colorPrimary: json['colorPrimary'],
        colorGradient: json['colorGradient'],
        colorSecondary: json['colorSecondary'],
      );

  Map<String, dynamic> toJson() => {
        'nama_partai': namaPartai,
        'logo_partai': logoPartai,
        'colorPrimary': colorPrimary,
        'colorGradient': colorGradient,
        'colorSecondary': colorSecondary,
      };
}
