import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_plus_student/screens/dashboard_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';


class PostJob extends StatefulWidget {
  const PostJob({Key? key}) : super(key: key);

  @override
  State<PostJob> createState() => _PostJobState();
}

class _PostJobState extends State<PostJob> {

  var selectedsalary = [
    "below 100,000",
    "100,000-200,000",
    "200,000-300,000",
    "300,000-400,000",
    "400,000-500,000",
    "Above 500,000",
    "not defined",
  ];
  String? selectsal;
  String? _CompanyName;
  String? _Title;
  String? _MinEx;
  String? _MaxEx;
  String? _Location;
  String? _Email;
  String? _Describe;
  String? _Qualify;
  File? file;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: Colors.deepPurpleAccent[100],
        title: Text('POST JOB', style: GoogleFonts.arsenal(
          fontWeight: FontWeight.bold,
        )),
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
                    _MinEx = value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Minimum Experience',
                    hintText: 'Minimum Experience(years)',
                  ),
                  maxLength: 1,
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
                    _MaxEx = value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Maximum  Experience',
                    hintText: 'Minimum Experience(years)',
                  ),
                  maxLength: 1,
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
                    labelText: 'Job Description',
                    hintText: 'Enter Job Description',
                  ),
                  maxLines: 5,
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
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  onSaved: (value) {
                    _Qualify = value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Job Qualification',
                    hintText: 'Enter Job Qualification',
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Information About the Qualification";
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
                  items: selectedsalary
                      .map((e) =>
                      DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectsal = val;
                    });
                  },
                  value: selectsal,
                  hint: Text("select package"),
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
            ],
          ),
        ),
      ),
    );
  }

  void uploadProfile(String id, String userId) async {
    final ref = FirebaseStorage.instance.ref("JobJDs/$id");
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
        .collection("PostedJobs")
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
      "maxexp": _MaxEx,
      "minexp": _MinEx,
      "qualification": _Qualify,
      "selectedsalary": selectsal,
    })
        .onError(
            (error, stackTrace) =>
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("$error"),
              ),
            ))
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Job posted Successfully"),
        ),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return DashBoardScreen();
          },
        ),
            (route) => false,
      );
    });
  }
}