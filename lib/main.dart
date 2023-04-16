import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_let_go/authentication/authentication_controller.dart';
import 'package:to_let_go/on_boarding/splash_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDikBiL3WFhIicn0YtRoQl3T12IILuXzCA",
        authDomain: "to-let-go-4112b.firebaseapp.com",
        projectId: "to-let-go-4112b",
        storageBucket: "to-let-go-4112b.appspot.com",
        messagingSenderId: "467804634898",
        appId: "1:467804634898:web:0d1f4f33b43139cf22bdcb",
        measurementId: "G-L6DMCM8YZN",
      ),
    ).then((value) {
      Get.put(AuthenticationController());
    });
  } else {
    await Firebase.initializeApp().then((value) {
      Get.put(AuthenticationController());
    });
  }


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'To Let Go',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const SplashScreen(),
    );
  }
}

// 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