import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_plus_student/screens/MoreOptionsInternship.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Members extends StatefulWidget {
  const Members({Key? key}) : super(key: key);

  @override
  State<Members> createState() => _MembersState();
}
class _MembersState extends State<Members> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
      FirebaseFirestore.instance.collection('users').where("type",isEqualTo: "alumni").snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot) {
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
              final allUserDocs = data.docs;
              return ListView(
                children: allUserDocs.map((document) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 8.0,
                          child: Column(
                            children: [
                              ListTile(
                                onTap: (){},
                                leading: CircleAvatar(
                                  radius: 30,
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(50),
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.white,
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl:
                                        "${FirebaseAuth.instance.currentUser?.photoURL}",
                                        errorWidget: (context, error, stack) {
                                          return Icon(Icons.person,
                                            size: MediaQuery.of(context).size.width *0.20  ,);
                                        },
                                        placeholder: (context, url) => CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                ),
                                  iconColor: Colors.black,
                                title:  Text("${document.get("fullName")}",style: GoogleFonts.arsenal(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                                subtitle: Text("${document.get("course")}",style: GoogleFonts.arsenal(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w800,
                                )),
                                trailing:Icon(Icons.message_rounded,size: 30,
                                    color: Colors.black),
                              ),



                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              );
            }
            else {
              return Center(
                child: Text("Data not found"),
              );
            }
          }
        }
      },
    );
  }
}
