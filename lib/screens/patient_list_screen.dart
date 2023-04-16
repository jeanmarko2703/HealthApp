import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_app/theme/app_theme.dart';
import 'package:health_app/widgets/widgets.dart';

import '../models/patient_model.dart';

class PatientListScreen extends StatelessWidget {
  const PatientListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        title: const Text(
          'Lista de pacientes',
          style: AppTheme.titleStyleLight,
        ),

        actions: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'addPatientScreen'),
            child: Container(
              margin: const EdgeInsets.only(right: 30, bottom: 10, top: 10),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: AppTheme.buttonLabelColor,
                  borderRadius: BorderRadius.circular(5)),
              child: const Center(child: Text('+')),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            const CupertinoSearchTextField(
              backgroundColor: Colors.white,
              padding:
                  EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
              placeholder: 'Buscar',
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: patients.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PatientCard(
                      size: size,
                      patients: patients,
                      index: index,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
