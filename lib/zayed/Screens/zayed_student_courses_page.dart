
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
        // appbar ://------
        appBar: AppBar(
          backgroundColor: const Color(0xFFf1f1f1),
          centerTitle: true,
          toolbarHeight: 80.0, // Adjust AppBar height
          elevation: 4.0,
          shadowColor: Colors.grey.withOpacity(0.5),

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

        // Main content of the page ////////////-----------//////////------

        body: const Center(
          child: Text(
            "Main Content Here",
            style: TextStyle(fontSize: 24.0),
          ),
        ),

        // Custom Bottom Taskbar///////////---------------//////////-------

        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home, size: 40.0),
                color: Color.fromARGB(197, 0, 129, 189),
                onPressed: () {
                },
              ),
              IconButton(
                icon: const Icon(Icons.menu_book_rounded, size: 37.0),
                color: Colors.grey,
                onPressed: () {
                },
              ),
              IconButton(
                icon: const Icon(Icons.videogame_asset, size: 42.5),
                color: Colors.grey,
                onPressed: () {
                },
              ),
              IconButton(
                icon: const Icon(Icons.person, size: 38.0),
                color: Colors.grey,
                onPressed: () {
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
