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
        title: Text('VIEW INTERNSHIPS',style: GoogleFonts.arsenal(
          fontWeight: FontWeight.bold,
        )),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:  Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'FILTER',
                  style: GoogleFonts.cairo(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: selectedDate == null
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
                        icon: const Icon(Icons.filter_alt))
                        : IconButton(
                        onPressed: () {
                          selectedDate = null;
                          setState(() {});
                        },
                        icon: const Icon(Icons.close))),
              ],
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
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
                                Row(
                                  children: [
                                    Text('Position: ',style: GoogleFonts.arsenal(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                                    Text(
                                      "${data?["jobtitle"]}",
                                      style: GoogleFonts.arsenal(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Text('Company: ',style: GoogleFonts.arsenal(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                                    Text(
                                      "${data?["Companyname"]}",
                                      style: GoogleFonts.arsenal(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Text('Location: ',style: GoogleFonts.arsenal(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                                    Text(
                                      "${data?["Location"]}",
                                      style: GoogleFonts.arsenal(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5,),
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
                                              style: GoogleFonts.cairo(
                                                fontSize: 16,
                                                letterSpacing: 1.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                        ),
                                        Icon(Icons.login,color: Colors.deepPurple),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )
                        ),
                      ),
                    );
                  },
                  itemCount: document?.length,
                );
              },
              stream: FirebaseFirestore.instance
                  .collection("PostedInternships")
                  .where("isVerified", isEqualTo: true)
                  .where("time", isGreaterThanOrEqualTo: selectedDate?.start.toUtc())
                  .where("time", isLessThanOrEqualTo: selectedDate?.end.toUtc())
                  .snapshots(),
            ),
          ],
        ),
      )


    );
  }
}
