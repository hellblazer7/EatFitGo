import 'package:cookbook/components/additionalingredientscard.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerIngredient extends StatelessWidget {
  const ShimmerIngredient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Shimmer.fromColors(
        period: const Duration(milliseconds: 1000),
        baseColor: (Colors.grey[200])!,
        highlightColor: (Colors.grey[100])!,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              height: 271,
            ),
            const SizedBox(height: 60.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 35.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 65.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 70.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(17.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Container(
                          height: 70.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(17.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 42.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      AdditionalIngredientsCard(
                        additionalIngredients: 0,
                      ),
                      SizedBox(width: 10.0),
                      AdditionalIngredientsCard(
                        additionalIngredients: 0,
                      ),
                      SizedBox(width: 10.0),
                      AdditionalIngredientsCard(
                        additionalIngredients: 0,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      AdditionalIngredientsCard(
                        additionalIngredients: 0,
                      ),
                      SizedBox(width: 10.0),
                      AdditionalIngredientsCard(
                        additionalIngredients: 0,
                      ),
                      SizedBox(width: 10.0),
                      AdditionalIngredientsCard(
                        additionalIngredients: 0,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    height: 63,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17.0),
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
