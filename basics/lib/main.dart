import 'package:flutter/material.dart';
import 'package:swd_journey_flutter/gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          [
            Color.fromARGB(255, 149, 45, 14),
            Color.fromARGB(255, 241, 102, 59),
          ],
        ),
      ),
    ),
  );
}
