import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:user_inputs/data/categories.dart';
import 'package:user_inputs/models/category.dart';

import 'package:http/http.dart' as http;

class NewItem extends StatefulWidget {
  const NewItem({super.key});
  @override
  State<NewItem> createState() {
    return _NewItem();
  }
}

class _NewItem extends State<NewItem> {
  final _formkey = GlobalKey<FormState>();
  var enteredName = '';
  var enteredQuantity = 1;
  var _selectedCategory = categories[Categories.vegetables]!;
  var isSending = false;

  void _saveItem() async {
    _formkey.currentState!.validate();
    _formkey.currentState!.save();
    setState(() {
      isSending = true;
    });
    final url = Uri.https(
      'flutter-prep-34c4b-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );
    final response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
      },
      body: json.encode(
        {
          'name': enteredName,
          'category': _selectedCategory.title,
          'quantity': enteredQuantity,
        },
      ),
    );

    if (!context.mounted) {
      return;
    }
    Navigator.of(context).pop();
    // GroceryItem(
    //   id: DateTime.now().toString(),
    //   name: enteredName,
    //   category: _selectedCategory,
    //   quantity: enteredQuantity,
    // ),
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Items'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('Name'),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length <= 1 ||
                          value.trim().length > 50) {
                        return 'Must be between 1 and 50 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      enteredName = value!;
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            label: Text('Quantity'),
                          ),
                          initialValue: enteredQuantity.toString(),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                int.tryParse(value) == null ||
                                int.tryParse(value)! <= 0) {
                              return 'Must be a valid, postive number';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            enteredQuantity = int.parse(value!);
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: DropdownButtonFormField(
                            value: _selectedCategory,
                            items: [
                              for (final category in categories.entries)
                                DropdownMenuItem(
                                    value: category.value,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 16,
                                          height: 16,
                                          color: category.value.color,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(category.value.title)
                                      ],
                                    ))
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedCategory = value!;
                              });
                            }),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: isSending
                              ? null
                              : () {
                                  _formkey.currentState!.reset();
                                },
                          child: const Text('Reset')),
                      ElevatedButton(
                        onPressed: isSending ? null : _saveItem,
                        child: isSending
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator())
                            : const Text('Add Item'),
                      ),
                    ],
                  ) // instead of TextField,
                ],
              ))),
    );
  }
}
