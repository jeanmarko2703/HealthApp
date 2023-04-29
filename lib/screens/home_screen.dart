import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_app/models/models.dart';
import 'package:health_app/theme/app_theme.dart';

import '../providers/auth.dart';
import '../providers/providers.dart';
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

  void changeLoaderState(setState) {
    setState(() {
      loaderList = !loaderList;
    });
  }

  Future<void> getUserInformation() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    User? user = await authProvider.getUser();
    if (user != null) {
      try {
        userInformation = (await database.getUserInfo(user.uid))!;
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
  }

  Future<void> getPatientsList() async {
    final patientListProvider =
        Provider.of<PatientListProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    User? user = await authProvider.getUser();
    patientListProvider.updatePatientsList(user!, database);
  }

  @override
  void initState() {
    super.initState();
    getUserInformation();
    gethospitalsList();
    getPatientsList();
  }

  @override
  Widget build(BuildContext context) {
    final patientListProvider = Provider.of<PatientListProvider>(context);
    final hospitalsListProvider = Provider.of<HospitalListProvider>(context);
    final size = MediaQuery.of(context).size;
    final patientsList = patientListProvider.patientsList;
    List<HospitalModel> medicalInstitutions =
        hospitalsListProvider.hospitalsList;

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
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                height: size.height * 0.225,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 10, bottom: 20, right: 10),
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
                            'Hola, ${userInformation.name}',
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
                                              medicalInstitutions.length - 1 <
                                                      index
                                                  ? const Size(5, 5)
                                                  : null,
                                          elevation: 0,
                                          backgroundColor:
                                              AppTheme.buttonLabelColor,
                                        ),
                                        onPressed: () {
                                          medicalInstitutions.length - 1 < index
                                              ? showDialog(
                                                  context: context,
                                                  builder: (BuildContext ctx) {
                                                    TextEditingController name =
                                                        TextEditingController();
                                                    TextEditingController
                                                        location =
                                                        TextEditingController();

                                                    return StatefulBuilder(
                                                        builder: (ctx,
                                                            StateSetter
                                                                setState) {
                                                      return AlertDialog(
                                                        title: Row(
                                                          // mainAxisAlignment: Main,
                                                          children: [
                                                            const Expanded(
                                                                child: Text(
                                                                    'Añadir institución')),
                                                            GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      ctx);
                                                                },
                                                                child: const Icon(
                                                                    Icons
                                                                        .cancel))
                                                          ],
                                                        ),
                                                        content: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            CustomInput(
                                                                title: const Text(
                                                                    'Nombre:'),
                                                                controller:
                                                                    name),
                                                            CustomInput(
                                                                title: const Text(
                                                                    'Ubicación:'),
                                                                controller:
                                                                    location)
                                                          ],
                                                        ),
                                                        actionsAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        actions: [
                                                          ElevatedButton(
                                                              onPressed:
                                                                  loaderList
                                                                      ? null
                                                                      : () async {
                                                                          final authProvider = Provider.of<AuthProvider>(
                                                                              ctx,
                                                                              listen: false);

                                                                          final DatabaseService
                                                                              database =
                                                                              DatabaseService();
                                                                          HospitalModel
                                                                              hospitalNew =
                                                                              HospitalModel(name: name.text, location: location.text);
                                                                          changeLoaderState(
                                                                              setState);
                                                                          print(
                                                                              'el estado es: $loaderList');

                                                                          if (name.text != '' &&
                                                                              location.text != '') {
                                                                            try {
                                                                              User? user = await authProvider.getUser();

                                                                              await database.saveHospitalInfo(hospitalNew, user!.uid);

                                                                              await gethospitalsList();
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
                                                  })
                                              : null;
                                        },
                                        child: medicalInstitutions.length - 1 <
                                                index
                                            ? const Text('+')
                                            : Text(medicalInstitutions[index]
                                                .name)),
                                  );
                                }),
                          ),
                          Text(
                            'Pacientes: ${patientsList.length} ',
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
            patientsList.isEmpty
                ? const SizedBox()
                : const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Citas próximas: ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
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
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: patientsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return PatientCard(
                            size: size,
                            patients: patientsList,
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
