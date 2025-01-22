
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';


class Quiz_cards extends StatelessWidget {
  final String lessonTitle;
  final int chapterNumber;
  final String date;
  final double grade;
  final int Qnumber;

  const Quiz_cards({
    super.key,
    required this.lessonTitle,
    required this.chapterNumber,
    required this.date,
    required this.grade,
    required this.Qnumber,
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
              top: 50,
              left: 31,
              child: Text(
                lessonTitle,
                style: TextStyle(
                  fontSize: 26,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3,
                ),
              ),
            ),
            Positioned(
              top: 137,
              left: 31,
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
              top: 100,
              left: 33,
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
              Positioned(
              bottom: 150,
              child: LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 31,
                animation: true,
                lineHeight: 48.0,
                
                animationDuration: 1000,
                percent: grade,
                center: Text(
                  '${(grade * 10).toInt()}/$Qnumber',
                  style: TextStyle(
                    fontSize: 28,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: const Color.fromARGB(197, 19, 161, 226),
                backgroundColor: const Color.fromARGB(255, 0, 71, 91),
                barRadius: Radius.circular(20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
