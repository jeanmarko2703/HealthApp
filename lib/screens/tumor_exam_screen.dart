import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/models.dart';
import '../providers/auth.dart';
import '../providers/providers.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';

class TumorExamScreen extends StatefulWidget {
  const TumorExamScreen({Key? key}) : super(key: key);

  @override
  State<TumorExamScreen> createState() => _TumorExamScreenState();
}

class _TumorExamScreenState extends State<TumorExamScreen> {
  bool errorMessage = false;
  @override
  Widget build(BuildContext context) {
    final examForm = Provider.of<TumorExamFormProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    final patientListProvider =
        Provider.of<PatientListProvider>(context, listen: true);
    final PatientInformation patient =
        ModalRoute.of(context)!.settings.arguments as PatientInformation;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Examen de tumor',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: PageContainer(
          child: Form(
            key: examForm.formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CustomInput(
                              title: const Text('Perimetro: '),
                              controller: examForm.perimeter,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                {
                                  print(examForm.perimeter.text);
                                  (value != null && value.isNotEmpty)
                                      ? examForm.perimeterValidatorError = ''
                                      : examForm.perimeterValidatorError =
                                          'Ingrese un valor';
                                  return null;
                                }
                              }),
                          const SizedBox(
                              height:
                                  5), // Add some space between the TextFormField and the error message
                          Text(
                            examForm.perimeterValidatorError == ''
                                ? ''
                                : examForm.perimeterValidatorError,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          CustomInput(
                              title: const Text('Textura: '),
                              controller: examForm.texture,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                {
                                  print('textura');
                                  print(examForm.texture.text);
                                  (value != null && value.isNotEmpty)
                                      ? examForm.textureValidatorError = ''
                                      : examForm.textureValidatorError =
                                          'Ingrese un valor';
                                  return null;
                                }
                              }),
                          const SizedBox(
                              height:
                                  5), // Add some space between the TextFormField and the error message
                          Text(
                            examForm.textureValidatorError == ''
                                ? ''
                                : examForm.textureValidatorError,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CustomInput(
                              title: const Text('smoothness: '),
                              controller: examForm.smoothhness,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                {
                                  (value != null && value.isNotEmpty)
                                      ? examForm.smoothhnessValidatorError = ''
                                      : examForm.smoothhnessValidatorError =
                                          'Ingrese un valor';
                                  return null;
                                }
                              }),
                          const SizedBox(
                              height:
                                  5), // Add some space between the TextFormField and the error message
                          Text(
                            examForm.smoothhnessValidatorError == ''
                                ? ''
                                : examForm.smoothhnessValidatorError,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          CustomInput(
                              title: const Text('P. concavidad: '),
                              controller: examForm.concavityPoints,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                {
                                  (value != null && value.isNotEmpty)
                                      ? examForm.concavityPointsValidatorError =
                                          ''
                                      : examForm.concavityPointsValidatorError =
                                          'Ingrese un valor';
                                  return null;
                                }
                              }),
                          const SizedBox(
                              height:
                                  5), // Add some space between the TextFormField and the error message
                          Text(
                            examForm.concavityPointsValidatorError == ''
                                ? ''
                                : examForm.concavityPointsValidatorError,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CustomInput(
                              title: const Text('Simetría: '),
                              controller: examForm.symetri,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                {
                                  (value != null && value.isNotEmpty)
                                      ? examForm.symetriValidatorError = ''
                                      : examForm.symetriValidatorError =
                                          'Ingrese un valor';
                                  return null;
                                }
                              }),
                          const SizedBox(
                              height:
                                  5), // Add some space between the TextFormField and the error message
                          Text(
                            examForm.concavityPointsValidatorError == ''
                                ? ''
                                : examForm.concavityPointsValidatorError,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          CustomInput(
                              title: const Text('Dimension fractal: '),
                              controller: examForm.fractalDimension,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                {
                                  (value != null && value.isNotEmpty)
                                      ? examForm
                                          .fractalDimensionValidatorError = ''
                                      : examForm
                                              .fractalDimensionValidatorError =
                                          'Ingrese un valor';
                                  return null;
                                }
                              }),
                          const SizedBox(
                              height:
                                  5), // Add some space between the TextFormField and the error message
                          Text(
                            examForm.fractalDimensionValidatorError == ''
                                ? ''
                                : examForm.fractalDimensionValidatorError,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                errorMessage
                    ? Column(
                        children: const [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Correo o contraseña incorrecta',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: examForm.isLoading
                          ? null
                          : () async {
                              FocusScope.of(context).unfocus();
                              if (!examForm.isValidForm() ||
                                  examForm.perimeterValidatorError != '' ||
                                  examForm.textureValidatorError != '' ||
                                  examForm.smoothhnessValidatorError != '' ||
                                  examForm.concavityPointsValidatorError !=
                                      '' ||
                                  examForm.symetriValidatorError != '' ||
                                  examForm.fractalDimensionValidatorError !=
                                      '') {
                                return;
                              }
                              examForm.isLoading = true;
                              DiagnosisModel diagnosisInfo = DiagnosisModel(
                                  perimeterMean:
                                      double.tryParse(examForm.perimeter.text) ??
                                          0,
                                  textureMean:
                                      double.tryParse(examForm.texture.text) ??
                                          0,
                                  smoothnessMean:
                                      double.tryParse(examForm.smoothhness.text) ??
                                          0,
                                  concavePointsMean: double.tryParse(
                                          examForm.concavityPoints.text) ??
                                      0,
                                  symmetryMean:
                                      double.tryParse(examForm.symetri.text) ??
                                          0,
                                  fractalDimensionMean: double.tryParse(
                                          examForm.fractalDimension.text) ??
                                      0
                                  // perimeterMean: 93.86,
                                  // textureMean: 13.98,
                                  // smoothnessMean: 0.10990,
                                  // concavePointsMean: 0.06495,
                                  // symmetryMean: 0.1650,
                                  // fractalDimensionMean: 0.06121

                                  );
                              print(diagnosisInfo.toJson());

                              var result = await DiagnosisPrediction()
                                  .makeDiagnosisPrediction(diagnosisInfo);

                              if (result != null && context.mounted) {
                                print(result);
                                showDialog(
                                    context: context,
                                    builder: (BuildContext dxcontext) {
                                      return AlertDialog(
                                        title: const Text('Examen de tumor'),
                                        content:
                                            Text('El resultado es: $result'),
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
                                                          hospital:
                                                              patient.hospital,
                                                          age: patient.age,
                                                          id: patient.id,
                                                          photo: patient.photo,
                                                          initialDate: patient
                                                              .initialDate,
                                                          date: patient.date,
                                                          riskFactors: patient
                                                              .riskFactors,
                                                          tumorType: result,
                                                          pathology:
                                                              patient.pathology,
                                                          treatment:
                                                              patient.treatment,
                                                          aditionalInformation:
                                                              patient
                                                                  .aditionalInformation,
                                                          gallery:
                                                              patient.gallery);
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
                                                    Navigator.pop(context);
                                                  }
                                                  examForm.cleanControllers();
                                                } catch (e) {
                                                  print(e);
                                                }
                                              },
                                              child: const Text('Aceptar'))
                                        ],
                                      );
                                    });
                                // Navigator.pop(context);
                              } else {
                                setState(() {
                                  errorMessage = true;
                                });
                              }
                              // examForm.cleanControllers();

                              examForm.isLoading = false;

                              // if (access != null &&
                              //     context.mounted) {
                              //   print('el uid es: ${access.uid}');

                              //   uiProvider.selectedMenuOpt = 0;
                              //   Navigator.pushReplacementNamed(
                              //       context, 'navigationScreen');
                              //   loginForm.isLoading = false;
                              //   loginForm.password.text = '';
                              // } else {
                              //   _message();
                              //   loginForm.isLoading = false;
                              // }
                            },
                      child: Text(
                          examForm.isLoading ? 'Cargando...' : 'Analizar')),
                )
              ],
            ),
          ),
        ));
  }
}
