import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:health_app/theme/app_theme.dart';

import '../models/patient_model.dart';
import '../widgets/widgets.dart';

class PatientInformationScreen extends StatelessWidget {
  const PatientInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PatientInformation patient =
        ModalRoute.of(context)!.settings.arguments as PatientInformation;
    String tumorType = 'MALIGNO';

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Resumen del paciente',
            style: AppTheme.titleStyleLight,
          ),
        ),
        body: SafeArea(
          child: PageContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderInformation(patient: patient),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {}, child: const Text('Agendar Cita')),
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
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        patient.date ?? 'No presenta cita',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Tratamiento actual:',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
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
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: patient.photo != ''
                ? CachedNetworkImage(
                    imageUrl: patient.photo,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 55,
                      height: 55,
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
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patient.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                ),

                Text('${patient.age} años - ${patient.gender}',
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500)),

                Text(
                  patient.hospital,
                  style: TextStyle(color: Colors.black.withOpacity(0.5)),
                ),
                // Text(patient.date,
                //     style: TextStyle(color: Colors.black.withOpacity(0.5))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
