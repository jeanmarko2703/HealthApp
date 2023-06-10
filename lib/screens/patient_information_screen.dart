import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:health_app/models/models.dart';

import '../providers/auth.dart';
import '../providers/providers.dart';
import '../services/database_service.dart';
import '../theme/app_theme.dart';

class PatientInformationScreen extends StatefulWidget {
  const PatientInformationScreen({Key? key}) : super(key: key);

  @override
  State<PatientInformationScreen> createState() =>
      _PatientInformationScreenState();
}

class _PatientInformationScreenState extends State<PatientInformationScreen> {
  PatientInformation patient = PatientInformation(
      name: '', gender: '', hospital: '', age: 0, id: 0, photo: '');

  Future<void> getInfo() async {
    final patientListProvider = Provider.of<PatientListProvider>(context);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    patient = await patientListProvider
        .getUserInfo(prefs.getString('currentPatient') ?? '');
    setState(() {
      patient;
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    final patientListProvider =
        Provider.of<PatientListProvider>(context, listen: true);

    if (patient.name == '') {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
        // appBar: AppBar(
        //   iconTheme: const IconThemeData(color: Colors.black),
        //   // title: const Text(
        //   //   'Resumen del paciente',
        //   //   style: AppTheme.titleStyleLight,
        //   // ),
        //   backgroundColor: AppTheme.primary,
        // ),
        body: Column(
      children: [
        HeaderInformation(patient: patient),
        Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        DateTime? date = DateTime(1900);
                        FocusScope.of(context).requestFocus(FocusNode());

                        date = await showDatePicker(
                            cancelText: 'Cancelar',
                            confirmText: 'Aceptar',
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));

                        if (date != null) {
                          try {
                            PatientInformation newPatient = PatientInformation(
                                doc: patient.doc,
                                name: patient.name,
                                gender: patient.gender,
                                hospital: patient.hospital,
                                age: patient.age,
                                id: patient.id,
                                photo: patient.photo,
                                initialDate: patient.initialDate,
                                date: date,
                                riskFactors: patient.riskFactors,
                                tumorType: patient.tumorType,
                                pathology: patient.pathology,
                                treatment: patient.treatment,
                                aditionalInformation:
                                    patient.aditionalInformation,
                                gallery: patient.gallery);
                            User? user = await authProvider.getUser();
                            final DatabaseService database = DatabaseService();
                            patientListProvider.isLoading = true;

                            await database.updatePatientlInfo(
                                user!.uid, newPatient, patient.doc ?? '');
                            patientListProvider.updatePatientsList(
                                user, database);

                            print(DateFormat.yMMMMEEEEd().format(date.toUtc()));
                            print('hola');
                          } catch (e) {
                            print(e);
                          }
                          setState(() {
                            patient;
                          });
                          patientListProvider.isLoading = false;
                        }
                      },
                      child: const Text('Agendar Cita')),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'moreInformationScreen',
                            arguments: patient);
                      },
                      child: const Text('Más información')),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cita próxima:',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      patientListProvider.isLoading
                          ? 'Cargando...'
                          : patient.date != null
                              ? DateFormat.yMMMMEEEEd()
                                  .format(patient.date!.toUtc())
                              : 'No presenta cita',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Tratamiento actual:',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      patient.treatment ?? 'No se ha añadido tratamiento',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Analisis del sistema',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      patient.tumorType != null
                          ? 'Tipo de tumor: ${patient.tumorType}'
                          : 'No se ha realizado análisis de tumor',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}

class HeaderInformation extends StatelessWidget {
  const HeaderInformation({
    super.key,
    required this.patient,
  });

  final PatientInformation patient;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: patient.photo != ''
                  ? CachedNetworkImage(
                      imageUrl: patient.photo,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 85,
                        height: 85,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.buttonLabelColor,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                  : const CircleAvatar(
                      backgroundColor: AppTheme.buttonLabelColor,
                      radius: 25,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      )),
            ),
            Text(
              patient.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
                '${patient.age} años - ${patient.gender} - ${patient.hospital}',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey))
          ],
        ),
      ),
    );
  }
}
