import 'package:cookbook/components/shimmermain.dart';
import 'package:cookbook/constants.dart';
import 'package:cookbook/services/recipes.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../components/recipecard.dart';

enum AppOption { recipes, restaurants, gyms }

class RecipesScreen extends StatefulWidget {
  static const String id = 'recipes_screen';

  const RecipesScreen({Key? key}) : super(key: key);

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  List<int> indexes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  bool isLoading = true;
  AppOption appMode = AppOption.recipes;
  String locality = 'City';
  String country = 'Country';
  RecipeModel recipeModel = RecipeModel();
  List<String> recipeImages = [];
  List<String> recipeName = [];
  List<int> caloriesInRecipes = [];
  List<String> prepTime = [];
  List<String> recipeURL = [];
  List<String> recipeID = [];
  List<String> imageURL = [];
  String mealName = '';
  String mealPunchline = '';
  List<int> servings = [];

  String returnMeal(int hour) {
    if (hour >= 6 && hour < 11) {
      return 'Breakfast';
    } else if (hour >= 11 && hour < 16) {
      return 'Lunch';
    } else if (hour >= 16 && hour < 20) {
      return 'Snacks';
    } else {
      return 'Dinner';
    }
  }

  String returnMealPunchline(int hour) {
    if (hour >= 6 && hour < 11) {
      return 'Have a hearty';
    } else if (hour >= 11 && hour < 16) {
      return 'Enjoy a satisfying';
    } else if (hour >= 16 && hour < 20) {
      return 'Time for';
    } else {
      return 'Savour a filling';
    }
  }

  updateUI() async {
    DateTime now = DateTime.now();
    setState(() {
      mealName = returnMeal(now.hour);
      mealPunchline = returnMealPunchline(now.hour);
    });
    var permission = await Geolocator.checkPermission();
    if (permission.toString() == 'LocationPermission.denied') {
      await Geolocator.requestPermission();
    }
    var position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best)
        .timeout(
      const Duration(seconds: 5),
    );

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      setState(() {
        locality = placemarks[0].locality.toString();
        country = placemarks[0].country.toString();
      });
    } on Error {
      locality = 'City';
      country = 'Country';
    }
    var recipeData = await recipeModel.getRecipes(mealName.toLowerCase());

    for (int i = 0; i < 20; i++) {
      recipeImages.add(recipeData['results'][i]['image']);
      String recipeNameRaw = (recipeData['results'][i]['title']);
      recipeName.add(recipeNameRaw.replaceAll(RegExp('â'), "'"));
      recipeID.add((recipeData['results'][i]['id']).toString());
      recipeURL.add(recipeData['results'][i]['sourceUrl']);
      caloriesInRecipes.add((recipeData['results'][i]['nutrition']['nutrients']
              [0]['amount'])
          .toInt());
      prepTime.add((recipeData['results'][i]['readyInMinutes']).toString());
      servings.add(recipeData['results'][i]['servings']);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    updateUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const ShimmerMain()
        : Scaffold(
            backgroundColor: kScaffoldColor,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 55.0, right: 10.0, left: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 70.0,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(17.0),
                              bottomLeft: Radius.circular(17.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 14.0,
                              ),
                              const CircleAvatar(
                                radius: 25.0,
                                backgroundImage:
                                    AssetImage('images/person.jpg'),
                              ),
                              const SizedBox(
                                width: 35.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Color(0xFF313131),
                                    size: 35.0,
                                  ),
                                  const SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(
                                    '$locality, $country',
                                    style: const TextStyle(
                                      color: Color(0xFF313131),
                                      fontSize: 18.0,
                                      fontFamily: 'RobotoSlab',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 70.0,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(17.0),
                            bottomRight: Radius.circular(17.0),
                          ),
                        ),
                        child: PopupMenuButton(
                          initialValue: appMode,
                          onSelected: (AppOption appOption) {
                            setState(() {
                              appMode = appOption;
                            });
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<AppOption>>[
                            const PopupMenuItem<AppOption>(
                              value: AppOption.recipes,
                              child: Text('Recipes'),
                            ),
                            const PopupMenuItem<AppOption>(
                              value: AppOption.restaurants,
                              child: Text('Restaurants'),
                            ),
                            const PopupMenuItem<AppOption>(
                              value: AppOption.gyms,
                              child: Text('Gyms'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 25.0, right: 10.0, left: 10.0),
                  child: Container(
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(17.0),
                    ),
                    child: Row(
                      children: [
                        const ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(1000.0),
                            bottomRight: Radius.circular(1000.0),
                            topLeft: Radius.circular(174.0),
                            bottomLeft: Radius.circular(174.0),
                          ),
                          child: Image(
                            image: AssetImage('images/recipe_screen_image.jpg'),
                          ),
                        ),
                        const SizedBox(
                          width: 30.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 21.0,
                            ),
                            const Text(
                              'Recipes',
                              style: TextStyle(
                                color: Color(0xFFFAF9FB),
                                fontSize: 31.0,
                                fontFamily: 'RobotoSlab',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 17.0,
                            ),
                            Text(
                              mealPunchline,
                              style: const TextStyle(
                                color: Color(0xFFFAF9FB),
                                fontSize: 18.0,
                                fontFamily: 'RobotoSlab',
                              ),
                            ),
                            const SizedBox(
                              height: 7.0,
                            ),
                            Text(
                              mealName,
                              style: const TextStyle(
                                color: Color(0xFFC7DDD1),
                                fontSize: 21.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'RobotoSlab',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 21.0,
                ),
                Row(
                  children: const [
                    SizedBox(
                      width: 17.0,
                    ),
                    Text(
                      'Based on the type of food you like',
                      style: TextStyle(
                        color: Color(0xFF313131),
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RobotoSlab',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35.0,
                ),
                Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                RecipeCard(
                                  imageSource: recipeImages[indexes[index] * 2],
                                  dishName: recipeName[indexes[index] * 2],
                                  calories:
                                      caloriesInRecipes[indexes[index] * 2],
                                  prepTime: prepTime[indexes[index] * 2],
                                  recipeURL: recipeURL[indexes[index] * 2],
                                  recipeID: recipeID[indexes[index] * 2],
                                  servingNumber: servings[indexes[index] * 2],
                                ),
                                const SizedBox(
                                  width: 14.0,
                                ),
                                RecipeCard(
                                  imageSource:
                                      recipeImages[indexes[index] * 2 + 1],
                                  dishName: recipeName[indexes[index] * 2 + 1],
                                  calories:
                                      caloriesInRecipes[indexes[index] * 2 + 1],
                                  prepTime: prepTime[indexes[index] * 2 + 1],
                                  recipeURL: recipeURL[indexes[index] * 2 + 1],
                                  recipeID: recipeID[indexes[index] * 2 + 1],
                                  servingNumber:
                                      servings[indexes[index] * 2 + 1],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 21.0,
                            ),
                          ],
                        );
                      }),
                ),
              ],
            ),
          );
  }
}
