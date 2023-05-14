import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PatientInformation {
  final String? doc;
  final String name;
  final String gender;
  final String hospital;
  final int age;
  final int id;
  final String photo;
  final String? initialDate;
  final DateTime? date;
  final List<String>? riskFactors;
  final String? tumorType;
  final String? pathology;
  final String? treatment;
  final String? aditionalInformation;
  final List<String>? gallery;

  PatientInformation(
      {this.doc,
      required this.name,
      required this.gender,
      required this.hospital,
      required this.age,
      required this.id,
      required this.photo,
      this.initialDate,
      this.date,
      this.riskFactors,
      this.tumorType,
      this.pathology,
      this.treatment,
      this.aditionalInformation,
      this.gallery});

  factory PatientInformation.fromRawJson(String str) =>
      PatientInformation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PatientInformation.fromJson(Map<String, dynamic> json) =>
      PatientInformation(
          doc: json["doc"],
          name: json["name"],
          gender: json["gender"],
          hospital: json["hospital"],
          age: json["age"],
          id: json["id"],
          photo: json["photo"],
          initialDate: json['initialDate'],
          date: json['date'] != null
              ? (json['date'] as Timestamp)
                  .toDate() // convert Timestamp to DateTime
              : null,
          riskFactors: json['riskFactor'],
          tumorType: json['tumorType'],
          pathology: json['pathology'],
          treatment: json['treatment'],
          aditionalInformation: json['aditionalInformation'],
          gallery: json['gallery']);

  Map<String, dynamic> toJson() => {
        "doc": doc,
        "name": name,
        "gender": gender,
        "hospital": hospital,
        "age": age,
        "id": id,
        "photo": photo,
        "initialDate": initialDate,
        "date": date,
        "riskFators": riskFactors,
        "tumorType": tumorType,
        "pathology": pathology,
        "treatment": treatment,
        "aditionalInformation": aditionalInformation,
        "gallery": gallery
      };
}
