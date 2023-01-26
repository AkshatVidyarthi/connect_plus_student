import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class updateprofile extends StatefulWidget {
  const updateprofile({Key? key}) : super(key: key);

  @override
  State<updateprofile> createState() => _updateprofileState();
}
class _updateprofileState extends State<updateprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 2.0,
        title: Text('Update Profile',style: GoogleFonts.arsenal(
          color: Colors.black,fontWeight: FontWeight.bold,
            wordSpacing: 1.0,
        )),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircleAvatar
                  (radius: 50,
                    child: Icon(Icons.person,size: 50,)),
              ),
            ),

            Text('Akshat Vidyarthi',style: GoogleFonts.arsenal(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),),
            SizedBox(height: 10),
            Text('BCA',style: GoogleFonts.arsenal(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 18,
            ),),
          SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onDoubleTap: (){},
                  child: Container(
                    width: 95,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.person),
                          Text(
                            'Change Picture',
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
                InkWell(
                  onDoubleTap: (){},
                  child: Container(
                    width: 95,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.work),
                          Text(
                            'Add Work',
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
                InkWell(
                  onDoubleTap: (){},
                  child: Container(
                    width: 95,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.location_on_rounded),
                          Text(
                            'Update Location',
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
              ],
            ),
            SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align
                (alignment: Alignment.topLeft,
                  child: Text('Education Details',style: TextStyle(fontWeight: FontWeight.bold),)),
            ),
            SizedBox(height: 10,),
            Material(
              elevation: 5.0,
              color: Colors.white70,
              child: Container(
                height: 80,
                width: 320,
                child: Column(
                  children: [
                    ListTile(
                      title: Text('National P.G. College',style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: FittedBox(
                        child: Text('Bachelors Of Computer Applications(B.C.A)'
                            '\n'
                            '2023'),
                      ),


                    )

                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align
                (alignment: Alignment.topLeft,
                  child: Text('Personal Information',style: TextStyle(fontWeight: FontWeight.bold),)),
            ),
            SizedBox(height: 10,),
            Material(
              elevation: 5.0,
              color: Colors.white70,
              child: Container(
                height: 30,
                width: 320,
                child: Column(
                  children: [
                    Text('No Personal Information Found For this User.'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align
                (alignment: Alignment.topLeft,
                  child: Text('Contact Details',style: TextStyle(fontWeight: FontWeight.bold),)),
            ),
            SizedBox(height: 10,),
            Material(
              elevation: 5.0,
              color: Colors.white70,
              child: Container(

                width: 320,
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Email Address'),
                      subtitle: Text('akshatvidyarthi91@gmail.com'),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Contact No'),
                      subtitle: Text('6387509445'),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Lives in:'),
                      subtitle: Text('Lucknow,India'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
