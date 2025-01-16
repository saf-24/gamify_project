
import 'package:flutter/material.dart';

void main() {
  runApp(const Student_Courses_Page());
}

class Student_Courses_Page extends StatelessWidget {
  const Student_Courses_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: Scaffold(
        backgroundColor: const Color(0xFFe4e4e4),
        appBar: AppBar(
          backgroundColor: const Color(0xFFf1f1f1),
          centerTitle: true,
           toolbarHeight: 80.0, // Adjust AppBar height
           leading: Padding(
              padding: const EdgeInsets.only(bottom: 1.0), // Adjust this value
              child: IconButton(
                icon: const Icon(
                  Icons.menu, // List/Menu icon
                  size: 47.0,
                  color: Color.fromARGB(197, 0, 129, 189),
                ),
                onPressed: () {}, // Add your logic here
              ),
           ),
          title: Text("Gamify",
            style: TextStyle(
            color: Color.fromARGB(255, 6, 147, 198),
            fontSize: 33.0,
            ),
          ),        
          actions: <Widget>[
           Padding(
              padding: const EdgeInsets.only(top: 6.0), // Adjust this value
              child: IconButton(
                icon: const Icon(
                  Icons.notifications_none,
                  size: 34.0,
                  color: Color.fromARGB(197, 0, 129, 189),
                ),
                onPressed: () {},
              ),
          )
        ],
        ),
      ),
    );
  }
}
