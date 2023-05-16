import 'package:flutter/material.dart';

import '../models/models.dart';
import '../providers/auth.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class TreatmentExamScreen extends StatefulWidget {
  const TreatmentExamScreen({Key? key}) : super(key: key);

  @override
  State<TreatmentExamScreen> createState() => _TreatmentExamScreenState();
}

class _TreatmentExamScreenState extends State<TreatmentExamScreen> {
  bool errorMessage = false;

  @override
  Widget build(BuildContext context) {
    final treatmentForm = Provider.of<TreatmentExamFormProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    final patientListProvider =
        Provider.of<PatientListProvider>(context, listen: true);
    final PatientInformation patient =
        ModalRoute.of(context)!.settings.arguments as PatientInformation;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Consulta tratamiento',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: PageContainer(
          child: Form(
            key: treatmentForm.formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CustomInput(
                              title: const Text('Edad de diagnostico: '),
                              controller: treatmentForm.ageAtDiagnosis,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                {
                                  print(treatmentForm.ageAtDiagnosis.text);
                                  (value != null && value.isNotEmpty)
                                      ? treatmentForm
                                          .ageAtDiagnosisValidatorError = ''
                                      : treatmentForm
                                              .ageAtDiagnosisValidatorError =
                                          'Ingrese un valor';
                                  return null;
                                }
                              }),
                          const SizedBox(
                              height:
                                  5), // Add some space between the TextFormField and the error message
                          Text(
                            treatmentForm.ageAtDiagnosisValidatorError == ''
                                ? ''
                                : treatmentForm.ageAtDiagnosisValidatorError,
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
                              title: const Text('Cohort: '),
                              controller: treatmentForm.cohort,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                {
                                  print('textura');
                                  print(treatmentForm.cohort.text);
                                  (value != null && value.isNotEmpty)
                                      ? treatmentForm.cohortValidatorError = ''
                                      : treatmentForm.cohortValidatorError =
                                          'Ingrese un valor';
                                  return null;
                                }
                              }),
                          const SizedBox(
                              height:
                                  5), // Add some space between the TextFormField and the error message
                          Text(
                            treatmentForm.cohortValidatorError == ''
                                ? ''
                                : treatmentForm.cohortValidatorError,
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
                              title: const Text('ER status: (P:1 N:0) '),
                              controller: treatmentForm.erStatus,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                {
                                  (value != null && value.isNotEmpty)
                                      ? treatmentForm.erStatusValidatorError =
                                          ''
                                      : treatmentForm.erStatusValidatorError =
                                          'Ingrese un valor';
                                  return null;
                                }
                              }),
                          const SizedBox(
                              height:
                                  5), // Add some space between the TextFormField and the error message
                          Text(
                            treatmentForm.erStatusValidatorError == ''
                                ? ''
                                : treatmentForm.erStatusValidatorError,
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
                              title: const Text('Neoplas grado: '),
                              controller: treatmentForm.neoplasmHistologicGrade,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                {
                                  (value != null && value.isNotEmpty)
                                      ? treatmentForm
                                              .neoplasmHistologicGradeValidatorError =
                                          ''
                                      : treatmentForm
                                              .neoplasmHistologicGradeValidatorError =
                                          'Ingrese un valor';
                                  return null;
                                }
                              }),
                          const SizedBox(
                              height:
                                  5), // Add some space between the TextFormField and the error message
                          Text(
                            treatmentForm
                                        .neoplasmHistologicGradeValidatorError ==
                                    ''
                                ? ''
                                : treatmentForm
                                    .neoplasmHistologicGradeValidatorError,
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
                              title: const Text('Lymph positivo: (P:1 N:0)'),
                              controller: treatmentForm.lymphPositive,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                {
                                  (value != null && value.isNotEmpty)
                                      ? treatmentForm
                                          .lymphPositiveValidatorError = ''
                                      : treatmentForm
                                              .lymphPositiveValidatorError =
                                          'Ingrese un valor';
                                  return null;
                                }
                              }),
                          const SizedBox(
                              height:
                                  5), // Add some space between the TextFormField and the error message
                          Text(
                            treatmentForm.lymphPositiveValidatorError == ''
                                ? ''
                                : treatmentForm.lymphPositiveValidatorError,
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
                              title: const Text('Mutaciones: '),
                              controller: treatmentForm.mutationCount,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                {
                                  (value != null && value.isNotEmpty)
                                      ? treatmentForm
                                          .mutationCountValidatorError = ''
                                      : treatmentForm
                                              .mutationCountValidatorError =
                                          'Ingrese un valor';
                                  return null;
                                }
                              }),
                          const SizedBox(
                              height:
                                  5), // Add some space between the TextFormField and the error message
                          Text(
                            treatmentForm.mutationCountValidatorError == ''
                                ? ''
                                : treatmentForm.mutationCountValidatorError,
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
                              title: const Text('PR status: (P:1 N:0) '),
                              controller: treatmentForm.prStatus,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                {
                                  (value != null && value.isNotEmpty)
                                      ? treatmentForm.prStatusValidatorError =
                                          ''
                                      : treatmentForm.prStatusValidatorError =
                                          'Ingrese un valor';
                                  return null;
                                }
                              }),
                          const SizedBox(
                              height:
                                  5), // Add some space between the TextFormField and the error message
                          Text(
                            treatmentForm.prStatusValidatorError == ''
                                ? ''
                                : treatmentForm.prStatusValidatorError,
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
                              title: const Text('Gene tipo: '),
                              controller: treatmentForm.geneClassifier,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                {
                                  (value != null && value.isNotEmpty)
                                      ? treatmentForm
                                          .geneClassifierValidatorError = ''
                                      : treatmentForm
                                              .geneClassifierValidatorError =
                                          'Ingrese un valor';
                                  return null;
                                }
                              }),
                          const SizedBox(
                              height:
                                  5), // Add some space between the TextFormField and the error message
                          Text(
                            treatmentForm.geneClassifierValidatorError == ''
                                ? ''
                                : treatmentForm.geneClassifierValidatorError,
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
                              title: const Text('Nottingham: '),
                              controller: treatmentForm.nottinghamPrognostic,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                {
                                  (value != null && value.isNotEmpty)
                                      ? treatmentForm
                                              .nottinghamPrognosticValidatorError =
                                          ''
                                      : treatmentForm
                                              .nottinghamPrognosticValidatorError =
                                          'Ingrese un valor';
                                  return null;
                                }
                              }),
                          const SizedBox(
                              height:
                                  5), // Add some space between the TextFormField and the error message
                          Text(
                            treatmentForm.nottinghamPrognosticValidatorError ==
                                    ''
                                ? ''
                                : treatmentForm
                                    .nottinghamPrognosticValidatorError,
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
                              title: const Text('Oncotree: '),
                              controller: treatmentForm.oncotree,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                {
                                  (value != null && value.isNotEmpty)
                                      ? treatmentForm.oncotreeValidatorError =
                                          ''
                                      : treatmentForm.oncotreeValidatorError =
                                          'Ingrese un valor';
                                  return null;
                                }
                              }),
                          const SizedBox(
                              height:
                                  5), // Add some space between the TextFormField and the error message
                          Text(
                            treatmentForm.oncotreeValidatorError == ''
                                ? ''
                                : treatmentForm.oncotreeValidatorError,
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
                      onPressed: treatmentForm.isLoading
                          ? null
                          : () async {
                              FocusScope.of(context).unfocus();
                              if (!treatmentForm.isValidForm() ||
                                  treatmentForm.ageAtDiagnosisValidatorError !=
                                      '' ||
                                  treatmentForm.cohortValidatorError != '' ||
                                  treatmentForm.erStatusValidatorError != '' ||
                                  treatmentForm.geneClassifierValidatorError !=
                                      '' ||
                                  treatmentForm
                                          .neoplasmHistologicGradeValidatorError !=
                                      '' ||
                                  treatmentForm.mutationCountValidatorError !=
                                      '' ||
                                  treatmentForm.prStatusValidatorError != '' ||
                                  treatmentForm
                                          .nottinghamPrognosticValidatorError !=
                                      '' ||
                                  treatmentForm.oncotreeValidatorError != '' ||
                                  treatmentForm.geneClassifierValidatorError !=
                                      '') {
                                return;
                              }
                              treatmentForm.isLoading = true;
                              // DiagnosisModel diagnosisInfo = DiagnosisModel(
                              //     perimeterMean:
                              //         double.tryParse(treatmentForm.perimeter.text) ??
                              //             0,
                              //     textureMean:
                              //         double.tryParse(examForm.texture.text) ??
                              //             0,
                              //     smoothnessMean:
                              //         double.tryParse(examForm.smoothhness.text) ??
                              //             0,
                              //     concavePointsMean: double.tryParse(
                              //             examForm.concavityPoints.text) ??
                              //         0,
                              //     symmetryMean:
                              //         double.tryParse(examForm.symetri.text) ??
                              //             0,
                              //     fractalDimensionMean: double.tryParse(
                              //             examForm.fractalDimension.text) ??
                              //         0

                              //     );

                              // var result = await DiagnosisPrediction()
                              //     .makeDiagnosisPredictionTreatment(diagnosisInfo);

                              // if (result != null && context.mounted) {
                              //   print(result);
                              //   showDialog(
                              //       context: context,
                              //       builder: (BuildContext dxcontext) {
                              //         return AlertDialog(
                              //           title: const Text('Examen de tumor'),
                              //           content:
                              //               Text('El resultado es: $result'),
                              //           actions: [
                              //             ElevatedButton(
                              //                 onPressed: () async {
                              //                   try {
                              //                     PatientInformation
                              //                         newPatient =
                              //                         PatientInformation(
                              //                             doc: patient.doc,
                              //                             name: patient.name,
                              //                             gender:
                              //                                 patient.gender,
                              //                             hospital:
                              //                                 patient.hospital,
                              //                             age: patient.age,
                              //                             id: patient.id,
                              //                             photo: patient.photo,
                              //                             initialDate: patient
                              //                                 .initialDate,
                              //                             date: patient.date,
                              //                             riskFactors: patient
                              //                                 .riskFactors,
                              //                             tumorType: result,
                              //                             pathology:
                              //                                 patient.pathology,
                              //                             treatment:
                              //                                 patient.treatment,
                              //                             aditionalInformation:
                              //                                 patient
                              //                                     .aditionalInformation,
                              //                             gallery:
                              //                                 patient.gallery);
                              //                     User? user =
                              //                         await authProvider
                              //                             .getUser();
                              //                     final DatabaseService
                              //                         database =
                              //                         DatabaseService();

                              //                     await database
                              //                         .updatePatientlInfo(
                              //                             user!.uid,
                              //                             newPatient,
                              //                             patient.doc ?? '');
                              //                     patientListProvider
                              //                         .updatePatientsList(
                              //                             user, database);
                              //                     // setState(() {
                              //                     //   patient = newPatient;
                              //                     // });

                              //                     if (mounted) {
                              //                       Navigator.pop(dxcontext);
                              //                       Navigator.pop(context);
                              //                     }
                              //                     examForm.cleanControllers();
                              //                   } catch (e) {
                              //                     print(e);
                              //                   }
                              //                 },
                              //                 child: const Text('Aceptar'))
                              //           ],
                              //         );
                              //       });
                              //   // Navigator.pop(context);
                              // } else {
                              //   setState(() {
                              //     errorMessage = true;
                              //   });
                              // }
                              // examForm.cleanControllers();

                              treatmentForm.isLoading = false;

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
                      child: Text(treatmentForm.isLoading
                          ? 'Cargando...'
                          : 'Analizar')),
                )
              ],
            ),
          ),
        ));
  }
}
