import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Moreoptions extends StatefulWidget {
  const Moreoptions({Key? key}) : super(key: key);

  @override
  State<Moreoptions> createState() => _MoreoptionsState();
}

class _MoreoptionsState extends State<Moreoptions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 14,
        ),
        Material(
          elevation: 5.0,
          child: Container(
            height: 180,
            width: 360,
            color: Colors.white70,
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.insert_invitation),
                    SizedBox(width: 10,),
                    Text('Share and Invite',style: GoogleFonts.arsenal(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.deepPurple),),
                  ],
                ),
                SizedBox(height: 20,),
                Center(
                  child: Text('Share about your Connect+ Student on social media and help to grow the feedback.',style: GoogleFonts.arsenal(
                    color: Colors.grey,fontWeight: FontWeight.bold,
                  )),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.add,color: Colors.deepPurple)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.account_circle,color: Colors.deepPurple,)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.adb,color: Colors.deepPurple,)),

                  ],
                ),


              ],
            ),
          ),
        ),
        SizedBox(height: 100,),
        Material(
          elevation: 5.0,
          color: Colors.white70,
          child: Container(
            height: 330,
            width: 360,
            child: Column(
              children: [
                  ListTile(
                    leading: Icon(Icons.person,color: Colors.deepPurple,size: 30),
                    title: Text('My Profile',style: GoogleFonts.arsenal(
                      color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
                  ),
                SizedBox(height: 20,),
                ListTile(
                  title: Text('Akshat Vidyarthi',style: TextStyle(fontWeight: FontWeight.bold)),
                  leading: CircleAvatar
                    (
                    radius: 30,
                      child: Icon(Icons.person,size: 40,)),
                  onTap: (){},
                  subtitle: Text('View And Edit Profile',style: TextStyle(
                    color: Colors.grey,
                  )),
                  trailing: Icon(Icons.arrow_back,color: Colors.black),
                ),
                ListTile(
                  onTap: (){},
                  title: Text('Add Work Details'),
                  leading: Icon(Icons.work,color: Colors.deepPurple),
                  trailing: Icon(Icons.arrow_back,color: Colors.black),

                ),
                ListTile(
                  onTap: (){},
                  title: Text('Change Picture'),
                  leading: Icon(Icons.photo_camera,color: Colors.deepPurple),
                  trailing: Icon(Icons.arrow_back,color: Colors.black),

                ),
                ListTile(
                  onTap: (){},
                  title: Text('Update Location'),
                  leading: Icon(Icons.location_on_rounded,color: Colors.deepPurple),
                  trailing: Icon(Icons.arrow_back,color: Colors.black),

                ),

              ],
            ),
          ),
        )
      ],
    );
  }
}
