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
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 60,
            left: MediaQuery.of(context).size.width * 0.35,
            child: Text(
              "Gamify",
              style: TextStyle(
                fontSize: 47,
                color: const Color.fromARGB(255, 54, 127, 156),
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Sign as Student",
                          style: TextStyle(
                            fontSize: 25,
                            color: const Color.fromARGB(192, 255, 255, 255),
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 27, 111, 167),
                          ),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.fromLTRB(32, 13, 32, 13)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28))),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Sign as University",
                          style: TextStyle(
                            fontSize: 25,
                            color: const Color.fromARGB(192, 255, 255, 255),
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 27, 111, 167),
                          ),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.fromLTRB(32, 13, 32, 13)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28))),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Sign as Instructor",
                          style: TextStyle(
                            fontSize: 25,
                            color: const Color.fromARGB(192, 255, 255, 255),
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 27, 111, 167),
                          ),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.fromLTRB(32, 13, 32, 13)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28))),
                        ),
                      ),
                    ],
                  ),
                  width: 360,
                  height: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                    color: const Color.fromARGB(153, 231, 231, 231),
                    border: Border.all(
                        color: const Color.fromARGB(94, 161, 161, 161),
                        width: 3),
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
