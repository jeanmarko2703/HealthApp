import 'package:flutter/material.dart';

import '../providers/providers.dart';
import '../routes/routes.dart';
import '../widgets/custom_navigatorbar.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    return Scaffold(
      body: Center(
        child: AppRoute.menuOption[currentIndex].screen,
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
