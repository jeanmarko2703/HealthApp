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
                            title: 'Nombre *',
                            controller: genderController,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                CustomInput(
                  title: 'Genero *',
                  controller: genderController,
                ),
                CustomInput(
                  title: 'Edad *',
                  controller: genderController,
                ),
                CustomInput(
                  title: 'DNI',
                  controller: genderController,
                ),
                CustomInput(
                  title: 'Tipo de cancer',
                  controller: genderController,
                ),
                CustomInput(
                  title: 'Próxima cita *',
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

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    required this.title,
    required this.controller,
  });
  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title),
          Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                controller: controller,
                cursorColor: Colors.grey,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              )),
        ],
      ),
    );
  }
}
