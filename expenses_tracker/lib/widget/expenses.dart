import 'package:expenses_tracker/widget/charts/chart_bar.dart';
import 'package:expenses_tracker/widget/charts/charts.dart';
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
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(addExpense),
    );
  }

  void addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Expense deleted'),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
          expenses: _registeredExpenses, removedExpense: removeExpense);
    }
    return Scaffold(
        // we need a colum because thoe widget a placed on top of each other
        appBar: AppBar(title: const Text('Flutter ExpenseTracker'), actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ]),
        body: width < 600
            ? Column(
                children: [
                  Chart(expenses: _registeredExpenses),
                  // for better prcatice i create the logic for the ExpensesList in another class which is basically using a listview and them get the data from here.
                  Expanded(
                    child: mainContent,
                  )
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  Expanded(
                    child: mainContent,
                  )
                ],
              ));
  }
}
