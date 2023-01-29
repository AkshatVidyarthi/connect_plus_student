import 'package:connect_plus_student/screens/Alumini_details.dart';
import 'package:connect_plus_student/screens/Student_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login_options extends StatefulWidget {
  const Login_options({Key? key}) : super(key: key);

  @override
  State<Login_options> createState() => _Login_optionsState();
}

class _Login_optionsState extends State<Login_options> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.08,
              child: Image.asset("Assets/login.png"),
            ),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 80,
              child: Image.asset('Assets/connect-student-logo.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border:
                    Border.all(color: Colors.deepPurpleAccent, width: 3),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: ListTile(
                  title: Center(
                      child: Text('Student?',
                          style: GoogleFonts.poppins(fontSize: 20))),
                  leading: Image.network(
                      'https://cdn-icons-png.flaticon.com/512/201/201818.png'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const StudentDetails();
                      },
                    ));
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54, width: 3),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: ListTile(
                  title: Center(
                      child: Text('Alumini?',
                          style: GoogleFonts.poppins(fontSize: 20))),
                  leading: Image.network(
                      'https://media.istockphoto.com/id/871028402/vector/bachelor-cap-icon.jpg?s=612x612&w=0&k=20&c=Q65yCIOlUsIonlNMh2uam9n0wrBldcMcOAETFvjR4Rw='),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const Aluminidetails();
                      },
                    ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
