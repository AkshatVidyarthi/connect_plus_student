import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_plus_student/screens/Alumini_details.dart';
import 'package:connect_plus_student/screens/Confirmation_Screen.dart';
import 'package:connect_plus_student/screens/HomeScreen.dart';
import 'package:connect_plus_student/screens/Student_details.dart';
import 'package:connect_plus_student/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

bool isStudent = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final Widget firstScreen = await checkUserVerification();
  runApp(MyApp(firstScreen));
}

Future<Widget> checkUserVerification() async {
  final data = await FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .get();
  if (!data.exists) {
    return const LoginScreen();
  } else {
    if (data.get("type") == "student") {
      isStudent = true;
    } else {
      isStudent = false;
    }
    if (data.get("isVerified")) {
      return HomeScreen();
    } else {
      return const ConfirmationScreen();
    }
  }
}

class MyApp extends StatelessWidget {
  final Widget firstScreen;

  const MyApp(this.firstScreen, {super.key});

  @override
  //WIDGET
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Connect Plus Student',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      //it will go according to the screen
      home: firstScreen,
      //SQSKO
      // home:FirebaseAuth.instance.currentUser != null ? ConfirmationScreen():LoginScreen(),
    );
  }
}
