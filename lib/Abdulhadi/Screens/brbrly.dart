import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gamify_project/Abdulhadi/Screens/abdulhadi_game_page.dart';
import 'package:gamify_project/Anas/Screens/Anas.dart';
import 'package:gamify_project/Safwan/Screens/safwan_anas_game.dart';
import 'package:gamify_project/Hamid/Screens/Hamid_welcompage.dart';
import 'package:gamify_project/Safwan/Screens/safwan_anas.dart';
import 'package:gamify_project/Safwan/Screens/test_fire_2.dart';
import 'package:gamify_project/zayed/Screens/zayed_courses_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GamifyScreen(
        fullName: "John Doe",
        email: "john@example.com",
        major: "Computer Science",
      ),
    );
  }
}

class GamifyScreen extends StatefulWidget {
  final String fullName;
  final String email;
  final String major;

  GamifyScreen({
    required this.fullName,
    required this.email,
    required this.major,
  });

  @override
  _GamifyScreenState createState() => _GamifyScreenState();
}

class _GamifyScreenState extends State<GamifyScreen> {
  String? selectedCourseHints;
  String? selectedCoursePuzzle;
  late Stream<QuerySnapshot> _subjectsStream;

  @override
  void initState() {
    super.initState();
    _subjectsStream =
        FirebaseFirestore.instance.collection('subjects').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe4e4e4),
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
        leading: Builder(
          builder: (context) => IconButton(
            tooltip: "Menu",
            icon: const Icon(
              Icons.menu,
              size: 43.4,
              color: Color.fromARGB(197, 0, 129, 189),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 120,
              child: DrawerHeader(
                decoration:
                    BoxDecoration(color: Color.fromARGB(197, 0, 129, 189)),
                child: Text("Menu",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.question_mark,
                size: 29,
              ),
              title: Text(
                "About us",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.phone,
                size: 27,
              ),
              title: Text(
                "Contact us",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {},
            ),
            Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(75, 550, 0, 0),
                child: ListTile(
                  leading: Icon(Icons.logout,
                      size: 35.4, color: Color.fromARGB(255, 223, 0, 0)),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 223, 0, 0),
                        fontWeight: FontWeight.w700),
                  ),
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
                                Navigator.pop(context);
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
                                    color:
                                        const Color.fromARGB(255, 255, 0, 0),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildGameCard(
              title: "Hints game",
              description:
                  "Choose the correct answer through a set of hints. There will be several hints. If you answer the first hint correctly, you will earn more points, and so on. You have two tries in each hint.",
              points:
                  "First hint: 15 points\nSecond hint: 10 points\nThird hint: 5 points",
              color: Color.fromARGB(255, 151, 80, 218),
              selectedCourse: selectedCourseHints,
              onCourseSelected: (value) {
                setState(() {
                  selectedCourseHints = value;
                });
              },
              onStartGame: () {
                if (selectedCourseHints != null) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HintPage(
                                fullName: widget.fullName,
                                email: widget.email,
                                major: widget.major,
                                course_name: selectedCourseHints!,
                              )));
                }
              },
            ),
            SizedBox(height: 20),
            _buildGameCard(
              title: "Puzzle words",
              description:
                  "Drag and place the correct choice in the correct space. There may be more than one blank space for an answer. There are no attempts. Once you press the 'Next' button, the score will be calculated.",
              points: "Each blank: 1 point\nwrong blank: no points",
              color: Color.fromARGB(197, 7, 90, 69),
              selectedCourse: selectedCoursePuzzle,
              onCourseSelected: (value) {
                setState(() {
                  selectedCoursePuzzle = value;
                });
              },
              onStartGame: () {
                if (selectedCoursePuzzle != null) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PuzzleGameScreen(
                                fullName: widget.fullName,
                                email: widget.email,
                                major: widget.major,                
                                course_name: selectedCoursePuzzle!,                
                      )
                    )
                  );
                }
              },
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => St_home_page2(fullName:widget.fullName,email: widget.email,major: widget.major,)));
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
                                Zayed_standard_navigations(fullName: widget.fullName,email: widget.email,major: widget.major,)));
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
                                  FirstName: widget.fullName,
                                  email: widget.email,
                                  major: widget.major,
                                )));
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

  Widget _buildGameCard({
    required String title,
    required String description,
    required String points,
    required Color color,
    required String? selectedCourse,
    required Function(String?) onCourseSelected,
    required VoidCallback onStartGame,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.29),
        borderRadius: BorderRadius.circular(25),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 28, fontWeight: FontWeight.w800, color: color)),
          SizedBox(height: 8),
          Text(description,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
          SizedBox(height: 12),
          Text("Points distribution:",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          Text(points,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
          SizedBox(height: 20),
          StreamBuilder<QuerySnapshot>(
            stream: _subjectsStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              List<String> courses = snapshot.data!.docs
                  .map((doc) => doc['title'] as String)
                  .toList();

              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color.fromARGB(255, 249, 252, 255),
                ),
                child: DropdownButton<String>(
                  dropdownColor: const Color.fromARGB(255, 241, 241, 241),
                  borderRadius: BorderRadius.circular(25),
                  hint: Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text("Select course")),
                  value: selectedCourse,
                  isExpanded: true,
                  items: courses.map((course) {
                    return DropdownMenuItem(
                      value: course,
                      child: Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Text(course),
                      ),
                    );
                  }).toList(),
                  onChanged: onCourseSelected,
                ),
              );
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              minimumSize: Size(double.infinity, 50),
            ),
            onPressed: selectedCourse != null ? onStartGame : null,
            child: Text(
              "Start game!",
              style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}