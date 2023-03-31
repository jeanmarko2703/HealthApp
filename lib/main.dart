import 'package:flutter/material.dart';
import 'package:health_app/providers/providers.dart';
import 'package:health_app/routes/routes.dart';
import 'package:health_app/theme/app_theme.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UiProvider()),
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
