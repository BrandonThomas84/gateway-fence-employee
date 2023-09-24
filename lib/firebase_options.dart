// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members

// Package imports:
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

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
    apiKey: 'AIzaSyDrvEiw4P2xDQNwv3Ak4las9skolY0tK-o',
    appId: '1:8841313432:web:0f2a71ad8cf859a15764ed',
    messagingSenderId: '8841313432',
    projectId: 'gateway-fence-employee',
    authDomain: 'gateway-fence-employee.firebaseapp.com',
    databaseURL: 'https://gateway-fence-employee-default-rtdb.firebaseio.com',
    storageBucket: 'gateway-fence-employee.appspot.com',
    measurementId: 'G-30BM0KWCP1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBlB07rru6ecBswcYEHiWdrjsAdOIPlaj4',
    appId: '1:8841313432:android:44e4e8e3e10244dd5764ed',
    messagingSenderId: '8841313432',
    projectId: 'gateway-fence-employee',
    databaseURL: 'https://gateway-fence-employee-default-rtdb.firebaseio.com',
    storageBucket: 'gateway-fence-employee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC0lhcNBr7LZGo4_v5D23ii8Fqiq7LVMtY',
    appId: '1:8841313432:ios:8112f63ac94f83f25764ed',
    messagingSenderId: '8841313432',
    projectId: 'gateway-fence-employee',
    databaseURL: 'https://gateway-fence-employee-default-rtdb.firebaseio.com',
    storageBucket: 'gateway-fence-employee.appspot.com',
    iosBundleId: 'com.example.gatewayFenceEmployee',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC0lhcNBr7LZGo4_v5D23ii8Fqiq7LVMtY',
    appId: '1:8841313432:ios:a1f05a356f80b25d5764ed',
    messagingSenderId: '8841313432',
    projectId: 'gateway-fence-employee',
    databaseURL: 'https://gateway-fence-employee-default-rtdb.firebaseio.com',
    storageBucket: 'gateway-fence-employee.appspot.com',
    iosBundleId: 'com.example.gatewayFenceEmployee.RunnerTests',
  );
}
