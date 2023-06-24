import 'dart:io';

import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:health_app/widgets/custom_input.dart';

import '../models/patient_model.dart';
import '../providers/auth.dart';
import '../providers/providers.dart';
import '../services/database_service.dart';
import '../theme/app_theme.dart';

class EditPatientScreen extends StatefulWidget {
  const EditPatientScreen({Key? key}) : super(key: key);

  @override
  State<EditPatientScreen> createState() => _EditPatientScreenState();
}

class _EditPatientScreenState extends State<EditPatientScreen> {
  PatientInformation patient = PatientInformation(
      name: '', gender: '', hospital: '', age: 0, id: 0, photo: '');
  TextEditingController age = TextEditingController();
  TextEditingController actualTreatment = TextEditingController();
  TextEditingController aditionalInformation = TextEditingController();
  bool loaderImage = false;
  String imageProfile = '';

  Future<void> getInfo() async {
    final patientListProvider =
        Provider.of<PatientListProvider>(context, listen: false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    patient = await patientListProvider
        .getUserInfo(prefs.getString('currentPatient') ?? '');
    setState(() {
      patient;
    });
  }

  void updatePatient() {
    setState(() {
      patient;
    });
  }

  void changeLoaderImage(setState) {
    setState(() {
      loaderImage = !loaderImage;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (patient.name == '') {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    final patientListProvider =
        Provider.of<PatientListProvider>(context, listen: true);
    age.text = patient.age.toString();
    actualTreatment.text = patient.treatment ?? '';
    aditionalInformation.text = patient.aditionalInformation ?? '';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Editar',
                        style: AppTheme.titleStyle,
                      ),
                      Text(
                        'Conoce el detalle y progreso',
                        style: AppTheme.subTitleStyle,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomInput(
                        title: const Text('Edad'),
                        controller: age,
                        keyboardType: TextInputType.number,
                      ),
                      CustomInput(
                          title: const Text('Tratamiento actual'),
                          controller: actualTreatment),
                      CustomInput(
                          maxLines: 3,
                          title: const Text('Información adicional'),
                          controller: aditionalInformation),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text('Añadir imagen'),
                      ),
                      GestureDetector(
                          onTap: () async {
                            final picker = ImagePicker();
                            var pickedFile = await picker.pickImage(
                                source: ImageSource.gallery);
                            if (context.mounted && pickedFile != null) {
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
                                          child: Image.asset(pickedFile!.path),
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
                                                      if (pickedFile != null) {
                                                        changeLoaderImage(
                                                            setStateBuilder);

                                                        final file = File(
                                                            pickedFile!.path);
                                                        final fileName =
                                                            getFileNameFromPath(
                                                                pickedFile!
                                                                    .path);
                                                        final firebaseStorageRef =
                                                            FirebaseStorage
                                                                .instance
                                                                .ref()
                                                                .child(
                                                                    fileName);
                                                        final uploadTask =
                                                            firebaseStorageRef
                                                                .putFile(file);
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
                          child: Container(
                              margin: const EdgeInsets.all(10),
                              color: Colors.grey,
                              height: 100,
                              width: 100,
                              child: imageProfile == ''
                                  ? const Icon(
                                      Icons.photo,
                                      color: Colors.white,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: imageProfile,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          const SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ))),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  bool agree = false;
                  await showDialog(
                      context: context,
                      builder: (BuildContext ctx) {
                        return AlertDialog(
                          title: const Text(
                              '¿Estás seguro de editar estos campos?'),
                          actions: [
                            Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(ctx);
                                    },
                                    child: const Text('Cancelar')),
                                ElevatedButton(
                                    onPressed: () {
                                      agree = true;
                                      Navigator.pop(ctx);
                                    },
                                    child: const Text('Aceptar'))
                              ],
                            )
                          ],
                        );
                      });
                  if (agree) {
                    try {
                      List<String> tempGallery = [];

                      if (imageProfile != '') {
                        if (patient.gallery != null) {
                          tempGallery = [...patient.gallery!];
                          tempGallery.add(imageProfile);
                        } else {
                          tempGallery.add(imageProfile);
                        }
                      }
                      PatientInformation newPatient = PatientInformation(
                          doc: patient.doc,
                          name: patient.name,
                          gender: patient.gender,
                          hospital: patient.hospital,
                          age: int.parse(age.text),
                          id: patient.id,
                          photo: patient.photo,
                          initialDate: patient.initialDate,
                          date: patient.date,
                          riskFactors: patient.riskFactors,
                          tumorType: patient.tumorType,
                          pathology: patient.pathology,
                          treatment: actualTreatment.text,
                          aditionalInformation: aditionalInformation.text,
                          gallery: tempGallery.isNotEmpty
                              ? tempGallery
                              : patient.gallery);
                      User? user = await authProvider.getUser();
                      final DatabaseService database = DatabaseService();

                      await database.updatePatientlInfo(
                          user!.uid, newPatient, patient.doc ?? '');
                      patientListProvider.updatePatientsList(user, database);
                      // setState(() {
                      //   patient = newPatient;
                      // });
                    } catch (e) {
                      print(e);
                    }

                    updatePatient();
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  }
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                    Size(size.width, 50), // Tamaño deseado del botón
                  ),
                ),
                child: const Text('Guardar'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.white // Tamaño deseado del botón
                        ),
                    fixedSize: MaterialStateProperty.all<Size>(
                      Size(size.width, 50), // Tamaño deseado del botón
                    ),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(40), // Radio de los bordes
                        side: BorderSide(
                            color: Colors.black.withOpacity(0.5),
                            width: 1), // Color y grosor del borde
                      ),
                    ),
                  ),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

String getFileNameFromPath(String path) {
  final separator = Platform.pathSeparator;
  final parts = path.split(separator);
  return parts.isNotEmpty ? parts.last : '';
}
