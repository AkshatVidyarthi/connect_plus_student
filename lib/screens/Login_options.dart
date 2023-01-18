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
   return (
   Container(
     decoration:BoxDecoration(
       image: DecorationImage(
         image: AssetImage("Assets/login.png"),
         fit: BoxFit.cover
       ),
     ),
     child: Scaffold(
       resizeToAvoidBottomInset: false,
       backgroundColor: Colors.transparent,

       body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [

           SizedBox(height: 300,),
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
               Text('Continue As:',style: TextStyle(
                 color: Colors.deepPurpleAccent,
                 fontWeight: FontWeight.bold,
                 wordSpacing: 1.5,
                 fontSize: 15.0
               )),
             ],
           ),
           Padding(
             padding: const EdgeInsets.all(16.0),
             child: Container(
             height: 300,
             width: 400,
             color: Colors.black,
               child: Card(
                 color:Colors.deepPurpleAccent,
                 child: Column(
                   children: [
                      SizedBox(height: 60,),
                     Padding(
                       padding: const EdgeInsets.all(16.0),
                       child: ListTile(
                         title: Text('Student',style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold),
                         ),
                         onTap: (){},
                         leading: CircleAvatar
                           (radius: 50,
                             child: Image.network('https://cdn-icons-png.flaticon.com/512/201/201818.png')),
                       ),
                     ),
                     SizedBox(height: 50,),
                     ListTile(
                       title: Text('Alumini',style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold)),
                       onTap: (){},
                       leading: CircleAvatar
                         (radius: 50,
                           child: Image.network('https://media.istockphoto.com/id/871028402/vector/bachelor-cap-icon.jpg?s=612x612&w=0&k=20&c=Q65yCIOlUsIonlNMh2uam9n0wrBldcMcOAETFvjR4Rw=')),
                     ),
                   ],
                 ),
               ),
         ),
           ),
       ]
       ),
     )
   )
     );
  }
}
