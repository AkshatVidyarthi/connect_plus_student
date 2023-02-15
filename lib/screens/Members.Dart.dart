import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_plus_student/screens/MoreOptionsInternship.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Members extends StatelessWidget {
  /*final Map<String, dynamic> data;
  final String? id;*/

  const Members(/*this.data, this.id, */ {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where("type", isEqualTo: "alumni")
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
          snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
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
              return ListView.builder(
                itemBuilder: (context, index) {
                  final userData = data.docs[index];
                  return ListTile(
                    onTap: () {},
                    leading: CircleAvatar(
                      radius: 30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: "${userData.get("photo")}",
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
                            const CircularProgressIndicator(),
                          ),
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
                    trailing: const Icon(Icons.message_rounded,
                        size: 30, color: Colors.black),
                  );
                },
                itemCount: data.docs.length,
              );
            } else {
              return const Center(
                child: Text("Data not found"),
              );
            }
          }
        }
      },
    );
  }
}
