import 'package:connect_plus_student/screens/PostInternship.dart';
import 'package:connect_plus_student/screens/PostJob.dart';
import 'package:connect_plus_student/screens/UpdateProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: [
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
              InkWell(
                onDoubleTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PostJob();
                  },));
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
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        FittedBox(
                          child: Text(
                            'Post Jobs',
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 10,
                            fontWeight: FontWeight.bold),
                          ),
                        ),
                        Icon(Icons.post_add),
                      ],
                    ),
                  ),
            ),
                ),
              ),
                SizedBox(width: 10,),
                InkWell(
                  onDoubleTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return updateprofile();
                    },));
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
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            FittedBox(
                              child: Text(
                                'Update Profile',
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Icon(Icons.update_sharp),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                InkWell(
                  onDoubleTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
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
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
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
                            Icon(Icons.post_add),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                InkWell(
                  onDoubleTap: (){},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 90,
                      height: 70,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'View Jobs',
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.view_comfy_sharp),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                InkWell(
                  onDoubleTap: (){},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 90,
                      height: 70,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Payments',
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.payment_outlined),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
          ),
      SizedBox(
        height: 64,
        child: ListView(
          scrollDirection: Axis.horizontal,
          itemExtent: 104,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          children: [
            CardWithIcon(
              text: "Post Job",
              icon: const Icon(Icons.post_add),
              onTap: () {},
            ),
            CardWithIcon(
              text: "Job cdsj dcd",
              icon: const Icon(Icons.post_add),
              onTap: () {},
            )
          ],
        ),
      ),
    ]));
  }
}

class CardWithIcon extends StatelessWidget {
  final String text;
  final Icon icon;
  final void Function()? onTap;

  const CardWithIcon({
    Key? key,
    required this.text,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 4),
            FittedBox(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
