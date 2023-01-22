import 'package:connect_plus_student/screens/Confirmation_Screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Studentdetails extends StatefulWidget {
  const Studentdetails({Key? key}) : super(key: key);

  @override
  State<Studentdetails> createState() => _StudentdetailsState();
}

class _StudentdetailsState extends State<Studentdetails> {
  _StudentdetailsState()
  {
    selval=courseslist[0];
  }
  var courseslist=['B.COM','BBA','BA','BCA','BVOC','MVOC','B.COM(H)','BBA(MS)'];
  String? selval="B.COM";

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,

        backgroundColor: Colors.deepPurpleAccent,
        title: Text('Student Registration',style:GoogleFonts.poppins(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold,wordSpacing: 2.0,letterSpacing: 1.0) ),
        surfaceTintColor: Colors.black,
      ),
      body: Card(
        elevation: 0.0,
        child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.white38,
                      Colors.purpleAccent,
                    ]
                )
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset('Assets/connect-student-logo-removebg-preview.png',height: 150),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(

                        ),
                        labelText: 'First Name',
                        hintText: 'Enter Full Name',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                        ),
                        labelText: 'Id',
                        hintText: 'Enter your ID number',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                        ),
                        labelText: 'Passing Year',
                        hintText: 'Year of Passing',
                      ),
                    ),
                  ),
                 /* Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                        ),
                        labelText: 'Course Enrolled',
                        hintText: 'Enrolled Course',
                      ),
                    ),
                  ),*/
                  Text('Enter Your Course',style: GoogleFonts.arsenal(fontWeight: FontWeight.bold,fontSize: 20)),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButton(
                      hint: Text('Select Course'),
                        value: selval,
                        items: courseslist
                            .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                            .toList(),
                        onChanged: (val) {setState(() {
                          selval = val;
                        });
                        }),
                  ),
                  /*DropdownButtonFormField(
                    value: selval,
                    items: courseslist
                        .map((e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selval = val;
                      });
                    },
                    icon: Icon(Icons.select_all_sharp),
                    iconSize: 30,
                  ),*/

                  ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ConfirmationScreen();
                        },));
                      }, child: Text('Submit',style: GoogleFonts.arsenal(fontWeight: FontWeight.bold),)),
                ],
              ),
            )

        ),
      ),
    );
  }
}
