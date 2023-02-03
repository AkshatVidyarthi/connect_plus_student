import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_plus_student/screens/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
class PostJob extends StatefulWidget {
  const PostJob({Key? key}) : super(key: key);

  @override
  State<PostJob> createState() => _PostJobState();
}

class _PostJobState extends State<PostJob> {
  String? _CompanyName;
  String? _Title;
  String? _MinExp;
  String? _MaxExp;
  String? _Location;
  String? _Email;
  String? _JobDescribe;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('POST JOB'),

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
                    labelText: 'Job Title',
                    hintText: 'Enter the Job Title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Your Job Title";
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
                    _MinExp = value;
                  },

                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Minimum Experience',
                    hintText: 'Minimum Experience(years)',
                  ),
                  maxLength: 4,
                  inputFormatters: <TextInputFormatter>[
                   FilteringTextInputFormatter.digitsOnly
                  ],

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Minimum Years";
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
                    _MaxExp = value;
                  },

                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Maximum  Experience',
                    hintText: 'Minimum Experience(years)',
                  ),
                  maxLength: 4,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Maximum Years";
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
                     _JobDescribe= value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Job Description',
                    hintText: 'Enter Job Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Information About the Job";
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
                              .collection("JOB POSTED")
                              .doc(user.uid)
                              .set({
                            "data":[
                              {
                                "Companyname": _CompanyName,
                                "jobtitle":_Title,
                                "minexp":_MinExp,
                                "maxexp":_MaxExp,
                                "Location":_Location,
                                "email": _Email,
                                "jobdescription":_JobDescribe,
                                "isVerified": false,
                              }
                            ]
                          },SetOptions(merge: true))
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
                                return  HomeScreen();
                              },
                            ),
                                (route) => false,
                          ));
                        }
                      }
                    },
                    //child is this
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      //this is the child
                      child: Container(
                        //width
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
