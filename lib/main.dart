import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_lesson/splash_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyA6GXXynNlBhsoMPdNHX-ateU7tFwQ3H8U",
            authDomain: "fir-apps-580af.firebaseapp.com",
            databaseURL: "https://fir-apps-580af-default-rtdb.firebaseio.com",
            projectId: "fir-apps-580af",
            storageBucket: "fir-apps-580af.firebasestorage.app",
            messagingSenderId: "269429948474",
            appId: "1:269429948474:web:f698b51ab8d8d0b2577503"));
  } else {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyB7IuQPTgjee6TQYfDUSkG8J3PsHyD503M",
            appId: "1:269429948474:android:7de3eeb8beaddbae577503",
            messagingSenderId: "",
            projectId: "fir-apps-580af",
            storageBucket: "fir-apps-580af.firebasestorage.app"));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashPage(),
    );
  }
}
