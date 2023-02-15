import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_plus_student/screens/MoreOptionsInternship.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Members extends StatelessWidget {
  final Map<String, dynamic> data;
  final String? id;

  const Members(this.data, this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('Members'),
      ),
      body: Card(
        elevation: 3.0,
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(id)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                    snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("${snapshot.error}"),
                      );
                    } else {
                      final data = snapshot.data;
                      if (data != null) {
                        final userData = data;
                        return ListTile(
                          onTap: () {},
                          leading: CircleAvatar(
                            radius: 30,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                child: FutureBuilder(
                                    future: FirebaseStorage.instance
                                        .ref("profilePhotos")
                                        .child("$id")
                                        .getDownloadURL(),
                                    builder: (context, snapshot) {
                                      return CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl: "${snapshot.data}",
                                        errorWidget: (context, error, stack) {
                                          return Icon(
                                            Icons.person,
                                            size: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.20,
                                          );
                                        },
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                      );
                                    }),
                              ),
                            ),
                          ),
                          iconColor: Colors.black,
                          title: Text("${userData.get("fullName")}",
                              style: GoogleFonts.arsenal(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Text("${userData.get("course")}",
                              style: GoogleFonts.arsenal(
                                color: Colors.grey,
                                fontWeight: FontWeight.w800,
                              )),
                          trailing: Icon(Icons.message_rounded,
                              size: 30, color: Colors.black),
                        );
                      } else {
                        return Center(
                          child: Text("Data not found"),
                        );
                      }
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
