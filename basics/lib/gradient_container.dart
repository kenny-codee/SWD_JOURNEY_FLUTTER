import 'package:flutter/material.dart';
import 'package:swd_journey_flutter/dice_roller.dart';

var startAlignment = Alignment.bottomLeft;
var endAlignment = Alignment.topLeft;

// var activeDataImage = 'assets/images/dice-2.png';

// void rollDice() {
//   activeDataImage = 'assets/images/dice-4.png';
// }

class GradientContainer extends StatelessWidget {
// A class should start with an upper case character and we can use the underscore to split the words. The class should also state what the objects or class want to do. As a class we need to inheret a kinda of data from a flutter widget. This tells flutter the way the class is gonna show the UI
  const GradientContainer(this.colors, {super.key});

  final List<Color> colors;
  // final Color color2;
  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: startAlignment,
          end: endAlignment,
        ),
      ),
      child: const Center(
        child: DiceRoller(),
      ),
    );
  }
}
