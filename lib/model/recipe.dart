import 'package:meercook/model/ingredient.dart';
import 'package:meercook/model/recipe_step.dart';

class Recipe {
  int? id;
  String title;
  String description;
  int? userId;
  List<Ingredient> ingredients = [];
  List<RecipeStep> steps = [];

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
