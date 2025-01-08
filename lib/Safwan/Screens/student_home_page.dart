// ignore_for_file: prefer_const_constructors, sort_child_properties_last

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

        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SingleChildScrollView(
              scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                    margin: EdgeInsets.fromLTRB(25, 105, 25, 35),
                    
                    width: 350,
                    height: 190,
                    decoration: BoxDecoration(color: Colors.amber,
                    borderRadius: BorderRadius.circular(28)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
