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
      home: CreateBlankGamePage(),
    );
  }
}

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
    final question = _questionController.text.trim();
    final blanks = _blanksControllers.map((c) => c.text.trim()).toList();
    final options = _optionsControllers.map((c) => c.text.trim()).toList();

    if (question.isEmpty || blanks.isEmpty || options.isEmpty || _correctAnswers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields and select correct answers")),
      );
      return;
    }

    try {
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
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Blank Game Questions',
          style: TextStyle(
            fontSize: 18,
            color: const Color.fromARGB(255, 26, 113, 194),
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question Field
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(28.0)),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: _questionController,
                  decoration: InputDecoration(
                    labelText: 'Question',
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(28.0)),
                    ),
                  ),
                  maxLines: 2,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Blanks Section
            Text("Blanks:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ..._blanksControllers.asMap().entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(28.0)),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: entry.value,
                    decoration: InputDecoration(
                      labelText: "Blank ${entry.key + 1}",
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(28.0)),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  
                  style: ElevatedButton.styleFrom(
                    elevation: 3.5,
                    backgroundColor:  const Color.fromARGB(255, 111, 255, 135),
                  ),
                  onPressed: addBlank, child: Text("Add Blank",style: TextStyle(color: Colors.black),)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3.5,
                    backgroundColor:  const Color.fromARGB(255, 255, 75, 75),
                  ),
                  onPressed: removeBlank, child: Text("Remove Blank",style: TextStyle(color: Colors.black),)),
              ],
            ),

            SizedBox(height: 30),

            // Options Section
            Text("Options:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ..._optionsControllers.asMap().entries.map((entry) {
              return Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(28.0)),
                          color: Colors.white,
                        ),
                        child: TextField(
                          controller: entry.value,
                          decoration: InputDecoration(
                            labelText: "Option ${entry.key + 1}",
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(28.0)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Checkbox(
                    value: _correctAnswers.contains(entry.key),
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          _correctAnswers.add(entry.key);
                        } else {
                          _correctAnswers.remove(entry.key);
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
                  style: ElevatedButton.styleFrom(
                    elevation: 3.5,
                    backgroundColor:  const Color.fromARGB(255, 111, 255, 135),
                  ),
                  
                  onPressed: addOption, child: Text("Add Option")),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3.5,
                    backgroundColor:  const Color.fromARGB(255, 255, 75, 75),
                  ),
                  
                  onPressed: removeOption, child: Text("Remove Option")),
              ],
            ),

            SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 111, 185, 255),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                ),
                onPressed: saveQuestion,
                child: Text("Save Question", style: TextStyle(fontSize: 17)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
