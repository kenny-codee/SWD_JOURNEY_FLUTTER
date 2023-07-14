import 'package:flutter/material.dart';
import 'package:meals/models/meals.dart';
import 'package:meals/screens/details_meals.dart';
import 'package:meals/widget/meals_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meals,
  });

  String get complexity {
    return meals.complexity.name[0].toUpperCase() +
        meals.complexity.name.substring(1);
  }

  String get affordability {
    return meals.affordability.name[0].toUpperCase() +
        meals.affordability.name.substring(1);
  }

  void detailMeals(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => DetialsMeals(
              mealsData: meals,
            )));
  }

  final Meal meals;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          detailMeals(context);
        },
        child: Stack(
          children: [
            FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meals.imageUrl),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 30,
                ),
                child: Column(
                  children: [
                    Text(
                      meals.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis, // Very long text ...
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealsItemTrait(
                          icon: Icons.schedule,
                          label: '${meals.duration} min',
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        MealsItemTrait(
                          icon: Icons.work,
                          label: complexity,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        MealsItemTrait(
                          icon: Icons.work,
                          label: affordability,
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
