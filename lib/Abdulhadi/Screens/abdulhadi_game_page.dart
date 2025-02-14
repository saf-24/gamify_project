import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // إضافة استيراد FirebaseAuth
import 'package:gamify_project/Abdulhadi/Screens/brbrly.dart';
import 'package:gamify_project/Safwan/Screens/safwan_games_list.dart';
import 'package:gamify_project/Safwan/Screens/test_fire_2.dart';
import 'package:gamify_project/zayed/Screens/zayed_courses_page.dart';
import 'package:gamify_project/zayed/Screens/zayed_leaderboard_page.dart';

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
      
    );
  }
}

class HintPage extends StatefulWidget {
  final String fullName;
  final String email;
  final String major;
  final String course_name;
  

  HintPage({
    required this.fullName,
    required this.email,
    required this.major,
    required this.course_name,
  });

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

  String playerUID = "playerUID"; // استبدل هذا بـ UID الحقيقي
  String playerName = "Unknown Player";

  @override
  void initState() {
    super.initState();
    _initializePlayerData(); // استدعاء دالة تهيئة البيانات
    _loadQuestions();
  }

  // دالة تهيئة بيانات اللاعب
  Future<void> _initializePlayerData() async {
    // الحصول على UID للمستخدم الحالي
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid; // الحصول على الـ UID للمستخدم الحالي
      String fetchedName = await _fetchPlayerName(uid);
      setState(() {
        playerName = fetchedName; // تحديث اسم اللاعب
      });
    }
  }

  // دالة لجلب اسم اللاعب باستخدام UID
  Future<String> _fetchPlayerName(String uid) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Login_info')
          .doc(uid)
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        print("Fetched player name: ${userDoc['full_name']}");
        return userDoc['full_name']; // تأكد أن الحقل مطابق لقاعدة البيانات
      } else {
        print("Player not found or data is missing.");
        return 'Unknown Player';
      }
    } catch (e) {
      print("Error fetching player name: $e");
      return 'Unknown Player';
    }
  }

  // دالة لتحميل الأسئلة من Firebase
  Future<void> _loadQuestions() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('Hint_game').where('subject_title',isEqualTo: widget.course_name).get();
    setState(() {
      questions = querySnapshot.docs;
    });
  }

  // دالة للتحقق من الإجابة
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

  // دالة لحفظ النقاط في Firebase
  void _saveScoreToFirebase(int score) async {
    try {
      await _firestore.collection('Leaderboard').add({
        'name': playerName,
        'score': score,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print("Score saved successfully!");
    } catch (e) {
      print("Error saving score: $e");
    }
  }

  // دالة للانتقال إلى السؤال التالي
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsPage(score: totalScore,fullName:widget.fullName,email: widget.email,major: widget.major,),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 230, 230, 230),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    var currentQuestion = questions[currentQuestionIndex];
    String hint = currentQuestion['Hint$currentHintIndex'];
    List<dynamic> answers = currentQuestion['answer'];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => GamifyScreen(fullName: widget.fullName,email: widget.email,major: widget.major,)));
                  },
                  child: Icon(Icons.close,
                      color: Color.fromARGB(197, 0, 129, 189), size: 45),
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
  final String fullName;
  final String email;
  final String major;
  

  ResultsPage({required this.score,required this.fullName,
    required this.email,
    required this.major,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        title: Text('Results'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
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
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      
                      children: [
                        ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => ZayedLeaderboardPage(fullName:fullName,email: email,major: major,)));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color.fromARGB(197, 0, 129, 189),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                      ),
                                      child: Text(
                                        "Leaderboard",
                                        style: TextStyle(fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(width: 20,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => St_home_page2(fullName:fullName,email: email,major: major,)));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(197, 0, 129, 189),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                "back to home",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
                      ],
                    ),
          ],
        ),
      ),
    );
  }
}
