class DetailKoordinatorModel {
  final String id;
  final String name;
  final String nik;
  final String gender;
  final String religion;
  final dynamic born;
  final dynamic birthday;
  final String phone;
  final String photo;
  final String ktp;
  final String address;
  final dynamic job;
  final dynamic statusKawin;
  final dynamic tps;
  final String nameVillage;
  final String nameDistrict;
  final String nameRegency;
  final String nameProvince;
  final String nameKoordinator;
  final int totalDukungan;
  final dynamic presentaseDukungan;
  final int totalTarget;
  final DateTime createAt;
  final String detailKoordinatorModelAs;

  DetailKoordinatorModel({
    required this.id,
    required this.name,
    required this.nik,
    required this.gender,
    required this.religion,
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
    required this.nameKoordinator,
    required this.totalDukungan,
    required this.presentaseDukungan,
    required this.totalTarget,
    required this.createAt,
    required this.detailKoordinatorModelAs,
  });

  factory DetailKoordinatorModel.fromJson(Map<String, dynamic> json) =>
      DetailKoordinatorModel(
        id: json['id'],
        name: json['name'],
        nik: json['nik'],
        gender: json['gender'],
        religion: json['religion'],
        born: json['born'],
        birthday: json['birthday'],
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
        nameKoordinator: json['name_koordinator'],
        totalDukungan: json['total_dukungan'],
        presentaseDukungan: json['presentase_dukungan'],
        totalTarget: json['total_target'],
        createAt: DateTime.parse(json['create_at']),
        detailKoordinatorModelAs: json['as'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'nik': nik,
        'gender': gender,
        'religion': religion,
        'born': born,
        'birthday': birthday,
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
        'name_koordinator': nameKoordinator,
        'total_dukungan': totalDukungan,
        'presentase_dukungan': presentaseDukungan,
        'total_target': totalTarget,
        'create_at': createAt.toIso8601String(),
        'as': detailKoordinatorModelAs,
      };
}
