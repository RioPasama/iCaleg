class DukunganMapModel {
  final double lat;
  final double log;
  final int value;
  final String label;

  DukunganMapModel({
    required this.lat,
    required this.log,
    required this.value,
    required this.label,
  });

  factory DukunganMapModel.fromJson(Map<String, dynamic> json) =>
      DukunganMapModel(
        lat: double.parse(json['lat'].toString()),
        log: double.parse(json['lng'].toString()),
        value: json['value'],
        label: json['label'],
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'log': log,
        'value': value,
        'label': label,
      };
}
