import 'package:flutter/material.dart';

class GradientLineWidget extends StatelessWidget {
  final double percentage; 
  final String label;

  GradientLineWidget({
    required this.percentage,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors;
    if (label == "Correct") {
      gradientColors = [Color.fromARGB(255, 1, 252, 231), Color.fromARGB(255, 0, 83, 143)];
    } else if (label == "Error") {
      gradientColors = [Color.fromARGB(255, 255, 136, 0), const Color.fromARGB(255, 68, 0, 0)];
    } else {
      gradientColors = [Colors.grey, Colors.black]; 
    }

    return Stack(
      children: [
        Container(
          height: 20,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          height: 20,
          width: percentage * 300, 
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Text(
              "$label (${(percentage * 100).toStringAsFixed(1)}%)",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
