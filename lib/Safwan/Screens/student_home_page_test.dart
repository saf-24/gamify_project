// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gamify_project/Safwan/Screens/Course_home_page_2.dart';
import 'package:gamify_project/Safwan/Screens/course_cards_widget.dart';
import 'package:gamify_project/Safwan/Screens/test_widget.dart';
import 'package:gamify_project/Safwan/Screens/welcom_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: const St_home_page(),
    );
  }
}

String username = "Safwan";
final List<Map<String, String>> test = [
  {
    'title': 'math 1',
    'image': 'assets/img/download.jpg',
    'disc': 'a new mid test added to math 1',
    'date': '9/01/2025',
    'username': 'Safwan',
  },
  {
    'title': 'java',
    'image': 'assets/img/download.jpg',
    'disc':
        'a new final test adde fdfgnldfgj  ldkjflk j  lkdfglj dlfkgjhlkdfhjg d to java 1',
    'date': '9/01/2025',
    'username': 'Safwan',
  },
  {
    'title': 'python',
    'image': 'assets/img/download.jpg',
    'disc': 'a new Quiz added to python 1',
    'date': '9/01/2025',
    'username': 'Safwan',
  },
];
final List<Map<String, String>> test2 = [
  {
    'title': 'Java peograming 1',
    'progres': 'Lesson: 3/7',
    'lessonName': 'if-Else lesson',
    'date': '9/01/2025',
    'percent': '74.2%'
  },
];

class St_home_page extends StatelessWidget {
  const St_home_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      appBar: AppBar(
        title: Text(
          "Gamify",
          style: TextStyle(
              fontSize: 32,
              color: Color.fromARGB(197, 13, 99, 139),
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            tooltip: "notifications",
            icon: const Icon(Icons.notifications_none,
                size: 35.4, color: Color.fromARGB(197, 13, 99, 139)),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          tooltip: "Menu",
          icon: const Icon(Icons.menu,
              size: 35.4, color: Color.fromARGB(197, 13, 99, 139)),
          onPressed: () {},
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Stack(
        children: [
          WelcomWidget(username: username),
          SizedBox(
            height: 330,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: test.length,
              itemBuilder: (context, index) {
                return TestWidget(
                  title: test[index]['title']!,
                  disc: test[index]['disc']!,
                  imagepath: test[index]['image']!,
                  date: test[index]['date']!,
                );
              },
            ),
          ),
          Positioned(
            top: 355,
            left: 35,
            child: Row(
              children: [
                RichText(
                    text: TextSpan(
                        style: const TextStyle(
                            fontSize: 24,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w500),
                        children: [
                      const TextSpan(
                        text: "Continue your ",
                      ),
                      TextSpan(
                          text: "Progress...",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 43, 115, 148),
                              fontWeight: FontWeight.w800,
                              fontSize: 24))
                    ]))
              ],
            ),
          ),
          Course_home_page(
            title: test2[0]['title']!,
            disc: test2[0]['progres']!,
            date: test2[0]['lessonName']!,
            percent1: test2[0]['percent']!,
          ),
          /*Course_home_page_2(
            title: test2[0]['title']!,
            disc: test2[0]['progres']!,
            date: test2[0]['lessonName']!,
            percent1: test2[0]['percent']!,
          )*/
        ],
      ),
    );
  }
}
