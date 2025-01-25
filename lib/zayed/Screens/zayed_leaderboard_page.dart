import 'package:flutter/material.dart';

void main() {
  runApp(const Zayed_leaderboard_page());
}

class Zayed_leaderboard_page extends StatelessWidget {
  const Zayed_leaderboard_page({super.key});

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
          backgroundColor: const Color(0xFF037190),
          centerTitle: true,
          toolbarHeight: screenHeight * 0.08, // Adjust height based on screen size
          // Menu icon
          leading: Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: screenHeight * 0.051, // Responsive size
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              onPressed: () {},
            ),
          ),
          // Title
          title: Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.0),
            child: Text(
              "Leaderboard",
              style: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontSize: screenHeight * 0.04, // Responsive font size
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
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),

        // Main content of the page
        body: Stack(
            children: [
              // Image at the top of the page
              Image.asset(
                'assets/img/bestponitNav.png', // Path to the image
                height: screenHeight * 0.345, // Adjust height
                fit: BoxFit.none, // Maintain aspect ratio
              ),

                Positioned(
                top: screenHeight * 0.1175,
                right: screenHeight * 0.0215, // Adjust position
                child: Container(
                  height: screenHeight * 0.1, // Circle size (adjust to match image circles)
                  width: screenHeight * 0.1,
                  decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 222, 220, 220),
                  shape: BoxShape.circle,
                  ),
                ),
                ),
                Positioned(
                top: screenHeight * 0.233,
                right: screenHeight * 0.012,                
                child: Column(
                  children: [
                  Text("abdulhadi", 
                    style: TextStyle(fontSize: 25,
                    color: const Color.fromARGB(255, 238, 235, 235)
                    ),
                  ),
                  Text("100 points",
                    style: TextStyle(fontSize: 18,
                    color: const Color.fromARGB(255, 238, 235, 235)
                    ),
                  ),
                  ],
                ),
                ),

                Positioned(
                top: screenHeight * 0.074,
                right: screenHeight * 0.166, // Adjust position
                child: Container(
                  height: screenHeight * 0.11, // Circle size (adjust to match image circles)
                  width: screenHeight * 0.11,
                  decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 219, 216, 216),
                  shape: BoxShape.circle,
                  ),
                ),
                ),
                Positioned(
                top: screenHeight * 0.202,
                left: screenHeight * 0.178,                
                child: Column(
                  children: [
                  Text("zayed", 
                    style: TextStyle(fontSize: 25 , 
                    color: const Color.fromARGB(255, 238, 235, 235)
                    ),
                  ),
                  Text("100 points",
                    style: TextStyle(fontSize: 18,
                    color: const Color.fromARGB(255, 238, 235, 235)
                    ),
                  ),
                  ],
                ),
                ),

                Positioned(
                top: screenHeight * 0.123,
                left: screenHeight * 0.024, // Adjust position
                child: Container(
                  height: screenHeight * 0.1, // Circle size (adjust to match image circles)
                  width: screenHeight * 0.1,
                  decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 216, 215, 215),
                  shape: BoxShape.circle,
                  ),
                ),
                ),
                Positioned(
                top: screenHeight * 0.24,
                left: screenHeight * 0.025,                
                child: Column(
                  children: [
                  Text("safwan",
                    style: TextStyle(fontSize: 25,
                    color: const Color.fromARGB(255, 238, 235, 235)
                    ),
                  ),
                  Text("100 points",
                    style: TextStyle(fontSize: 18,
                    color: const Color.fromARGB(255, 238, 235, 235)
                    ),
                  ),
                  ],
                ),
                ),
              
              // List of points bars
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.35),
                    child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.44,
                    child: ListView.builder(
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return points_bars(
                          names: "John Doe",
                          points: 100,
                          ranks: index + 4,
                          );
                      },
                    ),
                    ),
                  ),
                  ],
                ),
              ),
            ],
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, color: color, size: screenHeight * 0.04),
        Text(
          label,
          style: TextStyle(color: color, fontSize: screenHeight * 0.02),
        ),
      ],
    );
  }
}
