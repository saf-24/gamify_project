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
      home: AddLessonAndQuestionsScreen(),
    );
  }
}

class AddLessonAndQuestionsScreen extends StatefulWidget {
  @override
  _AddLessonAndQuestionsScreenState createState() =>
      _AddLessonAndQuestionsScreenState();
}

class _AddLessonAndQuestionsScreenState
    extends State<AddLessonAndQuestionsScreen> {
  final TextEditingController lessonTitleController = TextEditingController();
  final TextEditingController questionController = TextEditingController();
  final List<TextEditingController> answerControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  final ValueNotifier<int?> correctAnswerNotifier = ValueNotifier<int?>(null);

  void saveQuestion() {
    final lessonTitle = lessonTitleController.text;
    final question = questionController.text;
    final answers = answerControllers.map((c) => c.text).toList();
    final correctAnswer = correctAnswerNotifier.value;

    if (lessonTitle.isEmpty ||
        question.isEmpty ||
        answers.any((answer) => answer.isEmpty) ||
        correctAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields!')),
      );
      return;
    }

    FirebaseFirestore.instance.collection('questions').add({
      'lesson_id': lessonTitle,
      'question': question,
      'answers': answers,
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
        SnackBar(content: Text('Failed to save question: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Lesson and Questions'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: lessonTitleController,
              decoration: InputDecoration(
                labelText: 'Lesson Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
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
                onPressed: saveQuestion,
                child: Text('Save Question'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
