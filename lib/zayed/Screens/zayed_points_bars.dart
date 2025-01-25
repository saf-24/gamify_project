
import 'package:flutter/material.dart';

class points_bars extends StatelessWidget {
  final String names;
  final int points;
  final int ranks;

  const points_bars({
    super.key,
    required this.names,
    required this.points,
    required this.ranks,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.fromLTRB(screenHeight * 0.01, screenHeight * 0.01, 0, 0),
      child: Stack(
        children: [
          Image.asset(
            'assets/img/pointbar.png', // Path to the image
            height: screenHeight * 0.09, // Adjust height
            fit: BoxFit.contain, // Maintain aspect ratio
          ),
          Positioned(
            top: screenHeight * 0.026,
            left: ranks >= 10
                ? screenHeight * 0.1 // Adjust left for double digits
                : screenHeight * 0.0759,  // Default left for single digits,
            child: Text(
              names,
              style: TextStyle(
                color: const Color.fromARGB(255, 110, 107, 107),
                fontSize: screenHeight * 0.023,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          Positioned(
            top: screenHeight * 0.031,
            right: screenHeight * 0.053,
            child: Text(
              points.toString() + " Points",
              style: TextStyle(
                color: const Color.fromARGB(255, 238, 235, 235),
                fontSize: screenHeight * 0.017,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          Positioned(
            top: screenHeight * 0.0145,
            left: screenHeight * 0.04,
            child: Text(
              ranks.toString(),
              style: TextStyle(
                color: const Color.fromARGB(255, 110, 107, 107),
                fontSize: screenHeight * 0.038,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
