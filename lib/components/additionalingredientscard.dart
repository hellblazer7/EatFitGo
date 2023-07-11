import 'package:cookbook/constants.dart';
import 'package:flutter/material.dart';

class AdditionalIngredientsCard extends StatelessWidget {
  final int additionalIngredients;

  const AdditionalIngredientsCard(
      {Key? key, required this.additionalIngredients})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFFFFF9F3),
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Center(
          child: Text(
            '+$additionalIngredients More',
            style: const TextStyle(
              color: kPrimaryColor,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoSlab',
            ),
          ),
        ),
      ),
    );
  }
}
