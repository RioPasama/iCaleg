class DataKoordinatorModel {
  final String id;
  final String nik;
  final String dataKoordinatorModelAs;
  final String duty;
  final String phone;
  final String image;
  final String address;

  DataKoordinatorModel({
    required this.id,
    required this.nik,
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
        dataKoordinatorModelAs: json['as'],
        duty: json['duty'],
        phone: json['phone'],
        image: json['image'],
        address: json['address'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nik': nik,
        'as': dataKoordinatorModelAs,
        'duty': duty,
        'phone': phone,
        'image': image,
        'address': address,
      };
}
