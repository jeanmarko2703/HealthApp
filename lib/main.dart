import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/svg.dart';

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
  runApp(SplashApp());
}

class SplashApp extends StatelessWidget {
  final Future<String> splashScreenFuture = Future<String>.delayed(
    const Duration(seconds: 3),
    () => 'AppState',
  );
  SplashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<String>(
        future: splashScreenFuture,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          final size = MediaQuery.of(context).size;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SvgPicture.asset(
                    'assets/Oncoguard_Logo.svg',
                    width: size.width * 0.7,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          } else {
            return const AppState();
          }
        },
      ),
    );
  }
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
        create: (_) => TreatmentExamFormProvider(),
      ),
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
      title: "Oncoguard",
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.initialRoute,
      navigatorKey: navigatorKey,
      routes: AppRoute.getAppRoute(),
      theme: AppTheme.lightTheme,
    );
  }
}
