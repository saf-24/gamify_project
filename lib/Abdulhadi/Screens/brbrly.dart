import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GamifyScreen(),
    );
  }
}

class GamifyScreen extends StatefulWidget {
  @override
  _GamifyScreenState createState() => _GamifyScreenState();
}

class _GamifyScreenState extends State<GamifyScreen> {
  String? selectedCourse;
  final List<String> courses = ["Course 1", "Course 2", "Course 3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        title: Text(
          'Gamify',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Hints Game Card
            _buildGameCard(
              title: "Hints game",
              description:
                  "Choose the correct answer through a set of hints. There will be several hints. If you answer the first hint correctly, you will earn more points, and so on. You have two tries in each hint.",
              points:
                  "First hint: 15 points\nSecond hint: 10 points\nThird hint: 5 points",
              color: Color.fromARGB(255, 151, 80, 218),
            ),
            SizedBox(height: 20),
            // Puzzle Words Card
            _buildGameCard(
              title: "Puzzle words",
              description:
                  "Drag and place the correct choice in the correct space. There may be more than one blank space for an answer. There are no attempts. Once you press the 'Next' button, the score will be calculated.",
              points: "Each question: 15 points\nEach wrong blank: -5 points",
              color: Color.fromARGB(197, 7, 90, 69),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Courses",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: "Games",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Account",
          ),
        ],
      ),
    );
  }

  Widget _buildGameCard({
    required String title,
    required String description,
    required String points,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 12),
          Text(
            "Points distribution:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            points,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          DropdownButton<String>(
            hint: Text("Select course"),
            value: selectedCourse,
            isExpanded: true,
            items: courses.map((course) {
              return DropdownMenuItem(
                value: course,
                child: Text(course),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCourse = value;
              });
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              minimumSize: Size(double.infinity, 50),
            ),
            onPressed: selectedCourse != null
                ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Starting game for $selectedCourse"),
                      ),
                    );
                  }
                : null,
            child: Text("Start game!"),
          ),
        ],
      ),
    );
  }
}
