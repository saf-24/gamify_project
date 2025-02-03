// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gamify_project/Abdulhadi/Screens/abdulhadi_inst_signup_page.dart';

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
      home: const In_login_page(),
    );
  }
}

class In_login_page extends StatelessWidget {
  const In_login_page({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> ischecked = ValueNotifier(false);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 30,
            left: 135,
            child: Container(
              child: Text(
                "Gamify",
                style: TextStyle(
                    fontSize: 47,
                    color: const Color.fromARGB(255, 54, 127, 156),
                    fontWeight: FontWeight.w700),
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
                  child: Stack(
                    children: [
                      Positioned(
                        top: 28,
                        right: 27,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => instisignup()));
                          },
                          child: Text("Sign up",
                              style: TextStyle(
                                  fontSize: 22,
                                  color:
                                      const Color.fromARGB(255, 27, 111, 167),
                                  fontWeight: FontWeight.w900)),
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                const Color.fromARGB(225, 255, 255, 255),
                              ),
                              padding: WidgetStateProperty.all(
                                  EdgeInsets.fromLTRB(24, 12, 24, 12)),
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(28)))),
                        ),
                      ),
                      Positioned(
                        top: 28,
                        left: 33,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Login",
                              style: TextStyle(
                                  fontSize: 22,
                                  color:
                                      const Color.fromARGB(255, 190, 228, 253),
                                  fontWeight: FontWeight.w900)),
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                const Color.fromARGB(197, 0, 129, 189),
                              ),
                              padding: WidgetStateProperty.all(
                                  EdgeInsets.fromLTRB(35, 12, 35, 12)),
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(28)))),
                        ),
                      ),
                      SizedBox(
                        height: 44,
                      ),
                      Positioned(
                        top: 119,
                        left: 28,
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                color: const Color.fromARGB(141, 241, 241, 241),
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 54, 127, 156),
                                    width: 3)),
                            width: 303,
                            height: 55,
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "ID",
                                  hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: const Color.fromARGB(
                                          255, 54, 127, 156)),
                                  contentPadding: EdgeInsets.only(left: 20)),
                            )),
                      ),
                      Positioned(
                        top: 191,
                        left: 28,
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                color: const Color.fromARGB(141, 241, 241, 241),
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 54, 127, 156),
                                    width: 3)),
                            width: 303,
                            height: 55,
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: const Color.fromARGB(
                                          255, 54, 127, 156)),
                                  contentPadding: EdgeInsets.only(left: 20)),
                            )),
                      ),
                      Positioned(
                        top: 250,
                        left: 24,
                        child: Row(
                          children: [
                            ValueListenableBuilder<bool>(
                              valueListenable: ischecked,
                              builder: (context, value, child) {
                                return Checkbox(
                                  activeColor:
                                      const Color.fromARGB(255, 54, 127, 156),
                                  value: value,
                                  onChanged: (bool? newValue) {
                                    ischecked.value = newValue ?? false;
                                  },
                                  side: BorderSide(
                                      color:
                                          const Color.fromARGB(255, 0, 87, 145),
                                      width: 2),
                                );
                              },
                            ),
                            Text(
                              "remember me",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: const Color.fromARGB(255, 0, 54, 90),
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 310,
                        left: 89,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Login",
                              style: TextStyle(
                                  fontSize: 30,
                                  color:
                                      const Color.fromARGB(255, 190, 228, 253),
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1)),
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                const Color.fromARGB(197, 0, 129, 189),
                              ),
                              padding: WidgetStateProperty.all(
                                  EdgeInsets.fromLTRB(40, 10, 40, 10)),
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(28)))),
                        ),
                      ),
                    ],
                  ),
                  width: 360,
                  height: 424,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                      color: const Color.fromARGB(153, 231, 231, 231),
                      border: Border.all(
                          color: const Color.fromARGB(94, 161, 161, 161),
                          width: 3)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
