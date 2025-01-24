
import 'package:flutter/material.dart';


class Zayed_points_bars extends StatelessWidget {
  final String names;
  final int points;

  const Zayed_points_bars({
    super.key,
    required this.names,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(17, 0, 0, 0),
      width: 400,
      height: 199,
      child: SizedBox(
        width: 323,
        height: 22,
        child: Stack(
          children: [
            // Reposition the ElevatedButton using Positioned
            Positioned(
              top: 0,
              left: 0,
              right: 10,
              bottom: 9,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 9, 17, 18),
                child: ElevatedButton(
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Container(), // Add an empty container as the child
                ),
              ),
            ),
            Positioned(
              top: 30,
              left: 34,
              child: Text(
                names,
                style: TextStyle(
                  fontSize: 26,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3,
                ),
              ),
            ),
          
            Positioned(
              top: 82,
              left: 34,
              child: SizedBox(
                width: 320,
                child: Text(
                  points.toString(),
                  style: TextStyle(
                    fontSize: 17.6,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    wordSpacing: 2,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
