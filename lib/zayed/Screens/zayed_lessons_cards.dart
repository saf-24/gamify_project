
import 'package:flutter/material.dart';


class Lessons_cards extends StatelessWidget {
  final String lessonTitle;
  final int chapterNumber;
  final String date;

  const Lessons_cards({
    super.key,
    required this.lessonTitle,
    required this.chapterNumber,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(17, 0, 0, 0),
      width: 400,
      height: 199,
      child: SizedBox(
        width: 323,
        height: 22,
        child: Stack(
          children: [
            // Reposition the ElevatedButton using Positioned
            Positioned(
              top: 0,
              left: 0,
              right: 10,
              bottom: 9,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 9, 17, 18),
                child: ElevatedButton(
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Container(), // Add an empty container as the child
                ),
              ),
            ),
            Positioned(
              top: 43,
              left: 34,
              child: Text(
                lessonTitle,
                style: TextStyle(
                  fontSize: 25,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3,
                ),
              ),
            ),
            Positioned(
              top: 132,
              left: 34,
              child: Text(
                date,
                style: TextStyle(
                  fontSize: 14,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w500,
                  wordSpacing: 2,
                  letterSpacing: 3,
                ),
              ),
            ),
            Positioned(
              top: 90,
              left: 34,
              child: SizedBox(
                width: 320,
                child: Text(
                  "Chapter $chapterNumber",
                  style: TextStyle(
                    fontSize: 17.6,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    wordSpacing: 2,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(9, 0, 0, 0),
              width: 359,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: Color.fromARGB(255, 0, 129, 189),
              
              ),
            ),
          ],
        ),
      ),
    );
  }
}
