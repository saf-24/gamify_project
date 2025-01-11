// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class WelcomWidget extends StatelessWidget {
  final String username;

  const WelcomWidget({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 20,
            left: 35,
            child: RichText(
                text: TextSpan(
                    style: const TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w500),
                    children: [
                  const TextSpan(
                    text: "Welcome, ",
                  ),
                  TextSpan(
                      text: username,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 43, 115, 148),
                          fontWeight: FontWeight.w800,
                          fontSize: 24))
              ]
            )
          )
        ),
    
        Positioned(
            top: 72,
            left: 35,
            child: RichText(
                text: TextSpan(
                    style: const TextStyle(
                        fontSize: 23,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w500),
                    children: [
                  const TextSpan(
                    text: "What's ",
                  ),
                  TextSpan(
                      text: "New?",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 43, 115, 148),
                          fontWeight: FontWeight.w700,
                          fontSize: 23))
              ]
            )
          )
        )
      ],
    );
  }
}
