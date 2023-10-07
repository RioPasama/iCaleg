class DukunganDataIntervalModel {
  final String key;
  final int value;

  DukunganDataIntervalModel({
    required this.key,
    required this.value,
  });

  factory DukunganDataIntervalModel.fromJson(Map<String, dynamic> json) =>
      DukunganDataIntervalModel(
        key: json['key'],
        value: json['value'],
      );

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
      };
}
