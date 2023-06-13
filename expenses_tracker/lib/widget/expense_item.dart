import 'package:flutter/material.dart';

import '../models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({required this.expenseItem, super.key});

  final Expense expenseItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        child: Column(
          children: [
            Text(expenseItem.title),
            Row(
              children: [
                // since Text is expecting a string argument and amount is an int we have to convert it to string.
                Text(
                  '\$${(expenseItem.amount).toStringAsFixed(2)}',
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expenseItem.category]),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(expenseItem.formattedDate),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
