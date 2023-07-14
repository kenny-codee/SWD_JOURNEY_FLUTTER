import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meals.dart';
import 'package:meals/provider/fav_provider.dart';

class DetialsMeals extends ConsumerWidget {
  const DetialsMeals({
    super.key,
    required this.mealsData,
  });

  final Meal mealsData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toogleMealFavoriteStatus(mealsData);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        wasAdded ? 'Meal added as favorite' : 'Meal removed'),
                    duration: const Duration(
                      seconds: 2,
                    )),
              );
            },
            icon: const Icon(Icons.star),
          )
        ],
        title: Text(
          (mealsData.title),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Image.network(
            mealsData.imageUrl,
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 14,
          ),
          Text('Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  )),
          const SizedBox(
            height: 14,
          ),
          for (final ingredients in mealsData.ingredients)
            Text(ingredients,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    )),
          // THE STEP STYLE
          const SizedBox(
            height: 24,
          ),
          Text('Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  )),

          const SizedBox(
            height: 14,
          ),
          for (final steps in mealsData.steps)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 5,
              ),
              child: Text(steps,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      )),
            ),
        ]),
      ),
    );
  }
}
