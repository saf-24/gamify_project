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
      home: GamifyPage(),
    );
  }
}

class GamifyPage extends StatefulWidget {
  @override
  _GamifyPageState createState() => _GamifyPageState();
}

class _GamifyPageState extends State<GamifyPage> {
  final List<TextEditingController> hintControllers =
      List.generate(3, (index) => TextEditingController());
  final List<TextEditingController> answerControllers =
      List.generate(4, (index) => TextEditingController());
  int? selectedAnswerIndex;

  void saveToFirestore() {
    if (selectedAnswerIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select the correct answer.')),
      );
      return;
    }

    final data = {
      'Hint1': hintControllers[0].text,
      'Hint2': hintControllers[1].text,
      'Hint3': hintControllers[2].text,
      'answer': [
        answerControllers[0].text,
        answerControllers[1].text,
        answerControllers[2].text,
        answerControllers[3].text,
      ],
      'correctAnswer': selectedAnswerIndex,
    };

    FirebaseFirestore.instance.collection('Hint_game').add(data).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Question saved successfully!')),
      );
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Gamify'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hint Fields
            HintField(controller: hintControllers[0], hintText: 'First hint:'),
            SizedBox(height: 10),
            HintField(controller: hintControllers[1], hintText: 'Second hint:'),
            SizedBox(height: 10),
            HintField(controller: hintControllers[2], hintText: 'Third hint:'),
            SizedBox(height: 20),

            // Answer Text Fields
            Expanded(
              child: Column(
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: answerControllers[index],
                      decoration: InputDecoration(
                        hintText: 'Answer ${index + 1}',
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Answer Selection Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return AnswerButton(
                  label: String.fromCharCode(65 + index), // A, B, C, D
                  isSelected: selectedAnswerIndex == index,
                  onTap: () {
                    setState(() {
                      selectedAnswerIndex = index;
                    });
                  },
                );
              }),
            ),

            SizedBox(height: 20),

            // Save Button
            Center(
              child: ElevatedButton(
                onPressed: saveToFirestore,
                child: Text('Save Question'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HintField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const HintField({required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}

class AnswerButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const AnswerButton(
      {required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.blue : Colors.grey[300],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
