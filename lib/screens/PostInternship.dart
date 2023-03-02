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
  String? _Location;
  String? _Email;
  String? _Describe;
  File? file;
  String? selectstipend;
  String? duration;
  var selectedstipend=[
    "1000-3000",
    "3000-5000",
    "5000-8000",
    "Above 8000",
    "Not Defined",
  ];
  var time=[
         "1 week",
         "45 days",
         "2 week",
         "3 week",
        "1 month",
        "2 month",
        "3 month",
        "4 month",
        "5 month",
        "6 month",
        "7 month",
        "8 month",
        "9 month",
        "10 month",
        "11 month",
        "12 month",
  ];

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
              Padding(padding: EdgeInsets.all(16.0),
                child: DropdownButtonFormField
                  (
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: selectedstipend
                      .map((e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectstipend = val;
                    });
                  },
                  value: selectstipend,
                  hint: Text("select package"),
                ),
              ),
              Padding(padding: EdgeInsets.all(16.0),
                child: DropdownButtonFormField
                  (
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: time
                      .map((e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      duration = val;
                    });
                  },
                  value: duration,
                  hint: Text("select time duration"),
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
                    style: GoogleFonts.arsenal(fontWeight: FontWeight.bold),
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
                            saveData(internshipId, null, userId);
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
        .collection("PostedInternships")
        .doc()
        .set({
          "Companyname": _CompanyName,
          "jobtitle": _Title,
          "Location": _Location,
          "email": _Email,
          "jobdescription": _Describe,
          "isVerified": false,
          "attachment": url,
          "postedBy": FirebaseAuth.instance.currentUser?.uid,
          "time": DateTime.now().toUtc(),
          "stipend":selectstipend,
           "duration":duration,
        })
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
