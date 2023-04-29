import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_app/models/models.dart';

import '../services/database_service.dart';

class HospitalListProvider with ChangeNotifier {
  List<HospitalModel> _hospitalsList = [];

  List<HospitalModel> get hospitalsList => _hospitalsList;

  Future<void> updateHospitalsList(User user, DatabaseService database) async {
    try {
      _hospitalsList = (await database.getHospitalsList(user.uid))!;
      notifyListeners();
    } catch (e) {
      print('error $e');
    }
  }
}
