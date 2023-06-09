import 'package:flutter/material.dart';
import 'package:health_app/theme/app_theme.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notificaciones',
          style: AppTheme.titleStyleLight,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.notifications,
              size: 45,
            ),
            SizedBox(
              height: 10,
            ),
            Text('No presenta notificaciones actualmente'),
          ],
        ),
      ),
    );
  }
}
