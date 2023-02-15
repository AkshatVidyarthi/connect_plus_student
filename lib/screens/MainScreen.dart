import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_plus_student/main.dart';
import 'package:connect_plus_student/screens/MoreJobsOptions.dart';
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
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
                    ? const SizedBox()
                    : InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const PostJob();
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  const Icon(Icons.post_add),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  const FittedBox(
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
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const updateprofile();
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
                              const BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            const Icon(Icons.update_sharp),
                            const SizedBox(
                              height: 7,
                            ),
                            const FittedBox(
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
                const SizedBox(
                  width: 10,
                ),
                isStudent
                    ? const SizedBox()
                    : InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const PostInternships();
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  const Icon(Icons.post_add),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  const Center(
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
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) {
                      return const InternshipScreen();
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            const Icon(Icons.view_comfy_sharp),
                            const SizedBox(
                              height: 7,
                            ),
                            const FittedBox(
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
                const SizedBox(
                  width: 10,
                ),
                isStudent
                    ? const SizedBox()
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  const Icon(Icons.payment_outlined),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  const Text(
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
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurpleAccent, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(14)),
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
                  TextButton(onPressed: () {}, child: const Text('NATURE')),
                ],
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            builder: (context, snapShot2) {
              if (snapShot2.connectionState == ConnectionState.waiting) {
                return const Center(
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
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final List<dynamic> data =
                      document?[index].get("data") as List<dynamic>;
                  return Column(
                    children: <Widget>[
                      for (int i = 0; i < data.length; i++)
                        data[i]["isVerified"]
                            ? InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return MoreJobsOptions(
                                            data[i], document?[index].id);
                                      },
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 3.0,
                                  color: Colors.white,
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        const SizedBox(
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
                                        Row(
                                          children: [
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
                                            Text(
                                              "${data[i]["Location"]}",
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
                                                  style: TextButton.styleFrom(),
                                                  onPressed: () {},
                                                  child: const Text(
                                                    'View More',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                const Icon(Icons.login),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                    ],
                  );
                },
                itemCount: document?.length,
              );
            },
            stream:
                FirebaseFirestore.instance.collection("jobposted").snapshots(),
          ),
          /*StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            builder: (context, snapShot1) {
              if (snapShot1.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapShot1.hasError) {
                return Center(
                  child: Text("${snapShot1.error}"),
                );
              }
              final document = snapShot1.data?.docs;
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final List<dynamic> data =
                      document?[index].get("data") as List<dynamic>;
                  return Column(
                    children: <Widget>[
                      for (int i = 0; i < data.length; i++)
                        data[i]["isVerified"]
                            ? InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return MoreJobsOptions(
                                          data[i], document?[index].id);
                                    },
                                  ));
                                },
                                child: SizedBox(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Card(
                                          elevation: 3.0,
                                          color: Colors.white,
                                          child: Container(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${data[i]["jobtitle"]}",
                                                        style:
                                                            GoogleFonts.arsenal(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${data[i]["Companyname"]}",
                                                        style:
                                                            GoogleFonts.arsenal(
                                                          fontSize: 18,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${data[i]["Location"]}",
                                                        style:
                                                            GoogleFonts.arsenal(
                                                          color: Colors.grey,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w900,
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
                                                              child: const Text(
                                                                'View More',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              )),
                                                          const Icon(Icons.login),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )),
                                        );
                                      }),
                                ),
                              )
                            : const SizedBox(),
                    ],
                  );
                },
                itemCount: document?.length,
              );
            },
            stream:
                FirebaseFirestore.instance.collection("jobposted").snapshots(),
          ),*/
        ],
      ),
    );
  }
}
