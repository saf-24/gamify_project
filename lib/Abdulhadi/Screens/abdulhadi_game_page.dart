import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HintPage(),
    );
  }
}

class HintPage extends StatefulWidget {
  const HintPage({super.key});

  @override
  _HintPageState createState() => _HintPageState();
}

class _HintPageState extends State<HintPage> {
  int _selectedAnswerIndex = -1; // Track the selected answer

  void _onAnswerSelected(int index) {
    setState(() {
      _selectedAnswerIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6A4BA3), // Purple background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Close button
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    // Handle close button action
                  },
                  child: Icon(Icons.close, color: Colors.white, size: 30),
                ),
              ),
              SizedBox(height: 20),
              // Hint section
              RichText(
                text: TextSpan(
                  text: 'first hint: ',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD1B5F5), // Light purple
                  ),
                  children: const [
                    TextSpan(
                      text: '15 points',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFFFD700), // Gold
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'It is the basis of object-oriented programming in Java:',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              // Add spacing before the divider
              SizedBox(height: 30),
              Divider(
                color: Colors.white54,
                thickness: 1,
                height: 80,
              ),
              // Add spacing before the answers
              SizedBox(height: 20),
              // Answer buttons
              AnswerButton(
                label: 'A',
                text: 'Object',
                isSelected: _selectedAnswerIndex == 0,
                onTap: () => _onAnswerSelected(0),
              ),
              AnswerButton(
                label: 'B',
                text: 'Class',
                isSelected: _selectedAnswerIndex == 1,
                onTap: () => _onAnswerSelected(1),
              ),
              AnswerButton(
                label: 'C',
                text: 'Interface',
                isSelected: _selectedAnswerIndex == 2,
                onTap: () => _onAnswerSelected(2),
              ),
              AnswerButton(
                label: 'D',
                text: 'Package',
                isSelected: _selectedAnswerIndex == 3,
                onTap: () => _onAnswerSelected(3),
              ),
              Spacer(),
              // Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // "Next hint!" button
                  ElevatedButton(
                    onPressed: () {
                      // Handle next hint action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFB394F6), // Purple
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 30,
                      ),
                    ),
                    child: Text(
                      'Next hint!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // Arrow button
                  ElevatedButton(
                    onPressed: () {
                      // Handle forward action
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(16),
                      backgroundColor: Color(0xFFB394F6), // Purple
                    ),
                    child: Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 10),
              // Question info
              Text(
                '2 try left\nQuestion 1/10',
                style: TextStyle(
                  color: Colors.white70,
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

class AnswerButton extends StatelessWidget {
  final String label;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const AnswerButton({super.key, 
    required this.label,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: isSelected
              ? Color(0xFF9673D4)
              : Color(0xFFB394F6), // Selected/Unselected colors
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Label
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A4BA3), // Purple text
                ),
              ),
            ),
            SizedBox(width: 16),
            // Answer text
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
