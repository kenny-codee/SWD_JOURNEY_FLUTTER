import 'package:expenses_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.newExpenseData, {super.key});

  final void Function(Expense expense) newExpenseData;

  @override
  State<NewExpense> createState() {
    return _NewExpense();
  }
}

// var _enteredValue = '';

class _NewExpense extends State<NewExpense> {
  // void value(String inputData) {
  //   _enteredValue = inputData;
  // }

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedItem = Category.leisure;

  void _presentDatePicker() async {
    // so now here we passed an async function to stop the flow of the function until it gets is promise. With async and await function, we can pause and play the flow of our code.
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    // final lastDate = DateTime.now();
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      // setState is use here to update the UI from NO date, to the date picked.
      _selectedDate = pickedDate;
    });
  }

  void showExpenseData() {
    final newAmount = double.tryParse(_amountController.text);
    final amountData = newAmount == null || newAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountData ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Invalid input'),
              content: const Text(
                  'Please make sure a valid title, amount, data and category was entered'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Okay'))
              ],
            );
          });
      return;
    }
    widget.newExpenseData(Expense(
      amount: newAmount,
      title: _titleController.text,
      date: _selectedDate!,
      category: _selectedItem,
    ));
    Navigator.pop(context);
  }

  @override
  // a dispose function is needed here to dispose the data collected by the TextController
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              // onChanged: value,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixText: '\$',
                      label: Text('Amount'),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(_selectedDate == null
                          ? 'No date'
                          : formatter.format(_selectedDate!)),
                      IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                DropdownButton(
                  value: _selectedItem,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedItem = value;
                    });
                  },
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                    onPressed: showExpenseData,
                    child: const Text('Save Expense'))
              ],
            )
          ],
        ));
  }
}
