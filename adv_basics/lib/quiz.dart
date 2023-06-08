import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/question._screen.dart';
import 'package:adv_basics/results_screen.dart';
import 'package:adv_basics/start_screen.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  Widget? activeScreen;
  List<String> resultAnswers = [];

  @override
  void initState() {
    activeScreen = StartScreen(startQuiz: switchScreen);
    super.initState();
  }

  void choosenAnswers(selectedAnswer) {
    resultAnswers.add(selectedAnswer);

    if (resultAnswers.length == questions.length) {
      setState(() {
        activeScreen =
            ResultsScreen(restartQuiz, choosenAnswers: resultAnswers);
      });
    }
  }

  void restartQuiz() {
    setState(() {
      resultAnswers = [];
      activeScreen = activeScreen = QuestionScreen(
        onSelectedAnswer: choosenAnswers,
      );
    });
  }

  void switchScreen() {
    setState(() {
      activeScreen = QuestionScreen(
        onSelectedAnswer: choosenAnswers,
      );
    });
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: activeScreen,
        ),
      ),
    );
  }
}
