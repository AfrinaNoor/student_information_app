import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
            'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
      apiKey: 'AIzaSyA8TD0QkK22zRWFTNlIHRpXBzc_sGrksm4',
      appId: '1:685899998957:android:d085f1f4a39c17eebfcee4',
      messagingSenderId: '685899998957',
      projectId: 'student-registration-app-850ce',
      storageBucket: 'student-registration-app-850ce.firebasestorage.app',
      databaseURL:
      'https://student-registration-app-850ce-default-rtdb.firebaseio.com/');

  static const FirebaseOptions ios = FirebaseOptions(
      apiKey: 'AIzaSyA8TD0QkK22zRWFTNlIHRpXBzc_sGrksm4',
      appId: '1:685899998957:android:d085f1f4a39c17eebfcee4',
      messagingSenderId: '685899998957',
      projectId: 'student-registration-app-850ce',
      storageBucket: 'student-registration-app-850ce.firebasestorage.app',
      iosBundleId: 'com.myapp.firebase_note_app_realtime_db',
      databaseURL:
      'https://student-registration-app-850ce-default-rtdb.firebaseio.com/');
}