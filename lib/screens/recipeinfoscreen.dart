import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cookbook/components/additionalingredientscard.dart';
import 'package:cookbook/components/shimmeringredient.dart';
import 'package:cookbook/constants.dart';
import 'package:cookbook/services/recipeinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as IMG;
import 'package:url_launcher/url_launcher.dart';

import '../components/ingredientcard.dart';

class RecipeInfoScreen extends StatefulWidget {
  final String recipeUrl;
  final String recipeId;
  final int calorieCount;
  final String imageUrl;
  final String recipeName;
  final int servingCount;
  static const String id = 'recipe_info_screen.id';

  const RecipeInfoScreen(
      {Key? key,
      required this.recipeId,
      required this.recipeUrl,
      required this.calorieCount,
      required this.imageUrl,
      required this.recipeName,
      required this.servingCount})
      : super(key: key);

  @override
  State<RecipeInfoScreen> createState() => _RecipeInfoScreenState();
}

class _RecipeInfoScreenState extends State<RecipeInfoScreen> {
  RecipeInfoModel recipeInfoModel = RecipeInfoModel();
  bool isLoading = true;
  List<String> ingredientImages = [];
  List<String> ingredientNames = [];
  int remainingIngredients = 0;
  Uint8List? resizedImg;
  Random random = Random();
  Uint8List? bytes;
  bool isVegetarian = false;

  launchRecipe() async {
    var uri = Uri.parse(widget.recipeUrl.replaceFirst('http', 'https'));
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // can't launch url
    }
  }

  updateUI() async {
    var recipeData = await recipeInfoModel.getRecipes(widget.recipeId);
    for (int i = 0; i < 5; i++) {
      ingredientImages.add(recipeData['extendedIngredients'][i]['image']);
      ingredientNames.add(recipeData['extendedIngredients'][i]['nameClean']);
    }
    remainingIngredients = recipeData['extendedIngredients'].length - 5;
    isVegetarian = recipeData['vegetarian'];
    setState(() {
      isLoading = false;
    });
  }

  String capitalizeAllWord(String value) {
    var result = value[0].toUpperCase();
    for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " ") {
        result = result + value[i].toUpperCase();
      } else {
        result = result + value[i];
      }
    }
    return result;
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      String imgurl = widget.imageUrl;
      bytes = (await NetworkAssetBundle(Uri.parse(imgurl)).load(imgurl))
          .buffer
          .asUint8List();

      IMG.Image? img = IMG.decodeImage(bytes!);
      IMG.Image resized = IMG.copyResize(img!, width: 624, height: 462);
      resizedImg = Uint8List.fromList(IMG.encodePng(resized));
    });
    updateUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const ShimmerIngredient()
        : Scaffold(
            backgroundColor: const Color(0xFFFAF9FB),
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  height: double.infinity,
                  child: Image(
                    image: MemoryImage(resizedImg!),
                  ),
                ),
                Container(
                  height: 601,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(29.0),
                      topRight: Radius.circular(29.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 35.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        widget.recipeName,
                        maxFontSize: 31.0,
                        maxLines: 2,
                        minFontSize: 24.0,
                        style: const TextStyle(
                          color: Color(0xFF313131),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RobotoSlab',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${widget.calorieCount}cal',
                            style: const TextStyle(
                              color: Color(0xFF919191),
                              fontSize: 19.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RobotoSlab',
                            ),
                          ),
                          const Expanded(
                            child: SizedBox(
                              height: 1.0,
                            ),
                          ),
                          ImageIcon(
                            const AssetImage('images/veg.png'),
                            size: 40.0,
                            color: isVegetarian ? Colors.green : Colors.red,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              height: 70.0,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFAF9FB),
                                borderRadius: BorderRadius.circular(17.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.people_alt_rounded,
                                        color: Colors.indigo,
                                        size: 35.0,
                                      ),
                                      const SizedBox(
                                        width: 4.0,
                                      ),
                                      Text(
                                        widget.servingCount.toString(),
                                        style: const TextStyle(
                                          color: Color(0xFF313131),
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'RobotoSlab',
                                        ),
                                      )
                                    ],
                                  ),
                                  const Text(
                                    'number of serves',
                                    style: TextStyle(
                                      color: Color(0xFF919191),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'RobotoSlab',
                                    ),
                                  )
                                ],
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
                                color: const Color(0xFFFAF9FB),
                                borderRadius: BorderRadius.circular(17.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Colors.yellow,
                                        size: 35.0,
                                      ),
                                      Text(
                                        ((random.nextInt(10) / 10) + 4)
                                            .toString(),
                                        style: const TextStyle(
                                          color: Color(0xFF313131),
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'RobotoSlab',
                                        ),
                                      )
                                    ],
                                  ),
                                  const Text(
                                    'rating for this recipe',
                                    style: TextStyle(
                                      color: Color(0xFF919191),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'RobotoSlab',
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'Ingredients',
                        style: TextStyle(
                          color: Color(0xFF313131),
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RobotoSlab',
                        ),
                      ),
                      const SizedBox(
                        height: 11.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IngredientCard(
                            ingredientName:
                                capitalizeAllWord(ingredientNames[0]),
                            imageKey: ingredientImages[0],
                          ),
                          const SizedBox(width: 10.0),
                          IngredientCard(
                            ingredientName:
                                capitalizeAllWord(ingredientNames[1]),
                            imageKey: ingredientImages[1],
                          ),
                          const SizedBox(width: 10.0),
                          IngredientCard(
                            ingredientName:
                                capitalizeAllWord(ingredientNames[2]),
                            imageKey: ingredientImages[2],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IngredientCard(
                            ingredientName:
                                capitalizeAllWord(ingredientNames[3]),
                            imageKey: ingredientImages[3],
                          ),
                          const SizedBox(width: 10.0),
                          IngredientCard(
                            ingredientName:
                                capitalizeAllWord(ingredientNames[4]),
                            imageKey: ingredientImages[4],
                          ),
                          const SizedBox(width: 10.0),
                          AdditionalIngredientsCard(
                            additionalIngredients: remainingIngredients,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          launchRecipe();
                        },
                        child: Container(
                          height: 63,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(17.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              ImageIcon(
                                AssetImage('images/dinner_fill.png'),
                                color: Colors.white,
                                size: 40.0,
                              ),
                              SizedBox(
                                width: 14.0,
                              ),
                              Text(
                                "Let's Get Cooking!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'RobotoSlab',
                                ),
                              ),
                            ],
                          ),
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
          );
  }
}
