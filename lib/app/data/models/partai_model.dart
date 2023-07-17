class PartaiModel {
  final String id;
  final String name;
  final String logo;

  PartaiModel({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory PartaiModel.fromJson(Map<String, dynamic> json) => PartaiModel(
        id: json['id'],
        name: json['name'],
        logo: json['logo'],
      );
}
