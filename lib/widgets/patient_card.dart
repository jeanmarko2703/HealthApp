import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/patient_model.dart';
import '../theme/app_theme.dart';

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
      onTap: () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('currentPatient', patients[index].doc ?? '');
        print(patients[index].toJson());

        Navigator.pushNamed(context, 'patientInformationScreen');
      },
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
              child: patients[index].photo != ''
                  ? CachedNetworkImage(
                      imageUrl: patients[index].photo,
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
              //  Image.asset(
              //   patients[index].imagePath,
              //   height: 55,
              //   width: 55,
              // ),
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
                Text('${patients[index].age} años - ${patients[index].gender}',
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500)),
                Text(
                  patients[index].hospital,
                  style: TextStyle(color: Colors.black.withOpacity(0.5)),
                ),
                // Text(patients[index].,
                //     style: TextStyle(color: Colors.black.withOpacity(0.5))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
