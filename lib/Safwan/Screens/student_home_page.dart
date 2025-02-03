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
      home: const St_home_page_old(),
    );
  }
}

class St_home_page_old extends StatelessWidget {
  const St_home_page_old({super.key});

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
                          SizedBox(
                            width: 450,
                            height: 230,
                            
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
                          SizedBox(
                            width: 450,
                            height: 225,
                            
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
                          SizedBox(
                            width: 450,
                            height: 240,
                            
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
                    color: const Color.fromARGB(255, 22, 158, 221),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/test_fire_2');
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
