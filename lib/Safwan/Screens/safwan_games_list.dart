  
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
      home: const Games_list(),
    );
  }
}

class Games_list extends StatelessWidget {
  const Games_list({super.key});

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

        
        body:
        Center(
          child: Stack(
            children: [
              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                width: 350,
                height: 195,
                
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: const Color.fromARGB(255, 151, 80, 218),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(2, 7),
                      )
                    ]),
                ),
                
                SizedBox(height: 30),
                Container(
                width: 350,
                height: 195,
                
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: const Color.fromARGB(255, 59, 201, 118),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(2, 7),
                      )
                    ]),
                ),
                SizedBox(height: 30),
                Container(
                width: 350,
                height: 195,
                
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: const Color.fromARGB(255, 224, 145, 42),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(2, 7),
                      )
                    ]),
                ),
              ],
            ),
            Positioned(
              top: 166,
              right: 41,
              width: 266,
              height: 40,
              child: ElevatedButton(
                
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      const Color.fromARGB(255, 247, 231, 253)),
                ),
                child: Text(
                  "Choose this Game",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                      color: const Color.fromARGB(197, 65, 7, 90)),
                ),
              ),
            ),
            Positioned(
              top: 45,
              left: 26,
              child: Text("Hints game",
                style: TextStyle(
                  fontSize: 33,
                  color: const Color.fromARGB(255, 245, 219, 255),
                  fontWeight: FontWeight.w800,
                  letterSpacing: 3,
                ),
              ),
              ),
              Positioned(
              top: 94,
              left: 26,
              child: Container(
                width: 300,
                child: Text("Choose thw correct answer through the hints given",
                  style: TextStyle(
                    fontSize: 18,
                    color: const Color.fromARGB(255, 245, 219, 255),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 3,
                  ),
                ),
              ),
              ),
              Positioned(
              top: 395,
              right: 41,
              width: 266,
              height: 40,
              child: ElevatedButton(
                
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      const Color.fromARGB(255, 231, 253, 244)),
                ),
                child: Text(
                  "Choose this Game",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                      color: const Color.fromARGB(197, 7, 90, 69)),
                ),
              ),
            ),
            Positioned(
              top: 270,
              left: 26,
              child: Text("puzzle words",
                style: TextStyle(
                  fontSize: 33,
                  color: const Color.fromARGB(255, 226, 248, 238),
                  fontWeight: FontWeight.w800,
                  letterSpacing: 3,
                ),
              ),
              ),
              Positioned(
              top: 324,
              left: 26,
              child: Container(
                width: 300,
                child: Text("Drag and place the crrect choice in the correct space",
                  style: TextStyle(
                    fontSize: 18,
                    color: const Color.fromARGB(255, 236, 248, 243),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 3,
                  ),
                ),
              ),
              ),
              Positioned(
              top: 529,
              left: 26,
              child: Container(
                width: 300,
                child: Text("SOON...",
                  style: TextStyle(
                    fontSize: 78,
                    color: const Color.fromARGB(255, 255, 213, 157),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 3,
                  ),
                ),
              ),
              )
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
                    color: Colors.grey,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/st_home');
                    },
                  ),
                  const Text("Home", style: TextStyle(height: 0.1)),
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
                  const Text("Courses", style: TextStyle(height: 0.1, )),
                ],
              ),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.videogame_asset, size: 41),
                    color: Color.fromARGB(197, 0, 129, 189),
                    onPressed: () {
                    },
                  ),
                  const Text("Games", style: TextStyle(height: 0.1,color: Color.fromARGB(197, 0, 129, 189),fontWeight: FontWeight.w700)),
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


