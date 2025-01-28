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
      home: AddQuizScreen(),
    );
  }
}

class AddQuizScreen extends StatefulWidget {
  @override
  _AddQuizScreenState createState() => _AddQuizScreenState();
}

class _AddQuizScreenState extends State<AddQuizScreen> {
  final TextEditingController quizNameController = TextEditingController();
  final TextEditingController qNumberController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController chapterNumberController = TextEditingController(); // Controller for chapter number
  String? selectedCourse;

  @override
  void initState() {
    super.initState();
    dateController.text = DateTime.now().toLocal().toString().split(' ')[0];
  }

  void saveQuiz() async {
    final quizName = quizNameController.text;
    final qNumber = qNumberController.text;
    final date = dateController.text;
    final chapterNumber = chapterNumberController.text; // Get chapter number

    if (quizName.isEmpty || qNumber.isEmpty || selectedCourse == null || chapterNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields!')),
      );
      return;
    }

    try {
      // Save the quiz
      await FirebaseFirestore.instance.collection('quizes').add({
        'quiz_name': quizName,
        'Qnumber': int.parse(qNumber),
        'date': date,
        'course_name': selectedCourse,
        'chapter_number': int.parse(chapterNumber), // Add chapter number to Firestore
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Quiz saved successfully!')),
      );

      // Clear the form
      quizNameController.clear();
      qNumberController.clear();
      chapterNumberController.clear();
      selectedCourse = null;
      setState(() {});
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add quiz: $error')),
      );
    }
  }

  Future<List<String>> fetchCourses() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('subjects').get();
    return snapshot.docs.map((doc) => doc['title'] as String).toList();
  }

  void showCoursesDialog() async {
    List<String> courses = await fetchCourses();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Course', style: TextStyle(color: Color(0xFF1A71C2), fontWeight: FontWeight.bold)),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(courses[index], style: TextStyle(fontSize: 16)),
                  onTap: () {
                    setState(() {
                      selectedCourse = courses[index];
                    });
                    Navigator.pop(context);
                  },
                  tileColor: selectedCourse == courses[index] ? Colors.blue[100] : null,
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECECEC),
      appBar: AppBar(
        centerTitle: true,
        title: Text(' Add new quiz ',
            style: TextStyle(fontSize: 18, color: Color(0xFF1A71C2), fontWeight: FontWeight.w500)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextField('Quiz name', quizNameController),
            SizedBox(height: 16),
            buildTextField('Number of questions', qNumberController, isNumber: true),
            SizedBox(height: 16),
            buildTextField('Chapter number', chapterNumberController, isNumber: true), // Add chapter number field
            SizedBox(height: 16),
            buildTextField('Date', dateController, isReadOnly: true),
            SizedBox(height: 16),
            GestureDetector(
              onTap: showCoursesDialog,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28.0),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(selectedCourse ?? 'Select Course', style: TextStyle(fontSize: 16, color: Colors.black54)),
                    Icon(Icons.arrow_drop_down, color: Colors.grey),
                  ],
                ),
              ),
            ),
            SizedBox(height: 35),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF6FB9FF)),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0))),
                ),
                onPressed: saveQuiz,
                child: Text('Save Quiz', style: TextStyle(fontSize: 17, color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, {bool isNumber = false, bool isReadOnly = false}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.0),
        color: Colors.white,
      ),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        readOnly: isReadOnly,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(28.0)),
        ),
      ),
    );
  }
}