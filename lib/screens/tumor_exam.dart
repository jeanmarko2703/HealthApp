import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class TumorExamScreen extends StatelessWidget {
  const TumorExamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController perimeterController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Examen de tumor',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: PageContainer(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomInput(
                        title: const Text('Perimetro: '),
                        controller: perimeterController),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: CustomInput(
                        title: const Text('Textura: '),
                        controller: perimeterController),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomInput(
                        title: const Text('smoothness: '),
                        controller: perimeterController),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: CustomInput(
                        title: const Text('P. concavidad: '),
                        controller: perimeterController),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomInput(
                        title: const Text('Simetría: '),
                        controller: perimeterController),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: CustomInput(
                        title: const Text('Dimension fractal: '),
                        controller: perimeterController),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Analizar')),
              )
            ],
          ),
        ));
  }
}
