import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_plus_student/main.dart';
import 'package:connect_plus_student/screens/MoreOptionsInternship.dart';
import 'package:connect_plus_student/screens/PostInternship.dart';
import 'package:connect_plus_student/screens/PostJob.dart';
import 'package:connect_plus_student/screens/UpdateProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//import 'package:connect_plus_student/InternshipScreen';
import 'InternshipScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //final ViewInterns = data.docs;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Center(
            child: Text(
          'What you would Like to do?',
          style: GoogleFonts.arsenal(fontWeight: FontWeight.bold),
        )),
        const SizedBox(
          height: 20,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isStudent
                  ? SizedBox()
                  : InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return PostJob();
                          },
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 90,
                          height: 70,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.post_add),
                                SizedBox(
                                  height: 7,
                                ),
                                FittedBox(
                                  child: Text(
                                    'Post Jobs',
                                    style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return updateprofile();
                    },
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 90,
                    height: 70,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.update_sharp),
                          SizedBox(
                            height: 7,
                          ),
                          FittedBox(
                            child: Text(
                              'Update Profile',
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              isStudent
                  ? SizedBox()
                  : InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PostInternships();
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 90,
                          height: 70,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.post_add),
                                SizedBox(
                                  height: 7,
                                ),
                                Center(
                                  child: FittedBox(
                                    child: Text(
                                      'Post Internship',
                                      style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return InternshipScreen();
                  })));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 90,
                    height: 70,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.view_comfy_sharp),
                          SizedBox(
                            height: 7,
                          ),
                          FittedBox(
                            child: Text(
                              'View Internships',
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              isStudent
                  ? SizedBox()
                  : InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 90,
                          height: 70,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.payment_outlined),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  'Payments',
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
                    ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.deepPurpleAccent, width: 3),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('FILTER BY:',
                      style: GoogleFonts.cairo(fontWeight: FontWeight.bold)),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'DATE',
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'COURSE',
                      style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                    )),
                TextButton(onPressed: () {}, child: Text('NATURE')),
              ],
            ),
          ),
        ),
        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          builder: (context, snapShot1) {
            if (snapShot1.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapShot1.hasError) {
              return Center(
                child: Text("${snapShot1.error}"),
              );
            }
            final document = snapShot1.data?.docs;
            return SizedBox(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final data = document?[index].get("data");
                  return Column(
                    children: <Widget>[
                      for (int i = 0; i < data.length; i++)
                        data[index]["isVerified"]
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
                                                "${data[index]["jobtitle"]}",
                                                style: GoogleFonts.arsenal(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${data[index]["Companyname"]}",
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
                                              Text(
                                                "${data[index]["Location"]}",
                                                style: GoogleFonts.arsenal(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  TextButton(
                                                      style: TextButton
                                                          .styleFrom(),
                                                      onPressed: () {},
                                                      child: Text(
                                                        'View More',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      )),
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
              ),
            );
          },
          stream:
              FirebaseFirestore.instance.collection("jobposted").snapshots(),
        ),
      ],
    );
  }
}
