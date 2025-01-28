import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gamify_project/zayed/Screens/zayed_points_bars.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ZayedLeaderboardPage());
}

class ZayedLeaderboardPage extends StatelessWidget {
  const ZayedLeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: Scaffold(
        backgroundColor: const Color(0xFFe4e4e4),
        appBar: AppBar(
          backgroundColor: const Color(0xFF037190),
          centerTitle: true,
          toolbarHeight: screenHeight * 0.08,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: screenHeight * 0.051,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          title: Text(
            "Leaderboard",
            style: TextStyle(
              color: Colors.white,
              fontSize: screenHeight * 0.04,
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('Leaderboard').snapshots(),
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

            var leaderboardData = snapshot.data!.docs;
            leaderboardData.sort((a, b) {
              int scoreA = (a['score'] is int)
                  ? a['score']
                  : int.parse(a['score'].toString());
              int scoreB = (b['score'] is int)
                  ? b['score']
                  : int.parse(b['score'].toString());
              return scoreB.compareTo(scoreA);
            });

            return ListView.builder(
              itemCount: leaderboardData.length,
              itemBuilder: (context, index) {
                var user = leaderboardData[index];
                return points_bars(
                  names: user['name'],
                  points: (user['score'] is int)
                      ? user['score']
                      : int.tryParse(user['score'].toString()) ?? 0,
                  ranks: index + 1,
                );
              },
            );
          },
        ),
        bottomNavigationBar: _buildBottomNavigationBar(screenHeight),
      ),
    );
  }

  Widget _buildBottomNavigationBar(double screenHeight) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(bottom: screenHeight * 0.02),
      height: screenHeight * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildNavItem(Icons.home, "Home", Colors.grey, screenHeight),
          _buildNavItem(Icons.menu_book_rounded, "Courses",
              const Color(0xFF0081BD), screenHeight),
          _buildNavItem(
              Icons.videogame_asset, "Games", Colors.grey, screenHeight),
          _buildNavItem(Icons.person, "Profile", Colors.grey, screenHeight),
        ],
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
