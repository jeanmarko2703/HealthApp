import 'package:flutter/material.dart';
import 'package:health_app/screens/onboarding_backgroun.dart';
import 'package:health_app/theme/app_theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const TextStyle titleStyle = TextStyle(
        color: Colors.white, fontSize: 35, fontWeight: FontWeight.w700);
    const TextStyle subTitleStyle = TextStyle(
        color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const OnboardingBackground(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: size.height * 0.15, bottom: size.height * 0.1),
                      child: const Text(
                        "Health app",
                        style: titleStyle,
                      )),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Form(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          Container(
                              margin: const EdgeInsets.symmetric(vertical: 40),
                              child: const Text(
                                "Log In",
                                style: subTitleStyle,
                              )),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: TextFormField(
                                decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 15),
                              border: InputBorder.none,
                              labelText: 'Email',
                            )),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: TextFormField(
                                decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 15),
                              border: InputBorder.none,
                              labelText: 'Contraseña',
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, 'navigationScreen');
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    foregroundColor: AppTheme.buttonLabelColor
                                        .withOpacity(0.8),
                                    backgroundColor: Colors.white),
                                child: const Text(
                                  'Iniciar Sesión',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                )),
                          ),
                          TextButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {},
                              child: const Text('¿ Olvidaste tu contraseña ?'))
                        ],
                      ),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Container(
                              margin: const EdgeInsets.all(5),
                              child: Image.asset('assets/google_logo.png')),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Container(
                              margin: const EdgeInsets.all(5),
                              child: Image.asset('assets/apple_logo.png')),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
