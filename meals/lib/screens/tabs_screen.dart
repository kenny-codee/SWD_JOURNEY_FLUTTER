import 'package:flutter/material.dart';
import 'package:meals/models/meals.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widget/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends State<TabsScreen> {
  int selctedPageIndex = 0;

  void _currentPage(int index) {
    setState(() {
      selctedPageIndex = index;
    });
  }

  final List<Meal> _favoriteMeal = [];

  void showInfoMessage({
    required String message,
    SnackBarAction? snackBarAction,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(
        seconds: 2,
      ),
      action: snackBarAction,
    ));
  }

  void onToggleMeal(Meal meal) {
    final mealIndex = _favoriteMeal.indexOf(meal);
    // final isExisting = _favoriteMeal.contains(meal);
    if (_favoriteMeal.contains(meal)) {
      setState(() {
        _favoriteMeal.remove(meal);
        showInfoMessage(
            message: 'Meal is no longer a favorite',
            snackBarAction: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  setState(() {
                    _favoriteMeal.insert(mealIndex, meal);
                  });
                }));
      });
    } else {
      setState(() {
        _favoriteMeal.add(meal);
        showInfoMessage(message: 'Marked as favorite');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CatergoryScreen(
      onToogleStatus: onToggleMeal,
    );
    String activePageTitle = 'Categories';

    if (selctedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeal,
        onToogleStatus: onToggleMeal,
      );
      activePageTitle = 'Your Favorites';
    }

    void screenType(String identifier) async {
      Navigator.of(context).pop();
      if (identifier == 'filters') {
        final result = await Navigator.of(context).push<Map<Filters, bool>>(
          MaterialPageRoute(builder: (ctx) => const FilterScreen()),
        );
      }
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
