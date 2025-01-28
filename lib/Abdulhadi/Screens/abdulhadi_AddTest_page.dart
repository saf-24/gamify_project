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
        SnackBar(content: Text('Failed to save question: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Lesson and Questions',style: TextStyle(fontSize: 18,color: const Color.fromARGB(255, 26, 113, 194),fontWeight:FontWeight.w500 ),),
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
              
                controller: lessonTitleController,
                decoration: InputDecoration(
                  labelText: 'Lesson Title',
                  
                  border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(28.0),),),
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
                controller: questionController,
                decoration: InputDecoration(
                  labelText: 'Question',
                  border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(28.0))),
                ),
              ),
            ),
            SizedBox(height: 6),
            ...List.generate(4, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(28.0)),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: answerControllers[index],
                    decoration: InputDecoration(
                      labelText: 'Answer ${String.fromCharCode(65 + index)}',
                      border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(28.0))),
                    ),
                  ),
                ),
              );
            }),
            SizedBox(height: 16),
            Center(child: Text('Select the correct answer:',style: TextStyle(fontSize: 17),)),
            SizedBox(height: 10),
            ValueListenableBuilder<int?>(
              valueListenable: correctAnswerNotifier,
              builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return ChoiceChip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17.0),
                      ),
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      label: Text(String.fromCharCode(65 + index)),
                      selected: value == index,
                        onSelected: (selected) {
                        if (selected) correctAnswerNotifier.value = index;
                        },
                        selectedColor: const Color.fromARGB(255, 154, 206, 255),
                      
                      
                    );
                  }),
                );
              },
            ),
            SizedBox(height: 35),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 111, 185, 255),),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                  ),
                ),
                onPressed: saveQuestion,
                child: Text('Save Question',style: TextStyle(fontSize: 17),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
