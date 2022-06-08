import 'package:flutter/cupertino.dart';
import 'package:meercook/model/ingredient.dart';
import 'package:meercook/model/recipe.dart';
import 'package:meercook/utils/callbacks.dart';

class IngredientsEditor extends StatefulWidget {
  const IngredientsEditor({
    Key? key,
    required this.recipe,
    required this.onModified,
  }) : super(key: key);
  final Recipe recipe;
  final IngredientListCallBack onModified;
  @override
  State<IngredientsEditor> createState() => _IngredientsEditorState();
}

class _IngredientsEditorState extends State<IngredientsEditor> {
  List<Ingredient> ingredients = [];

  @override
  void initState() {
    ingredients = widget.recipe.ingredients;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                suffix: CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  child: const Icon(CupertinoIcons.clear_thick_circled),
                  onPressed: () {
                    setState(() {
                      ingredients.removeAt(index);
                    });
                    widget.onModified(ingredients);
                  },
                ),
                maxLines: 1,
                minLines: 1,
                expands: false,
                controller:
                    TextEditingController(text: ingredients[index].text),
                onChanged: (value) {
                  ingredients[index].text = value;
                  widget.onModified(ingredients);
                },
                placeholder: 'Ingrédient',
              ),
            );
          },
        ),
        CupertinoButton(
          padding: const EdgeInsets.all(0),
          child: Row(
            children: const [
              Icon(CupertinoIcons.add_circled),
              SizedBox(width: 5),
              Text(
                'Ajouter un ingrédient',
              ),
            ],
          ),
          onPressed: () {
            setState(
              () => ingredients.add(
                Ingredient(recipeId: widget.recipe.id, text: ''),
              ),
            );
          },
        ),
      ],
    );
  }
}
