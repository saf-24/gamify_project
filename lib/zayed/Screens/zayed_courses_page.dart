import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamify_project/Safwan/Screens/dummy_data.dart';
import 'package:gamify_project/zayed/Screens/zayed_courses_cards.dart';

void main() {
  runApp(const Zayed_standard_navigations());
}

class Zayed_standard_navigations extends StatelessWidget {
  const Zayed_standard_navigations({super.key});

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
                letterSpacing: 1),
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
                child: const Text(
                  "Courses",
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 3,
                  ),
                ),
              ),
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
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.74,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: subjects.length,
                        itemBuilder: (context, index) {
                          final subject =
                              subjects[index].data() as Map<String, dynamic>;
                          return Courses_cards(
                            title: subject['title'] ?? 'N/A',
                            disc: subject['progres'] ?? 'N/A',
                            date: subject['lessonName'] ?? 'N/A',
                            percent1: subject['percent'] ?? 'N/A',
                          );
                        },
                      ),
                    );
                  }
                  )
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
                  const Text("Home",
                      style: TextStyle(
                        height: 0.1,
                      )),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu_book_rounded, size: 40.0),
                    color: Color.fromARGB(197, 0, 129, 189),
                    onPressed: () {
                      
                    },
                  ),
                  const Text("Courses",
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
                    onPressed: () {},
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
