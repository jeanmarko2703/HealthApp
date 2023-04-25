import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/screens.dart';

class SaveAccount extends StatefulWidget {
  const SaveAccount({Key? key}) : super(key: key);

  @override
  State<SaveAccount> createState() => _SaveAccountState();
}

class _SaveAccountState extends State<SaveAccount> {
//   }
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const LoginScreen();
    } else {
      return const NavigationScreen();
    }
  }
}
