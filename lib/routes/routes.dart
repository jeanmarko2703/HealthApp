import 'package:flutter/material.dart';
import 'package:health_app/screens/sigin_screen.dart';

import '../models/models.dart';
import '../screens/screens.dart';

class AppRoute {
  static const initialRoute = "loginScreen";
  static final menuOption = <MenuOption>[
    MenuOption(route: "homeScreen", name: "home", screen: const HomeScreen()),
    MenuOption(
        route: "patientScreen", name: "patient", screen: const PatientScreen()),
    MenuOption(
        route: "notificationScreen",
        name: "notification",
        screen: const NotificationScreen()),
    MenuOption(
        route: "settingsScreen",
        name: "settings",
        screen: const SettingsScreen())
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
    appRoutes.addAll({
      "navigationScreen": (BuildContext context) => const NavigationScreen()
    });
    appRoutes
        .addAll({"homeScreen": (BuildContext context) => const HomeScreen()});
    appRoutes.addAll(
        {"patientScreen": (BuildContext context) => const PatientScreen()});
    appRoutes.addAll({
      "notificationScreen": (BuildContext context) => const NotificationScreen()
    });
    appRoutes.addAll(
        {"settingsScreen": (BuildContext context) => const SettingsScreen()});

    return appRoutes;
  }
}
