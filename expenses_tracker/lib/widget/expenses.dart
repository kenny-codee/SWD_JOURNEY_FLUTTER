import 'package:expenses_tracker/widget/expense_list.dart';
import 'package:expenses_tracker/models/expense.dart';
import 'package:expenses_tracker/widget/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _Expenses();
  }
}

// this is where the app Ui is gonna be designed. We will have a chart showing the statistic of each category of expense. We will then have a list of all added expense.
class _Expenses extends State<Expenses> {
// Here, I had to put in a dummy data for now to design the UI.I put them in a list so i can be able to iterate through them and call them through index.
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course ',
      amount: 19.9,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.9,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        context: context, builder: (ctx) => const NewExpense());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // we need a colum because thoe widget a placed on top of each other
        appBar: AppBar(title: const Text('Flutter ExpenseTracker'), actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ]),
        body: Column(
          children: [
            const Text('The chart'),
            // for better prcatice i create the logic for the ExpensesList in another class which is basically using a listview and them get the data from here.
            Expanded(
              child: ExpensesList(expenses: _registeredExpenses),
            )
          ],
        ));
  }
}
