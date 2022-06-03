import 'dart:convert';

import 'package:http/http.dart';
import 'package:meercook/model/recipe.dart';
import 'package:meercook/services/http_service.dart';

Future<bool> deleteRecipe(int id) async {
  final Response findResponse = await customRequest(
    requestMethod: get,
    path: '/recipes/$id',
  );
  if (findResponse.statusCode != 200) {
    return false;
  }
  final Response deleteResponse = await customRequest(
    requestMethod: delete,
    path: '/recipes/delete/$id',
  );
  if (deleteResponse.statusCode != 200) {
    return false;
  }
  return true;
}

Future<List<Recipe>> getRecipes() async {
  try {
    final Response response = await customRequest(
      requestMethod: get,
      path: '/recipes',
    );
    if (response.statusCode == 200) {
      final List res = jsonDecode(response.body);
      List<Recipe> recipesList = [];
      res.map((recipe) {
        recipesList.add(Recipe.fromJson(recipe));
      }).toList();
      return recipesList;
    }
    return [];
  } catch (e) {
    rethrow;
  }
}

Future<bool> saveRecipe(Recipe recipe) async {
  try {
    Map<String, dynamic> body = {
      'title': recipe.title,
      'description': recipe.description
    };
    if (recipe.id != null) {
      body['id'] = recipe.id.toString();
    }
    final Response response = await customRequest(
      requestMethod: post,
      path: '/recipes/save',
      body: body,
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (e) {
    rethrow;
  }
}
