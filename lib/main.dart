import 'package:flutter/material.dart';

import 'package:gamify_project/Abdulhadi/Screens/abdulhadi_student_signup_page.dart';
import 'package:gamify_project/Safwan/Screens/safwan_games_list.dart';
import 'package:gamify_project/Safwan/Screens/student_home_page.dart';
import 'package:gamify_project/zayed/Screens/zayed_courses_page.dart';


import 'Safwan/Screens/safwan_student_login_page.dart';

void main() {
  runApp(const MyApp());
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
      
      },


      
      
      
    );
  }
}


  