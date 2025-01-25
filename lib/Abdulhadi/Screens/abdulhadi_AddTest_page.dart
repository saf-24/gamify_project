import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddLessonsScreen(),
    );
  }
}

class AddLessonsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.menu, color: Colors.blue),
        title: Text(
          'Gamify',
          style: TextStyle(
              color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Icon(Icons.notifications, color: Colors.blue),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Test',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Lesson Title:',
                hintText: 'Lesson title here..',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildLessonCard('Add a questions', context),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonCard(String title, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Manually add questions to your question bank.',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddQuestionScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text('Add Questions', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFileUploadCard(String title) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Upload your lesson content as a file.',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Logic to upload a file can be added here
                    print("Upload file button pressed");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text('Upload File', style: TextStyle(fontSize: 16)),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Logic to save the file information to Firestore or perform another action
                    print("Save lesson content button pressed");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text('Save', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddQuestionScreen extends StatelessWidget {
  final TextEditingController questionController = TextEditingController();
  final List<TextEditingController> answerControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  final ValueNotifier<int?> correctAnswerNotifier = ValueNotifier<int?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Questions'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: questionController,
              decoration: InputDecoration(
                labelText: 'Question',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ...List.generate(4, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: answerControllers[index],
                  decoration: InputDecoration(
                    labelText: 'Answer ${String.fromCharCode(65 + index)}',
                    border: OutlineInputBorder(),
                  ),
                ),
              );
            }),
            SizedBox(height: 16),
            Text('Select the correct answer:'),
            ValueListenableBuilder<int?>(
              valueListenable: correctAnswerNotifier,
              builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return ChoiceChip(
                      label: Text(String.fromCharCode(65 + index)),
                      selected: value == index,
                      onSelected: (selected) {
                        if (selected) correctAnswerNotifier.value = index;
                      },
                    );
                  }),
                );
              },
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final question = questionController.text;
                  final answers = answerControllers.map((c) => c.text).toList();
                  final correctAnswer = correctAnswerNotifier.value;

                  if (question.isNotEmpty &&
                      answers.every((answer) => answer.isNotEmpty) &&
                      correctAnswer != null) {
                    FirebaseFirestore.instance.collection('questions').add({
                      'question': question,
                      'answer': answers,
                      'correctAnswer': correctAnswer,
                    }).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Question saved successfully!')),
                      );
                      questionController.clear();
                      for (var controller in answerControllers) {
                        controller.clear();
                      }
                      correctAnswerNotifier.value = null;
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Failed to save question: $error')),
                      );
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill out all fields!')),
                    );
                  }
                },
                child: Text('Save Question'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
