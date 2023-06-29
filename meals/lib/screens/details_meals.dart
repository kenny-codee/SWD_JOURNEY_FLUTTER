import 'package:flutter/material.dart';
import 'package:meals/models/meals.dart';

class DetialsMeals extends StatelessWidget {
  const DetialsMeals({
    super.key,
    required this.mealsData,
    required this.onToogleStatus,
  });

  final Meal mealsData;
  final void Function(Meal meal) onToogleStatus;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              onToogleStatus(mealsData);
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
