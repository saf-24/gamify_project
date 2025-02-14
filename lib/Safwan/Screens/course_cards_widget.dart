import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // تأكد من استيراد Firebase
import 'package:gamify_project/zayed/Screens/zayed_lessons_page.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Courses_cards_wid extends StatelessWidget {
  final String title;
  final String disc;
  final String date;
  final String tet_name;
  final String course_disc;
  final int highestProgres;
  final int total_lesson;
  final String fullName;
  final String email;
  final String major;
  final String documentId; // أضف documentId لتحديث المستند الصحيح

  const Courses_cards_wid({
    super.key,
    required this.title,
    required this.disc,
    required this.date,
    required this.tet_name,
    required this.highestProgres,
    required this.course_disc,
    required this.fullName,
    required this.email,
    required this.major,


    required this.total_lesson,
    required this.documentId, // أضف documentId كمعامل مطلوب
  });

  // دالة لتحديث الحقل percent في Firebase
  void updatePercentInFirebase(double percent1) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('subjects')
          .where('title', isEqualTo: title)
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.update({
          'percent': percent1 * 100,  
        });
      }
      print('Percent updated successfully in Firebase! $highestProgres and ');
    } catch (error) {
      print('Failed to update percent: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    
  final double percent1 = highestProgres / total_lesson;
       
    // استدعاء الدالة لتحديث الحقل percent في Firebase
    updatePercentInFirebase(percent1);

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
                  ],
                ),
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
                  letterSpacing: 3,
                ),
              ),
            ),
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
                  letterSpacing: 3,
                ),
              ),
            ),
            Positioned(
              top: 118,
              left: 30,
              child: SizedBox(
                width: 320,
                child: Text(
                  "Lesson: $highestProgres / $total_lesson",
                  style: TextStyle(
                    fontSize: 19,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    wordSpacing: 2,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 155,
              right: 50,
              width: 130,
              height: 35,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Zayed_lessons_page(title: title, cource_disc_lesson: course_disc,fullName: fullName,email: email,major: major,),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    const Color.fromARGB(255, 228, 228, 228),
                  ),
                ),
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                    color: const Color.fromARGB(197, 0, 129, 189),
                  ),
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
                barRadius: Radius.circular(28),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
