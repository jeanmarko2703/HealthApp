import 'package:flutter/material.dart';
import 'package:health_app/theme/app_theme.dart';
import 'package:health_app/widgets/widgets.dart';

class AddPatientScreen extends StatelessWidget {
  const AddPatientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final genderController = TextEditingController();
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      backgroundColor: AppTheme.buttonLabelColor,
                      radius: 35,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
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
                            controller: genderController,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                CustomInput(
                  title: const Text('Genero *'),
                  controller: genderController,
                ),
                CustomInput(
                  title: const Text('Edad *'),
                  controller: genderController,
                ),
                CustomInput(
                  title: const Text('DNI'),
                  controller: genderController,
                ),
                CustomInput(
                  title: const Text('Tipo de cancer'),
                  controller: genderController,
                ),
                CustomInput(
                  title: const Text('Próxima cita *'),
                  controller: genderController,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () => null, child: const Text('Guardar'))
              ],
            ),
          ),
        )));
  }
}
