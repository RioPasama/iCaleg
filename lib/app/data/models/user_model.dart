class UserModel {
  final String name;
  final String nik;
  final String gender;
  final String religion;
  final String phone;
  final String referalCode;
  final String userStatus;
  final String ketStatus;
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
