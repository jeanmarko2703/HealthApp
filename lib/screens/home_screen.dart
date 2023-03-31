import 'package:flutter/material.dart';
import 'package:health_app/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const String userName = 'Jean Marko Aguirre';
    final List<String> medicalInstitutions = ['Stella Maris', 'Javier Prado'];
    return Scaffold(
        backgroundColor: AppTheme.primary,
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              height: size.height * 0.25,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Hola, $userName'),
                  SizedBox(
                    width: size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: medicalInstitutions.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ElevatedButton(
                              onPressed: () {},
                              child: Text(medicalInstitutions[index]));
                        }),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
