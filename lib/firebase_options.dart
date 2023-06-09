// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDcRWNe89bFsZZc1w7lf7P3EcAIkxtzMBY',
    appId: '1:346071504861:web:fc286934ced8e4314b0834',
    messagingSenderId: '346071504861',
    projectId: 'healthapp-d8ee1',
    authDomain: 'healthapp-d8ee1.firebaseapp.com',
    databaseURL: 'https://healthapp-d8ee1-default-rtdb.firebaseio.com',
    storageBucket: 'healthapp-d8ee1.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyACfHYRa5wsO0hU33nJG68Q3HCEcn4KLVY',
    appId: '1:346071504861:android:fa33016b99ecb9a94b0834',
    messagingSenderId: '346071504861',
    projectId: 'healthapp-d8ee1',
    databaseURL: 'https://healthapp-d8ee1-default-rtdb.firebaseio.com',
    storageBucket: 'healthapp-d8ee1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBnZQXXJhZuRKwK4jON2UUTMQGDLVpkofU',
    appId: '1:346071504861:ios:46ef4afdaed77acf4b0834',
    messagingSenderId: '346071504861',
    projectId: 'healthapp-d8ee1',
    databaseURL: 'https://healthapp-d8ee1-default-rtdb.firebaseio.com',
    storageBucket: 'healthapp-d8ee1.appspot.com',
    iosClientId: '346071504861-lgb0kug52oot4hdd01qmm3ibm4131pnj.apps.googleusercontent.com',
    iosBundleId: 'com.example.healthApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBnZQXXJhZuRKwK4jON2UUTMQGDLVpkofU',
    appId: '1:346071504861:ios:46ef4afdaed77acf4b0834',
    messagingSenderId: '346071504861',
    projectId: 'healthapp-d8ee1',
    databaseURL: 'https://healthapp-d8ee1-default-rtdb.firebaseio.com',
    storageBucket: 'healthapp-d8ee1.appspot.com',
    iosClientId: '346071504861-lgb0kug52oot4hdd01qmm3ibm4131pnj.apps.googleusercontent.com',
    iosBundleId: 'com.example.healthApp',
  );
}
