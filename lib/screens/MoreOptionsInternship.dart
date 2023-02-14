import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MoreOptionsInternship extends StatefulWidget {
  const MoreOptionsInternship({Key? key}) : super(key: key);

  @override
  State<MoreOptionsInternship> createState() => _MoreOptionsInternshipState();
}
class _MoreOptionsInternshipState extends State<MoreOptionsInternship> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('INTERNSHIPS'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        builder: (context, snapShot2) {
          if (snapShot2.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapShot2.hasError) {
            return Center(
              child: Text("${snapShot2.error}"),
            );
          }
          final document = snapShot2.data?.docs;
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final data = document?[index].get("data");
              return Column(
                children: <Widget>[
                  for (int i = 0; i < data.length; i++)
                    data[i]["isVerified"]
                        ? InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return MoreOptionsInternship();
                                },
                              ));
                            },
                            child: Card(
                              elevation: 3.0,
                              color: Colors.white,
                              child: Container(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${data[i]["jobtitle"]}",
                                            style: GoogleFonts.arsenal(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                        thickness: 0.5,
                                      ),
                                      Row(
                                        children: [
                                          Text('Company Name: ',
                                              style: GoogleFonts.arsenal(
                                                fontWeight: FontWeight.w400,
                                              )),
                                          Text(
                                            "${data[i]["Companyname"]}",
                                            style: GoogleFonts.arsenal(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('Location: ',
                                              style: GoogleFonts.arsenal(
                                                fontWeight: FontWeight.w400,
                                              )),
                                          Text(
                                            "${data[i]["Location"]}",
                                            style: GoogleFonts.arsenal(
                                              color: Colors.grey,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                        thickness: 0.5,
                                      ),
                                      Row(
                                        children: [
                                          Text('Job Description:',
                                              style: GoogleFonts.arsenal(
                                                fontWeight: FontWeight.w400,
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${data[i]["jobdescription"]}",
                                            style: GoogleFonts.arsenal(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                        thickness: 0.5,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text('Posted By:',
                                              style: GoogleFonts.arsenal(
                                                color: Colors.black,
                                              )),
                                        ],
                                      ),
                                      StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('users')
                                            .where("type", isEqualTo: "alumni")
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<QuerySnapshot>
                                            snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                              child:
                                              CircularProgressIndicator(),
                                            );
                                          } else {
                                            if (snapshot.hasError) {
                                              return Center(
                                                child:
                                                Text("${snapshot.error}"),
                                              );
                                            } else {
                                              final data = snapshot.data;
                                              if (data != null) {
                                                final allUserDocs = data.docs;
                                                return SizedBox(
                                                  child: ListView(
                                                    shrinkWrap: true,
                                                    children: allUserDocs
                                                        .map((document) {
                                                      return Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            EdgeInsets.all(
                                                                8.0),
                                                            child: Column(
                                                              children: [
                                                                ListTile(
                                                                  onTap: () {},
                                                                  leading:
                                                                  CircleAvatar(
                                                                    radius: 30,
                                                                    child:
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          50),
                                                                      child:
                                                                      CircleAvatar(
                                                                        radius:
                                                                        40,
                                                                        backgroundColor:
                                                                        Colors.white,
                                                                        child:
                                                                        CachedNetworkImage(
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          imageUrl:
                                                                          "${FirebaseAuth.instance.currentUser?.photoURL}",
                                                                          errorWidget: (context,
                                                                              error,
                                                                              stack) {
                                                                            return Icon(
                                                                              Icons.person,
                                                                              size: MediaQuery.of(context).size.width * 0.20,
                                                                            );
                                                                          },
                                                                          placeholder: (context, url) =>
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  iconColor:
                                                                  Colors
                                                                      .black,
                                                                  title: Text(
                                                                      "${document.get("fullName")}",
                                                                      style: GoogleFonts
                                                                          .arsenal(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                        FontWeight.bold,
                                                                      )),
                                                                  subtitle: Text(
                                                                      "${document.get("course")}",
                                                                      style: GoogleFonts
                                                                          .arsenal(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontWeight:
                                                                        FontWeight.w800,
                                                                      )),
                                                                  trailing: Icon(
                                                                      Icons
                                                                          .message_rounded,
                                                                      size: 30,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }).toList(),
                                                  ),
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
                          )
                        : SizedBox(),
                ],
              );
            },
            itemCount: document?.length,
          );
        },
        stream: FirebaseFirestore.instance
            .collection("InternshipsPosted")
            .snapshots(),
      ),
    );
  }
}
