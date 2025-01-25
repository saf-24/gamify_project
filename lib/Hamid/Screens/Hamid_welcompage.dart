import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gamify_project/Abdulhadi/Screens/abdulhadi_inst_signup_page.dart';
import 'package:gamify_project/Safwan/Screens/safwan_institusoin_logn_page.dart';
import 'package:gamify_project/Safwan/Screens/safwan_student_login_page.dart';
import 'package:gamify_project/Safwan/Screens/teatcher_login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: const welcome_page(),
    );
  }
}

class welcome_page extends StatelessWidget {
  const welcome_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              size: 35.4,
              color: Color.fromARGB(197, 0, 129, 189),
            ),
            onPressed: () {},
          )
        ],
        backgroundColor: const Color.fromARGB(255, 230, 230, 230),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 30,
            left: 115,
            child: Text(
              "Gamify",
              style: TextStyle(
                fontSize: 47,
                color: const Color.fromARGB(255, 54, 127, 156),
                fontWeight: FontWeight.w700,
                
              ),
            ),
          ),
          Positioned(
            bottom: -59,
            right: -51,
            child: Image.asset(
              "assets/img/login_bachground1.png",
              scale: 0.75,
            ),
          ),
          Center(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 11),
                child: Container(
                  width: 360,
                  height: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(35),
                    ),
                    color: const Color.fromARGB(153, 231, 231, 231),
                    border: Border.all(
                        color: const Color.fromARGB(94, 161, 161, 161),
                        width: 3),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {

                          Navigator.push(context, MaterialPageRoute(builder: (context) => Stloginpage()));

                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(255, 8, 130, 179),
                          ),
                          padding: WidgetStateProperty.all(
                              EdgeInsets.fromLTRB(40, 13, 40, 13)),
                          shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28))),
                        ),
                        child: Text(
                          "Enter as Student",
                          style: TextStyle(
                            fontSize: 25,
                            color: const Color.fromARGB(192, 255, 255, 255),
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Taloginpage()));
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(255, 8, 130, 179),
                          ),
                          padding: WidgetStateProperty.all(
                              EdgeInsets.fromLTRB(25, 13, 25, 13)),
                          shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28))),
                        ),
                        child: Text(
                          "Enter as Instructor",
                          style: TextStyle(
                            fontSize: 25,
                            color: const Color.fromARGB(192, 255, 255, 255),
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => In_login_page()));
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(255, 8, 130, 179),
                          ),
                          padding: WidgetStateProperty.all(
                              EdgeInsets.fromLTRB(25, 13, 25, 13)),
                          shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28))),
                        ),
                        child: Text(
                          "Enter as University",
                          style: TextStyle(
                            fontSize: 25,
                            color: const Color.fromARGB(192, 255, 255, 255),
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
