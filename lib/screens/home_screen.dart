import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_app/theme/app_theme.dart';

import '../models/patient_model.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const String userName = 'Jean Marko Aguirre';
    final List<String> medicalInstitutions = ['Stella Maris', 'Montesur'];
    const int patientNumber = 10;

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(0),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderHome(
                size: size,
                userName: userName,
                medicalInstitutions: medicalInstitutions,
                patientNumber: patientNumber),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                'Citas próximas: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: patients.length,
                    itemBuilder: (BuildContext context, int index) {
                      return PatientCard(
                        size: size,
                        patients: patients,
                        index: index,
                      );
                    }),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}

class HeaderHome extends StatelessWidget {
  const HeaderHome({
    super.key,
    required this.size,
    required this.userName,
    required this.medicalInstitutions,
    required this.patientNumber,
  });

  final Size size;
  final String userName;
  final List<String> medicalInstitutions;
  final int patientNumber;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        height: size.height * 0.225,
        width: size.width,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10.0, left: 10, bottom: 20, right: 10),
          child: Stack(
            children: [
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    'assets/undraw_medicine.svg',
                    height: 80,
                    fit: BoxFit.fitHeight,
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hola, $userName',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: size.width * 0.75,
                    height: 35,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: medicalInstitutions.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize:
                                      medicalInstitutions.length - 1 < index
                                          ? const Size(5, 5)
                                          : null,
                                  elevation: 0,
                                  backgroundColor: AppTheme.buttonLabelColor,
                                ),
                                onPressed: () {},
                                child: medicalInstitutions.length - 1 < index
                                    ? const Text('+')
                                    : Text(medicalInstitutions[index])),
                          );
                        }),
                  ),
                  Text(
                    'Pacientes: $patientNumber ',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
