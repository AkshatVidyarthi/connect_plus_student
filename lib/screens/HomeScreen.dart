import 'package:connect_plus_student/screens/MainScreen.dart';
import 'package:connect_plus_student/screens/Members.Dart.dart';
import 'package:connect_plus_student/screens/Messages.dart';
import 'package:connect_plus_student/screens/Moreoptions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyNavigationBar (),
    );
  }
}
class MyNavigationBar extends StatefulWidget {
  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}
class _MyNavigationBarState extends State<MyNavigationBar > {
  int _selectedIndex = 0;
  static  List<Widget> _widgetOptions = <Widget>[
    MainScreen(),
    Members(data[i],document?[index].id),
    Messages(),
    Moreoptions(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:  Text('Connect+ Student',style: GoogleFonts.arsenal(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
          backgroundColor: Colors.deepPurpleAccent,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.deepPurpleAccent
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.people_alt_sharp),
                label: 'Members',
                backgroundColor: Colors.deepPurpleAccent
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat),
               label: 'Messages',
                backgroundColor: Colors.deepPurpleAccent
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more),
              label: 'More',
              backgroundColor: Colors.deepPurpleAccent,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.deepPurple,
          iconSize: 20,
          onTap: _onItemTapped,
          elevation: 5
      ),
    );
  }
}  