import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meals.dart';
import 'package:meals/provider/fav_provider.dart';
import 'package:meals/provider/meals_riverpod.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widget/main_drawer.dart';

const kInitialFilters = {
  Filters.gluten: false,
  Filters.lactose: false,
  Filters.vegan: false,
  Filters.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends ConsumerState<TabsScreen> {
  int selctedPageIndex = 0;

  void _currentPage(int index) {
    setState(() {
      selctedPageIndex = index;
    });
  }

  Map<Filters, bool> _selectedFilters = kInitialFilters;

  // void showInfoMessage({
  //   required String message,
  //   SnackBarAction? snackBarAction,
  // }) {
  //
  //     action: snackBarAction,
  //   ));
  // }

  // void onToggleMeal(Meal meal) {
  //   final mealIndex = _favoriteMeal.indexOf(meal);
  //   // final isExisting = _favoriteMeal.contains(meal);
  //   if (_favoriteMeal.contains(meal)) {
  //     setState(() {
  //       _favoriteMeal.remove(meal);
  //       showInfoMessage(
  //           message: 'Meal is no longer a favorite',
  //           snackBarAction: SnackBarAction(
  //               label: 'Undo',
  //               onPressed: () {
  //                 setState(() {
  //                   _favoriteMeal.insert(mealIndex, meal);
  //                 });
  //               }));
  //     });
  //   } else {
  //     setState(() {
  //       _favoriteMeal.add(meal);
  //       showInfoMessage(message: 'Marked as favorite');
  //     });
  //   }
  // }

  void screenType(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FilterScreen(currentFilters: _selectedFilters),
        ),
      );
      _selectedFilters = result ?? kInitialFilters;
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);

    final availableMeals = meals.where((meal) {
      if (_selectedFilters[Filters.gluten]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filters.vegan]! && !meal.isVegan) {
        return false;
      }
      if (_selectedFilters[Filters.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filters.lactose]! && !meal.isLactoseFree) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CatergoryScreen(
      availableMeals: availableMeals,
    );
    String activePageTitle = 'Categories';

    if (selctedPageIndex == 1) {
      final favMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favMeals,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(naviagtor: screenType),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _currentPage,
        currentIndex: selctedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites')
        ],
      ),
    );
  }
}
