import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_app/models/models.dart';
import 'package:health_app/services/database_service.dart';
import 'package:path/path.dart' show basename;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:health_app/theme/app_theme.dart';
import 'package:health_app/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/auth.dart';
import '../providers/providers.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({Key? key}) : super(key: key);

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  List<HospitalModel> hospitalsList = [];
  String imageProfile = '';
  bool loaderImage = false;
  String selectedValue = '';

  void changeLoaderImage(setState) {
    setState(() {
      loaderImage = !loaderImage;
    });
  }

  void addHospitalList() {
    final hospitalListProvider = Provider.of<HospitalListProvider>(context);
    hospitalsList = hospitalListProvider.hospitalsList;
  }

  Future<void> getPatientsList() async {
    final DatabaseService database = DatabaseService();

    final patientListProvider =
        Provider.of<PatientListProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    User? user = await authProvider.getUser();
    patientListProvider.updatePatientsList(user!, database);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    addHospitalList();

    selectedValue = hospitalsList[0].name;
  }

  @override
  Widget build(BuildContext context) {
    final patientFormProvider = Provider.of<PatientFormProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Añadir nuevo paciente',
            style: AppTheme.titleStyleLight,
          ),
        ),
        body: PageContainer(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            child: hospitalsList.isEmpty
                ? const Center(
                    child: Text(
                        'Añada una insitución médica para añadir un paciente'),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final picker = ImagePicker();
                              var pickedFile = await picker.pickImage(
                                  source: ImageSource.gallery);
                              if (context.mounted) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext ctx) {
                                      return StatefulBuilder(
                                          builder: (context, setStateBuilder) {
                                        return AlertDialog(
                                          title:
                                              const Text('Imagen seleccionada'),
                                          content: SizedBox(
                                            width: 200,
                                            height: 200,
                                            child:
                                                Image.asset(pickedFile!.path),
                                          ),
                                          actionsAlignment:
                                              MainAxisAlignment.center,
                                          actions: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors
                                                      .red, // Change the text color
                                                ),
                                                onPressed: loaderImage == true
                                                    ? null
                                                    : () {
                                                        pickedFile = null;

                                                        Navigator.pop(ctx);
                                                      },
                                                child: const Text('Cancel')),
                                            ElevatedButton(
                                                onPressed: loaderImage == true
                                                    ? null
                                                    : () async {
                                                        if (pickedFile !=
                                                            null) {
                                                          changeLoaderImage(
                                                              setStateBuilder);

                                                          final file = File(
                                                              pickedFile!.path);
                                                          final fileName =
                                                              basename(
                                                                  file.path);
                                                          final firebaseStorageRef =
                                                              FirebaseStorage
                                                                  .instance
                                                                  .ref()
                                                                  .child(
                                                                      fileName);
                                                          final uploadTask =
                                                              firebaseStorageRef
                                                                  .putFile(
                                                                      file);
                                                          final snapshot =
                                                              await uploadTask
                                                                  .whenComplete(
                                                                      () {});
                                                          final downloadUrl =
                                                              await snapshot.ref
                                                                  .getDownloadURL();
                                                          setState(() {
                                                            imageProfile =
                                                                downloadUrl;
                                                          });
                                                          changeLoaderImage(
                                                              setStateBuilder);
                                                          print(
                                                              'Download URL: $imageProfile');
                                                        }

                                                        Navigator.pop(ctx);
                                                      },
                                                child: Text(loaderImage == true
                                                    ? 'Cargando'
                                                    : 'Guardar'))
                                          ],
                                        );
                                      });
                                    });
                              }
                            },
                            child: CircleAvatar(
                                backgroundColor: AppTheme.buttonLabelColor,
                                radius: 35,
                                child: imageProfile == ''
                                    ? const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      )
                                    : FadeInImage.assetNetwork(
                                        placeholder: 'assets/grey_loader.gif',
                                        image: imageProfile)),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomInput(
                                  title: const Text('Nombre *'),
                                  controller:
                                      patientFormProvider.nameController,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      CustomInput(
                        title: const Text('Genero *'),
                        controller: patientFormProvider.genderController,
                      ),
                      CustomInput(
                        title: const Text('Edad *'),
                        controller: patientFormProvider.ageController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Instituación médica'),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            width: double.infinity,
                            child: DropdownButton<String>(
                              underline: const SizedBox(),
                              elevation: 0,
                              value: selectedValue,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedValue = newValue!;
                                  patientFormProvider.hospitalController.text =
                                      selectedValue;
                                  print(patientFormProvider
                                      .hospitalController.text);
                                });
                              },
                              items: hospitalsList
                                  .map<DropdownMenuItem<String>>(
                                      (HospitalModel value) {
                                return DropdownMenuItem<String>(
                                  value: value.name,
                                  child: Text(value.name),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      CustomInput(
                        title: const Text('DNI'),
                        controller: patientFormProvider.idController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: patientFormProvider.isLoading
                              ? null
                              : () async {
                                  patientFormProvider.isLoading = true;
                                  final DatabaseService database =
                                      DatabaseService();
                                  final authProvider =
                                      Provider.of<AuthProvider>(context,
                                          listen: false);
                                  User? user = await authProvider.getUser();
                                  final PatientInformation newPatient =
                                      PatientInformation(
                                          name: patientFormProvider
                                              .nameController.text,
                                          gender: patientFormProvider
                                              .genderController.text,
                                          hospital: selectedValue,
                                          age: int.parse(patientFormProvider
                                              .ageController.text),
                                          id: int.parse(patientFormProvider
                                              .ageController.text),
                                          photo: imageProfile);
                                  await database.savePatientlInfo(
                                      newPatient, user!.uid);
                                  patientFormProvider.isLoading = false;
                                  await getPatientsList();

                                  Navigator.pop(context);
                                },
                          child: Text(patientFormProvider.isLoading
                              ? 'Cargando'
                              : 'Guardar'))
                    ],
                  ),
          ),
        )));
  }
}
