import 'dart:async';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}
class SplashScreenState extends State<Splash> {
  @override
  void initState() {

    super.initState();
    Timer(Duration(seconds: 10),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => Splash(),
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child:const Center(
          child:  CircleAvatar(
            maxRadius: 150,
            backgroundImage: AssetImage('connect-student-logo-removebg-preview.png'),
          ),
        )
    );
  }
}