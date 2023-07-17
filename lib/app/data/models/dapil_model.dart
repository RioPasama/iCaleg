class DapilModel {
  final String id;
  final String name;

  DapilModel({
    required this.id,
    required this.name,
  });

  factory DapilModel.fromJson(Map<String, dynamic> json) => DapilModel(
        id: json['id'],
        name: json['name'],
      );
}
