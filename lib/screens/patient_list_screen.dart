import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:health_app/theme/app_theme.dart';
import 'package:health_app/widgets/widgets.dart';

import '../models/patient_model.dart';
import '../providers/providers.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({Key? key}) : super(key: key);

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  List<PatientInformation> patientsList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final patientListProvider =
        Provider.of<PatientListProvider>(context, listen: false);
    List<PatientInformation> patientsList = patientListProvider.patientsList;

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        title: const Text(
          'Lista de pacientes',
          style: AppTheme.titleStyleLight,
        ),

        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'addPatientScreen').then((value) {
                setState(() {
                  patientsList;
                });
              });
            },
            icon: const Icon(Icons.add),
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
            patientsList.isEmpty
                ? const SizedBox()
                : const CupertinoSearchTextField(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.only(
                        top: 15, bottom: 15, left: 10, right: 10),
                    placeholder: 'Buscar',
                  ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: patientsList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.personal_injury_rounded,
                            size: 30,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'No tiene pacientes registrados',
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: patientsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return PatientCard(
                          size: size,
                          patients: patientsList,
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
