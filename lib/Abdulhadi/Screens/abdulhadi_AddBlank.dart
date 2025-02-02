import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print(Firebase.apps);
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
  String? _selectedSubjectId;
  String? _selectedSubjectTitle;
  final TextEditingController _questionController = TextEditingController();
  final List<TextEditingController> _blanksControllers = [];
  final List<TextEditingController> _optionsControllers = [];
  final List<int> _correctAnswers = [];
  final int _initialBlanksCount = 3;
  final int _initialOptionsCount = 4;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    for (int i = 0; i < _initialBlanksCount; i++) {
      _blanksControllers.add(TextEditingController());
    }
    for (int i = 0; i < _initialOptionsCount; i++) {
      _optionsControllers.add(TextEditingController());
    }
  }

  void _addBlank() {
    setState(() => _blanksControllers.add(TextEditingController()));
  }

  void _removeBlank() {
    if (_blanksControllers.length > 1) {
      setState(() => _blanksControllers.removeLast());
    }
  }

  void _addOption() {
    setState(() => _optionsControllers.add(TextEditingController()));
  }

  void _removeOption() {
    if (_optionsControllers.length > 1) {
      setState(() => _optionsControllers.removeLast());
    }
  }

  Future<void> _saveQuestion() async {
    if (_selectedSubjectId == null) {
      _showSnackBar('Please select a subject first');
      return;
    }

    if (!_validateForm()) {
      _showSnackBar('Please fill all required fields');
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('Blank_game').add({
        'subject_id': _selectedSubjectId,
        'subject_title': _selectedSubjectTitle,
        'question': _questionController.text.trim(),
        'blanks': _blanksControllers.map((c) => c.text.trim()).toList(),
        'options': _optionsControllers.map((c) => c.text.trim()).toList(),
        'correct_answers': _correctAnswers,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _showSnackBar('Question saved successfully!');
      _resetForm();
    } catch (e) {
      _showSnackBar('Error saving question: $e');
    }
  }

  bool _validateForm() {
    return _questionController.text.trim().isNotEmpty &&
        _blanksControllers.every((c) => c.text.trim().isNotEmpty) &&
        _optionsControllers.every((c) => c.text.trim().isNotEmpty) &&
        _correctAnswers.isNotEmpty;
  }

  void _resetForm() {
    _questionController.clear();
    _blanksControllers.forEach((c) => c.clear());
    _optionsControllers.forEach((c) => c.clear());
    _correctAnswers.clear();
    setState(() {
      _selectedSubjectId = null;
      _selectedSubjectTitle = null;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Create Blank Game',
            style: TextStyle(color: Colors.blue)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subject Selection Dropdown
            _buildSubjectDropdown(),
            const SizedBox(height: 20),

            // Question Input
            _buildQuestionField(),
            const SizedBox(height: 20),

            // Blanks Section
            _buildSectionHeader('Blanks'),
            ..._buildBlanksFields(),
            _buildAddRemoveButtons(
                _addBlank, _removeBlank, 'Add Blank', 'Remove Blank'),
            const SizedBox(height: 20),

            // Options Section
            _buildSectionHeader('Options'),
            ..._buildOptionsFields(),
            _buildAddRemoveButtons(
                _addOption, _removeOption, 'Add Option', 'Remove Option'),
            const SizedBox(height: 30),

            // Save Button
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectDropdown() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('subjects').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Text('Error loading subjects');
        if (!snapshot.hasData) return const CircularProgressIndicator();

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: DropdownButton<String>(
            isExpanded: true,
            value: _selectedSubjectId,
            hint: const Text('Select Subject'),
            items: snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return DropdownMenuItem<String>(
                value: doc.id,
                child: Text(data['title'] ?? 'Untitled Subject'),
                onTap: () => _selectedSubjectTitle = data['title'],
              );
            }).toList(),
            onChanged: (value) => setState(() => _selectedSubjectId = value),
          ),
        );
      },
    );
  }

  Widget _buildQuestionField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: _questionController,
        decoration: const InputDecoration(
          labelText: 'Question',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
        maxLines: 3,
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  List<Widget> _buildBlanksFields() {
    return _blanksControllers.asMap().entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: entry.value,
            decoration: InputDecoration(
              labelText: 'Blank ${entry.key + 1}',
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildOptionsFields() {
    return _optionsControllers.asMap().entries.map((entry) {
      return Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: entry.value,
                  decoration: InputDecoration(
                    labelText: 'Option ${String.fromCharCode(65 + entry.key)}',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Checkbox(
            value: _correctAnswers.contains(entry.key),
            onChanged: (value) => setState(() {
              value!
                  ? _correctAnswers.add(entry.key)
                  : _correctAnswers.remove(entry.key);
            }),
          )
        ],
      );
    }).toList();
  }

  Widget _buildAddRemoveButtons(
    VoidCallback addAction,
    VoidCallback removeAction,
    String addText,
    String removeText,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[100],
            foregroundColor: Colors.black,
          ),
          onPressed: addAction,
          child: Text(addText),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[100],
            foregroundColor: Colors.black,
          ),
          onPressed: removeAction,
          child: Text(removeText),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: _saveQuestion,
        child: const Text(
          'Save Question',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
