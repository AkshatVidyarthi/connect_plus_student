
import 'package:connect_plus_student/screens/HomeScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        title: Text('Confirmation Screen',style: GoogleFonts.alegreyaSans(fontSize: 25,fontWeight: FontWeight.bold,)),
      ),
      body: Column(
        children: [
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Congratulations,you have submitted your Membership Request!',style: GoogleFonts.alegreyaSans(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          Image.asset('Assets/confirmation.jpg'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Click On Get Started to explore the features of the App and how to Stay Connected.',style: GoogleFonts.alegreyaSans(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.deepPurple)),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(

                style: ElevatedButton.styleFrom(

                  backgroundColor: Colors.black,

                ),

                  onPressed: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                    return HomeScreen();
                  },), (route) => false);

                  }, child: Text('Lets Get Started',style: TextStyle(color: Colors.purpleAccent),)),
            ),
          ),

        ],
      ),
    );
  }
}
