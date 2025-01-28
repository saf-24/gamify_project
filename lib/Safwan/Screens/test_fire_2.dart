// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gamify_project/Safwan/Screens/course_cards_widget.dart';
import 'package:gamify_project/Safwan/Screens/dummy_data.dart';
import 'package:gamify_project/Safwan/Screens/frfrly.dart';

import 'package:gamify_project/Safwan/Screens/new_learrn_widget.dart';
import 'package:gamify_project/Safwan/Screens/safwan_anas.dart';
import 'package:gamify_project/Safwan/Screens/safwan_games_list.dart';
import 'package:gamify_project/Safwan/Screens/test_add_lesson.dart';
import 'package:gamify_project/Safwan/Screens/welcom_widget.dart';
import 'package:gamify_project/Safwan/Screens/whats_new_widget1.dart';
import 'package:gamify_project/zayed/Screens/zayed_courses_page.dart';


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
      toolbarHeight: 65,
        title: Text(
          "Gamify",
          style: TextStyle(
              fontSize: 32,
              color: Color.fromARGB(197, 0, 129, 189),
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            tooltip: "notifications",
            icon: const Icon(Icons.notifications_none,
                size: 39.4, color: Color.fromARGB(197, 0, 129, 189),),
            onPressed: () {
              
            },
          ),
        ],
        leading: IconButton(
          tooltip: "Menu",
          icon: const Icon(Icons.menu,
              size: 43.4, color: Color.fromARGB(197, 0, 129, 189),),
          onPressed: () {
            
          },
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            WelcomWidget(username: username),

                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('whats_new')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text("Error fetching data"));
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text("No subjects available"));
                      }

                      final subjects = snapshot.data!.docs;

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 450,
                              height: 225,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: subjects.length,
                                itemBuilder: (context, index) {
                                  final subject = subjects[index].data()
                                      as Map<String, dynamic>;
                                  return Whats_New_Widget(
                                    title: subject['title'] ?? 'N/A',
                                    disc: subject['disc'] ?? 'N/A',
                                    date: subject['date'] ?? 'N/A',
                                    imagepath: subject['image'] ?? 'N/A',
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                    Container(
                      margin: EdgeInsets.fromLTRB(30, 20, 6, 0),
                      child: Row(
                        children: [
                          
                          RichText(
                              text: TextSpan(
                                  style: const TextStyle(
                                      fontSize: 22,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w500),
                                  children: const [
                                TextSpan(
                                  text: "Continue your ",
                                ),
                                TextSpan(
                                    text: "Progress...",
                                    style: TextStyle(
                                        color: Color.fromARGB(197, 0, 129, 189),
                                        fontWeight: FontWeight.w800,
                                        fontSize: 22
                                        )
                                      )
                              ]
                              )
                              )
                        ],
                      ),
                    ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('subjects')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text("Error fetching data"));
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text("No subjects available"));
                      }

                      final subjects = snapshot.data!.docs;

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 450,
                              height: 225,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: subjects.length,
                                itemBuilder: (context, index) {
                                  final subject = subjects[index].data()
                                      as Map<String, dynamic>;
                                  return Course_home_page(
                                    title: subject['title'] ?? 'N/A',
                                    disc: subject['progres'] ?? 'N/A',
                                    date: subject['lessonName'] ?? 'N/A',
                                    percent1: subject['percent'] ?? 0.0,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(32, 15, 6, 0),
                    child: Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                fontSize: 22,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.w500),
                            children: const [
                              TextSpan(
                                text: "Start ",
                              ),
                              TextSpan(
                                text: "Learn ",
                                style: TextStyle(
                                    color: Color.fromARGB(197, 0, 129, 189),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 22),
                              ),
                              TextSpan(
                                text: "new things...",
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                      StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('new_learn')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text("Error fetching data"));
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text("No subjects available"));
                      }

                      final subjects = snapshot.data!.docs;

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 450,
                              height: 225,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: subjects.length,
                                itemBuilder: (context, index) {
                                  final subject = subjects[index].data()
                                      as Map<String, dynamic>;
                                  return New_learn_widget(
                                    title: subject['title'] ?? 'N/A',
                                    disc: subject['disc'] ?? 'N/A',
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
                ],
              ),
          ) ,
        
        
      
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(bottom: 14.0),
        height: 96,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.home, size: 40.0),
                  color: Color.fromARGB(197, 0, 129, 189),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => St_home_page()));
                  },
                ),
                const Text("Home",
                    style: TextStyle(
                        height: 0.1,
                        color: Color.fromARGB(197, 0, 129, 189),
                        fontWeight: FontWeight.w700)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.menu_book_rounded, size: 40.0),
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Zayed_standard_navigations()));
                  },
                ),
                const Text(
                  "Courses",
                  style: TextStyle(
                        height: 0.1,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.videogame_asset, size: 41),
                  color: Colors.grey,
                  onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Games_list()));
                  },
                ),
                const Text("Games", style: TextStyle(height: 0.1)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.person, size: 43),
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfilePage()));
                  },
                ),
                const Text("Profile", style: TextStyle(height: 0.1)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
