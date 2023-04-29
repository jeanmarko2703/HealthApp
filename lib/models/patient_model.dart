// class PatientInformation {
//   String imagePath;
//   String name;
//   int age;
//   String disease;
//   String date;

//   PatientInformation(
//       this.imagePath, this.name, this.age, this.disease, this.date);
// }

// final List<PatientInformation> patients = [
//   PatientInformation(
//       'assets/patientes_example/patient_1.png',
//       'Maria Rosa Lopez Aguilar',
//       30,
//       'Cancer de mama - Etapa 3',
//       'Lunes 29 sep 3:00 pm - 3:30 pm'),
//   PatientInformation(
//       'assets/patientes_example/patient_2.png',
//       'Romina Isabel Sanchez ',
//       28,
//       'Cancer de mama - Etapa 2',
//       'Lunes 29 sep 3:00 pm - 3:30 pm'),
//   PatientInformation(
//       'assets/patientes_example/patient_3.png',
//       'Emma Alba Garcia Rodriguez',
//       35,
//       'Cancer de mama - Etapa 3',
//       'Lunes 2 oct 10:00 am - 11:30 am'),
//   PatientInformation(
//       'assets/patientes_example/patient_4.png',
//       'Maria Paula Diaz Hernandez',
//       38,
//       'Cancer de mama - Etapa 2',
//       'Lunes 2 oct 3:00 pm - 3:30 pm'),
// ];

// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final patientInformation = patientInformationFromJson(jsonString);

import 'dart:convert';

class PatientInformation {
  final String name;
  final String gender;
  final String hospital;
  final int age;
  final int id;
  final String photo;

  PatientInformation({
    required this.name,
    required this.gender,
    required this.hospital,
    required this.age,
    required this.id,
    required this.photo,
  });

  factory PatientInformation.fromRawJson(String str) =>
      PatientInformation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PatientInformation.fromJson(Map<String, dynamic> json) =>
      PatientInformation(
        name: json["name"],
        gender: json["gender"],
        hospital: json["hospital"],
        age: json["age"],
        id: json["id"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "gender": gender,
        "hospital": hospital,
        "age": age,
        "id": id,
        "photo": photo,
      };
}
