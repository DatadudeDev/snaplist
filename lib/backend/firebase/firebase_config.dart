import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBPVToppiZzfyA2vfStefeLtcYnHEoT3AY",
            authDomain: "store-e9omk8.firebaseapp.com",
            projectId: "store-e9omk8",
            storageBucket: "store-e9omk8.appspot.com",
            messagingSenderId: "893777894200",
            appId: "1:893777894200:web:a01b94a1e8fbc000be7fcd"));
  } else {
    await Firebase.initializeApp();
  }
}
