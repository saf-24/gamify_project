import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddLessonPage extends StatefulWidget {
  final String className;
  final String subjectName;

  AddLessonPage({required this.className, required this.subjectName});

  @override
  _AddLessonPageState createState() => _AddLessonPageState();
}

class _AddLessonPageState extends State<AddLessonPage> {
  final TextEditingController _lessonController = TextEditingController();
  final TextEditingController _lessonContentController = TextEditingController();

  void _addLesson() async {
    String lessonName = _lessonController.text;
    String lessonContent = _lessonContentController.text;

    if (lessonName.isNotEmpty && lessonContent.isNotEmpty) {
      DocumentReference lessonRef = FirebaseFirestore.instance
          .collection('classes')
          .doc(widget.className)
          .collection('subjects')
          .doc(widget.subjectName)
          .collection('lessons')
          .doc(lessonName);

      await lessonRef.set({
        'lessonName': lessonName,
        'lessonContent': lessonContent,
        'completionPercentage': 0, // يمكن تعديلها حسب الحاجة
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم إضافة الدرس بنجاح')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('الرجاء إدخال جميع الحقول')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('إضافة درس')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _lessonController,
              decoration: InputDecoration(labelText: 'اسم الدرس'),
            ),
            TextField(
              controller: _lessonContentController,
              decoration: InputDecoration(labelText: 'محتوى الدرس'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addLesson,
              child: Text('إضافة الدرس'),
            ),
          ],
        ),
      ),
    );
  }
}
