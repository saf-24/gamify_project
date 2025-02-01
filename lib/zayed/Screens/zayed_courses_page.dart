import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamify_project/Safwan/Screens/safwan_anas.dart';
import 'package:gamify_project/Safwan/Screens/safwan_games_list.dart';
import 'package:gamify_project/Safwan/Screens/test_fire_2.dart';
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
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          tooltip: "Menu",
          icon: const Icon(Icons.menu,
              size: 43.4, color: Color.fromARGB(197, 0, 129, 189),),
          onPressed: () {},
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                            disc: subject['progres']?.toString() ?? 'N/A',
                            highestProgres: subject['highestProgres'] ?? 0,
                            date: subject['lessonName'] ?? '',                                                
                            total_lesson: subject['total_lessons'] ?? 0,
                            tet_name: subject['tet_name'] ?? "N/A",
                            cource_disc: subject['course_disc'] ?? "N/A",                        
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => St_home_page2(fullName: '',email: "",major: "",)));
                  },
                ),
                const Text("Home",
                    style: TextStyle(
                        height: 0.1,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700
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
                const Text(
                  "Courses",
                  style: TextStyle(height: 0.1,color: Color.fromARGB(197, 0, 129, 189),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfilePage(FirstName: "",email: "",major: "",)));
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
