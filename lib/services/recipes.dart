import 'networking.dart';

const apiKey = '7779f62b8d6843938d02f4a07eaee455';

class RecipeModel {
  Future<dynamic> getRecipes(String meal) async {
    String spoonacularURL =
        'https://api.spoonacular.com/recipes/complexSearch?query=$meal&apiKey=$apiKey&sort=popularity&number=20&addRecipeNutrition=true';
    try {
      NetworkHelper networkHelper = NetworkHelper(spoonacularURL);
      var recipeData = await networkHelper.getData();
      return recipeData;
    } catch (e) {
      return null;
    }
  }
}
