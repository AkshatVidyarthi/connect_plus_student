import 'package:connect_plus_student/screens/MainScreen.dart';
import 'package:connect_plus_student/screens/Members.Dart.dart';
import 'package:connect_plus_student/screens/Messages.dart';
import 'package:connect_plus_student/screens/Moreoptions.dart';
import 'package:flutter/material.dart';
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
  static const List<Widget> _widgetOptions = <Widget>[
    MainScreen(),
    Members(),
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
          title: const Text('Connect+ Student'),
          backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.green
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.people_alt_sharp),
                label: 'Members',
                backgroundColor: Colors.yellow
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat),
               label: 'Messages',
                backgroundColor: Colors.deepPurpleAccent
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more),
              label: 'More',
              backgroundColor: Colors.blue,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 20,
          onTap: _onItemTapped,
          elevation: 5
      ),
    );
  }
}  