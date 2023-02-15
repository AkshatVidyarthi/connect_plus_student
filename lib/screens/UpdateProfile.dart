import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class updateprofile extends StatefulWidget {
  const updateprofile({Key? key}) : super(key: key);

  @override
  State<updateprofile> createState() => _updateprofileState();
}

class _updateprofileState extends State<updateprofile> {
  final ImagePicker _picker = ImagePicker();

  final emailController =
      TextEditingController(text: FirebaseAuth.instance.currentUser?.email);
  final mobileController = TextEditingController(
      text: FirebaseAuth.instance.currentUser?.phoneNumber);
  final otpController = TextEditingController();

  bool isOTPSend = false;

  String verificationID = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text('Update Profile',
            style: GoogleFonts.arsenal(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              wordSpacing: 1.0,
            )),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl:
                          "${FirebaseAuth.instance.currentUser?.photoURL}",
                      errorWidget: (context, error, stack) {
                        return Icon(
                          Icons.person,
                          size: MediaQuery.of(context).size.width * 0.20,
                        );
                      },
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
            ),
            Text(
              'Akshat Vidyarthi',
              style: GoogleFonts.arsenal(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'BCA',
              style: GoogleFonts.arsenal(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    final XFile? image =
                                        await _picker.pickImage(
                                      source: ImageSource.camera,
                                      maxHeight: 500,
                                      maxWidth: 500,
                                      imageQuality: 50,
                                    );
                                    if (image != null) {
                                      uploadProfile(image);
                                    }
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.camera),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    final XFile? image =
                                        await _picker.pickImage(
                                      source: ImageSource.gallery,
                                      maxHeight: 500,
                                      maxWidth: 500,
                                      imageQuality: 50,
                                    );
                                    if (image != null) {
                                      uploadProfile(image);
                                    }
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.image),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 95,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: <Widget>[
                          const Icon(Icons.person),
                          const Text(
                            'Change Picture',
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onDoubleTap: () {},
                  child: Container(
                    width: 95,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: <Widget>[
                          const Icon(Icons.work),
                          const Text(
                            'Add Work',
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onDoubleTap: () {},
                  child: Container(
                    width: 95,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: <Widget>[
                          const Icon(Icons.location_on_rounded),
                          const Text(
                            'Update Location',
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            /*const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Education Details',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Material(
              elevation: 5.0,
              color: Colors.white70,
              child: SizedBox(
                height: 80,
                width: 320,
                child: Column(
                  children: [
                    const ListTile(
                      title: Text('National P.G. College',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: FittedBox(
                        child: Text('Bachelors Of Computer Applications(B.C.A)'
                            '\n'
                            '2023'),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Personal Information',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Material(
              elevation: 5.0,
              color: Colors.white70,
              child: SizedBox(
                height: 30,
                width: 320,
                child: Column(
                  children: [
                    const Text('No Personal Information Found For this User.'),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Contact Details',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),*/
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Contact Details',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ),
            Card(
              elevation: 5.0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Please Enter Your Email"),
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: updateEmail,
                          child: const Text("Update Email"))
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: mobileController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Please Enter Your Phone Number"),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: isOTPSend ? null : updateMobile,
                        child: const Text("Update Mobile"),
                      )
                    ],
                  ),
                  isOTPSend
                      ? Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: TextField(
                                  controller: otpController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                          "Please Enter Your Phone Number"),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: verifyMobile,
                              child: const Text("Verify"),
                            )
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void uploadProfile(XFile image) async {
    final user = FirebaseAuth.instance.currentUser;
    final ref = FirebaseStorage.instance.ref("profilePhotos/${user?.uid}");
    final uploadTask = ref.putFile(File(image.path));
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
          user?.updatePhotoURL(url);
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user?.uid)
              .set({
            "photo": url,
          }, SetOptions(merge: true));

          //ref.getDownloadURL();
          // Handle successful uploads on complete
          // ...
          break;
      }
    });
  }

  void updateEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (emailController.text.contains(".") &&
          emailController.text.contains("@")) {
        await user.updateEmail(emailController.text);
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .set({
              "email": emailController.text,
            }, SetOptions(merge: true))
            .onError(
              (error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("$error"),
                ),
              ),
            )
            .then(
              (value) => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Update Success"),
                ),
              ),
            );
      }
    }
  }

  void updateMobile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+${mobileController.text}",
        verificationCompleted: (cred) async {
          await FirebaseAuth.instance.currentUser?.updatePhoneNumber(cred);
        },
        verificationFailed: (error) {},
        codeSent: (String id, int? token) {
          verificationID = id;
          setState(() {
            isOTPSend = true;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }

  void verifyMobile() async {
    final user = FirebaseAuth.instance.currentUser;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await FirebaseAuth.instance.currentUser?.updatePhoneNumber(credential);

    if (user != null) {
      await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        "phone": mobileController.text,
      }, SetOptions(merge: true)).then((value) {
        isOTPSend = false;
        setState(() {});
      });
    }
  }
}
