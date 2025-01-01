// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:ui';

import 'package:flutter/material.dart';

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
      home: const Stloginpage(),
    );
  }
}

class Stloginpage extends StatelessWidget {
  const Stloginpage({super.key});

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
      ),
      body: Stack(
        children: [
          Positioned(
            top: 37,
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
                        top: 42,
                        left: 33,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 25,
                              color: const Color.fromARGB(255, 27, 111, 167),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 255, 255, 255),
                            ),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.fromLTRB(32, 13, 32, 13)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 44,
                      ),
                      Positioned(
                        top: 34, // Top position for the Sign up button
                        right: 27,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 30,
                              color: const Color.fromARGB(255, 190, 228, 253),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(197, 0, 129, 189),
                            ),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.fromLTRB(40, 16, 44, 16)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 139,
                        left: 28,
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                color: const Color.fromARGB(141, 241, 241, 241),
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 64, 157, 194),
                                    width: 3)),
                            width: 303,
                            height: 55,
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Full name",
                                  hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: const Color.fromARGB(
                                          255, 33, 123, 165)),
                                  contentPadding: EdgeInsets.only(left: 20)),
                            )),
                      ),
                      Positioned(
                        top: 219,
                        left: 28,
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                color: const Color.fromARGB(141, 241, 241, 241),
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 64, 157, 194),
                                    width: 3)),
                            width: 303,
                            height: 55,
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Institution Email Address",
                                  hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: const Color.fromARGB(
                                          255, 33, 123, 165)),
                                  contentPadding: EdgeInsets.only(left: 20)),
                            )),
                      ),
                      Positioned(
                        top: 299,
                        left: 28,
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                color: const Color.fromARGB(141, 241, 241, 241),
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 64, 157, 194),
                                    width: 3)),
                            width: 303,
                            height: 55,
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Job title",
                                  hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: const Color.fromARGB(
                                          255, 33, 123, 165)),
                                  contentPadding: EdgeInsets.only(left: 20)),
                            )),
                      ),
                      Positioned(
                        top: 379,
                        left: 28,
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                color: const Color.fromARGB(141, 241, 241, 241),
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 64, 157, 194),
                                    width: 3)),
                            width: 303,
                            height: 55,
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Institution name",
                                  hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: const Color.fromARGB(
                                          255, 33, 123, 165)),
                                  contentPadding: EdgeInsets.only(left: 20)),
                            )),
                      ),
                      Positioned(
                        top: 480,
                        left: 85,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Login",
                              style: TextStyle(
                                  fontSize: 30,
                                  color:
                                      const Color.fromARGB(255, 190, 228, 253),
                                  fontWeight: FontWeight.w900)),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(197, 0, 129, 189),
                              ),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.fromLTRB(60, 14, 60, 14)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(28)))),
                        ),
                      ),
                    ],
                  ),
                  width: 360,
                  height: 600,
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
