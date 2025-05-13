// File: lib/firebase_options.dart

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyDhDyDWubGLY7zBQf85REt8w9aoo6fiIN4",
    authDomain: "the-diet-and-wellness-app.firebaseapp.com",
    projectId: "the-diet-and-wellness-app",
    storageBucket: "the-diet-and-wellness-app.firebasestorage.app",
    messagingSenderId: "71058652675",
    appId: "1:71058652675:web:168c65cde47b0660ea1836",
    measurementId: null, // Add if you have one
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyDhDyDWubGLY7zBQf85REt8w9aoo6fiIN4",
    appId: "1:71058652675:web:168c65cde47b0660ea1836",
    messagingSenderId: "71058652675",
    projectId: "the-diet-and-wellness-app",
    storageBucket: "the-diet-and-wellness-app.firebasestorage.app",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyDhDyDWubGLY7zBQf85REt8w9aoo6fiIN4",
    appId: "1:71058652675:web:168c65cde47b0660ea1836",
    messagingSenderId: "71058652675",
    projectId: "the-diet-and-wellness-app",
    storageBucket: "the-diet-and-wellness-app.firebasestorage.app",
    iosClientId: null, // Add if you have one
    iosBundleId: null, // Add if you have one
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: "AIzaSyDhDyDWubGLY7zBQf85REt8w9aoo6fiIN4",
    appId: "1:71058652675:web:168c65cde47b0660ea1836",
    messagingSenderId: "71058652675",
    projectId: "the-diet-and-wellness-app",
    storageBucket: "the-diet-and-wellness-app.firebasestorage.app",
    iosClientId: null, // Add if you have one
    iosBundleId: null, // Add if you have one
  );
}
