import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:health_app/models/models.dart';

import '../services/database_service.dart';

class PatientListProvider with ChangeNotifier {
  List<PatientInformation> _patientsList = [];
  bool _isLoading = false;

  late PatientInformation _patient;

  List<PatientInformation> get patientsList => _patientsList;

  PatientInformation get patient => _patient;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<PatientInformation> getUserInfo(String doc) async {
    for (var element in _patientsList) {
      if (element.doc == doc) {
        return element;
      }
    }
    return PatientInformation(
        name: '', gender: '', hospital: '', age: 0, id: 0, photo: '');
  }

  Future<List<PatientInformation>?> updatePatientsList(
      User user, DatabaseService database) async {
    try {
      _patientsList = (await database.getPatientsList(user.uid))!;
    } catch (e) {
      print('error $e');
    }
    return _patientsList;
  }
}
