// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:gamify_project/Safwan/Screens/test_widget.dart';

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

final List<Map<String,String >> test = [{
  'title': 'math 1',
  'image': 'assets/img/download.jpg',
  'disc':'a new mid test added to math 1'
},

{
  'title': 'java',
  'image': 'assets/img/download.jpg',
  'disc':'a new final test added to java 1'
},

{
  'title': 'python',
  'image': 'assets/img/download.jpg',
  'disc':'a new Quiz added to python 1'
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
        body: SizedBox(
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: test.length,
                itemBuilder: (context, index) {
                  return TestWidget(
                    title: test[index]['title']!,
                    disc: test[index]['disc']!,
                    imagepath: test[index]['image']!,
                  );
                })));
  }
}
