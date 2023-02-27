import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_plus_student/screens/single_communication_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../entity/my_chat_entity.dart';
import '../model/my_chat_model.dart';
class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);
  @override
  State<Messages> createState() => _MessagesState();
}
class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<MyChatEntity>>(
        stream: getMyChat(),
        builder: (BuildContext context,
            AsyncSnapshot<List<MyChatEntity>>
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
                final myChat = data;
              return  ListView.builder(
                  itemCount: myChat.length,
                  itemBuilder: (_, index) {
                    final chat = myChat[index];
                    print("${FirebaseAuth.instance.currentUser?.uid } ${chat.recipientUID}");
                    return ListTile(
                      onTap: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return SingleCommunicationPage(
                                FirebaseAuth.instance.currentUser?.uid,
                                chat.recipientUID,
                                recipientName: "${chat.recipientName}",
                                photo: "${chat.profileURL}",
                                senderUID: FirebaseAuth.instance.currentUser?.uid,
                                recipientUID:  chat.recipientUID,

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
                              imageUrl: "${chat.profileURL}",
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
                      iconColor: Colors.black,
                      title: Text("${chat.recipientName}",
                          style: GoogleFonts.arsenal(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )),
                      subtitle: Text("${chat.recentTextMessage}",
                          style: GoogleFonts.arsenal(
                            color: Colors.grey,
                            fontWeight: FontWeight.w800,
                          )),
                    );
                  },
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
    );
  }

  Stream<List<MyChatEntity>> getMyChat() {
    final myChatRef =
    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('myChat');

    return myChatRef.orderBy('time', descending: true).snapshots().map(
          (querySnap) => querySnap.docs
          .map((doc) => MyChatModel.fromSnapShot(doc))
          .toList(),
    );
  }

}
