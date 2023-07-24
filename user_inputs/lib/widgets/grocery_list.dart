import 'package:flutter/material.dart';
import 'package:user_inputs/data/dummy_items.dart';
import 'package:user_inputs/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  void addItem() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const NewItem(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Griceries'),
        actions: [
          IconButton(
            onPressed: addItem,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (ctx, index) => ListTile(
          title: Text(groceryItems[index].name),
          leading: Container(
            width: 24,
            height: 24,
            color: groceryItems[index].category.color,
          ),
          trailing: Text(groceryItems[index].quantity.toString()),
        ),
      ),
    );
  }
}
