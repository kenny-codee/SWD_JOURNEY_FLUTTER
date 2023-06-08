import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({required this.startQuiz, super.key});

  final Function() startQuiz;

  @override
  Widget build(context) {
    return Center(
        child: Column(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image.asset(
        //   'assets/images/quiz-logo.png',
        //   width: 300,
        //   color: const Color.fromARGB(122, 255, 255, 255),
        // ),
        Opacity(
          opacity: 0.4,
          child: Image.asset(
            'assets/images/quiz-logo.png',
            width: 300,
          ),
        ),
        const SizedBox(
          height: 80,
        ),
        Text(
          'Learn Flutter the fun Way!',
          style: GoogleFonts.lato(
            fontSize: 24,
            color: const Color.fromARGB(255, 237, 223, 252),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        OutlinedButton.icon(
          icon: const Icon(Icons.arrow_right_alt),
          onPressed: startQuiz,
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 237, 223, 252),
          ),
          label: Text(
            'Start Quiz',
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 237, 223, 252),
              fontSize: 15,
            ),
          ),
        )
      ],
    ));
  }
}
