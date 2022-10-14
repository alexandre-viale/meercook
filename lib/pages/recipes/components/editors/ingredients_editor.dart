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
  List<FocusNode> focusNodes = [];
  @override
  void initState() {
    ingredients = widget.recipe.ingredients;
    for (var i = 0; i < ingredients.length; i++) {
      focusNodes.add(FocusNode());
    }
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
                focusNode: focusNodes[index],
                textCapitalization: TextCapitalization.sentences,
                suffix: CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  child: const Icon(CupertinoIcons.clear_thick_circled),
                  onPressed: () {
                    setState(() {
                      ingredients.removeAt(index);
                      focusNodes.removeAt(index);
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
                textInputAction: TextInputAction.done,
                onSubmitted: (value) {
                  if (!ingredients.asMap().containsKey(index + 1) &&
                      value.isNotEmpty) {
                    setState(() {
                      ingredients.add(Ingredient(text: ''));
                      focusNodes.add(FocusNode());
                    });
                    focusNodes[index + 1].requestFocus();
                  }
                  if (value.isEmpty) {
                    setState(() {
                      ingredients.removeAt(index);
                      focusNodes.removeAt(index);
                    });
                  }
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
              () {
                ingredients.add(
                  Ingredient(text: ''),
                );
                focusNodes.add(FocusNode());
              },
            );
            focusNodes[focusNodes.length - 1].requestFocus();
          },
        ),
      ],
    );
  }
}
