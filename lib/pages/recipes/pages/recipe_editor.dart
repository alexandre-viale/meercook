import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image/image.dart' as img;
import 'package:meercook/globals.dart';
import 'package:meercook/model/recipe.dart';
import 'package:meercook/pages/recipes/components/editors/description_editor.dart';
import 'package:meercook/pages/recipes/components/editors/ingredients_editor.dart';
import 'package:meercook/pages/recipes/components/editors/photo_editor.dart';
import 'package:meercook/pages/recipes/components/editors/steps_editor.dart';
import 'package:meercook/pages/recipes/components/editors/title_editor.dart';
import 'package:meercook/services/ingredient_service.dart';
import 'package:meercook/services/recipe_service.dart';
import 'package:meercook/services/step_service.dart';

class RecipeEditor extends StatefulWidget {
  const RecipeEditor({
    Key? key,
    required this.recipe,
  }) : super(key: key);
  final Recipe recipe;
  @override
  State<RecipeEditor> createState() => _RecipeEditorState();
}

class _RecipeEditorState extends State<RecipeEditor> {
  bool fetching = true;
  late Recipe _recipe;
  bool saving = false;
  dynamic image = const AssetImage('assets/img/login_background.jpg');

  @override
  void initState() {
    _recipe = Recipe(
      id: widget.recipe.id,
      title: widget.recipe.title,
      description: widget.recipe.description,
      userId: widget.recipe.userId,
    );
    fetchRecipeDetails();
    super.initState();
  }

  void fetchRecipeDetails() async {
    _recipe.ingredients = await getIngredientsByRecipeId(_recipe.id);
    _recipe.steps = await getStepsByRecipeId(_recipe.id);
    if (mounted) {
      setState(() {
        fetching = false;
      });
    }
  }

  void removeEmptyIngredients() {
    _recipe.ingredients = _recipe.ingredients
        .where((ingredient) => ingredient.text != '')
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              previousPageTitle: 'Annuler',
              largeTitle: _recipe.id == null
                  ? const Text('Nouvelle recette')
                  : Text('Modifier ${widget.recipe.title}'),
            ),
            SliverToBoxAdapter(
              child: Hero(
                tag: 'recipe_${_recipe.id}',
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    image: DecorationImage(
                      image: image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: PhotoEditor(
                  onImageSelected: (xFile) async {
                    final path = xFile.path;
                    final bytes = await File(path).readAsBytes();
                    setState(() {
                      image = img.decodeImage(bytes);
                    });
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TitleEditor(
                  recipe: _recipe,
                  onModified: (value) => _recipe.title = value,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: DescriptionEditor(
                  recipe: _recipe,
                  onModified: (value) => _recipe.description = value,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ingrédients',
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .navTitleTextStyle,
                    ),
                    const SizedBox(height: 10),
                    fetching
                        ? const CupertinoActivityIndicator()
                        : IngredientsEditor(
                            recipe: _recipe,
                            onModified: (ingredients) => {
                              _recipe.ingredients = ingredients,
                            },
                          ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Étapes',
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .navTitleTextStyle,
                    ),
                    const SizedBox(height: 10),
                    fetching
                        ? const CupertinoActivityIndicator()
                        : StepsEditor(
                            recipe: _recipe,
                            onModified: (steps) {
                              _recipe.steps = steps;
                            },
                          ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                alignment: AlignmentDirectional.center,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
                child: CupertinoButton.filled(
                  child: saving == true
                      ? const CupertinoActivityIndicator()
                      : const Text(
                          'Sauvegarder',
                          style: TextStyle(
                            color: CupertinoColors.white,
                          ),
                        ),
                  onPressed: () async {
                    setState(() {
                      saving = true;
                    });

                    int? insertId = await saveRecipe(_recipe);
                    _recipe.id ??= insertId;

                    await saveStepsByRecipeId(_recipe.id, _recipe.steps);

                    removeEmptyIngredients();

                    await saveIngredientsByRecipeId(
                        _recipe.id, _recipe.ingredients);

                    _recipe.ingredients =
                        await getIngredientsByRecipeId(_recipe.id);

                    globalRecipesList
                        .removeWhere((element) => element.id == _recipe.id);

                    globalRecipesList.add(_recipe);

                    globalRecipesList
                        .sort((a, b) => a.title.compareTo(b.title));

                    if (_recipe.id == null) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pop(context, _recipe);
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
