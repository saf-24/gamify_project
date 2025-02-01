import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gamify_project/Safwan/Screens/add_lesson_content.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AddLessonScreen());
}



class AddLessonScreen extends StatefulWidget {
  @override
  _AddLessonScreenState createState() => _AddLessonScreenState();
}

class _AddLessonScreenState extends State<AddLessonScreen> {
  final TextEditingController lessonNameController = TextEditingController();
  final TextEditingController chapterNumberController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  String? selectedCourse;

  @override
  void initState() {
    super.initState();
    dateController.text = DateTime.now().toLocal().toString().split(' ')[0];
  }

  void saveLesson() async {
    final lessonName = lessonNameController.text;
    final chapterNumber = chapterNumberController.text;
    final date = dateController.text;

    if (lessonName.isEmpty || chapterNumber.isEmpty || selectedCourse == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields!')),
      );
      return;
    }

    try {
      // Save the lesson
      await FirebaseFirestore.instance.collection('lessons').add({
        'lesson_name': lessonName,
        'Chapter_number': int.parse(chapterNumber),
        'date': date,
        'course_name': selectedCourse,
  
      });
        FirebaseFirestore.instance.collection('notifications').add({
        'title': lessonName,
        'message': "New course has benn added in $selectedCourse ",
        'image': "assets/img/download.jpg",
        'date': date,
      });
      // Update total_lessons in the corresponding subject
      QuerySnapshot subjectSnapshot = await FirebaseFirestore.instance
          .collection('subjects')
          .where('title', isEqualTo: selectedCourse)
          .get();

      if (subjectSnapshot.docs.isNotEmpty) {
        String subjectId = subjectSnapshot.docs.first.id;
        int currentTotalLessons = subjectSnapshot.docs.first['total_lessons'] ?? 0;

        await FirebaseFirestore.instance
            .collection('subjects')
            .doc(subjectId)
            .update({
          'total_lessons': currentTotalLessons + 1,
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lesson saved successfully!')),
      );

      // Clear the form
      lessonNameController.clear();
      chapterNumberController.clear();
      selectedCourse = null;
      setState(() {});
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add lesson: $error')),
      );
    }
  }

  Future<List<String>> fetchSubjects() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('subjects').get();
    return snapshot.docs.map((doc) => doc['title'] as String).toList();
  }

  void showSubjectsDialog() async {
    List<String> subjects = await fetchSubjects();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Course', style: TextStyle(color: Color(0xFF1A71C2), fontWeight: FontWeight.bold)),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(subjects[index], style: TextStyle(fontSize: 16)),
                  onTap: () {
                    setState(() {
                      selectedCourse = subjects[index];
                    });
                    Navigator.pop(context);
                  },
                  tileColor: selectedCourse == subjects[index] ? Colors.blue[100] : null,
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<int> getTotalLessons(String courseName) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('subjects')
        .where('title', isEqualTo: courseName)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first['total_lessons'] ?? 0;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECECEC),
      appBar: AppBar(
        centerTitle: true,
        title: Text(' Add new lesson ',
            style: TextStyle(fontSize: 18, color: Color(0xFF1A71C2), fontWeight: FontWeight.w500)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextField('Lesson name', lessonNameController),
            SizedBox(height: 16),
            buildTextField('Lesson number', chapterNumberController, isNumber: true),
            SizedBox(height: 16),
            buildTextField('Date', dateController, isReadOnly: true),
            SizedBox(height: 16),
            GestureDetector(
              onTap: showSubjectsDialog,
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
            if (selectedCourse != null)
              FutureBuilder<int>(
                future: getTotalLessons(selectedCourse!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Text('Total Lessons: ${snapshot.data}');
                  }
                },
              ),
            SizedBox(height: 35),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF6FB9FF)),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0))),
                ),
                
                onPressed: () {
                  if (lessonNameController.text.isNotEmpty && chapterNumberController.text.isNotEmpty && selectedCourse != null) {
                    saveLesson();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddLessonContentScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill out all fields!')),
                    );
                  }
                },
                child: Text('Add content', style: TextStyle(fontSize: 17, color: Colors.black)),
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