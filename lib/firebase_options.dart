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
    apiKey: 'AIzaSyDPIGbRVOOsKH08a3Z7LHj9G5cTPl6cFdU',
    appId: '1:533724276715:web:3cd840875e51e91b2bdbae',
    messagingSenderId: '533724276715',
    projectId: 'wrbase-59fd4',
    authDomain: 'wrbase-59fd4.firebaseapp.com',
    databaseURL: 'https://wrbase-59fd4-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'wrbase-59fd4.appspot.com',
    measurementId: 'G-9WDL0TCPWC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBGcYiRs1dBT0jABghZM4MwEqlE-t3gSOY',
    appId: '1:533724276715:android:2ec4b6040b2b98ec2bdbae',
    messagingSenderId: '533724276715',
    projectId: 'wrbase-59fd4',
    databaseURL: 'https://wrbase-59fd4-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'wrbase-59fd4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCy5BINLFJWGUHHavp-ntO-T8fsPnaw3zA',
    appId: '1:533724276715:ios:e24010557c62ce162bdbae',
    messagingSenderId: '533724276715',
    projectId: 'wrbase-59fd4',
    databaseURL: 'https://wrbase-59fd4-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'wrbase-59fd4.appspot.com',
    iosClientId: '533724276715-56g8q713947s7g9aukrlhr39l8unhlas.apps.googleusercontent.com',
    iosBundleId: 'com.example.wr',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCy5BINLFJWGUHHavp-ntO-T8fsPnaw3zA',
    appId: '1:533724276715:ios:e24010557c62ce162bdbae',
    messagingSenderId: '533724276715',
    projectId: 'wrbase-59fd4',
    databaseURL: 'https://wrbase-59fd4-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'wrbase-59fd4.appspot.com',
    iosClientId: '533724276715-56g8q713947s7g9aukrlhr39l8unhlas.apps.googleusercontent.com',
    iosBundleId: 'com.example.wr',
  );
}