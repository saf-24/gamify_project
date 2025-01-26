import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClassSubjectsPage extends StatelessWidget {
  final String className;

  ClassSubjectsPage({required this.className});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('المواد في الشعبة')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('classes')
            .doc(className)
            .collection('subjects')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var subjects = snapshot.data!.docs;

          return ListView.builder(
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              var subject = subjects[index];
              return ListTile(
                title: Text(subject['subjectName']),
                onTap: () {
                  // عند الضغط على المادة، انتقل إلى صفحة الدروس
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LessonsPage(
                        className: className,
                        subjectName: subject['subjectName'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class LessonsPage extends StatelessWidget {
  final String className;
  final String subjectName;

  LessonsPage({required this.className, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('الدروس في مادة $subjectName')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('classes')
            .doc(className)
            .collection('subjects')
            .doc(subjectName)
            .collection('lessons')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var lessons = snapshot.data!.docs;

          return ListView.builder(
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              var lesson = lessons[index];
              return ListTile(
                title: Text(lesson['lessonName']),
                subtitle: Text('نسبة الاكتمال: ${lesson['completionPercentage']}%'),
                onTap: () {
                  // هنا يمكن أن تذهب إلى صفحة تفاصيل الدرس
                },
              );
            },
          );
        },
      ),
    );
  }
}
