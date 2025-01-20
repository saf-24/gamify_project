// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:gamify_project/Safwan/Screens/course_cards_widget.dart';
import 'package:gamify_project/Safwan/Screens/new_learrn_widget.dart';
import 'package:gamify_project/Safwan/Screens/dummy_data.dart';
import 'package:gamify_project/Safwan/Screens/welcom_widget.dart';
import 'package:gamify_project/Safwan/Screens/whats_new_widget1.dart';

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
        backgroundColor: const Color(0xFFe4e4e4),
        // appbar ://------------------------------------------//
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 252, 252, 252),
          centerTitle: true,
          toolbarHeight: 65.0, // Adjust AppBar height
          

          // menu icon :----------------------------------------------

          leading: Padding(
            padding: const EdgeInsets.only(bottom: 1.0),
            child: IconButton(
              icon: const Icon(
                Icons.menu,
                size: 47.0,
                color: Color.fromARGB(197, 0, 129, 189),
              ),
              onPressed: () {},
            ),
          ),

          // title :-------------------------------------------

          title: const Text(
            "Gamify",
            style: TextStyle(
              color: Color.fromARGB(197, 0, 129, 189),
              fontSize: 33.0,
              fontWeight: FontWeight.w500,
              letterSpacing: 1
            ),
          ),

          // notification icon :---------------------------------------

          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
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

        
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              WelcomWidget(username: username),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            width: 450,
                            height: 230,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: test.length,
                              itemBuilder: (context, index) {
                                return Whats_New_Widget(
                                  title: test[index]['title']!,
                                  disc: test[index]['disc']!,
                                  imagepath: test[index]['image']!,
                                  date: test[index]['date']!,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            width: 450,
                            height: 225,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: test2.length,
                              itemBuilder: (context, index) {
                                return Course_home_page(
                                  title: test2[index]['title']!,
                                  disc: test2[index]['progres']!,
                                  date: test2[index]['lessonName']!,
                                  percent1: test3[index]['percent']!,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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
                                        fontSize: 22
                                        )
                                      ),
                                      TextSpan(
                                  text: "new things...",
                                ),
                              ]
                              )
                              )
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            width: 450,
                            height: 240,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: test.length,
                              itemBuilder: (context, index) {
                                return New_learn_widget(
                                  title: test2[0]['title']!,
                                  disc: test2[0]['progres']!,
                                  date: test2[0]['lessonName']!,
                                  percent1: test2[0]['percent']!,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
                    },
                  ),
                  const Text("Home", style: TextStyle(height: 0.1,color: Color.fromARGB(197, 0, 129, 189),fontWeight: FontWeight.w700)),
                ],
              ),
              
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu_book_rounded, size: 40.0),
                    color: Colors.grey,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/st_course');
                    },
                  ),
                  const Text("Courses", style: TextStyle(height: 0.1,)),
                ],
              ),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.videogame_asset, size: 41),
                    color: Colors.grey,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/st_games_list');
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
