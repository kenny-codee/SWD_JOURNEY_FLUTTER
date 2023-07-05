import 'package:flutter/material.dart';
import 'package:meals/models/meals.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widget/category_grid_item.dart';
import 'package:meals/data/dummy_data.dart';

import '../models/category.dart';

class CatergoryScreen extends StatelessWidget {
  const CatergoryScreen(
      {super.key, required this.onToogleStatus, required this.availableMeals});

  final void Function(Meal meal) onToogleStatus;
  final List<Meal> availableMeals;

  void onSelectedCategory(BuildContext context, Category category) {
    final mealsList = availableMeals
        .where((meals) => meals.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsScreen(
              title: category.title,
              meals: mealsList,
              onToogleStatus: onToogleStatus,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 3 / 2,
        // the size if the gridview
      ),
      children: [
        // Text('1', style: TextStyle(color: Colors.white)),
        // Text('2', style: TextStyle(color: Colors.white)),
        // Text('3', style: TextStyle(color: Colors.white)),
        // Text('4', style: TextStyle(color: Colors.white)),
        // Text('5', style: TextStyle(color: Colors.white)),
        // Text('6', style: TextStyle(color: Colors.white)),
        // availableCategories.map((category) => CategoryItem(category: category),).toList(),
        for (final category in availableCategories)
          CategoryItem(
              category: category,
              selectedCategory: () {
                onSelectedCategory(context, category);
              }),
      ],
    );
  }
}
