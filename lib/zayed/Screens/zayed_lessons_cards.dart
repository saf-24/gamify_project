
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Lessons_cards extends StatelessWidget {
  final String title;
  final String disc;
  final double percent1;
  final String date;

  const Lessons_cards({
    super.key,
    required this.title,
    required this.disc,
    required this.date,
    required this.percent1,
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
              top: 63,
              left: 30,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 23,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3,
                ),
              ),
            ),
            Positioned(
              top: 140,
              left: 30,
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
              top: 103,
              left: 30,
              child: SizedBox(
                width: 320,
                child: Text(
                  disc,
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
              bottom: 143,
              child: LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 34,
                animation: true,
                lineHeight: 47.0,
                animationDuration: 1000,
                percent: percent1,
                center: Text(
                  '${(percent1 * 100).toStringAsFixed(1)}%',
                  style: TextStyle(
                    fontSize: 35,
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
