import 'package:flutter/material.dart';
import 'package:health_app/screens/onboarding_backgroun.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const OnboardingBackground(),
          Column(
            children: [
              const Text("title"),
              Center(
                child: Container(
                  color: Colors.white,
                  child: Form(
                      child: Column(
                    children: [
                      const Text("Iniciar Sesión"),
                      TextFormField(),
                      TextFormField()
                    ],
                  )),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
