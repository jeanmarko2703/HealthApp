import 'package:flutter/material.dart';

import '../models/models.dart';
import '../providers/auth.dart';
import '../providers/providers.dart';
import '../services/services.dart';
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
          child: SingleChildScrollView(
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
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
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
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                validator: (value) {
                                  {
                                    print('textura');
                                    print(treatmentForm.cohort.text);
                                    (value != null && value.isNotEmpty)
                                        ? treatmentForm.cohortValidatorError =
                                            ''
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
                                controller:
                                    treatmentForm.neoplasmHistologicGrade,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
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
                                title: const Text('Lymph positivo:'),
                                controller: treatmentForm.lymphPositive,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
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
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
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
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
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
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
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
                              treatmentForm
                                          .nottinghamPrognosticValidatorError ==
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
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
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
                  CustomInput(
                      title: const Text('Fase del tumor: '),
                      controller: treatmentForm.tumorStage,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        {
                          (value != null && value.isNotEmpty)
                              ? treatmentForm.tumorStageValidatorError = ''
                              : treatmentForm.tumorStageValidatorError =
                                  'Ingrese un valor';
                          return null;
                        }
                      }),
                  const SizedBox(
                      height:
                          5), // Add some space between the TextFormField and the error message
                  Text(
                    treatmentForm.tumorStageValidatorError == ''
                        ? ''
                        : treatmentForm.tumorStageValidatorError,
                    style: const TextStyle(color: Colors.red),
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
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
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
                                    treatmentForm.erStatusValidatorError !=
                                        '' ||
                                    treatmentForm.geneClassifierValidatorError !=
                                        '' ||
                                    treatmentForm
                                            .neoplasmHistologicGradeValidatorError !=
                                        '' ||
                                    treatmentForm.mutationCountValidatorError !=
                                        '' ||
                                    treatmentForm.prStatusValidatorError !=
                                        '' ||
                                    treatmentForm
                                            .nottinghamPrognosticValidatorError !=
                                        '' ||
                                    treatmentForm.oncotreeValidatorError !=
                                        '' ||
                                    treatmentForm
                                            .geneClassifierValidatorError !=
                                        '' ||
                                    treatmentForm.tumorStageValidatorError !=
                                        '') {
                                  return;
                                }
                                treatmentForm.isLoading = true;
                                try {
                                  List<String> result = await DiagnosisPrediction().makeDiagnosisPredictionTreatment(
                                          int.parse(treatmentForm
                                              .ageAtDiagnosis.text),
                                          int.parse(treatmentForm.cohort.text),
                                          int.parse(
                                              treatmentForm.erStatus.text),
                                          int.parse(treatmentForm
                                              .neoplasmHistologicGrade.text),
                                          int.parse(
                                              treatmentForm.lymphPositive.text),
                                          int.parse(
                                              treatmentForm.mutationCount.text),
                                          int.parse(
                                              treatmentForm.prStatus.text),
                                          int.parse(treatmentForm
                                              .geneClassifier.text),
                                          int.parse(treatmentForm
                                              .nottinghamPrognostic.text),
                                          int.parse(treatmentForm.oncotree.text),
                                          int.parse(treatmentForm.tumorStage.text)) ??
                                      [];

                                  for (String r in result) {
                                    print(r);
                                  }

                                  if (context.mounted) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext dxcontext) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Tratamiento recomendado'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  'El resultado es: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                ...result
                                                    .map((e) => Text(e))
                                                    .toList()
                                              ],
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    try {
                                                      if (mounted) {
                                                        Navigator.pop(
                                                            dxcontext);
                                                        Navigator.pop(context);
                                                      }
                                                      treatmentForm
                                                          .cleanControllers();
                                                    } catch (e) {
                                                      print(e);
                                                    }
                                                  },
                                                  child: const Text('Aceptar'))
                                            ],
                                          );
                                        });
                                  }
                                } catch (e) {}

                                treatmentForm.isLoading = false;
                              },
                        child: Text(treatmentForm.isLoading
                            ? 'Cargando...'
                            : 'Analizar')),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
