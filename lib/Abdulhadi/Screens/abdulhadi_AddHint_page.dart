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
  String? selectedSubjectId;
  String? selectedSubjectTitle;
  final List<TextEditingController> hintControllers =
      List.generate(3, (index) => TextEditingController());
  final List<TextEditingController> answerControllers =
      List.generate(4, (index) => TextEditingController());
  final ValueNotifier<int?> selectedAnswerIndex = ValueNotifier<int?>(null);

  Future<void> saveToFirestore() async {
    if (selectedSubjectId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select the subject first")),
      );
      return;
    }

    if (selectedAnswerIndex.value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select the correct answer")),
      );
      return;
    }

    final data = {
      'subject_id': selectedSubjectId,
      'subject_title': selectedSubjectTitle,
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

    try {
      await FirebaseFirestore.instance.collection('Hint_game').add(data);
      clearForm();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Question saved successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Save error: $e')),
      );
    }
  }

  void clearForm() {
    for (var controller in hintControllers) {
      controller.clear();
    }
    for (var controller in answerControllers) {
      controller.clear();
    }
    selectedAnswerIndex.value = null;
    setState(() {
      selectedSubjectId = null;
      selectedSubjectTitle = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECECEC),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Add Questions to Hint Game",
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF1A71C2),
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('subjects').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text("There was an error loading the material");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final subjects = snapshot.data!.docs;

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedSubjectId,
                    hint: const Text("Select subject"),
                    items: subjects.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return DropdownMenuItem<String>(
                        value: doc.id,
                        child: Text(data['title'] ?? "no title"),
                        onTap: () => selectedSubjectTitle = data['title'],
                      );
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => selectedSubjectId = value),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            ...List.generate(3, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: hintControllers[index],
                    decoration: InputDecoration(
                      labelText: 'Hint ${index + 1}',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 20),

            // Answer field
            ...List.generate(4, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: answerControllers[index],
                    decoration: InputDecoration(
                      labelText: 'Answer ${String.fromCharCode(65 + index)}',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Select the correct answer:",
                style: TextStyle(fontSize: 17),
              ),
            ),

            const SizedBox(height: 10),

            ValueListenableBuilder<int?>(
              valueListenable: selectedAnswerIndex,
              builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return ChoiceChip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                      backgroundColor: Colors.white,
                      label: Text(String.fromCharCode(65 + index)),
                      selected: value == index,
                      onSelected: (selected) {
                        if (selected) selectedAnswerIndex.value = index;
                      },
                      selectedColor: const Color(0xFF9ACDFF),
                    );
                  }),
                );
              },
            ),

            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6FB9FF),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                onPressed: saveToFirestore,
                child: const Text(
                  "Save Question",
                  style: TextStyle(fontSize: 17, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
