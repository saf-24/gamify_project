import 'package:flutter/material.dart';
import 'package:gamify_project/Abdulhadi/Screens/abdulhadi_Add_instr.dart';
import 'package:gamify_project/Abdulhadi/Screens/abdulhadi_inst_st.dart';
import 'package:gamify_project/Hamid/Screens/Hamid_welcompage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const InstHomePage(),
    );
  }
}

class InstHomePage extends StatelessWidget {
  const InstHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      appBar: AppBar(
        title: const Text(
          'Gamify',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 70, 154, 209),
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      leading:  IconButton(
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
            const Text(
              'Manage Users',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(157, 0, 0, 0),
              ),
            ),
            const SizedBox(height: 25),
            _buildButton(
              context: context,
              label: 'Add Student',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentRegistration()),
                );
              },
            ),
            const SizedBox(height: 30),
            _buildButton(
              context: context,
              label: 'Add Instructor',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InstructorRegistration()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        padding: const EdgeInsets.symmetric(vertical: 18),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
