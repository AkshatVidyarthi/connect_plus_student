import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_plus_student/screens/dashboard_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  File? file;
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
                    _Describe = value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Internship Description',
                    hintText: 'Enter Internship Description',
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Information About the Internship";
                    } else {
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
                    'Upload File',
                    style: GoogleFonts.arsenal(
                        fontWeight: FontWeight.bold),
                  )),
              file != null
                  ? Row(
                      children: [
                        Expanded(child: Text("${file?.path.split("/").last}")),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            file = null;
                            setState(() {});
                          },
                        ),
                      ],
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
                          final internshipId =
                              DateTime.now().millisecond.toString();
                          final userId = user.uid;
                          if (file != null) {
                            uploadProfile(internshipId, userId);
                          } else {
                            saveData(internshipId, "", userId);
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
            ],
          ),
        ),
      ),
    );
  }

  void uploadProfile(String id, String userId) async {
    final ref = FirebaseStorage.instance.ref("internshipJDs/$id");
    final uploadTask = ref.putFile(file!);
    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          print("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          print("Upload is paused.");
          break;
        case TaskState.canceled:
          print("Upload was canceled");
          break;
        case TaskState.error:
          print("Upload was error");
          // Handle unsuccessful uploads
          break;
        case TaskState.success:
          final url = await ref.getDownloadURL();
          print("Upload was success $url");
          saveData(id, url, userId);
          break;
      }
    });
  }

  void saveData(String id, String url, String userId) async {
    await FirebaseFirestore.instance
        .collection("InternshipsPosted")
        .doc(userId)
        .set({
          "data": FieldValue.arrayUnion([
            {
              "id": id,
              "Companyname": _CompanyName,
              "jobtitle": _Title,
              "Location": _Location,
              "email": _Email,
              "jobdescription": _Describe,
              "isVerified": false,
              "attachment": url,
            }
          ])
        }, SetOptions(merge: true))
        .onError(
            (error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("$error"),
                  ),
                ))
        .then((value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DashBoardScreen();
                },
              ),
              (route) => false,
            ));






  }
}
