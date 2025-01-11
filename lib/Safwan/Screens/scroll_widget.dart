// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ScrollWidget extends StatelessWidget {
  
    final String title;
  final String disc;

  final String date;

  const ScrollWidget({
    super.key,
    required this.title,
    required this.disc,
    required this.date,
  });

final List<Map<String, String>> test = [
  {
    'title': 'math 1',
    'image': 'assets/img/download.jpg',
    'disc': 'a new mid test added to math 1',
    'date': '9/01/2025',
    'username': 'Safwan',
  },
  {
    'title': 'java',
    'image': 'assets/img/download.jpg',
    'disc':
        'a new final test adde fdfgnldfgj  ldkjflk j  lkdfglj dlfkgjhlkdfhjg d to java 1',
    'date': '9/01/2025',
    'username': 'Safwan',
  },
  {
    'title': 'python',
    'image': 'assets/img/download.jpg',
    'disc': 'a new Quiz added to python 1',
    'date': '9/01/2025',
    'username': 'Safwan',
  },
];

                

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            height: 330,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: test.length,
              itemBuilder: (context, index) {
                return TestWidget(
                  title: test[index]['title']!,
                  disc: test[index]['disc']!,
                  imagepath: test[index]['image']!,
                  date: test[index]['date']!,
                );
              },
            ),
          ),
    )
  }
  
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
      return Card(
        child: Column(
          children: [
            Image.asset(imagepath),
            Text(title),
            Text(disc),
            Text(date),
          ],
        ),
      );
    }
  }
}

