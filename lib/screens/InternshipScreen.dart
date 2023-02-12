import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_plus_student/screens/MoreOptionsInternship.dart';
import 'package:connect_plus_student/screens/Moreoptions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InternshipScreen extends StatelessWidget {
  //final DocumentReference<Object?> reference;

  const InternshipScreen({
    Key? key,
    /*required this.reference*/
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('VIEW INTERNSHIPS'),
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
            itemBuilder: (context, index) {
              final data = document?[index].get("data");
              return Column(
                children: <Widget>[
                  for (int i = 0; i < data.length; i++)
                    data[index]["isVerified"]
                        ? InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return MoreOptionsInternship();
                        },));
                      },
                          child: Card(
                      elevation: 3.0,
                          color: Colors.white,
                            child: Container(
                              padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                SizedBox(height: 20,),
                                Row(
                                  children: [
                                    Text("${data[index]["jobtitle"]}",
                                  style: GoogleFonts.arsenal(
                                    color:Colors.black,
                                    fontWeight:FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("${data[index]["Companyname"]}",style: GoogleFonts.arsenal(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("${data[index]["Location"]}",
                                      style: GoogleFonts.arsenal(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight:FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                      Row(
                                        children: [
                                          TextButton(
                                            style: TextButton.styleFrom(
                                            ),
                                              onPressed: (){}, child: Text('View More',style: TextStyle(
                                            color: Colors.black
                                          ),)),
                                          Icon(Icons.login),
                                        ],
                                      ),
                                  ],
                                )
                              ],
                            )),
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
