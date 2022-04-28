import 'dart:convert';

import 'package:http/http.dart';
import 'package:meercook/environment.dart';
import 'package:meercook/model/recipe.dart';
import 'package:meercook/model/storer.dart';

Future<bool> deleteRecipe(int id) async {
  final Response response = await get(
    Uri(
      host: Environment.apiHost,
      port: Environment.apiPort,
      path: '${Environment.apiPath}/recipes/$id',
      scheme: 'http',
    ),
    headers: {
      'Authorization': 'Bearer ${await Storer.getAccessToken()}',
    },
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    final Response response = await post(
      Uri(
        host: Environment.apiHost,
        port: Environment.apiPort,
        path: '${Environment.apiPath}/recipes/delete/$id',
        scheme: 'http',
      ),
      headers: {
        'Authorization': 'Bearer ${await Storer.getAccessToken()}',
      },
    );
    if (response.statusCode == 200) {
      return true;
    }
  }
  return false;
}

Future<List<Recipe>> getRecipes() async {
  final uri = Uri(
      host: Environment.apiHost,
      port: Environment.apiPort,
      path: '${Environment.apiPath}/recipes',
      scheme: 'http');
  try {
    final response = await get(uri, headers: {
      'Authorization': 'Bearer ${await Storer.getAccessToken()}',
    });
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
    return [];
  }
}
