class Ingredient {
  int? id;
  String text;
  int? recipeId;

  Ingredient({
    this.id,
    required this.text,
    this.recipeId,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        id: json['id'] as int,
        text: json['text'] as String,
        recipeId: json['recipeId'] as int,
      );
}
