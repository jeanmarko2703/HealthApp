import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:health_app/providers/auth.dart';
import 'package:health_app/providers/providers.dart';
import 'package:health_app/routes/routes.dart';
import 'package:health_app/theme/app_theme.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UiProvider()),
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => PatientListProvider()),
      ChangeNotifierProvider(create: (_) => HospitalListProvider()),
      ChangeNotifierProvider(
        create: (_) => TumorExamFormProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => PatientFormProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => LoginFormProvider(),
        lazy: true,
      ),
      ChangeNotifierProvider(
        create: (_) => SignInFormProvider(),
        lazy: true,
      ),
    ], child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    return MaterialApp(
      title: "Health App",
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.initialRoute,
      navigatorKey: navigatorKey,
      routes: AppRoute.getAppRoute(),
      theme: AppTheme.lightTheme,
    );
  }
}
