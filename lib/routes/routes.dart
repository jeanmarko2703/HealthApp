import 'package:flutter/material.dart';
import 'package:health_app/screens/sigin_screen.dart';

import '../models/models.dart';
import '../screens/screens.dart';

class AppRoute {
  static const initialRoute = "loginScreen";
  static final menuOption = <MenuOption>[
    MenuOption(route: "homeScreen", name: "home", screen: const HomeScreen())
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoute() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes.addAll({
      "onboardingScreen": (BuildContext context) => const OnboardingScreen()
    });
    appRoutes
        .addAll({"siginScreen": (BuildContext context) => const SiginScreen()});
    appRoutes
        .addAll({"loginScreen": (BuildContext context) => const LoginScreen()});

    appRoutes
        .addAll({"homeScreen": (BuildContext context) => const HomeScreen()});

    return appRoutes;
  }
}
