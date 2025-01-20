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
      gradientColors = [
        const Color.fromARGB(255, 1, 252, 231),
        const Color.fromARGB(255, 0, 83, 143)
      ];
    } else if (label == "Error") {
      gradientColors = [
        const Color.fromARGB(255, 255, 136, 0),
        const Color.fromARGB(255, 68, 0, 0)
      ];
    } else {
      gradientColors = [Colors.grey, Colors.black];
    }

    String formattedPercentage = (percentage * 100) % 1 == 0
        ? (percentage * 100).toInt().toString()
        : (percentage * 100).toStringAsFixed(1);

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
        if (label == 'Correct')
          Positioned.fill(
            child: Center(
              child: Text(
                "$label ($formattedPercentage%)",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        if (label == 'Error')
          Positioned.fill(
            child: Center(
              child: Text(
                "$label ($formattedPercentage%)",
                style: const TextStyle(
                  color: Color.fromARGB(255, 168, 168, 168),
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
