import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamify_project/Abdulhadi/Screens/brbrly.dart';
import 'package:gamify_project/Anas/Screens/Anas.dart';
import 'package:gamify_project/Hamid/Screens/Hamid_welcompage.dart';
import 'package:gamify_project/Safwan/Screens/safwan_anas.dart';
import 'package:gamify_project/Safwan/Screens/safwan_games_list.dart';
import 'package:gamify_project/Safwan/Screens/test_fire_2.dart';
import 'package:gamify_project/zayed/Screens/zayed_courses_cards.dart';



class Zayed_standard_navigations extends StatelessWidget {
  final String fullName;
  final String email;
  final String major;
  const Zayed_standard_navigations({super.key,
  required this.fullName,
    required this.email,
    required this.major,});

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
                margin: EdgeInsets.fromLTRB(75, 550, 0, 0),
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
                            fullName: fullName,email: email,major: major,                
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => St_home_page2(fullName: fullName,email: email,major: major,)));
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GamifyScreen(fullName: fullName,email: email,major: major,)));
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfilePage(FirstName: fullName,email: email,major: major,)));
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
