class LevelModel {
  final String id;
  final String status;
  final String name;

  LevelModel({
    required this.id,
    required this.status,
    required this.name,
  });

  factory LevelModel.fromJson(Map<String, dynamic> json) => LevelModel(
        id: json['id'],
        status: json['status'],
        name: json['name'],
      );
}
