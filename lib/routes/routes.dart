import 'package:flutter/material.dart';
import 'package:health_app/helpers/save_account_helper.dart';
import 'package:health_app/screens/sigin_screen.dart';

import '../models/models.dart';

class AppRoute {
  static const initialRoute = "saveAccount";
  static final menuOption = <MenuOption>[
    MenuOption(route: "homeScreen", name: "home", screen: const HomeScreen()),
    MenuOption(
        route: "patientScreen", name: "patient", screen: const PatientListScreen()),
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
        {"patientListScreen": (BuildContext context) => const PatientListScreen()});
    appRoutes.addAll({
      "notificationScreen": (BuildContext context) => const NotificationScreen()
    });
    appRoutes.addAll(
        {"settingsScreen": (BuildContext context) => const SettingsScreen()});

        appRoutes.addAll(
        {"patientInformationScreen": (BuildContext context) => const PatientInformationScreen()});
         appRoutes.addAll(
        {"saveAccount": (BuildContext context) => const SaveAccount()});

    return appRoutes;
  }
}
