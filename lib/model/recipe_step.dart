class RecipeStep {
  int? id;
  String text;
  int recipeId;
  int sortId;

  RecipeStep({
    this.id,
    this.text = '',
    required this.recipeId,
    required this.sortId,
  });

  factory RecipeStep.fromJson(Map<String, dynamic> json) => RecipeStep(
        id: json['id'] as int,
        text: json['text'] as String,
        recipeId: json['recipeId'] as int,
        sortId: json['sortId'] as int,
      );
}
