// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

class HospitalModel {
  final String name;
  final String location;

  HospitalModel({
    required this.name,
    required this.location,
  });

  factory HospitalModel.fromRawJson(String str) =>
      HospitalModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HospitalModel.fromJson(Map<String, dynamic> json) => HospitalModel(
        name: json["name"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "location": location,
      };
}
