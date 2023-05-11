import 'package:flutter/material.dart';

import '../models/models.dart';
import '../services/services.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';

class MoreInformationScreen extends StatefulWidget {
  const MoreInformationScreen({Key? key}) : super(key: key);

  @override
  State<MoreInformationScreen> createState() => _MoreInformationScreenState();
}

class _MoreInformationScreenState extends State<MoreInformationScreen> {
  void loadingPrediction() {
    DiagnosisPrediction().makeDiagnosisPrediction(DiagnosisModel(
        textureMean: 13.98,
        perimeterMean: 93.86,
        smoothnessMean: 0.10990,
        concavePointsMean: 0.06495,
        symmetryMean: 0.1650,
        fractalDimensionMean: 0.06121));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PatientInformation patient =
        ModalRoute.of(context)!.settings.arguments as PatientInformation;
    final size = MediaQuery.of(context).size;
    List<String> riskfactors = ['Fumador', 'Sobrepeso'];
    String tumorType = 'MALIGNO';
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
                            Navigator.pushNamed(context, 'tumorExamScreen');
                          },
                          child: const Text('Tipo de tumor')),
                      ElevatedButton(
                          onPressed: () {}, child: const Text('Patología')),
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
                          patient.initialDate ?? 'Error',
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
                          'Tipo de tumor: ${patient.tumorType}',
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
                                onPressed: () {}, icon: const Icon(Icons.edit))
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
                                onPressed: () {}, icon: const Icon(Icons.edit))
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
