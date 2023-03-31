import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_app/theme/app_theme.dart';

class PatientInformation {
  String imagePath;
  String name;
  int age;
  String disease;
  String date;

  PatientInformation(
      this.imagePath, this.name, this.age, this.disease, this.date);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const String userName = 'Jean Marko Aguirre';
    final List<String> medicalInstitutions = ['Stella Maris', 'Montesur'];
    const int patientNumber = 10;
    final List<PatientInformation> patients = [
      PatientInformation(
          'assets/patientes_example/patient_1.png',
          'Maria Rosa Lopez Aguilar',
          30,
          'Cancer de mama - Etapa 3',
          'Lunes 29 sep 3:00 pm - 3:30 pm'),
      PatientInformation(
          'assets/patientes_example/patient_2.png',
          'Romina Isabel Sanchez ',
          28,
          'Cancer de mama - Etapa 2',
          'Lunes 29 sep 3:00 pm - 3:30 pm'),
      PatientInformation(
          'assets/patientes_example/patient_3.png',
          'Emma Alba Garcia Rodriguez',
          35,
          'Cancer de mama - Etapa 3',
          'Lunes 2 oct 10:00 am - 11:30 am'),
      PatientInformation(
          'assets/patientes_example/patient_4.png',
          'Maria Paula Diaz Hernandez',
          38,
          'Cancer de mama - Etapa 2',
          'Lunes 2 oct 3:00 pm - 3:30 pm'),
    ];

    return Scaffold(
        backgroundColor: AppTheme.primary,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          backgroundColor: Colors.white,
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
                      return Container(
                        width: size.width,
                        margin: const EdgeInsets.only(bottom: 10),
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Image.asset(
                                patients[index].imagePath,
                                height: 55,
                                width: 55,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  patients[index].name,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text('${patients[index].age} años',
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500)),
                                Text(
                                  patients[index].disease,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                                Text(patients[index].date,
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5))),
                              ],
                            )
                          ],
                        ),
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
