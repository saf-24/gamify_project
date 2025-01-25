//THE SECOND PAGE MY PROFILE;
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyProfilePage(),
    );
  }
}

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  String FirstName = "Safwan";
  String FullName = "Safwan Alghamdi";
  String Magor = "information system";

  String profilePictureUrl = "";
  int xp = 1500;
  int level = 3;
  int nextLevelXP = 2000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      body: SizedBox(
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
                          FirstName,
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
              margin: EdgeInsets.fromLTRB(350, 46, 0, 0),
              child: IconButton(
              tooltip: "notifications",
              icon: const Icon(Icons.notifications_none,
                  size: 35.4, color: Color.fromARGB(255, 255, 255, 255)),
              onPressed: () {},
            ),
            ),
             Container(
              margin: EdgeInsets.fromLTRB(12, 47, 0, 0),
               child: IconButton(
                  tooltip: "Menu",
                  icon: const Icon(Icons.menu,
                  size: 35.4,  color: Color.fromARGB(255, 255, 255, 255)),
                  onPressed: () {},
                       ),
             ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                
              ),
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
                          ? Icon(Icons.person, size: 90,color: const Color.fromARGB(255, 10, 100, 136),)
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
                    child: Text("Student info",style: TextStyle(
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
                  child: Text("Full name",style: TextStyle(
                    fontSize: 20,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w500,
                  ),
                  )
                  ),

                Container(
                  margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.person,
                        size: 31.4, color:Color.fromARGB(255, 10, 100, 136),),
                        onPressed: () {},
            ),
                      Text(FullName,style: TextStyle(
                        fontSize: 18,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w500,
                      ),
                      ),
                      
                    ],
                  )
                  
                  ),
                  SizedBox(height: 20),
                    Container(
                  margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: Text("Email",style: TextStyle(
                    fontSize: 18,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w500,
                  ),
                  )
                  ),
                  Container(
                  margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: Row(
                    children: [
                      IconButton(
                        
                        icon: const Icon(Icons.email,
                        size: 25.4, color:Color.fromARGB(255, 10, 100, 136),),
                        onPressed: () {},
            ),
                      Text("safwanalgha@gmail.com",style: TextStyle(
                        fontSize: 18,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w500,
                      ),),
                    ],
                  )
                  
                  ),
                  SizedBox(height: 20),
                    Container(
                  margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: Text("Major",style: TextStyle(
                    fontSize: 18,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w500,
                  ),
                  )
                  ),
                  Container(
                  margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: Row(
                    children: [
                      IconButton(

                        icon: const Icon(Icons.school,
                        size: 29.4, color:Color.fromARGB(255, 10, 100, 136),),
                        onPressed: () {},
            ),
                      Text(Magor,style: TextStyle(
                        fontSize: 18,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w500,
                      ),),
                    ],
                  )
                  
                  ),
              ],
            )
            
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
                  onPressed: () {},
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
                    Navigator.pushReplacementNamed(context, '/st_course');
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
                    Navigator.pushReplacementNamed(context, '/st_games_list');
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
                  onPressed: () {
                    
                  },
                ),
                const Text("Profile", style: TextStyle(height: 0.1,color: Color.fromARGB(197, 0, 129, 189),
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
