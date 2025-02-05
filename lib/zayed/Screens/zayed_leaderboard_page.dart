import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gamify_project/Anas/Screens/Anas.dart';
import 'package:gamify_project/Hamid/Screens/Hamid_welcompage.dart';
import 'package:gamify_project/Safwan/Screens/safwan_anas.dart';
import 'package:gamify_project/Safwan/Screens/test_fire_2.dart';
import 'package:gamify_project/zayed/Screens/zayed_courses_page.dart';
import 'package:gamify_project/zayed/Screens/zayed_points_bars.dart';



class ZayedLeaderboardPage extends StatelessWidget {
    final String fullName;
  final String email;
  final String major;
  const ZayedLeaderboardPage({super.key,    required this.fullName,
    required this.email,
    required this.major,});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      appBar: AppBar(
        toolbarHeight: 65,
        title: Text(
          "Leaderboard",
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
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationsScreen()));
            },
          ),
        ],
        leading: Builder( // استخدم Builder لإتاحة الوصول إلى Scaffold
          builder: (context) => IconButton(
            tooltip: "Menu",
            icon: const Icon(
              Icons.menu,
              size: 43.4,
              color: Color.fromARGB(197, 0, 129, 189),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // يفتح القائمة الجانبية
            },
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),

      drawer: Drawer( // القائمة الجانبية
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 120,
              child: DrawerHeader(
              
                decoration: BoxDecoration(color: Color.fromARGB(197, 0, 129, 189),),
                child: Text("Menu", textAlign:TextAlign.center , style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
            ),
            ListTile(
              leading: Icon(Icons.question_mark,size: 29,),
              title: Text("About us",style: TextStyle(fontSize: 20,)),
              onTap: () {
              
              },
            ),
            ListTile(
              leading: Icon(Icons.phone,size: 27,),
              title: Text("Contact us",style: TextStyle(fontSize: 20,)),
              onTap: () {
                
              },
              
            ),
            Center(
              child: Container(
                width: 164,
                margin: EdgeInsets.fromLTRB(17, 550, 0, 0),
                child: ListTile(
                
                   leading:  Icon(Icons.logout,
                        size: 35.4, color: Color.fromARGB(255, 223, 0, 0)),
                        title: Text("Logout",style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 223, 0, 0),fontWeight: FontWeight.w700),),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirm logout"),
                            content: Text(
                              "Are you sure you want to log out?",
                              style: TextStyle(fontSize: 20),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // إغلاق الرسالة
                                },
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => welcome_page()),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                child: Text("Log out",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: const Color.fromARGB(255, 255, 0, 0),
                                    )),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
              ),
            )
          ],
        ),
      ),
        body: StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection('Leaderboard').snapshots(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
      return const Center(child: Text("Error fetching data"));
    }

    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return const Center(child: Text("No leaderboard data available"));
    }

    // تجميع النقاط لكل اسم
    Map<String, int> scoresMap = {};
    for (var doc in snapshot.data!.docs) {
      String name = doc['name'];
      int score = (doc['score'] is int)
          ? doc['score'] as int
          : int.tryParse(doc['score'].toString()) ?? 0;

      if (scoresMap.containsKey(name)) {
        scoresMap[name] = scoresMap[name]! + score;
      } else {
        scoresMap[name] = score;
      }
    }

    // تحويل الـ Map إلى قائمة وفرزها
    var sortedList = scoresMap.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return ListView.builder(
      itemCount: sortedList.length,
      itemBuilder: (context, index) {
        var entry = sortedList[index];
        return points_bars(
          names: entry.key,
          points: entry.value,
          ranks: index + 1,
        );
      },
    );
  },
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => St_home_page2(fullName:fullName,email: email,major: major,)));
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
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Zayed_standard_navigations(fullName:fullName,email: email,major: major,)));
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
                  color: Color.fromARGB(197, 0, 129, 189),
                  onPressed: () {
                    // Navigation logic for Games
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyProfilePage(
                                  FirstName:fullName,email: email,major: major,
                                )));
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



  Widget _buildNavItem(
      IconData icon, String label, Color color, double screenHeight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, color: color, size: screenHeight * 0.04),
        Text(label,
            style: TextStyle(color: color, fontSize: screenHeight * 0.02)),
      ],
    );
  }
}
