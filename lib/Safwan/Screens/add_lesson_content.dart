import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';



class MyApp extends StatelessWidget {
    final String lesson_name_next;
  final String course_name;
  const MyApp({
    super.key,    
    required this.course_name,
    required this.lesson_name_next,
    }
    );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddLessonContentScreen(),
    );
  }
}

class AddLessonContentScreen extends StatefulWidget {
  @override
  _AddLessonContentScreenState createState() => _AddLessonContentScreenState();
}

class _AddLessonContentScreenState extends State<AddLessonContentScreen> {
  final TextEditingController contentController = TextEditingController();
  String? selectedCourse;
  String? selectedLesson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECECEC),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Lesson Content',
          style: TextStyle(fontSize: 18, color: Color(0xFF1A71C2), fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => showCoursesDialog(),
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
            SizedBox(height: 16),
            GestureDetector(
              onTap: () => showLessonsDialog(),
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
                    Text(selectedLesson ?? 'Select Lesson', style: TextStyle(fontSize: 16, color: Colors.black54)),
                    Icon(Icons.arrow_drop_down, color: Colors.grey),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            buildTextField('Lesson Content', contentController, maxLines: 5),
            SizedBox(height: 35),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF6FB9FF)),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0))),
                ),
                onPressed: saveLessonContent,
                child: Text('Save Content', style: TextStyle(fontSize: 17, color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.0),
        color: Colors.white,
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(28.0)),
        ),
      ),
    );
  }

  void saveLessonContent() async {
    final content = contentController.text;

    if (selectedCourse == null || selectedLesson == null || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields!')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('lesson_content').add({
        'course_name': selectedCourse,
        'lesson_name': selectedLesson,
        'text_content': content,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lesson content saved successfully!')),
      );

      // Clear the form
      contentController.clear();
      setState(() {
        selectedCourse = null;
        selectedLesson = null;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add lesson content: $error')),
      );
    }
  }

  Future<List<String>> fetchCourses() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('subjects').get();
    return snapshot.docs.map((doc) => doc['title'] as String).toList();
  }

  Future<List<String>> fetchLessons() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('lessons').where('course_name',isEqualTo: selectedCourse).get();
    return snapshot.docs.map((doc) => doc['lesson_name'] as String).toList();
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

  void showLessonsDialog() async {
    List<String> lessons = await fetchLessons();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Lesson', style: TextStyle(color: Color(0xFF1A71C2), fontWeight: FontWeight.bold)),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(lessons[index], style: TextStyle(fontSize: 16)),
                  onTap: () {
                    setState(() {
                      selectedLesson = lessons[index];
                    });
                    Navigator.pop(context);
                  },
                  tileColor: selectedLesson == lessons[index] ? Colors.blue[100] : null,
                );
              },
            ),
          ),
        );
      },
    );
  }
}