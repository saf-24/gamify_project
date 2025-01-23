//THE SECOND PAGE MY PROFILE;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyProfilePage(),
    );
  }
}

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  String name = "Safwan";
  String profilePictureUrl = "";
  int xp = 1500;
  int level = 3;
  int nextLevelXP = 2000;

  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Navigation logic for other pages
    });
  }

  void _editName() {
    TextEditingController nameController = TextEditingController(text: name);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Name"),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(hintText: "Enter new name"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                name = nameController.text;
              });
              Navigator.of(context).pop();
            },
            child: Text("Save"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _editPicture() {
    // Add actual image picker logic here
    setState(() {
      profilePictureUrl = ""; // Replace with actual image URL after picking
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        width: 423,
        height: double.infinity,
        child: Stack(
          children: [
            
            Container(
              child: Positioned(
                top: -10,
                right: -5,
              
                child: Image.asset(
                  "assets/img/profile_back.png",
                  scale: 0.65,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Text(
                          name,
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
              decoration: BoxDecoration(
                
              ),
              child: Column(
                children: [
        
                  Container(
                    margin: EdgeInsets.fromLTRB(210, 180, 0, 0),
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 221, 221, 221),
                      radius: 75,
                      backgroundImage: profilePictureUrl.isNotEmpty
                          ? NetworkImage(profilePictureUrl)
                          : null,
                      child: profilePictureUrl.isEmpty
                          ? Icon(Icons.person, size: 90,color: const Color.fromARGB(255, 10, 100, 136),)
                          : null,
                    ),
                  ),
                  SizedBox(height: 3),
                  

                ],
              ),
            ),
            SizedBox(height: 20),
            
          ],
        ),
      ),
    
    );
  }
}
