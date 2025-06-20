import 'package:flutter/material.dart';
import 'package:projects/library.dart';
import 'dart:math';

class VerticalText extends CustomPainter {
  double x;
  double y;
  double fontsize;
  final String text;

  VerticalText({
    required this.text,
    required this.fontsize,
    required this.y,
    required this.x,
  });

  final textPainter = TextPainter(
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.center,
  );

  @override
  void paint(Canvas canvas, Size size) {
    Random random = Random();

    int greenColor = 50;
    int increment = ((255 - greenColor) / text.length).toInt();
    Color curColor = Color.fromARGB(
      255,
      0,
      greenColor <= 255 ? greenColor : 255,
      0,
    );

    for (int i = 0; i < text.length; i++) {
      var letter = TextSpan(
        text: text[i],
        style: TextStyle(
          color: curColor,
          fontSize: fontsize,
          shadows: [
            Shadow(color: curColor, blurRadius: 10),
            Shadow(color: Colors.black, blurRadius: 15),
            Shadow(color: Colors.white, blurRadius: 20),
          ],
        ),
      );

      textPainter.text = letter;
      textPainter.layout();
      textPainter.paint(canvas, Offset(x, y));

      y += fontsize * (4 / 3);
      greenColor += increment;
      curColor = Color.fromARGB(255, 0, greenColor, 0);
    }
  }

  @override
  bool shouldRepaint(covariant VerticalText oldPainter) {
    return oldPainter.y != y;
  }
}
