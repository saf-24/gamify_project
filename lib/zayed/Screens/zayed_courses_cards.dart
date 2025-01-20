import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
class Courses_cards extends StatelessWidget {
  final String title;
  final String disc;
  final double percent1;
  final String date;

  const Courses_cards({
    super.key,
    required this.title,
    required this.disc,
    required this.date,
    required this.percent1,
  });

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: const EdgeInsets.fromLTRB(17, 0, 18, 5),
      width: 400,
      height: 220,
      child: SizedBox(
        
        width: 323,
        height: 22,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.5),
              child: Container(
                width: 359,
                height: 195,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: const Color.fromARGB(255, 255, 255, 255),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: const Offset(3, 6),
                      )
                    ]),
              ),
            ),
            Positioned(
                top: 68,
                left: 30,
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 26,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w700,
                      
                      letterSpacing: 3),
                )),
            Positioned(
                top: 165,
                left: 30,
                child: Text(
                  date,
                  style: TextStyle(
                      fontSize: 15,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w500,
                      wordSpacing: 2,
                      letterSpacing: 3),
                )),
            Positioned(
                top: 118,
                left: 30,
                child: SizedBox(
                  width: 320,
                  child: Text(
                    disc,
                    style: TextStyle(
                        fontSize: 19,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        wordSpacing: 2,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ),
            Positioned(
              top: 155,
              right: 30,
              width: 116,
              height: 34,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      const Color.fromARGB(255, 228, 228, 228)),
                ),
                child: Text(
                  "Explore",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                      color: const Color.fromARGB(197, 0, 129, 189)),
                ),
              ),
            ),
            Positioned(
              top: 9,
              child: LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 35,
              
              animation: true,
              lineHeight: 52.0,
              
              animationDuration: 1000,
              percent: percent1,
              center: Text('${(percent1 * 100).toStringAsFixed(1)}%', style: TextStyle(fontSize: 35, color: const Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.w700),),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: const Color.fromARGB(197, 19, 161, 226),
                backgroundColor: const Color.fromARGB(255, 0, 71, 91),
              barRadius: Radius.circular(28),
            )
            )
          ],
        ),
      ),
    );
  }
}
