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
  final ValueNotifier<int?> selectedAnswerIndex = ValueNotifier<int?>(null);

  void saveToFirestore() {
    if (selectedAnswerIndex.value == null) {
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
      'correctAnswer': selectedAnswerIndex.value,
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
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Questions to Hint Game',
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
            // Hint Fields
            ...List.generate(3, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(28.0)),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: hintControllers[index],
                    decoration: InputDecoration(
                      labelText: 'Hint ${index + 1}',
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(28.0)),
                      ),
                    ),
                  ),
                ),
              );
            }),
            SizedBox(height: 16),

            // Answer Text Fields
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
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(28.0)),
                      ),
                    ),
                  ),
                ),
              );
            }),

            SizedBox(height: 16),

            Center(
              child: Text(
                'Select the correct answer:',
                style: TextStyle(fontSize: 17),
              ),
            ),

            SizedBox(height: 10),

            ValueListenableBuilder<int?>(
              valueListenable: selectedAnswerIndex,
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
                        if (selected) selectedAnswerIndex.value = index;
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
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 111, 185, 255),
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                  ),
                ),
                onPressed: saveToFirestore,
                child: Text(
                  'Save Question',
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
