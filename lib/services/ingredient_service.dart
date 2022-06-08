import 'dart:convert';

import 'package:http/http.dart';
import 'package:meercook/model/ingredient.dart';
import 'package:meercook/services/http_service.dart';

Future<List<Ingredient>> getIngredientsByRecipeId(recipeId) async {
  try {
    final response = await customRequest(
        requestMethod: get, path: '/recipes/$recipeId/ingredients');
    if (response.statusCode == 200) {
      final Map res = jsonDecode(response.body);
      List<Ingredient> ingredients = [];
      res['ingredients'].map((ingredient) {
        ingredients.add(Ingredient.fromJson(ingredient));
      }).toList();
      return ingredients;
    }
    return [];
  } catch (e) {
    rethrow;
  }
}

Future<bool> saveIngredientsByRecipeId(recipeId, ingredients) async {
  try {
    const jsonEncoder = JsonEncoder();
    final response = await customRequest(
        requestMethod: post,
        path: '/recipes/ingredients/save/$recipeId',
        body: {
          'ingredients': jsonEncoder.convert(
            ingredients.map((ingredient) {
              return {
                'text': ingredient.text,
              };
            }).toList(),
          )
        });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    rethrow;
  }
}
