import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';
import '../providers/auth.dart';
import '../providers/providers.dart';
import '../theme/app_theme.dart';

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
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Más información',
                            style: AppTheme.titleStyle,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, 'editPatientScreen');
                              },
                              child: const Text(
                                'Editar',
                                style:
                                    TextStyle(color: AppTheme.buttonLabelColor),
                              ))
                        ],
                      ),
                      Text(
                        'Conoce el detalle y progreso',
                        style: AppTheme.subTitleStyle,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                  const SizedBox(
                    height: 20,
                  ),
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
                    children: const [
                      Text(
                        'Factores de riesgo:',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        riskfactors.map((e) => Text('\u2022 $e')).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Analisis del sistema:',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
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
                    children: const [
                      Text(
                        'Tratamiento Actual:',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    patient.treatment ?? 'No ha añadido un tratamiento',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      Text(
                        'Información adicional:',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
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
                  // const Text(
                  //   'Galería de examenes:',
                  //   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Center(
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         color: AppTheme.buttonLabelColor,
                  //         borderRadius: BorderRadius.circular(10)),
                  //     height: size.width * 0.5,
                  //     width: size.width * 0.5,
                  //     child: Center(
                  //       child: Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: const [
                  //           Icon(Icons.upload, color: Colors.white),
                  //           SizedBox(
                  //             height: 5,
                  //           ),
                  //           Text(
                  //             'Sube una imagen',
                  //             style: TextStyle(color: Colors.white),
                  //             textAlign: TextAlign.center,
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ));
  }
}
