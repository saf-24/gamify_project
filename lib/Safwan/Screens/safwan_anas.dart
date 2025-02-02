//THE SECOND PAGE MY PROFILE;
import 'package:flutter/material.dart';
import 'package:gamify_project/Anas/Screens/Anas.dart';
import 'package:gamify_project/Hamid/Screens/Hamid_welcompage.dart';
import 'package:gamify_project/Safwan/Screens/safwan_games_list.dart';
import 'package:gamify_project/Safwan/Screens/test_fire_2.dart';
import 'package:gamify_project/zayed/Screens/zayed_courses_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyProfilePage extends StatefulWidget {
  final String FirstName;
  final String email;
  final String major;
  const MyProfilePage({
    super.key,
    required this.FirstName,
    required this.email,
    required this.major,
  });
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  late String fullName;

  @override
  void initState() {
    super.initState();
    fullName = widget.FirstName;
  }
  String profilePictureUrl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      body: Container(
        width: 423,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: -10,
              right: -5,
              child: Image.asset(
                "assets/img/profile_back.png",
                scale: 0.65,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Text(
                    widget.FirstName,
                    style: TextStyle(
                      fontSize: 24,
                      color: const Color.fromARGB(255, 248, 248, 248),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(210, 185, 0, 0),
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      radius: 75,
                      backgroundImage: profilePictureUrl.isNotEmpty
                          ? NetworkImage(profilePictureUrl)
                          : null,
                      child: profilePictureUrl.isEmpty
                          ? Icon(
                              Icons.person,
                              size: 90,
                              color: const Color.fromARGB(255, 10, 100, 136),
                            )
                          : null,
                    ),
                  ),
                  SizedBox(height: 3),
                ],
              ),
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 335, 0, 0),
                    child: Text(
                      "Student info",
                      style: TextStyle(
                        fontSize: 29,
                        color: const Color.fromARGB(255, 10, 100, 136),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: Text(
                      "Full name",
                      style: TextStyle(
                        fontSize: 20,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                Container(
                    margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.person,
                            size: 31.4,
                            color: Color.fromARGB(255, 10, 100, 136),
                          ),
                          onPressed: () {},
                        ),
                        Text(
                          fullName,
                          style: TextStyle(
                            fontSize: 18,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )),
                SizedBox(height: 20),
                Container(
                    margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 18,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                Container(
                    margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.email,
                            size: 25.4,
                            color: Color.fromARGB(255, 10, 100, 136),
                          ),
                          onPressed: () {},
                        ),
                        Text(
                          widget.email,
                          style: TextStyle(
                            fontSize: 18,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )),
                SizedBox(height: 20),
                Container(
                    margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: Text(
                      "Major",
                      style: TextStyle(
                        fontSize: 18,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                Container(
                    margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.school,
                            size: 29.4,
                            color: Color.fromARGB(255, 10, 100, 136),
                          ),
                          onPressed: () {},
                        ),
                        Text(
                          widget.major,
                          style: TextStyle(
                            fontSize: 18,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(350, 46, 0, 0),
              child: IconButton(
                tooltip: "notifications",
                icon: const Icon(Icons.notifications_none,
                    size: 35.4, color: Color.fromARGB(255, 255, 255, 255)),
                onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationsScreen()));},
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(12, 47, 0, 0),
              child: IconButton(
                tooltip: "logout",
                icon: const Icon(Icons.logout,
                    size: 35.4, color: Color.fromARGB(255, 255, 255, 255)),
                onPressed: () {
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
                            builder: (context) => St_home_page2(
                                  fullName: widget.FirstName,email: widget.email,major: widget.major,
                                )));
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
                                Zayed_standard_navigations(fullName: widget.FirstName,email: widget.email,major: widget.major,)));
                  },
                ),
                const Text(
                  "Courses",
                  style: TextStyle(height: 0.1),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Games_list(fullName: widget.FirstName,email: widget.email,major: widget.major,)));
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
                  color: Color.fromARGB(197, 0, 129, 189),
                  onPressed: () {},
                ),
                const Text("Profile",
                    style: TextStyle(
                        height: 0.1,
                        color: Color.fromARGB(197, 0, 129, 189),
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
