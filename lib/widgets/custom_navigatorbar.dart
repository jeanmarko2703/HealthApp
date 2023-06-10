import 'package:flutter/material.dart';

import '../providers/providers.dart';
import '../theme/app_theme.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    return SafeArea(
        bottom: false,
        child: BottomNavigationBar(
          onTap: (int i) {
            if (currentIndex != i) {
              uiProvider.selectedMenuOpt = i;
            }
            return;
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: currentIndex,
          elevation: 0,
          selectedItemColor: AppTheme.buttonLabelColor,
          unselectedItemColor: const Color.fromRGBO(105, 106, 123, 1),
          unselectedLabelStyle: const TextStyle(color: Colors.red),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.medical_information_rounded,
                size: 30,
              ),
              label: 'Pacientes',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
                size: 30,
              ),
              label: 'Notificaciones',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.grain,
                size: 30,
              ),
              label: 'Ajustes',
            ),
          ],
        ));
  }
}
