import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  final String title;
  final String disc;
  final String imagepath;

  const TestWidget({super.key, 
    required this.title,
    required this.disc,
    required this.imagepath,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      
      width: 280,
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(22) ),color: Colors.amber,),
      child: Stack(
        children: [
          Positioned.fill(child: Image.asset(imagepath,fit: BoxFit.cover, )),
          Positioned(
              top: 20,
              left: 24,
              child: Text(
                title,
              )),
          Positioned(
              top: 44,
              left: 24,
              child: Text(
                disc,
                style: TextStyle(fontSize: 18, color: Colors.amber),
              )
            ),
            
        ],
      ),
    );
  }
}
