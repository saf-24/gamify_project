import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // تأكد من استيراد Firebase
import 'package:gamify_project/zayed/Screens/zayed_lessons_page.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class New_learn_widget extends StatelessWidget {
  final String title;
  final String disc;
  final String fullName;
  final String email;
  final String major;
  final String tet_name;
  final String course_disc;
  final int highestProgres;
  final int total_lesson;

  const New_learn_widget({
    super.key,
    required this.title,
    required this.disc,
    required this.course_disc,
    required this.fullName,
    required this.email,
    required this.major,

    required this.tet_name,
    required this.highestProgres,
    required this.total_lesson,

  });


  

  @override
  Widget build(BuildContext context) {


    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 35, 5),
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
                  ],
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 30,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 26,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3,
                ),
              ),
            ),
            Positioned(
              top: 145,
              left: 30,
              child: Text(
                tet_name,
                style: TextStyle(
                  fontSize: 15,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w500,
                  wordSpacing: 2,
                  letterSpacing: 3,
                ),
              ),
            ),
            Positioned(
              top: 55,
              left: 30,
              child: SizedBox(
                width: 310,
                height: 70,
                child: Text(
                  disc,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 16,
                    
                    
                    color: const Color.fromARGB(255, 0, 0, 0),
                    wordSpacing: 2,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 135,
              right: 50,
              width: 130,
              height: 35,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Zayed_lessons_page(title: title,cource_disc_lesson: course_disc,fullName: fullName,email: email,major: major,),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    const Color.fromARGB(255, 228, 228, 228),
                  ),
                ),
                child: Text(
                  "Start",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                    color: const Color.fromARGB(197, 0, 129, 189),
                  ),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
