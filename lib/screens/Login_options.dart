import 'package:connect_plus_student/screens/Alumini_details.dart';
import 'package:connect_plus_student/screens/Student_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login_options extends StatefulWidget {
  const Login_options({Key? key}) : super(key: key);

  @override
  State<Login_options> createState() => _Login_optionsState();
}

class _Login_optionsState extends State<Login_options> {
  @override
  Widget build(BuildContext context) {
   return  Container(
       decoration:BoxDecoration(
         image: DecorationImage(
             image: AssetImage("Assets/login.png"),
             fit: BoxFit.cover,
         ),
       ),
       child: Scaffold(
         backgroundColor: Colors.transparent,
         body: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               SizedBox(height:240,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   CircleAvatar(
                       backgroundColor: Colors.transparent,radius: 80,
                       child: Image.asset('Assets/connect-student-logo.png')),
                 ],
               ),

               Padding(
                 padding: const EdgeInsets.all(16.0),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Text('Welcome!',style: TextStyle(
                       fontSize: 22,
                       color: Colors.black,
                       wordSpacing: 1.0,
                     )),
                   ],
                 ),
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   SizedBox(width: 17,),
                   Text('Tell us How you are associated with us?',style: TextStyle(
                       color: Colors.deepPurpleAccent,
                       fontWeight: FontWeight.bold,
                       wordSpacing: 1.5,
                       fontSize: 15.0
                   )),
                 ],
               ),
               SizedBox(height: 30,),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(
                   decoration: BoxDecoration(
                       border: Border.all(color: Colors.deepPurpleAccent,width: 3),
                       borderRadius: BorderRadius.all(Radius.circular(20))
                   ),
                   child: ListTile(
                     title: Center(child: Text('Student?',style: GoogleFonts.poppins(fontSize: 20))),
                     leading: Image.network('https://cdn-icons-png.flaticon.com/512/201/201818.png'),
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context) {
                         return StudentDetails();
                       },));
                     },
                   ),
                 ),
               ),
               SizedBox(height: 30,),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(
                   decoration: BoxDecoration(
                       border: Border.all(color: Colors.black54,width: 3),
                       borderRadius: BorderRadius.all(Radius.circular(20))
                   ),
                   child: ListTile(
                     title: Center(child: Text('Alumini?',style: GoogleFonts.poppins(fontSize: 20))),
                     leading: Image.network('https://media.istockphoto.com/id/871028402/vector/bachelor-cap-icon.jpg?s=612x612&w=0&k=20&c=Q65yCIOlUsIonlNMh2uam9n0wrBldcMcOAETFvjR4Rw='),
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context) {
                         return Aluminidetails();
                       },));
                     },
                   ),
                 ),
               ),
             ]
         ),
       )
   );
  }
}
