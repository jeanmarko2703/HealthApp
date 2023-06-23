import 'package:flutter/material.dart';

import 'package:health_app/widgets/custom_input.dart';

import '../theme/app_theme.dart';

class EditPatientScreen extends StatelessWidget {
  const EditPatientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController treatment = TextEditingController();
    final size = MediaQuery.of(context).size;
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
                          title: const Text('Edad'), controller: treatment),
                      CustomInput(
                          title: const Text('Tratamiento actual'),
                          controller: treatment),
                      CustomInput(
                          maxLines: 3,
                          title: const Text('Información adicional'),
                          controller: treatment)
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
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
                  onPressed: () {},
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
