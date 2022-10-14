import 'dart:convert';

import 'package:http/http.dart';
import 'package:meercook/model/recipe_step.dart';
import 'package:meercook/services/http_service.dart';

Future<List<RecipeStep>> getStepsByRecipeId(recipeId) async {
  try {
    final response = await customRequest(
      requestMethod: get,
      path: '/recipes/$recipeId/steps',
    );
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

Future<bool> saveStepsByRecipeId(recipeId, steps) async {
  try {
    const jsonEncoder = JsonEncoder();
    final response = await customRequest(
        requestMethod: post,
        path: '/recipes/steps/save/$recipeId',
        body: {
          'steps': jsonEncoder.convert(
            steps.map((step) {
              return {
                'text': step.text,
                'sortId': step.sortId,
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
