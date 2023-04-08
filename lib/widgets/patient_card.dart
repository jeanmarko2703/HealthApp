import 'package:flutter/material.dart';

import '../models/patient_model.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({
    super.key,
    required this.size,
    required this.patients,
    required this.index,
  });

  final Size size;
  final List<PatientInformation> patients;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'patientInformationScreen',
          arguments: patients[index]),
      child: Container(
        width: size.width,
        margin: const EdgeInsets.only(bottom: 10),
        height: 100,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Text('${patients[index].age} años',
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500)),
                Text(
                  patients[index].disease,
                  style: TextStyle(color: Colors.black.withOpacity(0.5)),
                ),
                Text(patients[index].date,
                    style: TextStyle(color: Colors.black.withOpacity(0.5))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
