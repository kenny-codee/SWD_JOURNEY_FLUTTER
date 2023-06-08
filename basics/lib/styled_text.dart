import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  // StyledText(String textData, {super.key}) : outputText = textData;
  const StyledText(this.outputText, {super.key});
  final String outputText;

  @override
  Widget build(context) {
    return Text(
      outputText,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 28,
      ),
    );
  }
}
