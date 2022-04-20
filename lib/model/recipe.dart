import 'dart:convert';
import 'package:meercook/environment.dart';
import 'package:http/http.dart';
import 'package:meercook/model/storer.dart';

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

Future<List<Recipe>> getRecipes() async {
  final url = Uri(
      host: Environment.apiHost,
      port: Environment.apiPort,
      path: '${Environment.apiPath}/recipes',
      scheme: 'http');
  try {
    final response = await get(url, headers: {
      'Authorization': 'Bearer ${await Storer.getAccessToken()}',
    });
    if (response.statusCode == 200) {
      final List res = jsonDecode(response.body);
      List<Recipe> recipesList = [];
      res.map((recipe) {
        recipesList.add(Recipe.fromJson(recipe));
        recipesList.add(Recipe.fromJson(recipe));
        recipesList.add(Recipe.fromJson(recipe));
        recipesList.add(Recipe.fromJson(recipe));
        recipesList.add(Recipe.fromJson(recipe));
        recipesList.add(Recipe.fromJson(recipe));
        recipesList.add(Recipe.fromJson(recipe));
        recipesList.add(Recipe.fromJson(recipe));
        recipesList.add(Recipe.fromJson(recipe));
      }).toList();
      return recipesList;
    }
    return [];
  } catch (e) {
    rethrow;
  }
}
