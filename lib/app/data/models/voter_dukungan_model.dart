class VoterDukunganModel {
  final String id;
  final String name;
  final String nik;
  final String gender;
  final String born;
  final DateTime birthday;
  final String phone;
  final String photo;
  final String ktp;
  final String address;
  final String job;
  final String statusKawin;
  final String tps;
  final String nameVillage;
  final String nameDistrict;
  final String nameRegency;
  final String nameProvince;
  final String nameSurveyer;
  final DateTime survey;

  VoterDukunganModel({
    required this.id,
    required this.name,
    required this.nik,
    required this.gender,
    required this.born,
    required this.birthday,
    required this.phone,
    required this.photo,
    required this.ktp,
    required this.address,
    required this.job,
    required this.statusKawin,
    required this.tps,
    required this.nameVillage,
    required this.nameDistrict,
    required this.nameRegency,
    required this.nameProvince,
    required this.nameSurveyer,
    required this.survey,
  });

  factory VoterDukunganModel.fromJson(Map<String, dynamic> json) =>
      VoterDukunganModel(
        id: json['id'],
        name: json['name'],
        nik: json['nik'],
        gender: json['gender'],
        born: json['born'],
        birthday: DateTime.parse(json['birthday']),
        phone: json['phone'],
        photo: json['photo'],
        ktp: json['ktp'],
        address: json['address'],
        job: json['job'],
        statusKawin: json['status_kawin'],
        tps: json['tps'],
        nameVillage: json['name_village'],
        nameDistrict: json['name_district'],
        nameRegency: json['name_regency'],
        nameProvince: json['name_province'],
        nameSurveyer: json['name_surveyer'],
        survey: DateTime.parse(json['survey']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'nik': nik,
        'gender': gender,
        'born': born,
        'birthday':
            '${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}',
        'phone': phone,
        'photo': photo,
        'ktp': ktp,
        'address': address,
        'job': job,
        'status_kawin': statusKawin,
        'tps': tps,
        'name_village': nameVillage,
        'name_district': nameDistrict,
        'name_regency': nameRegency,
        'name_province': nameProvince,
        'name_surveyer': nameSurveyer,
        'survey': survey.toIso8601String(),
      };
}
