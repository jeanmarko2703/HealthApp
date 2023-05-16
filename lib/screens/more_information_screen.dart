import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';
import '../providers/auth.dart';
import '../providers/providers.dart';
import '../services/services.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';

class MoreInformationScreen extends StatefulWidget {
  const MoreInformationScreen({Key? key}) : super(key: key);

  @override
  State<MoreInformationScreen> createState() => _MoreInformationScreenState();
}

class _MoreInformationScreenState extends State<MoreInformationScreen> {
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

  void updatePatient() {
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
    if (patient.name == '') {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    final patientListProvider =
        Provider.of<PatientListProvider>(context, listen: true);
    final size = MediaQuery.of(context).size;
    List<String> riskfactors = ['Fumador', 'Sobrepeso'];
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Información de paciente',
            style: AppTheme.titleStyleLight,
          ),
        ),
        body: SafeArea(
          child: PageContainer(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'tumorExamScreen',
                                arguments: patient);
                          },
                          child: const Text('Tipo de tumor')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'treatmentExamScreen',
                                arguments: patient);
                          },
                          child: const Text('Tratamiento')),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text(
                              'Fecha de inicio:',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                            // IconButton(
                            //     onPressed: () {}, icon: const Icon(Icons.edit))
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          patient.initialDate != null
                              ? DateFormat.yMMMMEEEEd()
                                  .format(patient.initialDate!.toUtc())
                              : 'Error',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Factores de riesgo:',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                            IconButton(
                                onPressed: () {}, icon: const Icon(Icons.edit))
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: riskfactors
                              .map((e) => Text('\u2022 $e'))
                              .toList(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Analisis del sistema:',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          patient.tumorType != null
                              ? 'Tipo de tumor: ${patient.tumorType}'
                              : 'No se ha realizado análisis de tumor',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Tratamiento Actual:',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext dxcontext) {
                                        TextEditingController treatment =
                                            TextEditingController();
                                        treatment.text =
                                            patient.treatment ?? '';

                                        return AlertDialog(
                                          title:
                                              const Text('Tratamiento actual'),
                                          content: CustomInput(
                                            title: const Text('Tratamiento'),
                                            controller: treatment,
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () async {
                                                  try {
                                                    PatientInformation
                                                        newPatient =
                                                        PatientInformation(
                                                            doc: patient.doc,
                                                            name: patient.name,
                                                            gender:
                                                                patient.gender,
                                                            hospital: patient
                                                                .hospital,
                                                            age: patient.age,
                                                            id: patient.id,
                                                            photo:
                                                                patient.photo,
                                                            initialDate: patient
                                                                .initialDate,
                                                            date: patient.date,
                                                            riskFactors: patient
                                                                .riskFactors,
                                                            tumorType: patient
                                                                .tumorType,
                                                            pathology: patient
                                                                .pathology,
                                                            treatment:
                                                                treatment.text,
                                                            aditionalInformation:
                                                                patient
                                                                    .aditionalInformation,
                                                            gallery: patient
                                                                .gallery);
                                                    User? user =
                                                        await authProvider
                                                            .getUser();
                                                    final DatabaseService
                                                        database =
                                                        DatabaseService();

                                                    await database
                                                        .updatePatientlInfo(
                                                            user!.uid,
                                                            newPatient,
                                                            patient.doc ?? '');
                                                    patientListProvider
                                                        .updatePatientsList(
                                                            user, database);
                                                    // setState(() {
                                                    //   patient = newPatient;
                                                    // });

                                                    if (mounted) {
                                                      Navigator.pop(dxcontext);
                                                    }
                                                  } catch (e) {
                                                    print(e);
                                                  }
                                                  updatePatient();
                                                },
                                                child: const Text('Ingresar'))
                                          ],
                                        );
                                      });
                                },
                                icon: const Icon(Icons.edit))
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          patient.treatment ?? 'No ha añadido un tratamiento',
                        ),
                        Row(
                          children: [
                            const Text(
                              'Información adicional:',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext dxcontext) {
                                        TextEditingController
                                            aditionalInformation =
                                            TextEditingController();
                                        aditionalInformation.text =
                                            patient.aditionalInformation ?? '';

                                        return StatefulBuilder(
                                          builder: (BuildContext context,
                                              setStateAditional) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Información adicional'),
                                              content: CustomInput(
                                                maxLines: 5,
                                                title: const Text('Datos: '),
                                                controller:
                                                    aditionalInformation,
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      try {
                                                        PatientInformation
                                                            newPatient =
                                                            PatientInformation(
                                                                doc:
                                                                    patient.doc,
                                                                name: patient
                                                                    .name,
                                                                gender: patient
                                                                    .gender,
                                                                hospital: patient
                                                                    .hospital,
                                                                age:
                                                                    patient.age,
                                                                id: patient.id,
                                                                photo: patient
                                                                    .photo,
                                                                initialDate: patient
                                                                    .initialDate,
                                                                date: patient
                                                                    .date,
                                                                riskFactors: patient
                                                                    .riskFactors,
                                                                tumorType: patient
                                                                    .tumorType,
                                                                pathology: patient
                                                                    .pathology,
                                                                treatment: patient
                                                                    .treatment,
                                                                aditionalInformation:
                                                                    aditionalInformation
                                                                        .text,
                                                                gallery: patient
                                                                    .gallery);
                                                        User? user =
                                                            await authProvider
                                                                .getUser();
                                                        final DatabaseService
                                                            database =
                                                            DatabaseService();

                                                        await database
                                                            .updatePatientlInfo(
                                                                user!.uid,
                                                                newPatient,
                                                                patient.doc ??
                                                                    '');
                                                        patientListProvider
                                                            .updatePatientsList(
                                                                user, database);
                                                        // setState(() {
                                                        //   patient = newPatient;
                                                        // });

                                                        if (mounted) {
                                                          Navigator.pop(
                                                              dxcontext);
                                                        }
                                                      } catch (e) {
                                                        print(e);
                                                      }
                                                      updatePatient();
                                                    },
                                                    child:
                                                        const Text('Ingresar'))
                                              ],
                                            );
                                          },
                                        );
                                      });
                                },
                                icon: const Icon(Icons.edit))
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(patient.aditionalInformation ??
                            'Añada información adicional'),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Galería de examenes:',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppTheme.buttonLabelColor,
                                borderRadius: BorderRadius.circular(10)),
                            height: size.width * 0.5,
                            width: size.width * 0.5,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.upload, color: Colors.white),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Sube una imagen',
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
