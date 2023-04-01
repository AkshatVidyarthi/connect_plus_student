import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_plus_student/screens/Confirmation_Screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  String? _id;
  File? file;

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
                    _id = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                    ),
                    labelText: 'ID',
                    hintText: 'Enter your ID',
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Your ID";
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

              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent),
                  onPressed: () async {
                    FilePickerResult? result =
                    await FilePicker.platform.pickFiles();
                    if (result != null) {
                      file = File("${result.files.single.path}");
                      setState(() {});
                    }
                  },
                  child: Text(
                    'Upload Job Description',
                    style: GoogleFonts.arsenal(
                        fontWeight: FontWeight.bold),
                  )),
              file != null
                  ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(child: Text("${file?.path
                        .split("/")
                        .last}")),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        file = null;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              )
                  : SizedBox(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent),
                    onPressed: () async {
                      _formKey.currentState?.save();
                      if (_formKey.currentState?.validate() ?? false) {
                        final user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          final jobId =
                          DateTime
                              .now()
                              .millisecond
                              .toString();
                          final userId = user.uid;
                          if (file != null) {
                            uploadProfile(jobId, userId);
                          } else {
                            saveData(jobId, null, userId);
                          }
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

              /*Padding(
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
                            "id":_id,
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
              ),*/
            ],
          ),
        ),
      ),
    );
  }
  void uploadProfile(String id, String userId) async {
    final ref = FirebaseStorage.instance.ref("Marksheets/$id");
    final uploadTask = ref.putFile(file!);
    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          Text("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          Text("Upload is paused.");
          break;
        case TaskState.canceled:
          Text("Upload was canceled");
          break;
        case TaskState.error:
          Text("Upload was error");
          // Handle unsuccessful uploads
          break;
        case TaskState.success:
          final url = await ref.getDownloadURL();
          Text("Upload was success $url");
          saveData(id, url, userId);
          break;
      }
    });
  }
  void saveData(String id, String? url, String userId) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc()
        .set({
      "fullName": _fullName,
      "stream":_stream,
      "passingYear": _passingYear,
      "course": _course,
      "id":_id,
      "isVerified":false,
      "type": "alumni",
      "attachment":url,
      "time": DateTime.now().toUtc(),
    })
        .onError(
            (error, stackTrace) =>
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("$error"),
              ),
            ))
        .then((value) {
      FirebaseAuth.instance.currentUser?.updateDisplayName(_fullName);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User posted Successfully"),
        ),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ConfirmationScreen();
          },
        ),
            (route) => false,
      );
    });
  }
}


