// File generated manually from google-services.json values.
// Re-run `flutterfire configure` to regenerate this file with proper web app values.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
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
        return windows;
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

  // TODO: Run `flutterfire configure` to get the correct web appId and
  // messagingSenderId. The values below use the Android API key and project
  // info which may work for basic usage but a dedicated web app registration
  // in the Firebase console is recommended.
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBGE53nolXmCIWtRYPlvb_6v0_kF6K8bI4',
    appId: '1:973100933748:web:0000000000000000',
    messagingSenderId: '973100933748',
    projectId: 'healtether-9b6df',
    storageBucket: 'healtether-9b6df.firebasestorage.app',
    authDomain: 'healtether-9b6df.firebaseapp.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBGE53nolXmCIWtRYPlvb_6v0_kF6K8bI4',
    appId: '1:973100933748:android:38058fe81f613bb01be721',
    messagingSenderId: '973100933748',
    projectId: 'healtether-9b6df',
    storageBucket: 'healtether-9b6df.firebasestorage.app',
  );

  // TODO: Replace with actual iOS values from GoogleService-Info.plist
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBGE53nolXmCIWtRYPlvb_6v0_kF6K8bI4',
    appId: '1:973100933748:ios:0000000000000000',
    messagingSenderId: '973100933748',
    projectId: 'healtether-9b6df',
    storageBucket: 'healtether-9b6df.firebasestorage.app',
    iosBundleId: 'com.healtether.www',
  );

  // TODO: Replace with actual macOS values
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBGE53nolXmCIWtRYPlvb_6v0_kF6K8bI4',
    appId: '1:973100933748:ios:0000000000000000',
    messagingSenderId: '973100933748',
    projectId: 'healtether-9b6df',
    storageBucket: 'healtether-9b6df.firebasestorage.app',
    iosBundleId: 'com.healtether.www',
  );

  // TODO: Replace with actual Windows values
  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBGE53nolXmCIWtRYPlvb_6v0_kF6K8bI4',
    appId: '1:973100933748:web:0000000000000000',
    messagingSenderId: '973100933748',
    projectId: 'healtether-9b6df',
    storageBucket: 'healtether-9b6df.firebasestorage.app',
    authDomain: 'healtether-9b6df.firebaseapp.com',
  );
}
