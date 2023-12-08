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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBDekmYW-Vetf2wKpPyVWYB-QBkyeCF3-c',
    appId: '1:88000209683:web:e3ed087803999576d1f0e6',
    messagingSenderId: '88000209683',
    projectId: 'commetareview',
    authDomain: 'commetareview.firebaseapp.com',
    storageBucket: 'commetareview.appspot.com',
    measurementId: 'G-5CN3FENX64',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCd_rp8oNlWGfAN37LZVewrpP0MHSYqFKM',
    appId: '1:88000209683:android:3aa468dbc9080798d1f0e6',
    messagingSenderId: '88000209683',
    projectId: 'commetareview',
    storageBucket: 'commetareview.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA2v6IEWkviBXzmxs8pfe6Mi6v3HqQPMHw',
    appId: '1:88000209683:ios:330a4bc62e26a6e5d1f0e6',
    messagingSenderId: '88000209683',
    projectId: 'commetareview',
    storageBucket: 'commetareview.appspot.com',
    androidClientId: '88000209683-66qhlg9c9ea3cp1lqf7f50alttmk4cer.apps.googleusercontent.com',
    iosClientId: '88000209683-8gehrd09i1hn7i0fgcgk3h6n6mj1mr3d.apps.googleusercontent.com',
    iosBundleId: 'io.commeta.hissa',
  );
}
