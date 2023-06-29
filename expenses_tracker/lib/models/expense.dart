import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:uuid/uuid.dart';

enum Category {
  travel,
  work,
  leisure,
  food,
}

final categoryIcons = {
  Category.work: Icons.work,
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
};
const uuid = Uuid();
final formatter = DateFormat.yMd();

class Expense {
  // I created a class so I can be also to get all the dynmaic data in a place and it can reuseable anywhere I want to. So the expenses tracker app is going go to have an amount which is a type double, a title which is string, a date and Dart have a default type for that which DateTime. Lastly the app is gonna be grouped in different categories so we will need this as well, to keep all the catergory in a type i had to use the enum class so we will be able to pick each category from there.

  Expense({
    required this.amount,
    required this.title,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount; // sum = sum + expense.amount
    }

    return sum;
  }
}
