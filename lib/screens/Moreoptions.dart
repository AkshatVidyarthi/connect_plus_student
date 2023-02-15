import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_plus_student/screens/HomeScreen.dart';
import 'package:connect_plus_student/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Moreoptions extends StatefulWidget {
  const Moreoptions({Key? key}) : super(key: key);

  @override
  State<Moreoptions> createState() => _MoreoptionsState();
}

class _MoreoptionsState extends State<Moreoptions> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Are You Sure You Want to Logout"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text('LOGOUT'),
              onPressed: () async {
                Navigator.pop(context);
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }), (route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Material(
              elevation: 2.0,
              color: Colors.white54,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.black, width: 1),
              ),
              child: Container(
                height: 200,
                width: 360,
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.insert_invitation),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Share and Invite',
                            style: GoogleFonts.arsenal(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.deepPurple),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            'Share about your Connect+ Student on social media and help to grow the feedback.',
                            style: GoogleFonts.arsenal(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent),
                      child: const Text('Open form',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => const FeedbackDialog());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Material(
              elevation: 2.0,
              color: Colors.white54,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.black, width: 1),
              ),
              child: Container(
                height: 300,
                width: 360,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.account_circle,
                          color: Colors.deepPurple, size: 35),
                      title: Text('My Profile',
                          style: GoogleFonts.arsenal(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: Text('Akshat Vidyarthi',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      leading: SizedBox(
                        height: 56,
                        width: 56,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl:
                            "${FirebaseAuth.instance.currentUser?.photoURL}",
                            errorWidget: (context, error, stack) {
                              return const Icon(
                                Icons.person,
                                size: 40,
                              );
                            },
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                          ),
                        ),
                      ),
                      subtitle: Text('View And Edit Profile',
                          style: TextStyle(
                            color: Colors.grey,
                          )),
                      onTap: () {},
                    ),
                    ListTile(
                      onTap: () {},
                      title: Text('Add Work Details',
                          style:
                              GoogleFonts.arsenal(fontWeight: FontWeight.bold)),
                      leading: Icon(Icons.work, color: Colors.deepPurple),
                    ),
                    ListTile(
                      onTap: () {
                        showAlertDialog();
                      },
                      title: Text('Logout',
                          style: GoogleFonts.arsenal(
                            fontWeight: FontWeight.bold,
                          )),
                      leading: Icon(Icons.logout, color: Colors.deepPurple),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FeedbackDialog extends StatefulWidget {
  const FeedbackDialog({Key? key}) : super(key: key);

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: _controller,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              hintText: 'Enter your feedback here',
              filled: true,
            ),
            maxLines: 5,
            maxLength: 4096,
            textInputAction: TextInputAction.done,
            validator: (String? text) {
              if (text == null || text.isEmpty) {
                return 'Please enter a value';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('Send'),
            onPressed: () async {
              // Only if the input form is valid (the user has entered text)
              if (_formKey.currentState!.validate()) {
                // We will use this var to show the result
                // of this operation to the user
                String message;

                try {
                  // Get a reference to the `feedback` collection
                  final collection =
                      FirebaseFirestore.instance.collection('feedback');

                  // Write the server's timestamp and the user's feedback
                  await collection.doc().set({
                    'timestamp': FieldValue.serverTimestamp(),
                    'feedback': _controller.text,
                  });

                  message = 'Feedback sent successfully';
                } catch (e) {
                  message = 'Error when sending feedback';
                }

                // Show a snackbar with the result
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message)));
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
    );
  }
}
