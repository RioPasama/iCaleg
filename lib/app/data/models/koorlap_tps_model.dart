class KoorlapTpsModel {
  final String id;
  final String name;
  final String photoKtp;

  KoorlapTpsModel({
    required this.id,
    required this.name,
    required this.photoKtp,
  });

  factory KoorlapTpsModel.fromJson(Map<String, dynamic> json) =>
      KoorlapTpsModel(
        id: json['id'],
        name: json['name'],
        photoKtp: json['photo_ktp'],
      );
}
