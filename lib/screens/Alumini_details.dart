import 'package:connect_plus_student/screens/Confirmation_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Aluminidetails extends StatefulWidget {
  const Aluminidetails({Key? key}) : super(key: key);

  @override
  State<Aluminidetails> createState() => _AluminidetailsState();
}

class _AluminidetailsState extends State<Aluminidetails> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text('Alumini Registration',style:GoogleFonts.arsenal(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold,wordSpacing: 2.0,letterSpacing: 1.0) ),
        surfaceTintColor: Colors.black,
      ),
      body: Card(
         elevation: 0.0,
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset('Assets/connect-student-logo-removebg-preview.png',height: 150),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                      ),
                        labelText: 'First Name',
                      hintText: 'Enter First Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                      ),
                      labelText: 'Stream',
                      hintText: 'Stream Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                      ),
                      labelText: 'Passing Year',
                      hintText: 'Year of Passing',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                      ),
                      labelText: 'Course Enrolled',
                      hintText: 'Enrolled Course',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                      ),
                      labelText: 'Upload Marksheet',
                      hintText: 'Upload Marksheet',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent),
                      onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return ConfirmationScreen();
                      },));
                      },
                      child: Container
                        (
                        width: double.infinity,
                          child: Center(child: Text('Submit',style: GoogleFonts.arsenal(fontWeight: FontWeight.bold),)))),
                ),
              ],
            ),
          )


          ),
        ),
      );

  }
}
