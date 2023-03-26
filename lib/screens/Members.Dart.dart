import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_plus_student/screens/MoreOptionsInternship.dart';
import 'package:connect_plus_student/screens/single_communication_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Members extends StatefulWidget {
  /*final Map<String, dynamic> data;
  final String? id;*/

  const Members(/*this.data, this.id, */ {Key? key}) : super(key: key);

  @override
  State<Members> createState() => _MembersState();
}

class _MembersState extends State<Members> {
  DateTimeRange? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [

      StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where("type", isEqualTo: "alumni")
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
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
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final userData = data.docs[index];

                    return FirebaseAuth.instance.currentUser?.uid != userData.id
                        ? ListTile(
                            onTap: () async {
                              await createOneToOneChatChannel(
                                  FirebaseAuth.instance.currentUser?.uid,
                                  data.docs[index].id);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SingleCommunicationPage(
                                  FirebaseAuth.instance.currentUser?.uid,
                                  data.docs[index].id,
                                  recipientName: "${userData.get("fullName")}",
                                  photo: "${userData.get("photo")}",
                                  senderUID:
                                      FirebaseAuth.instance.currentUser?.uid,
                                  recipientUID: data.docs[index].id,
                                );
                              }));
                            },
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
                                        size:
                                            MediaQuery.of(context).size.width *
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
                          )
                        : SizedBox();
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
      )
    ]);
  }

  Future<void> createOneToOneChatChannel(String? uid, String? otherUid) async {
    final userCollectionRef = FirebaseFirestore.instance.collection("users");
    final oneToOneChatChannelRef =
        FirebaseFirestore.instance.collection('myChatChannel');

    userCollectionRef
        .doc(uid)
        .collection('engagedChatChannel')
        .doc(otherUid)
        .get()
        .then((chatChannelDoc) {
      if (chatChannelDoc.exists) {
        return;
      }
      //if not exists
      final chatChannelId = oneToOneChatChannelRef.doc().id;
      var channelMap = {
        "channelId": chatChannelId,
        "channelType": "oneToOneChat",
      };
      oneToOneChatChannelRef.doc(chatChannelId).set(channelMap);

      //currentUser
      userCollectionRef
          .doc(uid)
          .collection("engagedChatChannel")
          .doc(otherUid)
          .set(channelMap);

      //OtherUser
      userCollectionRef
          .doc(otherUid)
          .collection("engagedChatChannel")
          .doc(uid)
          .set(channelMap);

      return;
    });
  }
}
