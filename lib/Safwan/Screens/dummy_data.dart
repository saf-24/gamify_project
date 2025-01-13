// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

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
    'percent': '46.2%'
  },
  {
    'title': 'Pyhon peograming 1',
    'progres': 'Lesson: 2/7',
    'lessonName': 'Loop lesson',
    'date': '14/02/2025',
    'percent': '23.1%'
  },
  {
    'title': 'Histoty 2',
    'progres': 'Lesson: 1/7',
    'lessonName': 'our past lesson',
    'date': '16/02/2025',
    'percent': '0%'
  },
  {
    'title': 'Math 3',
    'progres': 'Lesson: 6/7',
    'lessonName': 'cosx & sinx lesson',
    'date': '03/02/2025',
    'percent': '94.6%'
  },
];
final List<Map<String, double>> test3 = [
  {
    'percent': 0.462
  },
  {
    'percent': 0.231
  },
  {
    'percent': 0.0
  },
  {
    'percent': 0.946,
  }

];

class St_home_page extends StatelessWidget {
  const St_home_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
    );
  }
}
