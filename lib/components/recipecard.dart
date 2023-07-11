import 'package:cookbook/constants.dart';
import 'package:flutter/material.dart';

import '../screens/recipeinfoscreen.dart';

class RecipeCard extends StatefulWidget {
  final String imageSource;
  final String dishName;
  final int calories;
  final String prepTime;
  final String recipeURL;
  final String recipeID;
  final int servingNumber;

  const RecipeCard({
    required this.imageSource,
    Key? key,
    required this.dishName,
    required this.calories,
    required this.prepTime,
    required this.recipeURL,
    required this.recipeID,
    required this.servingNumber,
  }) : super(key: key);

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeInfoScreen(
                recipeId: widget.recipeID,
                recipeUrl: widget.recipeURL,
                calorieCount: widget.calories,
                imageUrl: widget.imageSource,
                recipeName: widget.dishName,
                servingCount: widget.servingNumber,
              ),
            ),
          );
        },
        child: Container(
          height: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(17.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.imageSource,
                    ),
                    radius: 50,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  (widget.dishName.length > 16)
                      ? '${widget.dishName.substring(0, 12)}..'
                      : widget.dishName,
                  style: const TextStyle(
                    fontSize: 17.0,
                    color: Color(0xFF313131),
                    fontFamily: 'RobotoSlab',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  '${widget.calories} cal',
                  style: const TextStyle(
                    color: Color(0xFF919191),
                    fontSize: 14.0,
                    fontFamily: 'RobotoSlab',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(
                  height: 11.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        height: 28.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            ImageIcon(
                              AssetImage(
                                'images/eye.png',
                              ),
                              size: 17.0,
                              color: Color(0xFFFAF9FB),
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              'View',
                              style: TextStyle(
                                color: Color(0xFFFAF9FB),
                                fontSize: 10.0,
                                fontFamily: 'RobotoSlab',
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          color: Color(0xFF919191),
                          size: 19.0,
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          '${widget.prepTime} min',
                          style: const TextStyle(
                            color: Color(0xFF919191),
                            fontSize: 12.0,
                            fontFamily: 'RobotoSlab',
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
