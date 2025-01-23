import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gamify_project/Abdulhadi/Screens/abdulhadi_student_signup_page.dart';
import 'package:gamify_project/Safwan/Screens/safwan_games_list.dart';
import 'package:gamify_project/Safwan/Screens/test_fire_2.dart';
import 'package:gamify_project/Safwan/Screens/test_firebace.dart';
import 'package:gamify_project/zayed/Screens/zayed_courses_page.dart';
import 'package:gamify_project/zayed/Screens/zayed_quiz_page.dart';
import 'package:gamify_project/zayed/Screens/zayed_lessons_page.dart';
import 'Safwan/Screens/safwan_student_login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(); // تهيئة Firebase
    print("Firebase Initialized Successfully"); // طباعة رسالة نجاح
    runApp(const MyApp());
  } catch (e) {
    print("Error initializing Firebase: $e"); // طباعة الخطأ
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',

      routes: {
        '/': (context) => const Stsignuppage(),
        '/st_login': (context) => const Stloginpage(),
        '/st_home': (context) => const St_home_page(),
        '/st_course': (context) => const Zayed_standard_navigations(),
        '/st_games_list': (context) => const Games_list(),
        '/test_fire': (context) => const Test_fire(),
        '/lesson_page': (context) => const Zayed_lessons_page(),
        '/quiz_page': (context) => const Zayed_quiz_page(),
      },
    );
  }
}


  