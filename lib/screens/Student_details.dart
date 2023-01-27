import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_plus_student/screens/Confirmation_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({Key? key}) : super(key: key);

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  final _coursesList = [
    'B.COM',
    'BBA',
    'BA',
    'BCA',
    'BVOC',
    'MVOC',
    'B.COM(H)',
    'BBA(MS)'
  ];
  String? _selectedCourse;
  String? _fullName;
  String? _id;
  String? _passingYear;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          'Student Registration',
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
                    _id = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Id',
                    hintText: 'Enter your ID number',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Your Id";
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Your Passing Year";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              /* Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                          ),
                          labelText: 'Course Enrolled',
                          hintText: 'Enrolled Course',
                        ),
                      ),
                    ),*/
              Text('Enter Your Course',
                  style: GoogleFonts.arsenal(
                      fontWeight: FontWeight.bold, fontSize: 20)),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DropdownButton(
                  hint: Text('Select Course'),
                  value: _selectedCourse,
                  items: _coursesList
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedCourse = val;
                    });
                  },
                ),
              ),
              /*DropdownButtonFormField(
                      value: selval,
                      items: courseslist
                          .map((e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          selval = val;
                        });
                      },
                      icon: Icon(Icons.select_all_sharp),
                      iconSize: 30,
                    ),*/

              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent),
                    onPressed: () async {
                      _formKey.currentState?.save();
                      if (_formKey.currentState?.validate() ?? false) {
                        if (_selectedCourse == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please Select Your Course"),
                            ),
                          );
                          return;
                        }
                        final user = FirebaseAuth.instance.currentUser;
                        if (user != null) {

                          await FirebaseFirestore.instance
                              .collection("studentData")
                              .doc(user.uid)
                              .set({
                                "fullName": _fullName,
                                "id": _id,
                                "passingYear": _passingYear,
                                "course": _selectedCourse,
                              })
                              .onError((error, stackTrace) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text("${error}"),
                                    ),
                                  ))
                              .then((value) =>
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return ConfirmationScreen();
                                    },
                                  )));
                        }
                      }

                      /**/
                      /**/
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
