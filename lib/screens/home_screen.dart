import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:health_app/models/models.dart';
import 'package:health_app/theme/app_theme.dart';

import '../providers/auth.dart';
import '../providers/providers.dart';
import '../services/database_service.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService database = DatabaseService();
  UserModel userInformation = UserModel(email: '', name: '');
  bool loaderList = false;
  List<PatientInformation> patientsList = [];
  List<PatientInformation> secondPatientsList = [];
  String selectedValue = '';
  List<HospitalModel> medicalInstitutions = [];

  void changeLoaderState(setState) {
    setState(() {
      loaderList = !loaderList;
    });
  }

  void instituteListPatient(String hospitalName) {
    List<PatientInformation> tempPatientsList = [];

    for (var element in secondPatientsList) {
      if (element.hospital == hospitalName) {
        tempPatientsList.add(element);
      }
    }
    patientsList = tempPatientsList;

    setState(() {
      patientsList;
    });
  }

  Future<void> getUserInformation() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User? user = await authProvider.getUser();
    if (user != null) {
      try {
        userInformation = (await database.getUserInfo(user.uid))!;
        await prefs.setString('name', userInformation.name);
        await prefs.setString('email', userInformation.email);

        setState(() {
          userInformation;
        });
      } catch (e) {
        print('error $e');
      }
    }
  }

  Future<void> gethospitalsList() async {
    final hospitalsListProvider =
        Provider.of<HospitalListProvider>(context, listen: false);

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    User? user = await authProvider.getUser();
    await hospitalsListProvider.updateHospitalsList(user!, database);
    medicalInstitutions = hospitalsListProvider.hospitalsList;
    if (medicalInstitutions.isNotEmpty) {
      selectedValue = medicalInstitutions[0].name;
    }
  }

  Future<void> getPatientsList() async {
    final patientListProvider =
        Provider.of<PatientListProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    User? user = await authProvider.getUser();
    patientsList =
        await patientListProvider.updatePatientsList(user!, database) ?? [];
  }

  // void updateHospitalsListScreen() {
  //   final hospitalListProvider =
  //       Provider.of<HospitalListProvider>(context, listen: false);
  //   medicalInstitutions = hospitalListProvider.hospitalsList;
  //   if (medicalInstitutions.isNotEmpty) {
  //     selectedValue = medicalInstitutions[0].name;
  //   }
  // }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // updateHospitalsListScreen();
  }

  @override
  void initState() {
    super.initState();
    gethospitalsList();
    getUserInformation();
    getPatientsList();
  }

  @override
  Widget build(BuildContext context) {
    final patientListProvider =
        Provider.of<PatientListProvider>(context, listen: false);

    final size = MediaQuery.of(context).size;
    if (secondPatientsList.isEmpty) {
      secondPatientsList = patientListProvider.patientsList
          .where((element) => element.hospital == selectedValue)
          .toList();
    }

    // patientsList = patientListProvider.patientsList;

    if (userInformation.name == '') {
      return const CircularProgressIndicator(
        color: AppTheme.buttonLabelColor,
      );
    }

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
            SafeArea(
              top: true,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[350]!, width: 1),
                  ),
                ),
                height: size.height * 0.2,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 10, bottom: 20, right: 10),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -10,
                        child: IconButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(10, 10),
                              elevation: 0,
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext ctx) {
                                    TextEditingController name =
                                        TextEditingController();
                                    TextEditingController location =
                                        TextEditingController();

                                    return StatefulBuilder(
                                        builder: (ctx, StateSetter setState) {
                                      final authProvider =
                                          Provider.of<AuthProvider>(context,
                                              listen: false);
                                      return AlertDialog(
                                        title: Row(
                                          // mainAxisAlignment: Main,
                                          children: [
                                            const Expanded(
                                                child:
                                                    Text('Añadir institución')),
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(ctx);
                                                },
                                                child: const Icon(Icons.cancel))
                                          ],
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CustomInput(
                                                title: const Text('Nombre:'),
                                                controller: name),
                                            CustomInput(
                                                title: const Text('Ubicación:'),
                                                controller: location)
                                          ],
                                        ),
                                        actionsAlignment:
                                            MainAxisAlignment.center,
                                        actions: [
                                          ElevatedButton(
                                              onPressed: loaderList
                                                  ? null
                                                  : () async {
                                                      final DatabaseService
                                                          database =
                                                          DatabaseService();
                                                      HospitalModel
                                                          hospitalNew =
                                                          HospitalModel(
                                                              name: name.text,
                                                              location: location
                                                                  .text);
                                                      changeLoaderState(
                                                          setState);
                                                      print(
                                                          'el estado es: $loaderList');

                                                      if (name.text != '' &&
                                                          location.text != '') {
                                                        try {
                                                          User? user =
                                                              await authProvider
                                                                  .getUser();

                                                          await database
                                                              .saveHospitalInfo(
                                                                  hospitalNew,
                                                                  user!.uid);

                                                          await gethospitalsList();
                                                          setState(
                                                            () {},
                                                          );
                                                        } catch (e) {
                                                          print(e);
                                                        }
                                                      }
                                                      changeLoaderState(
                                                          setState);
                                                      print(
                                                          'el estado es: $loaderList');
                                                      if (name.text != '' &&
                                                          location.text != '') {
                                                        Navigator.pop(ctx);
                                                      }
                                                    },
                                              child: Text(!loaderList
                                                  ? 'Guardar'
                                                  : 'Cargando'))
                                        ],
                                      );
                                    });
                                  });
                            },
                            icon: const Icon(
                              Icons.add,
                            )),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hola, ${userInformation.name}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            medicalInstitutions.isNotEmpty
                                ? 'Selecciona un hospital o clinica'
                                : 'Añada un hospital o clínica con el botón más',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          if (medicalInstitutions.isNotEmpty)
                            Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey[350]!, width: 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedValue,
                                  isExpanded: true,
                                  hint: const Text('Selecciona',
                                      style: TextStyle(color: Colors.grey)),
                                  items: medicalInstitutions
                                      .map<DropdownMenuItem<String>>(
                                          (HospitalModel value) {
                                    return DropdownMenuItem<String>(
                                      value: value.name,
                                      child: Text(value.name),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        selectedValue = newValue;
                                        secondPatientsList = patientsList
                                            .where((element) =>
                                                element.hospital == newValue)
                                            .toList();
                                      });
                                    }
                                    // Acciones cuando se selecciona una opción
                                  },
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                selectedValue,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                ' (${secondPatientsList.length} pacientes totales)',
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            ' Proximas citas en "$selectedValue"',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: secondPatientsList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return PatientCard(
                                    size: size,
                                    patients: secondPatientsList,
                                    index: index,
                                  );
                                }),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
