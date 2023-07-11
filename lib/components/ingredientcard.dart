import 'package:auto_size_text/auto_size_text.dart';
import 'package:cookbook/constants.dart';
import 'package:flutter/material.dart';

class IngredientCard extends StatelessWidget {
  final String imageKey;
  final String ingredientName;

  const IngredientCard({
    required this.imageKey,
    Key? key,
    required this.ingredientName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFFFFF9F3),
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Container(
              width: 90,
              height: 50.0,
              color: kScaffoldColor,
              child: Image(
                image: NetworkImage(
                  'https://spoonacular.com/cdn/ingredients_250x250/$imageKey',
                ),
                height: 50,
                width: 50,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Center(
              child: AutoSizeText(
                ingredientName,
                maxLines: 1,
                maxFontSize: 14.0,
                minFontSize: 11.0,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF313131),
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoSlab',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
