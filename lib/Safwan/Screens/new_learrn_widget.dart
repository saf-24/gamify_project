import 'package:flutter/material.dart';

class New_learn_widget extends StatelessWidget {
  final String title;
  final String disc;
  final String percent1;
  final String date;

  const New_learn_widget({
    super.key,
    required this.title,
    required this.disc,
    required this.date,
    required this.percent1,
  });

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: const EdgeInsets.fromLTRB(17, 15, 30, 0),
      width: 400,
      height: 300,
      child: SizedBox(
        
        width: 323,
        height: 222,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.5),
              child: Container(
                width: 359,
                height: 175,
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
                top: 28,
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
                top: 145,
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
                top: 90,
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
                )),
            Positioned(
              top: 135,
              right: 50,
              width: 116,
              height: 34,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      const Color.fromARGB(255, 228, 228, 228)),
                ),
                child: Text(
                  "Start!",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                      color: const Color.fromARGB(255, 45, 110, 153)),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
