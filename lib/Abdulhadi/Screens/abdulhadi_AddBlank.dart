import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class CreateBlankGamePage extends StatefulWidget {
  @override
  _CreateBlankGamePageState createState() => _CreateBlankGamePageState();
}

class _CreateBlankGamePageState extends State<CreateBlankGamePage> {
  final TextEditingController _questionController = TextEditingController();
  final _blanksControllers = <TextEditingController>[];
  final _optionsControllers = <TextEditingController>[];
  final _correctAnswers = <int>[];
  int blanksCount = 3;
  int optionsCount = 4;

  @override
  void initState() {
    super.initState();
    // Initialize with default blank and options controllers
    for (int i = 0; i < blanksCount; i++) {
      _blanksControllers.add(TextEditingController());
    }
    for (int i = 0; i < optionsCount; i++) {
      _optionsControllers.add(TextEditingController());
    }
  }

  void addBlank() {
    setState(() {
      _blanksControllers.add(TextEditingController());
    });
  }

  void addOption() {
    setState(() {
      _optionsControllers.add(TextEditingController());
    });
  }

  void removeBlank() {
    if (_blanksControllers.isNotEmpty) {
      setState(() {
        _blanksControllers.removeLast();
      });
    }
  }

  void removeOption() {
    if (_optionsControllers.isNotEmpty) {
      setState(() {
        _optionsControllers.removeLast();
      });
    }
  }

  Future<void> saveQuestion() async {
    // Collect the question, blanks, options, and correct answers
    final question = _questionController.text.trim();
    final blanks = _blanksControllers.map((c) => c.text.trim()).toList();
    final options = _optionsControllers.map((c) => c.text.trim()).toList();

    // Validate input
    if (question.isEmpty ||
        blanks.isEmpty ||
        options.isEmpty ||
        _correctAnswers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Please fill all fields and select correct answers")),
      );
      return;
    }

    try {
      // Save question to Firestore
      await FirebaseFirestore.instance.collection('Blank_game').add({
        'question': question,
        'blanks': blanks,
        'options': options,
        'correct_answers': _correctAnswers,
        'created_at': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Question saved successfully!")),
      );

      // Clear fields
      setState(() {
        _questionController.clear();
        _blanksControllers.forEach((controller) => controller.clear());
        _optionsControllers.forEach((controller) => controller.clear());
        _correctAnswers.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving question: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Blank Game"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Question input
              TextField(
                controller: _questionController,
                decoration: InputDecoration(
                  labelText: "Question",
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              SizedBox(height: 20),
              // Section for blanks
              Text("Blanks:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ..._blanksControllers.asMap().entries.map((entry) {
                int index = entry.key;
                return TextField(
                  controller: entry.value,
                  decoration: InputDecoration(
                    labelText: "Blank ${index + 1}",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 1,
                );
              }).toList(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(onPressed: addBlank, child: Text("Add Blank")),
                  ElevatedButton(
                      onPressed: removeBlank, child: Text("Remove Blank")),
                ],
              ),
              SizedBox(height: 20),
              // Section for options
              Text("Options:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ..._optionsControllers.asMap().entries.map((entry) {
                int index = entry.key;
                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: entry.value,
                        decoration: InputDecoration(
                          labelText: "Option ${index + 1}",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Checkbox(
                      value: _correctAnswers.contains(index),
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            _correctAnswers.add(index);
                          } else {
                            _correctAnswers.remove(index);
                          }
                        });
                      },
                    )
                  ],
                );
              }).toList(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: addOption, child: Text("Add Option")),
                  ElevatedButton(
                      onPressed: removeOption, child: Text("Remove Option")),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveQuestion,
                child: Text("Save Question"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MaterialApp(
    home: CreateBlankGamePage(),
  ));
}
