import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gamify_project/zayed/Screens/zayed_courses_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContentPage extends StatefulWidget {
  final String lesson_name;

  const ContentPage({
    super.key,
    required this.lesson_name,
  });

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  String? courseName;
  String? lessonName;
  String? lessonContent;
  bool _isProgressUpdated = false;
  final String userId = FirebaseAuth.instance.currentUser?.uid ?? "guest";

  @override
  void initState() {
    super.initState();
    fetchLessonContent();
    checkUserProgress();
  }

  void fetchLessonContent() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('lesson_content')
        .where('lesson_name', isEqualTo: widget.lesson_name)
        .get();
    if (snapshot.docs.isNotEmpty) {
      var data = snapshot.docs.last.data() as Map<String, dynamic>;
      setState(() {
        courseName = data['course_name'];
        lessonName = data['lesson_name'];
        lessonContent = data['text_content'];
      });
    }
  }

  void checkUserProgress() async {
    DocumentSnapshot userProgress = await FirebaseFirestore.instance
        .collection('user_progress')
        .doc(userId)
        .get();
    
    if (userProgress.exists) {
      Map<String, dynamic> progressData = userProgress.data() as Map<String, dynamic>;
      if (progressData.containsKey(widget.lesson_name)) {
        setState(() {
          _isProgressUpdated = true;
        });
      }
    }
  }

  void updateHighestProgress() async {
    if (_isProgressUpdated || courseName == null) {
      return;
    }

    try {
      QuerySnapshot subjectSnapshot = await FirebaseFirestore.instance
          .collection('subjects')
          .where('title', isEqualTo: courseName)
          .get();

      if (subjectSnapshot.docs.isNotEmpty) {
        String subjectId = subjectSnapshot.docs.first.id;
        int currentHighestProgress = subjectSnapshot.docs.first['highestProgres'] ?? 0;

        await FirebaseFirestore.instance.collection('subjects').doc(subjectId).update({
          'highestProgres': currentHighestProgress + 1,
        });

        await FirebaseFirestore.instance.collection('user_progress').doc(userId).set({
          widget.lesson_name: true,
        }, SetOptions(merge: true));

        setState(() {
          _isProgressUpdated = true;
        });
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update progress: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      appBar: AppBar(
        toolbarHeight: 65,
        title: const Text(
          "Gamify",
          style: TextStyle(
              fontSize: 32,
              color: Color.fromARGB(197, 0, 129, 189),
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            tooltip: "notifications",
            icon: const Icon(
              Icons.notifications_none,
              size: 39.4,
              color: Color.fromARGB(197, 0, 129, 189),
            ),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          tooltip: "Menu",
          icon: const Icon(
            Icons.arrow_back,
            size: 43.4,
            color: Color.fromARGB(197, 0, 129, 189),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lessonName ?? '',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            Text(
              lessonContent ?? 'No data found!',
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 40),
            Center(
              child: SizedBox(
                height: 53,
                width: 160,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(197, 0, 129, 189),
                  ),
                  onPressed: () async {
                    updateHighestProgress();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Zayed_standard_navigations(),
                      ),
                    );
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 26, color: Colors.white),
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