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
      home: HintPage(),
    );
  }
}

class HintPage extends StatefulWidget {
  @override
  _HintPageState createState() => _HintPageState();
}

class _HintPageState extends State<HintPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> questions = [];
  int currentQuestionIndex = 0;
  int currentHintIndex = 1;
  int selectedAnswerIndex = -1;
  bool isAnswerCorrect = false;
  int incorrectAttempts = 0;
  int totalScore = 0;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('Hint_game').get();
    setState(() {
      questions = querySnapshot.docs;
    });
  }

  void _checkAnswer(int selectedIndex) {
    var currentQuestion = questions[currentQuestionIndex];
    int correctAnswer = currentQuestion['correctAnswer'];

    setState(() {
      selectedAnswerIndex = selectedIndex;
      isAnswerCorrect = selectedIndex == correctAnswer;

      if (isAnswerCorrect) {
        if (incorrectAttempts == 0) {
          totalScore += 15;
        } else if (incorrectAttempts == 1) {
          totalScore += 10;
        } else if (incorrectAttempts == 2) {
          totalScore += 5;
        }
        _goToNextQuestion();
      } else {
        incorrectAttempts++;
        if (incorrectAttempts >= 3) {
          _goToNextQuestion();
        } else if (currentHintIndex < 3) {
          currentHintIndex++;
        }
      }
    });
  }

  void _saveScoreToFirebase(int score) async {
    await _firestore.collection('leaderboard').add({
      'name': 'Player',
      'score': score,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  void _goToNextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        currentHintIndex = 1;
        selectedAnswerIndex = -1;
        isAnswerCorrect = false;
        incorrectAttempts = 0;
      } else {
        _saveScoreToFirebase(totalScore);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsPage(score: totalScore),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return Scaffold(
        backgroundColor: Color(0xFFE6F7FF),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    var currentQuestion = questions[currentQuestionIndex];
    String hint = currentQuestion['Hint$currentHintIndex'];
    List<dynamic> answers = currentQuestion['answer'];

    return Scaffold(
      backgroundColor: Color(0xFFE6F7FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.close, color: Colors.black, size: 30),
                ),
              ),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: 'Hint $currentHintIndex: ',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1D4E89),
                  ),
                  children: [
                    TextSpan(
                      text: hint,
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFFFA500),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              ...answers.asMap().entries.map((entry) {
                int index = entry.key;
                String answerText = entry.value;

                return GestureDetector(
                  onTap: () {
                    if (!isAnswerCorrect) {
                      _checkAnswer(index);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: selectedAnswerIndex == index
                          ? (isAnswerCorrect ? Colors.green : Colors.red)
                          : Color(0xFF87CEEB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      answerText,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
              Spacer(),
              ElevatedButton(
                onPressed: isAnswerCorrect ? _goToNextQuestion : null,
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(16),
                  backgroundColor:
                      isAnswerCorrect ? Color(0xFF1D4E89) : Colors.grey,
                ),
                child: Icon(Icons.arrow_forward, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'Question ${currentQuestionIndex + 1}/${questions.length}',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultsPage extends StatelessWidget {
  final int score;

  ResultsPage({required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Results'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your Score',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('$score',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}
