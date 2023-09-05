class DataKoordinatorModel {
  final String id;
  final String nik;
  final String name;
  final String dataKoordinatorModelAs;
  final String duty;
  final String phone;
  final String image;
  final String address;

  DataKoordinatorModel({
    required this.id,
    required this.nik,
    required this.name,
    required this.dataKoordinatorModelAs,
    required this.duty,
    required this.phone,
    required this.image,
    required this.address,
  });

  factory DataKoordinatorModel.fromJson(Map<String, dynamic> json) =>
      DataKoordinatorModel(
        id: json['id'],
        nik: json['nik'],
        name: json['name'],
        dataKoordinatorModelAs: json['as'],
        duty: json['duty'],
        phone: json['phone'],
        image: json['image'],
        address: json['address'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nik': nik,
        'name': name,
        'as': dataKoordinatorModelAs,
        'duty': duty,
        'phone': phone,
        'image': image,
        'address': address,
      };
}
