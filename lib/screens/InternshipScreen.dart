import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_plus_student/screens/MoreOptionsInternship.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InternshipScreen extends StatefulWidget {
  const InternshipScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<InternshipScreen> createState() => _InternshipScreenState();
}

class _InternshipScreenState extends State<InternshipScreen> {

  DateTimeRange? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('VIEW INTERNSHIPS'),
        actions: [
          selectedDate == null
              ? IconButton(
                  onPressed: () async {
                    final date = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(3000),
                    );

                    selectedDate = date;
                    print(date?.start);
                    print(date?.end);
                    setState(() {});
                  },
                  icon: Icon(Icons.filter_alt))
              : IconButton(
                  onPressed: () {
                    selectedDate = null;
                    setState(() {

                    });
                  },
                  icon: Icon(Icons.close))
        ],
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
              final data = document?[index].data();
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return MoreOptionsInternship(data!, data["postedBy"]);
                    },
                  ));
                },
                child: Card(
                  elevation: 3.0,
                  color: Colors.white,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
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
                                "${data?["jobtitle"]}",
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
                                "${data?["Companyname"]}",
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
                                "${data?["Location"]}",
                                style: GoogleFonts.arsenal(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
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
                                      style: TextButton.styleFrom(),
                                      onPressed: () {},
                                      child: Text(
                                        'View More',
                                        style: TextStyle(color: Colors.black),
                                      )),
                                  Icon(Icons.login),
                                ],
                              ),
                            ],
                          )
                        ],
                      )),
                ),
              );
            },
            itemCount: document?.length,
          );
        },
        stream: FirebaseFirestore.instance
            .collection("PostedInternships")
            .where("isVerified", isEqualTo: true)
            .where("time", isGreaterThanOrEqualTo: selectedDate?.start.millisecond)
            .where("time", isLessThanOrEqualTo: selectedDate?.end.millisecond)
            .snapshots(),
      ),
    );
  }
}
