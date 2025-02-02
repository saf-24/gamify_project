// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:gamify_project/Abdulhadi/Screens/abdulhadi_game_page.dart';
import 'package:gamify_project/Anas/Screens/Anas.dart';
import 'package:gamify_project/Hamid/Screens/Hamid_welcompage.dart';
import 'package:gamify_project/Safwan/Screens/safwan_anas.dart';
import 'package:gamify_project/Safwan/Screens/safwan_anas_game.dart';
import 'package:gamify_project/Safwan/Screens/test_fire_2.dart';
import 'package:gamify_project/zayed/Screens/zayed_courses_page.dart';



class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      
    );
  }
}

class Games_list extends StatelessWidget {
  final String fullName;
  final String email;
  final String major;
  const Games_list({super.key,required this.fullName,
    required this.email,
    required this.major,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 350,
                  height: 215,
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
                  height: 215,
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
              ],
            ),
            Positioned(
              top: 236,
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
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                      color: const Color.fromARGB(197, 65, 7, 90)),
                ),
              ),
            ),
            Positioned(
              top: 90,
              left: 26,
              child: Text(
                "Hints game",
                style: TextStyle(
                  fontSize: 33,
                  color: const Color.fromARGB(255, 245, 219, 255),
                  fontWeight: FontWeight.w800,
                  letterSpacing: 3,
                ),
              ),
            ),
            Positioned(
              top: 157,
              left: 26,
              child: SizedBox(
                width: 300,
                child: Text(
                  "Choose thw correct answer through the hints given",
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color.fromARGB(255, 245, 219, 255),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 3,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 483,
              right: 41,
              width: 266,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PuzzleGameScreen(fullName: fullName,email: email,major: major,)));
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      const Color.fromARGB(255, 231, 253, 244)),
                ),
                child: Text(
                  "Choose this Game",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                      color: const Color.fromARGB(197, 7, 90, 69)),
                ),
              ),
            ),
            Positioned(
              top: 330,
              left: 26,
              child: Text(
                "puzzle words",
                style: TextStyle(
                  fontSize: 33,
                  color: const Color.fromARGB(255, 226, 248, 238),
                  fontWeight: FontWeight.w800,
                  letterSpacing: 3,
                ),
              ),
            ),
            Positioned(
              top: 394,
              left: 26,
              child: SizedBox(
                width: 300,
                child: Text(
                  "Drag and place the crrect choice in the correct space",
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color.fromARGB(255, 236, 248, 243),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 3,
                  ),
                ),
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
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => St_home_page2(fullName: fullName,email: email,major: major,)));
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Zayed_standard_navigations(fullName: fullName,email: email,major: major,)));
                  },
                ),
                const Text("Courses",
                    style: TextStyle(
                      height: 0.1,
                    )),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.videogame_asset, size: 41),
                  color: Color.fromARGB(197, 0, 129, 189),
                  onPressed: () {},
                ),
                const Text("Games",
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
                  icon: const Icon(Icons.person, size: 43),
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyProfilePage(FirstName: fullName,email: email,major: major,)));
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
