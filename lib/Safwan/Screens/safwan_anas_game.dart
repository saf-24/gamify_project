import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gamify_project/Safwan/Screens/safwan_games_list.dart';

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
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          secondary: Color.fromARGB(197, 0, 129, 189),
        ),
      ),
      home: PuzzleGameScreen(),
    );
  }
}

class PuzzleGameScreen extends StatefulWidget {
  @override
  _PuzzleGameScreenState createState() => _PuzzleGameScreenState();
}

class _PuzzleGameScreenState extends State<PuzzleGameScreen> {
  List<Map<String, dynamic>> questions = [];
  int questionIndex = 0;
  List<List<String>> userAnswers = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Blank_game').get();

      List<Map<String, dynamic>> loadedQuestions = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        List<String> options = List<String>.from(data['options']);
        List<int> correctIndices = List<int>.from(data['correct_answers']);
        List<String> correctAnswers =
            correctIndices.map((index) => options[index]).toList();

        loadedQuestions.add({
          'text': data['question'],
          'correctAnswers': correctAnswers,
          'options': options,
        });
      }

      setState(() {
        questions = loadedQuestions;
        userAnswers = List.generate(
          loadedQuestions.length,
          (index) =>
              List.filled(loadedQuestions[index]['correctAnswers'].length, ""),
        );
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load questions. Please try again.';
      });
    }
  }

  void resetAnswers() {
    setState(() {
      userAnswers[questionIndex] =
          List.filled(questions[questionIndex]['correctAnswers'].length, "");
    });
  }

  void nextQuestion() {
    if (questionIndex < questions.length - 1) {
      setState(() {
        questionIndex++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            totalQuestions: questions.fold<int>(
                0, (sum, q) => sum + (q['correctAnswers'].length as int)),
            correctAnswers: _calculateTotalScore(),
          ),
        ),
      );
    }
  }

  void previousQuestion() {
    if (questionIndex > 0) {
      setState(() {
        questionIndex--;
      });
    }
  }

  int _calculateCurrentQuestionScore() {
    int score = 0;
    List<String> user = userAnswers[questionIndex];
    List<String> correct = questions[questionIndex]['correctAnswers'];
    for (int i = 0; i < user.length; i++) {
      if (user[i] == correct[i]) score++;
    }
    return score;
  }

  int _calculateTotalScore() {
    int total = 0;
    for (int i = 0; i < questions.length; i++) {
      List<String> user = userAnswers[i];
      List<String> correct = questions[i]['correctAnswers'];
      for (int j = 0; j < user.length; j++) {
        if (user[j] == correct[j]) total++;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: _buildAppBar(),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage.isNotEmpty) {
      return Scaffold(
        appBar: _buildAppBar(),
        body: Center(child: Text(errorMessage)),
      );
    }

    if (questions.isEmpty) {
      return Scaffold(
        appBar: _buildAppBar(),
        body: Center(child: Text('No questions available.')),
      );
    }

    final currentQuestion = questions[questionIndex];
    final blanks = currentQuestion['correctAnswers'];
    final options = currentQuestion['options'];
    final userBlankAnswers = userAnswers[questionIndex];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Header with question number and score
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Question ${questionIndex + 1}/${questions.length}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(197, 0, 129, 189),
                  ),
                ),
              ],
            ),
          ),

          // Question content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    currentQuestion['text'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      blanks.length,
                      (index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Blank ${index + 1}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(197, 0, 129, 189),
                            ),
                          ),
                          SizedBox(height: 8),
                          DragTarget<String>(
                            builder: (context, candidateData, rejectedData) {
                              return Container(
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: userBlankAnswers[index].isEmpty
                                      ? Colors.grey[100]
                                      : (userBlankAnswers[index] ==
                                              blanks[index]
                                          ? Colors.lightBlue
                                          : Colors.lightBlue),
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(color: Colors.black),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  userBlankAnswers[index],
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              );
                            },
                            onAccept: (data) {
                              setState(() {
                                userBlankAnswers[index] = data;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.black),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: options.map<Widget>((option) {
                      return Draggable<String>(
                        data: option,
                        child: OptionChip(option: option),
                        feedback: OptionChip(option: option, isDragging: true),
                        childWhenDragging: Opacity(
                          opacity: 0.4,
                          child: OptionChip(option: option),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),

          // Bottom buttons
          Container(
            color: const Color.fromARGB(255, 230, 230, 230),
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 226, 0, 0),
                  ),
                  onPressed: resetAnswers,
                  child: Text("Reset", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(197, 0, 129, 189),
                  ),
                  onPressed: previousQuestion,
                  child: Text("Back", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: nextQuestion,
                  child: Text("Next", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Align(
        alignment: Alignment.center,
        child: IconButton(
          icon: Icon(
            Icons.close,
            color: Color.fromARGB(197, 0, 129, 189),
            size: 50,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Games_list()));
          },
        ),
      ),
    );
  }
}

class OptionChip extends StatelessWidget {
  final String option;
  final bool isDragging;

  OptionChip({required this.option, this.isDragging = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 3),
      padding: EdgeInsets.symmetric(horizontal: 17, vertical: 9),
      decoration: BoxDecoration(
        color: isDragging ? Colors.blue[300] : Colors.grey[100],
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Color.fromARGB(197, 0, 129, 189), width: 2),
      ),
      child: Text(
        option,
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;

  ResultScreen({required this.totalQuestions, required this.correctAnswers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 230, 230, 230),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment.center,
          child: Text(
            "Results",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your Score",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "$correctAnswers/$totalQuestions",
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(197, 0, 129, 189),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Games_list()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(197, 0, 129, 189),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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
