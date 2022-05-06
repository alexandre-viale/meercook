import 'package:flutter/cupertino.dart';
import 'package:meercook/model/ingredient.dart';
import 'package:meercook/model/recipe.dart';
import 'package:meercook/services/ingredient_service.dart';

class IngredientsEditor extends StatefulWidget {
  const IngredientsEditor({Key? key, required this.recipe}) : super(key: key);
  final Recipe recipe;
  @override
  State<IngredientsEditor> createState() => _IngredientsEditorState();
}

class _IngredientsEditorState extends State<IngredientsEditor> {
  List<Ingredient> ingredients = [];
  List<Ingredient> savedIngredients = [];
  final Map<String, TextEditingController> _ingredientControllers = {};

  @override
  void initState() {
    super.initState();
    ingredients = savedIngredients = widget.recipe.ingredients;
    for (final ingredient in ingredients) {
      _ingredientControllers[ingredient.id.toString()] =
          TextEditingController(text: ingredient.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingrédients',
          textAlign: TextAlign.left,
          style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
        ),
        const SizedBox(height: 10),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          cacheExtent: 0,
          padding: const EdgeInsets.symmetric(vertical: 0),
          shrinkWrap: true,
          itemCount: ingredients.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: CupertinoTextField(
                maxLines: null,
                minLines: null,
                expands: true,
                controller:
                    _ingredientControllers[ingredients[index].id.toString()],
                placeholder: 'Ingrédient',
              ),
            );
          },
        ),
      ],
    );
  }
}
