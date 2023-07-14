import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meals.dart';

class FavoriteMealsNotifiers extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifiers() : super([]);

  bool toogleMealFavoriteStatus(Meal meal) {
    final mealsIsFavourite = state.contains(meal);

    if (mealsIsFavourite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifiers, List<Meal>>((ref) {
  return FavoriteMealsNotifiers();
});
//StateNotifierProvider helps with dynamic data