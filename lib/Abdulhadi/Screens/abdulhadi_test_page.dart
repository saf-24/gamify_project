import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  String _questionText = '';
  List<String> _answers = [];
  int _correctAnswerIndex = -1;
  int _questionIndex = 0;
  int _totalCorrectAnswers = 0;
  List<DocumentSnapshot> _questions = [];

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('questions').get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          _questions = querySnapshot.docs;
          _loadQuestion();
        });
      } else {
        _navigateToResults();
      }
    } catch (e) {
      setState(() {
        _questionText = 'Error fetching questions';
        _isLoading = false;
      });
    }
  }

  void _loadQuestion() {
    if (_questionIndex < _questions.length) {
      final data = _questions[_questionIndex].data() as Map<String, dynamic>;
      setState(() {
        _questionText = data['question'] ?? 'No question available';
        _answers = List<String>.from(data['answer'] ?? []);
        _correctAnswerIndex = data['correctAnswer'] ?? -1;
        _isLoading = false;
      });
    } else {
      _navigateToResults();
    }
  }

  void _onAnswerSelected(int index) {
    setState(() {
      _selectedAnswerIndex = index;
    });
  }

  void _submitAnswer() {
    if (_selectedAnswerIndex == _correctAnswerIndex) {
      _totalCorrectAnswers++;
    }

    setState(() {
      _selectedAnswerIndex = -1;
      _questionIndex++;
      _isLoading = true;
    });

    _loadQuestion();
  }

  void _navigateToResults() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsPage(score: _totalCorrectAnswers),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf4f4f4),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Gamify",
          style: TextStyle(
            color: Color(0xFF007ab9),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Question ${_questionIndex + 1}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        )
                      ],
                    ),
                    child: Text(
                      _questionText,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _answers.length,
                      itemBuilder: (context, index) {
                        String letter = String.fromCharCode(
                            65 + index); // Generate A, B, C, ...
                        return GestureDetector(
                          onTap: () => _onAnswerSelected(index),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: _selectedAnswerIndex == index
                                  ? Colors.blue[100]
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: _selectedAnswerIndex == index
                                    ? Colors.blue
                                    : Colors.grey[300]!,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "$letter. ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    _answers[index],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _submitAnswer,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                        backgroundColor: Color(0xFF007ab9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        "Next",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class ResultsPage extends StatelessWidget {
  final int score;

  const ResultsPage({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf4f4f4),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Results",
          style: TextStyle(
            color: Color(0xFF007ab9),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your Score",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "$score",
              style: TextStyle(fontSize: 48, color: Colors.blue),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF007ab9),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "Back to Home",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
