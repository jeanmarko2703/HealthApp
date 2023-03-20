import 'package:flutter/material.dart';

import 'onboarding_backgroun.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        const OnboardingBackground(),
        const Center(
            child: Text(
          "Health App",
          style: TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.w800),
        )),
        OnBoardingButtons(size: size)
      ],
    ));
  }
}

class OnBoardingButtons extends StatelessWidget {
  const OnBoardingButtons({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        child: Center(
          child: SizedBox(
            width: size.width,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  LoginButton(),
                  SizedBox(
                    height: 10,
                  ),
                  SigninButton()
                ],
              ),
            ),
          ),
        ));
  }
}

class SigninButton extends StatelessWidget {
  const SigninButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, "siginScreen");
      },
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(225, 225, 225, 0.1),
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          textStyle:
              const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      child:
          const SizedBox(width: 300, child: Center(child: Text("Registrarse"))),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(168, 190, 221, 1),
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          textStyle:
              const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      onPressed: () {
        Navigator.pushNamed(context, "loginScreen");
      },
      child: const SizedBox(
          width: 300, child: Center(child: Text("Iniciar Sesión"))),
    );
  }
}
