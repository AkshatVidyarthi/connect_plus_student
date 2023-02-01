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
      child: Column(
        children: [
          SizedBox(height: 10,),
          Center
            (child: Text('What you would Like to do?',style: GoogleFonts.arsenal(
            fontWeight: FontWeight.bold
          ),)),
          SizedBox(height: 20,),
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
                child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
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
                      Icon(Icons.search),
                    ],
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
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        children: <Widget>[
                         
                          FittedBox(
                            child: Text(
                              'Update Profile',
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Icon(Icons.search),
                        ],
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
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
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
                          Icon(Icons.search),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                InkWell(
                  onDoubleTap: (){},
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'View Jobs',
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.search),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                InkWell(
                  onDoubleTap: (){},
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Payments',
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.search),
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
          ),
      ]
      )
    );
  }
}
