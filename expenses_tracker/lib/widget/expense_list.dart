import 'package:expenses_tracker/widget/expense_item.dart';
import 'package:expenses_tracker/models/expense.dart';
import 'package:flutter/material.dart';

// Basially this is statlesswidget takiing an argument that is going to be feed the Expenses data.
class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.removedExpense,
  });

// we can use custom type here, I've defined what Expense is in a class, we can use this class as type to store our data.
  final List<Expense> expenses;
  final void Function(Expense expense) removedExpense;
  @override
  Widget build(BuildContext context) {
    // because we're creating a list of data that the length of the data is unknown we need to use a builder that builds list on demands
    return ListView.builder(
      itemCount: expenses.length,
      // itemBuilder takes a function that returns a widget and basically the parameter of the function is bctx and an int.
      itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) {
            removedExpense(expenses[index]);
          },
          key: ValueKey(expenses[index]),
          child: ExpenseItem(expenseItem: expenses[index])),
    );
  }
}
