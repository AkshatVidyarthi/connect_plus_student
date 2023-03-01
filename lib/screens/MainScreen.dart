import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_plus_student/main.dart';
import 'package:connect_plus_student/screens/MoreJobsOptions.dart';
import 'package:connect_plus_student/screens/MoreOptionsInternship.dart';
import 'package:connect_plus_student/screens/PostInternship.dart';
import 'package:connect_plus_student/screens/PostJob.dart';
import 'package:connect_plus_student/screens/UpdateProfile.dart';
import 'package:connect_plus_student/screens/payment_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

//import 'package:connect_plus_student/InternshipScreen';
import 'InternshipScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DateTimeRange? selectedDate;

  //final ViewInterns = data.docs;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
            padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                    Radius.circular(14))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: const <Widget>[
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
                              const BorderRadius.all(Radius.circular(14))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: const <Widget>[
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
                                    Radius.circular(14))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: const <Widget>[
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
                              const BorderRadius.all(Radius.circular(14))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: const <Widget>[
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
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const PaymentScreen();
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
                              const BorderRadius.all(Radius.circular(14))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: const <Widget>[
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
                /* isStudent
                    ? const SizedBox()
                    : InkWell(
                        onTap: () {
                          Razorpay razorpay = Razorpay();
                          var options = {
                            'key': 'rzp_live_ILgsfZCZoFIKMb',
                            'amount': 100,
                            'name': 'Acme Corp.',
                            'description': 'Fine T-Shirt',
                            'retry': {'enabled': true, 'max_count': 1},
                            'send_sms_hash': true,
                            'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
                            'external': {
                              'wallets': ['paytm']
                            }
                          };
                          razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                          razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
                          razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
                          razorpay.open(options);
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
                                    Radius.circular(14))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: const <Widget>[
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
                      ),*/
              ],
            ),
          ),
          /* Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurpleAccent, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(14)),
              ),
              width: double.infinity,
            ),
          ),*/
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
                  final data = document?[index].data();
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return MoreJobsOptions(data!, data["postedBy"]);
                        },
                      ));
                    },
                    child: Card(
                      elevation: 3.0,
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
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
                                          child: const Text(
                                            'View More',
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                      const Icon(Icons.login),
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
                .collection("PostedJobs")
                .where("isVerified", isEqualTo: true)
                .where("time",
                    isGreaterThanOrEqualTo: selectedDate?.start.toUtc())
                .where("time", isLessThanOrEqualTo: selectedDate?.end.toUtc())
                .snapshots(),
          ),
        ],
      ),
    );
  }
}
