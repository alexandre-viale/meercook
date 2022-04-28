import 'dart:convert';

import 'package:http/http.dart';
import 'package:meercook/environment.dart';
import 'package:meercook/model/recipe_step.dart';
import 'package:meercook/model/storer.dart';

Future<List<RecipeStep>> getStepsByRecipeId(recipeId) async {
  final uri = Uri(
      host: Environment.apiHost,
      port: Environment.apiPort,
      path: '${Environment.apiPath}/recipes/$recipeId/steps/',
      scheme: 'http');
  try {
    final response = await get(uri, headers: {
      'Authorization': 'Bearer ${await Storer.getAccessToken()}',
    });
    if (response.statusCode == 200) {
      final Map res = jsonDecode(response.body);
      List<RecipeStep> steps = [];
      res['steps'].map((step) {
        steps.add(RecipeStep.fromJson(step));
      }).toList();
      return steps;
    }
    return [];
  } catch (e) {
    print(e);
    return [];
  }
}
