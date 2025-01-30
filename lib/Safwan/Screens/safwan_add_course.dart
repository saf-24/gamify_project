import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

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
      home: AddSubjectScreen(),
    );
  }
}

class AddSubjectScreen extends StatefulWidget {
  @override
  _AddSubjectScreenState createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final TextEditingController subjectNameController = TextEditingController();
  final TextEditingController teacherNameController = TextEditingController();
  final TextEditingController courseDiscController = TextEditingController();

  void saveSubject() {
    final subjectName = subjectNameController.text;
    final teacherName = teacherNameController.text;
    final courseDisc = courseDiscController.text;

    if (subjectName.isEmpty || teacherName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields!')),
      );
      return;
    }

    FirebaseFirestore.instance.collection('subjects').add({
      'title': subjectName,
      'tet_name': teacherName,
      'course_disc': courseDisc,
      'total_lessons': 0,
      'highestProgres': 0,
      'percent': 0.0,
      'progres': " ",
      
       // Add this field with a default value of 0
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Subject added successfully!')),
      );
      subjectNameController.clear();
      teacherNameController.clear();
      courseDiscController.clear();

    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add subject: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Subject',
          style: TextStyle(
            fontSize: 18,
            color: const Color.fromARGB(255, 26, 113, 194),
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(28.0)),
                color: Colors.white,
              ),
              child: TextField(
                controller: subjectNameController,
                decoration: InputDecoration(
                  labelText: 'Subject Name',
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(28.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
              Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(28.0)),
                color: Colors.white,
              ),
              child: TextField(
                controller: courseDiscController,
                decoration: InputDecoration(
                  labelText: 'Subject discrption',
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(28.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 35),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(28.0)),
                color: Colors.white,
              ),
              child: TextField(
                controller: teacherNameController,
                decoration: InputDecoration(
                  labelText: 'Teacher Name',
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(28.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 35),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 111, 185, 255),
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                  ),
                ),
                onPressed: saveSubject,
                child: Text(
                  'Save Subject',
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}