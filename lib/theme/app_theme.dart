import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color.fromRGBO(211, 224, 239, 1);
  static const Color buttonLabelColor = Color.fromRGBO(86, 120, 183, 1);

  // static const secondColor = Color.fromRGBO(173, 173, 175, 1);
  // static const backgroundColor = Color.fromRGBO(246, 246, 249, 1);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: primary,
      appBarTheme: const AppBarTheme(color: Colors.white)
      //color primario
      );
}
