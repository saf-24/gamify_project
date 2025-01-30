import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gamify_project/Abdulhadi/Screens/abdulhadi_AddBlank.dart';
import 'package:gamify_project/Abdulhadi/Screens/abdulhadi_AddHint_page.dart';
import 'package:gamify_project/Abdulhadi/Screens/abdulhadi_AddTest_page.dart';
import 'package:gamify_project/Hamid/Screens/Hamid_welcompage.dart';
import 'package:gamify_project/Safwan/Screens/add_lesson.dart';
import 'package:gamify_project/Safwan/Screens/safwan_add_course.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: teatcher_page(),
    );
  }
}

class teatcher_page extends StatelessWidget {
  const teatcher_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Gamify',
          style: TextStyle(
            color: const Color.fromARGB(255, 70, 154, 209),
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
    tooltip: "Logout",
    icon: const Icon(Icons.logout,
        size: 35.4, color: const Color.fromARGB(255, 70, 154, 209)),
    onPressed: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirm logout"),
            content: Text("Are you sure you want to log out?",style: TextStyle(fontSize: 20),),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); 
                },
                child: Text("No",style: TextStyle(fontSize: 18,color: Colors.black,),),
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
                child: Text("Log out",style: TextStyle(fontSize: 18,color: const Color.fromARGB(255, 255, 0, 0),)),
              ),
            ],
          );
        },
      );
    },
  ),
        ),
        
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Course content',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(157, 0, 0, 0),
              ),
            ),
            SizedBox(height: 25),
            

            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddSubjectScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                padding: EdgeInsets.symmetric(vertical: 18),
              ),
              child: Center(
                child: Text(
                  'Add a new course',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddLessonScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                padding: EdgeInsets.symmetric(vertical: 18),
              ),
              child: Center(
                child: Text(
                  'Add a new lesson',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddLessonAndQuestionsScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                padding: EdgeInsets.symmetric(vertical: 18),
              ),
              child: Center(
                child: Text(
                  'Add a new test',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => GamifyPage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                padding: EdgeInsets.symmetric(vertical: 18),
              ),
              child: Center(
                child: Text(
                  'Add a quastions to hint game',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateBlankGamePage()));

              },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                padding: EdgeInsets.symmetric(vertical: 18),
              ),
              child: Center(
                child: Text(
                  'Add a quastions to puzzle game',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}
