import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/models.dart';

class DatabaseService {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> saveUserInfo(UserModel userModel) async {
    try {
      await _usersCollection.doc(userModel.uid).set({
        'name': userModel.name,
        'email': userModel.email,
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<UserModel?> getUserInfo(String uid) async {
    DocumentReference userRef = _usersCollection.doc(uid);
    DocumentSnapshot userSnapshot = await userRef.get();

    if (userSnapshot.exists) {
      UserModel userInformation =
          UserModel.fromJson(userSnapshot.data() as Map<String, dynamic>);
      print(
          'el nombre del usuario es: ${userInformation.name} y su correo: ${userInformation.email} ');
      return userInformation;
    }
    return null;
  }

  Future<void> saveHospitalInfo(HospitalModel hospital, String uid) async {
    try {
      await _usersCollection.doc(uid).collection('hospitals').add({
        'name': hospital.name,
        'location': hospital.location,
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<List<HospitalModel>?> getHospitalsList(String uid) async {
    CollectionReference usersRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('hospitals');

    List<HospitalModel> listHospitals = [];
    await usersRef.get().then((QuerySnapshot querySnapshot) {
      for (var documentSnapshot in querySnapshot.docs) {
        print(documentSnapshot.data());
        listHospitals.add(HospitalModel.fromJson(
            documentSnapshot.data() as Map<String, dynamic>));
      }
    });

    return listHospitals;
  }

  Future<void> savePatientlInfo(PatientInformation patient, String uid) async {
    try {
      await _usersCollection
          .doc(uid)
          .collection('patients')
          .add(patient.toJson());
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<List<PatientInformation>?> getPatientsList(String uid) async {
    CollectionReference usersRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('patients');

    List<PatientInformation> listPatients = [];
    await usersRef.get().then((QuerySnapshot querySnapshot) {
      for (var documentSnapshot in querySnapshot.docs) {
        print(documentSnapshot.data());
        listPatients.add(PatientInformation.fromJson(
            documentSnapshot.data() as Map<String, dynamic>));
      }
    });

    return listPatients;
  }
}
