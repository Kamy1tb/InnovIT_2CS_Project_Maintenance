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
    apiKey: 'AIzaSyCC2Q5AeN2VY2oB9OPv9WfkyTpXT9vpbLA',
    appId: '1:30570018858:web:7294cfd7976b11343a6b53',
    messagingSenderId: '30570018858',
    projectId: 'smartbev-innovit',
    authDomain: 'smartbev-innovit.firebaseapp.com',
    storageBucket: 'smartbev-innovit.appspot.com',
    measurementId: 'G-XMFX5TH5TB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDU44Ggwy-8AjsDtexC_hUCdt8Lqev6-QU',
    appId: '1:30570018858:android:2f7e72f39f990b433a6b53',
    messagingSenderId: '30570018858',
    projectId: 'smartbev-innovit',
    storageBucket: 'smartbev-innovit.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCjglsrgWcoeycZrSrtmx_r8TkYNqAVtDU',
    appId: '1:30570018858:ios:85f2f44b5feba43d3a6b53',
    messagingSenderId: '30570018858',
    projectId: 'smartbev-innovit',
    storageBucket: 'smartbev-innovit.appspot.com',
    iosClientId: '30570018858-rg4mevirr82k5relc11k9en6f4eiiu8s.apps.googleusercontent.com',
    iosBundleId: 'com.example.innovit2csProjectPaiement',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCjglsrgWcoeycZrSrtmx_r8TkYNqAVtDU',
    appId: '1:30570018858:ios:039e083bfddcf1ff3a6b53',
    messagingSenderId: '30570018858',
    projectId: 'smartbev-innovit',
    storageBucket: 'smartbev-innovit.appspot.com',
    iosClientId: '30570018858-mqs6h040icalsdtlgvbki6koumlihkv7.apps.googleusercontent.com',
    iosBundleId: 'com.example.innovit2csProjectPaiement.RunnerTests',
  );
}