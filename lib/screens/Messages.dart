import 'package:flutter/material.dart';
class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);
  @override
  State<Messages> createState() => _MessagesState();
}
class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: (){},
        child: Icon(Icons.messenger,color: Colors.black,size: 30),
      ),
    );
  }
}
