import 'dart:convert';

import 'package:http/http.dart';
import 'package:meercook/environment.dart';
import 'package:meercook/model/ingredient.dart';
import 'package:meercook/model/storer.dart';
import 'package:meercook/services/http_service.dart';

Future<List<Ingredient>> getIngredientsByRecipeId(recipeId) async {
  final uri = Uri(
      host: Environment.apiHost,
      port: Environment.apiPort,
      path: '${Environment.apiPath}/recipes/$recipeId/ingredients',
      scheme: 'http');
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
    print(e);
    return [];
  }
}
