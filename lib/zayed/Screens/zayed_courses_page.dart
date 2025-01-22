
import 'package:flutter/material.dart';
import 'package:gamify_project/Safwan/Screens/dummy_data.dart';
import 'package:gamify_project/zayed/Screens/zayed_courses_cards.dart';

void main() {
  runApp(const Zayed_standard_navigations());
}

class Zayed_standard_navigations extends StatelessWidget {
  const Zayed_standard_navigations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: Scaffold(
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

        // Main content of the page better be here : ////////////-----------//////////------

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 7, 0, 0),
                child: const Text("Courses",
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w500,
                  letterSpacing: 3,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.74,
              child: ListView.builder(
                itemCount: test2.length,
                itemBuilder: (context, index) {
                  return Courses_cards(
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

        // Custom Bottom Taskbar///////////---------------//////////-------

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
                  const Text("Home", style: TextStyle(height: 0.1,)),
                ],
              ),
              
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu_book_rounded, size: 40.0),
                    color: Color.fromARGB(197, 0, 129, 189),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/st_course');
                    },
                  ),
                  const Text("Courses", style: TextStyle(height: 0.1,color: Color.fromARGB(197, 0, 129, 189),fontWeight: FontWeight.w700)),
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
      ),
    );
  }
}