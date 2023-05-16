import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user
  Stream<User?> get userStream {
    return _auth.authStateChanges();
  }

  Future<void> logInWithCustomToken(String token) async {
    try {
      // final userCredential =
      await FirebaseAuth.instance.signInWithCustomToken(token);
      // print("Sign-in successful.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-custom-token":
          // print("The supplied token is not a Firebase custom auth token.");
          break;
        case "custom-token-mismatch":
          // print("The supplied token is for a different Firebase project.");
          break;
        default:
        // print("Unkown error.");
      }
    }
  }

  // sign in with email and password
  Future<User?> getUser() async {
    return _auth.currentUser;
  }

  // sign in with email and password
  Future<UserCredential?> signIn(String email, String password) async {
    UserCredential? result;

    result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    return result;
  }

  // log in
  Future<User?> logIn(String email, String password) async {
    // UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);

    try {
      final UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return result.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // print('No user found for that email.');
        return null;
      } else if (e.code == 'wrong-password') {
        return null;
      }
    }
    return null;
  }

  // sign out
  Future signOut() async {
    await _auth.signOut();
  }

  Future<String?> getIdToken() async {
    return _auth.currentUser != null ? _auth.currentUser!.getIdToken() : null;
  }

  Future<IdTokenResult?> getIdTokenResult() async {
    return _auth.currentUser!.getIdTokenResult(true);
  }
}
