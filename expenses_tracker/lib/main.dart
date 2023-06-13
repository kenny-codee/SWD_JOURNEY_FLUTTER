import 'package:expenses_tracker/widget/expenses.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const Expenses(),
    ),

    // created a custom widget to design the UI of the app for better practice.
    // This UI is going to be a Statefulwidget becauuse there's going to be a lot of change in state there.
  );
}
