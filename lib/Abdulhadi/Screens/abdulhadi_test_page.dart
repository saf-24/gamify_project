import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TestPage(),
    );
  }
}

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int _selectedAnswerIndex = -1;
  bool _isLoading = true;
  String? _questionText;
  List<String>? _answers;
  int? _correctAnswerIndex;

  @override
  void initState() {
    super.initState();
    _fetchQuestion();
  }

  Future<void> _fetchQuestion() async {
    try {
      // Fetch question from Firestore
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('questions')
          .doc('wldn95QOXjCxdCtEYUYQ') // Replace with your document ID
          .get();

      if (doc.exists) {
        setState(() {
          _questionText = doc['question'];
          _answers = List<String>.from(doc['answers']);
          _correctAnswerIndex = doc['correctAnswerIndex'];
          _isLoading = false;
        });
      } else {
        print("Document does not exist");
      }
    } catch (e) {
      print("Error fetching question: $e");
    }
  }

  void _onAnswerSelected(int index) {
    setState(() {
      _selectedAnswerIndex = index;
    });

    // Check if the answer is correct
    if (index == _correctAnswerIndex) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Correct Answer!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Wrong Answer. Try Again!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // App Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.menu, size: 28, color: Colors.black),
                        Text(
                          "Gamify",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Icon(Icons.notifications,
                            size: 28, color: Colors.black),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Image Placeholder
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          "Image Placeholder",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Question
                    Text(
                      _questionText ?? "Loading question...",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    // Answer Buttons
                    if (_answers != null)
                      ..._answers!.asMap().entries.map((entry) {
                        int index = entry.key;
                        String answer = entry.value;
                        return GestureDetector(
                          onTap: () => _onAnswerSelected(index),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 12.0,
                            ),
                            decoration: BoxDecoration(
                              color: _selectedAnswerIndex == index
                                  ? Colors.green
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _selectedAnswerIndex == index
                                    ? Colors.green
                                    : Colors.grey[400]!,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    String.fromCharCode(
                                        65 + index), // A, B, C, D
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  answer,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),

                    const Spacer(),

                    // Next Button
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle next action
                          print("Next question...");
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(16),
                          backgroundColor: Colors.blue,
                        ),
                        child: const Icon(Icons.arrow_forward,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
