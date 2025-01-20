
import 'package:flutter/material.dart';
import 'package:gamify_project/Safwan/Screens/dummy_data.dart';
import 'package:gamify_project/zayed/Screens/zayed_Lessons_cards.dart';

void main() {
  runApp(const Zayed_lessons_page());
}

class Zayed_lessons_page extends StatelessWidget {
  const Zayed_lessons_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: Scaffold(
        backgroundColor: const Color(0xFFe4e4e4),
        
        // appbar ://------------------------------------------//

        appBar: AppBar(
          backgroundColor: const Color(0xFFffffff),
          centerTitle: true,
          toolbarHeight: 350.0, // Adjust AppBar height
          elevation: 4.0,
          shadowColor: Colors.grey.withOpacity(0.5),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
            ),
          ),
          // menu icon :----------------------------------------------

          leading: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 270.0),
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

          title: const Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 270.0),
            child: Text(
              "Gamify",
              style: TextStyle(
                color: Color.fromARGB(197, 0, 129, 189),
                fontSize: 33.0,
              ),
            ),
          ),

          // notification icon :---------------------------------------

          actions: <Widget>[
            Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 270.0),
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
          child: Container(
            margin: const EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 0.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.44,
              child: ListView.builder(
                itemCount: test2.length,
                itemBuilder: (context, index) {
                  return Lessons_cards(
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
      ),

        // Custom Bottom Taskbar///////////---------------//////////-------

        bottomNavigationBar: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(bottom: 28.0),
          height: 107,

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
                    },
                  ),
                  const Text("Home", style: TextStyle(height: 0.1)),
                ],
              ),
              
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu_book_rounded, size: 37.0),
                    color: Color.fromARGB(197, 0, 129, 189),
                    onPressed: () {
                    },
                  ),
                  const Text("Courses", style: TextStyle(height: 0.1)),
                ],
              ),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.videogame_asset, size: 42.5),
                    color: Colors.grey,
                    onPressed: () {
                    },
                  ),
                  const Text("Games", style: TextStyle(height: 0.1)),
                ],
              ),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.person, size: 38.0),
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