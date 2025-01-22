import 'package:flutter/material.dart';
import 'package:gamify_project/Safwan/Screens/dummy_data.dart';
import 'package:gamify_project/zayed/Screens/zayed_Lessons_cards.dart';

void main() {
  runApp(const Zayed_test_page());
}

class Zayed_test_page extends StatelessWidget {
  const Zayed_test_page({Key? key}) : super(key: key);

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
          backgroundColor: const Color(0xFFffffff),
          centerTitle: true,
          toolbarHeight: screenHeight * 0.08, // Adjust height based on screen size
          // Menu icon
          leading: Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.0),
            child: IconButton(
              icon: Icon(
                Icons.menu,
                size: screenHeight * 0.059, // Responsive size
                color: const Color.fromARGB(197, 0, 129, 189),
              ),
              onPressed: () {},
            ),
          ),
          // Title
          title: Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.0),
            child: Text(
              "Gamify",
              style: TextStyle(
                color: const Color.fromARGB(197, 0, 129, 189),
                fontSize: screenHeight * 0.045, // Responsive font size
              ),
            ),
          ),
          // Notification icon
          actions: [
            Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.0),
              child: IconButton(
                icon: Icon(
                  Icons.notifications_none,
                  size: screenHeight * 0.045, // Responsive size
                  color: const Color.fromARGB(197, 0, 129, 189),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),

        // Main Content
        body: SingleChildScrollView(
          child: Container(
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
                          // TextButton aligned to the right
                          TextButton(
                            onPressed: () {
                              // Add functionality here for TextButton
                            },
                            child: Text(
                              "Lessons",
                              style: TextStyle(
                                fontSize: screenHeight * 0.03, // Responsive font size
                                color: const Color.fromARGB(197, 0, 129, 189),
                              ),
                            ),
                          ),
                          // Lessons button
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
                              "Test",
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
                Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.02),
                  height: screenHeight * 0.477, // Responsive height
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

        // Bottom Navigation Bar 
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: EdgeInsets.only(bottom: screenHeight * 0.02),
          height: screenHeight * 0.1, // Responsive height
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(Icons.home, "Home", Colors.grey, screenHeight),
              _buildNavItem(Icons.menu_book_rounded, "Courses",
                  const Color.fromARGB(197, 0, 129, 189), screenHeight),
              _buildNavItem(Icons.videogame_asset, "Games", Colors.grey,
                  screenHeight),
              _buildNavItem(Icons.person, "Profile", Colors.grey, screenHeight),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      IconData icon, String label, Color color, double screenHeight) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, size: screenHeight * 0.047), // Responsive size
          color: color,
          onPressed: () {},
        ),
        Text(label, style: const TextStyle(height: 0.1)),
      ],
    );
  }
}
