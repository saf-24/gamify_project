import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddClassPage extends StatefulWidget {
  @override
  _AddClassPageState createState() => _AddClassPageState();
}

class _AddClassPageState extends State<AddClassPage> {
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();

  void _addClassAndSubject() async {
    String className = _classController.text;
    String subjectName = _subjectController.text;

    if (className.isNotEmpty && subjectName.isNotEmpty) {
      // إضافة الشعبة
      DocumentReference classRef = FirebaseFirestore.instance
          .collection('classes')
          .doc(className);

      // إضافة المادة داخل الشعبة
      await classRef.collection('subjects').doc(subjectName).set({
        'subjectName': subjectName,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم إضافة المادة بنجاح')),
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
      appBar: AppBar(title: Text('إضافة شعبة ومادة')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _classController,
              decoration: InputDecoration(labelText: 'رقم الشعبة'),
            ),
            TextField(
              controller: _subjectController,
              decoration: InputDecoration(labelText: 'اسم المادة'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addClassAndSubject,
              child: Text('إضافة الشعبة والمادة'),
            ),
          ],
        ),
      ),
    );
  }
}
