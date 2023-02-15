import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MoreJobsOptions extends StatelessWidget {
  final Map<String, dynamic> data;
  final String? id;

  const MoreJobsOptions(this.data, this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VIEW JOBS'),
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
              Row(
                children: [
                  Text(
                    "${data["jobtitle"]}",
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
              RichText(
                text: TextSpan(
                    text: "Company Name: ",
                    style: GoogleFonts.arsenal(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: "${data["Companyname"]}",
                        style: GoogleFonts.arsenal(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ]),
              ),
              Row(
                children: [
                  Text('Location: ',
                      style: GoogleFonts.arsenal(
                        fontWeight: FontWeight.w400,
                      )),
                  Text(
                    "${data["Location"]}",
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
              Text('Minimum Experience:',
                  style: GoogleFonts.arsenal(
                    fontWeight: FontWeight.w400,
                  )),
              SizedBox(
                height: 5,
              ),
              Text(
                "${data["maxexp"]}",
                style: GoogleFonts.arsenal(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Minimum Experience',
                  style: GoogleFonts.arsenal(
                    fontWeight: FontWeight.w400,
                  )),
              SizedBox(
                height: 5,
              ),
              Text(
                "${data["minexp"]}",
                style: GoogleFonts.arsenal(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Posted By:',
                style: GoogleFonts.arsenal(
                  color: Colors.black,
                ),
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
              data["attachment"] != null ||
                      data["attachment"].toString().toLowerCase() != "null"
                  ? IconButton(
                      onPressed: () async {
                        final url = data["attachment"];
                        if (await canLaunchUrlString(url)) {
                          launchUrlString(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      },
                      icon: Icon(Icons.download))
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
