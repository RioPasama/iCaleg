import 'package:meta/meta.dart';
import 'dart:convert';

class DukunganDataIntervalModel {
  final String key;
  final int value;

  DukunganDataIntervalModel({
    required this.key,
    required this.value,
  });

  factory DukunganDataIntervalModel.fromRawJson(String str) =>
      DukunganDataIntervalModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DukunganDataIntervalModel.fromJson(Map<String, dynamic> json) =>
      DukunganDataIntervalModel(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}
