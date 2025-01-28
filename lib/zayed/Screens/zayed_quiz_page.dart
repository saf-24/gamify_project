import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamify_project/Safwan/Screens/safwan_anas.dart';
import 'package:gamify_project/Safwan/Screens/safwan_games_list.dart';
import 'package:gamify_project/Safwan/Screens/test_fire_2.dart';
import 'package:gamify_project/zayed/Screens/zayed_courses_page.dart';
import 'package:gamify_project/zayed/Screens/zayed_lessons_page.dart';

import 'package:gamify_project/zayed/Screens/zayed_quiz_cards.dart';



class Zayed_quiz_page extends StatelessWidget {
  final String title;
  const Zayed_quiz_page({super.key,
  required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: Scaffold(
        backgroundColor: const Color(0xFFe4e4e4),

        // AppBar
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
              icon: const Icon(
                Icons.notifications_none,
                size: 39.4,
                color: Color.fromARGB(197, 0, 129, 189),
              ),
              onPressed: () {},
            ),
          ],
          leading: IconButton(
            tooltip: "Menu",
            icon: const Icon(
              Icons.arrow_back,
              size: 43.4,
              color: Color.fromARGB(197, 0, 129, 189),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),

        // Main Content
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Material widget to apply elevation and shadow
                  Material(
                    elevation: 4.0,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(25),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(25),
                      ),
                      child: Container(
                        color: Color(0xFFffffff),
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.22,
                          left: screenHeight * 0.06,
                          right: screenHeight * 0.09,
                          bottom: screenHeight * 0.02,
                        ),
                        
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Lessons button
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => Zayed_lessons_page(title: title,)),
                                );
                                
                              },
                              child: Text(
                                "Lessons",
                                style: TextStyle(
                                  fontSize: screenHeight * 0.03, // Responsive font size
                                  color: const Color.fromARGB(197, 0, 129, 189),
                                ),
                              ),
                            ),
                            // TextButton aligned to the right
                            ElevatedButton(
                              onPressed: () {
                                // Add functionality here when the button is pressed
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(197, 0, 129, 189),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                "Tests",
                                style: TextStyle(
                                  fontSize: screenHeight * 0.03, // Responsive font size
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            
                          ],
                        ),
                        
                      ),
                    
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('quizes')
                        .where('course_name', isEqualTo: title)
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

                      return Container(
                        margin: EdgeInsets.only(top: screenHeight * 0.02),
                        height: screenHeight * 0.477, // Responsive height
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: subjects.length,
                          itemBuilder: (context, index) {
                            final subject =
                                subjects[index].data() as Map<String, dynamic>;
                            return Quiz_cards(
                              lessonTitle: subject['quiz_name'] ?? 'N/A',
                              chapterNumber: subject['quiz_number'] ?? 0,
                              date: subject['date'] ?? 'N/A',
                              grade: subject['grade'] ?? 0.0,
                              Qnumber: subject['Qnumber'] ?? 0,
                            );
                          },
                        ),
                      );
                    }),
                ],
              ),
            ),
              Container(              
              margin: EdgeInsets.fromLTRB(25, 10, 0, 0),
              padding: EdgeInsets.fromLTRB(15, 13, 15, 15),
              width: 360,
              height: 170,
              alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 218, 218, 218),
                      borderRadius: BorderRadius.circular(25),
                    ),
              child: Text(
                      "Java is a programming language and computing platform first released by Sun Microsystems in 1995. It has evolved from humble beginnings to power a large share of today’s digital", textAlign: TextAlign.center,
                      style: TextStyle(
                      
                        fontSize: 15.5,
                        color: const Color.fromARGB(255, 0, 59, 99),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            ],
          ),
        ),

        // Bottom Navigation Bar
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => St_home_page()));
                    },
                  ),
                  const Text("Home",
                      style: TextStyle(
                          height: 0.1,
                          color: Colors.grey,
                          fontWeight: FontWeight.w700)),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu_book_rounded, size: 40.0),
                    color: Color.fromARGB(197, 0, 129, 189),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Zayed_standard_navigations()));
                    },
                  ),
                  const Text(
                    "Courses",
                    style: TextStyle(
                        height: 0.1,
                        color: Color.fromARGB(197, 0, 129, 189),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Games_list()));
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyProfilePage()));
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
