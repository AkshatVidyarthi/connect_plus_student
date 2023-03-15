import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_plus_student/screens/Confirmation_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Aluminidetails extends StatefulWidget {
  const Aluminidetails({Key? key}) : super(key: key);

  @override
  State<Aluminidetails> createState() => _AluminidetailsState();
}


class _AluminidetailsState  extends State<Aluminidetails> {

  String? _fullName;
  String? _passingYear;
  String? _course;
  String? _stream;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          'Alumini Registration',
          style: GoogleFonts.arsenal(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              wordSpacing: 2.0,
              letterSpacing: 1.0),
        ),
        surfaceTintColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset('Assets/connect-student-logo-removebg-preview.png',
                  height: 150),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  onSaved: (value) {
                    _fullName = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full Name',
                    hintText: 'Enter Full Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Your Full name";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(

                  onSaved: (value) {
                    _stream = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Stream',
                    hintText: 'Enter your Stream',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Your Stream";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  onSaved: (value) {
                    _course = value;
                  },

                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your Course',
                    hintText: 'Enter your Course',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Your Course";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(

                  onSaved: (value) {
                    _passingYear = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Passing Year',
                    hintText: 'Year of Passing',

                  ),

                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly

                  ],
                  maxLength: 4,


                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Your Passing Year";
                    }
                    else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent),
                    onPressed: () async {
                      _formKey.currentState?.save();
                      if (_formKey.currentState?.validate() ?? false) {
                        final user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(user.uid)
                              .set({
                            "fullName": _fullName,
                             "stream":_stream,
                            "passingYear": _passingYear,
                            "course": _course,
                            "isVerified":false,
                            "type": "alumni",
                            "photo":"${user.photoURL}",
                            "email":"${user.email}",
                            "phone":"${user.phoneNumber}",
                          }).onError((error, stackTrace) =>
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                  Text("${error}"),
                                ),
                              ))
                              .then((value) {
                            FirebaseAuth.instance.currentUser?.updateDisplayName(_fullName);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const ConfirmationScreen();
                                },
                              ),
                                  (route) => false,
                            );
                          });
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: double.infinity,
                          child: Center(
                              child: Text(
                                'Submit',
                                style: GoogleFonts.arsenal(
                                    fontWeight: FontWeight.bold),
                              )
                          )
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

