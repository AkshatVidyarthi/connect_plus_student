import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_plus_student/screens/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class PostInternships extends StatefulWidget {
  const PostInternships({Key? key}) : super(key: key);
  @override
  State<PostInternships> createState() => _PostInternshipsState();
}
class _PostInternshipsState extends State<PostInternships> {
  final _formKey = GlobalKey<FormState>();
  String? _CompanyName;
  String? _Title;
  String? _Duration;
  String? _Location;
  String? _Email;
  String? _Describe;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('POST INTERNSHIPS'),
      ),
//body
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
                    _CompanyName = value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Company Name',
                    hintText: 'Enter Company Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Company Name";
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
                    _Title = value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                    hintText: 'Enter the Title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Your Title";
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
                    _Location = value;
                  },

                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Location',
                    hintText: 'Enter Job Location',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Location";
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
                    _Email = value;
                  },

                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Email',
                    hintText: 'Please Enter Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Your Email";
                    }
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return "Please enter a valid email address";
                    }
                    else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  onSaved: (value) {
                    _Describe= value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Internship Description',
                    hintText: 'Enter Internship Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Information About the Internship";
                    } else {
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
                              .collection("INTERNSHIPS POSTED")
                              .doc(user.uid)
                              .set({
                            "Companyname": _CompanyName,
                            "jobtitle":_Title,
                            "Location":_Location,
                            "email": _Email,
                            "jobdescription":_Describe,
                            "isVerified": false,
                          })
                              .onError((error, stackTrace) =>
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("${error}"),
                                ),
                              ))
                              .then((value) => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomeScreen();
                              },
                            ),
                                (route) => false,
                          ));
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
                              ))),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
