class UserModel {
  final String name;
  final String nik;
  final String gender;
  final String religion;
  final String phone;
  final String referalCode;
  final String userStatus;
  final String ketStatus;
  final String image;
  final String partai;
  final District province;
  final District regency;
  final District district;
  final District village;
  final String labelDusun;
  final String labelTps;
  final DateTime expToken;
  final List<Device> device;

  UserModel({
    required this.name,
    required this.nik,
    required this.gender,
    required this.religion,
    required this.phone,
    required this.referalCode,
    required this.userStatus,
    required this.ketStatus,
    required this.image,
    required this.partai,
    required this.province,
    required this.regency,
    required this.district,
    required this.village,
    required this.labelDusun,
    required this.labelTps,
    required this.expToken,
    required this.device,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        nik: json['nik'],
        gender: json['gender'],
        religion: json['religion'],
        phone: json['phone'],
        referalCode: json['referal_code'],
        userStatus: json['user_status'],
        ketStatus: json['ket_status'],
        image: json['image'],
        partai: json['partai'],
        province: District.fromJson(json['province']),
        regency: District.fromJson(json['regency']),
        district: District.fromJson(json['district']),
        village: District.fromJson(json['village']),
        labelDusun: json['label_dusun'],
        labelTps: json['label_tps'],
        expToken: DateTime.parse(json['exp_token']),
        device:
            List<Device>.from(json['device'].map((x) => Device.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'nik': nik,
        'gender': gender,
        'religion': religion,
        'phone': phone,
        'referal_code': referalCode,
        'user_status': userStatus,
        'ket_status': ketStatus,
        'image': image,
        'partai': partai,
        'province': province.toJson(),
        'regency': regency.toJson(),
        'district': district.toJson(),
        'village': village.toJson(),
        'label_dusun': labelDusun,
        'label_tps': labelTps,
        'exp_token': expToken.toIso8601String(),
        'device': List<dynamic>.from(device.map((x) => x.toJson())),
      };
}

class Device {
  final String device;
  final DateTime loginAt;
  final DateTime expiredDate;

  Device({
    required this.device,
    required this.loginAt,
    required this.expiredDate,
  });

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        device: json['device'],
        loginAt: DateTime.parse(json['loginAt']),
        expiredDate: DateTime.parse(json['expiredDate']),
      );

  Map<String, dynamic> toJson() => {
        'device': device,
        'loginAt': loginAt.toIso8601String(),
        'expiredDate': expiredDate.toIso8601String(),
      };
}

class District {
  final String id;
  final String label;

  District({
    required this.id,
    required this.label,
  });

  factory District.fromJson(Map<String, dynamic> json) => District(
        id: json['id'],
        label: json['label'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
      };
}
