import 'package:flutter/material.dart';
import 'package:health_app/theme/app_theme.dart';

import '../providers/auth.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ajustes',
          style: AppTheme.titleStyleLight,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () async {
                try {
                  await AuthProvider().signOut();
                  if (context.mounted) {
                    Navigator.pushNamed(context, 'loginScreen');
                  }
                } catch (e) {
                  print('el error fue: $e');
                }
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: const [
                    Icon(Icons.lock),
                    Text('Cerrar Sesión'),
                    Expanded(child: SizedBox()),
                    Icon(Icons.arrow_forward_ios_rounded)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
