import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  final String title;
  final String disc;
  final String imagepath;
  final String date;

  const TestWidget({
    super.key,
    required this.title,
    required this.disc,
    required this.imagepath,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(26, 85, 24, 20),
      width: 359,
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      const Color.fromARGB(255, 121, 121, 121),
                      BlendMode.modulate),
                  child: Image.asset(
                    imagepath,
                    fit: BoxFit.cover,
                    width: 400,
                    height: 300,
                  ))),
          Positioned(
              top: 18,
              left: 24,
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 32,
                    color: const Color.fromARGB(255, 235, 234, 234),
                    fontWeight: FontWeight.w800,
                    wordSpacing: 2,
                    letterSpacing: 3),
              )),
          Positioned(
              bottom: 28,
              left: 25,
              child: Text(
                date,
                style: TextStyle(
                    fontSize: 15,
                    color: const Color.fromARGB(230, 235, 234, 234),
                    fontWeight: FontWeight.w800,
                    wordSpacing: 2,
                    letterSpacing: 3),
              )),
          Positioned(
              top: 67,
              left: 24,
              child: Container(
                width: 320,
                child: Text(
                  disc,
                  style: TextStyle(
                      fontSize: 19,
                      color: const Color.fromARGB(255, 230, 230, 230),
                      wordSpacing: 2,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w500),
                ),
              )),
          Positioned(
            bottom: 23,
            right: 23,
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 228, 228, 228)),
              ),
              child: Text("Explore",style: TextStyle(fontSize: 18, fontWeight:FontWeight.w800,letterSpacing: 1,color: const Color.fromARGB(255, 45, 110, 153) ),),
            ),
            width: 116,
            height: 34,
          ),
        ],
      ),
    );
  }
}
