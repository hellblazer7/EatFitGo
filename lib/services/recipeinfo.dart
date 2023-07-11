import 'networking.dart';

const apiKey = '7779f62b8d6843938d02f4a07eaee455';

class RecipeInfoModel {
  Future<dynamic> getRecipes(String id) async {
    String spoonacularURL =
        'https://api.spoonacular.com/recipes/$id/information?apiKey=$apiKey';
    try {
      NetworkHelper networkHelper = NetworkHelper(spoonacularURL);
      var recipeData = await networkHelper.getData();
      return recipeData;
    } catch (e) {
      return null;
    }
  }
}
