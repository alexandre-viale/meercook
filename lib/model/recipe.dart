import 'dart:convert';
import 'package:meercook/environment.dart';
import 'package:http/http.dart';
import 'package:meercook/model/storer.dart';

import 'ingredient.dart';

class Recipe {
  int? id;
  String title;
  String description;
  int? userId;

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        userId: json['userId'] as int,
      );

  Recipe({
    this.id,
    this.title = '',
    this.description = '',
    this.userId,
  });
}

Future<List<Ingredient>> getRecipeIngredients(recipeId) async {
  final uri = Uri(
      host: Environment.apiHost,
      port: Environment.apiPort,
      path: '${Environment.apiPath}/recipes/details/$recipeId',
      scheme: 'http');
  try {
    final response = await get(uri, headers: {
      'Authorization': 'Bearer ${await Storer.getAccessToken()}',
    });
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
    print('hey');
    final response = await get(uri, headers: {
      'Authorization': 'Bearer ${await Storer.getAccessToken()}',
    });
    print(response.statusCode);
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
