import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_app/models/models.dart';
import 'package:provider/provider.dart';

import '../services/database_service.dart';
import 'auth.dart';

class PatientListProvider with ChangeNotifier {
  List<PatientInformation> _patientsList = [];

  List<PatientInformation> get patientsList => _patientsList;

  Future<void> updatePatientsList(User user, DatabaseService database) async {
    try {
      _patientsList = (await database.getPatientsList(user.uid))!;
      notifyListeners();
    } catch (e) {
      print('error $e');
    }
  }
}
