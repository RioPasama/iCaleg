class AddressModel {
  final String id;
  final String? idParent;
  final String name;

  AddressModel({
    required this.id,
    required this.idParent,
    required this.name,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json['id'],
        idParent: json['id_parent'],
        name: json['name'],
      );
}
