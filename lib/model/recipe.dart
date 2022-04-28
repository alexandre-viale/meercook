import 'package:flutter/material.dart';
import 'package:meercook/model/ingredient.dart';

class Recipe {
  int? id;
  String title;
  String description;
  int? userId;
  List<Ingredient>? ingredients;
  List<Step>? steps;

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
