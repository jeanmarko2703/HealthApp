import 'package:flutter/material.dart';

class OnboardingBackground extends StatelessWidget {
  const OnboardingBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      bottom: false,
      top: false,
      child: Image.asset(
        "assets/onboarding_backgorund.jpeg",
        height: size.height,
        width: size.width,
        fit: BoxFit.cover,
      ),
    );
  }
}
