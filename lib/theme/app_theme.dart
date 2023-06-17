import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color.fromRGBO(249, 249, 249, 1);
  static const Color buttonLabelColor = Color.fromRGBO(98, 210, 212, 1);
  static const TextStyle titleStyleLight = TextStyle(color: Colors.black);

  // static const secondColor = Color.fromRGBO(173, 173, 175, 1);
  // static const backgroundColor = Color.fromRGBO(246, 246, 249, 1);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: primary,
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        // toolbarTextStyle: TextStyle(color: Colors.black),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                30), 
          ),

          // minimumSize:
          //     medicalInstitutions.length - 1 < index
          //         ? const Size(5, 5)
          //         : null,
          elevation: 0,
          backgroundColor: AppTheme.buttonLabelColor,
        ),
      )
      //color primario
      );
}
