import 'package:flutter/material.dart';
import 'package:gamify_project/Safwan/Screens/safwan_games_list.dart';

void main() {
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
  final List<Map<String, dynamic>> questions = [
    {
      "text":
          "In Java, __ is defined using the class keyword. To create a copy of this object, we use the keyword __. The keyword __ is used to define properties that cannot be changed after they are set.",
      "correctAnswers": ["Class", "new", "final", "Constructor"],
      "options": [
        "Object",
        "Static",
        "new",
        "Class",
        "final",
        "Constructor",
        "immutable",
        "Inheritance",
        "interface"
      ]
    },
    {
      "text":
          "In HTML, the __ tag is used to create a hyperlink. The __ tag is used to display an image. The __ tag is used to define a paragraph.",
      "correctAnswers": ["<a>", "<img>", "<p>"],
      "options": [
        "<a>",
        "<img>",
        "<p>",
        "<div>",
        "<span>",
        "<h1>",
        "<ul>",
        "<li>",
        "<table>"
      ]
    },
  ];

  int questionIndex = 0;
  List<List<String>> userAnswers = [];

  @override
  void initState() {
    super.initState();
    userAnswers = List.generate(
      questions.length,
      (index) => List.filled(questions[index]['correctAnswers'].length, ""),
    );
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
            correctAnswers: userAnswers.asMap().entries.fold(0, (sum, entry) {
              int index = entry.key;
              List<String> user = entry.value;
              List<String> correct = questions[index]['correctAnswers'];
              return sum +
                  List.generate(
                          user.length, (i) => user[i] == correct[i] ? 1 : 0)
                      .reduce((a, b) => a + b);
            }),
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

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[questionIndex];
    final blanks = currentQuestion['correctAnswers'];
    final options = currentQuestion['options'];
    final userBlankAnswers = userAnswers[questionIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Games_list()));
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                            color: Color.fromARGB(197, 0, 129, 189)),
                      ),
                      SizedBox(height: 8),
                      DragTarget<String>(
                        builder: (context, candidateData, rejectedData) {
                          return Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                              color: userBlankAnswers[index].isEmpty
                                  ? Colors.grey[300]
                                  : Color.fromARGB(197, 0, 129, 189),
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.black),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              userBlankAnswers[index],
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
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
              SizedBox(height: 20),
              Row(
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
            ],
          ),
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
        color: isDragging ? Colors.blue[300] : Colors.grey[200],
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
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              "$correctAnswers",
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
