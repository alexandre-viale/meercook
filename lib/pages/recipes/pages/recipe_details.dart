import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meercook/model/ingredient.dart';
import 'package:meercook/model/recipe.dart';
import 'package:meercook/model/recipe_step.dart';
import 'package:meercook/pages/recipes/pages/recipe_editor.dart';
import 'package:meercook/services/ingredient_service.dart';
import 'package:meercook/services/step_service.dart';

class RecipeDetails extends StatefulWidget {
  const RecipeDetails({
    Key? key,
    required this.recipe,
  }) : super(key: key);
  final Recipe recipe;
  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  late Recipe _recipe;
  @override
  void initState() {
    _recipe = Recipe(
      id: widget.recipe.id,
      title: widget.recipe.title,
      description: widget.recipe.description,
      userId: widget.recipe.userId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            previousPageTitle: 'Recettes',
            largeTitle: Text(_recipe.title),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(
                CupertinoIcons.pencil,
                color: CupertinoColors.activeOrange,
              ),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => RecipeEditor(recipe: _recipe),
                  ),
                );
                if (result != null) {
                  setState(() {
                    _recipe = result;
                  });
                }
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Hero(
              tag: 'recipe_${_recipe.id}',
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                height: 250,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  image: DecorationImage(
                    image: AssetImage('assets/img/login_background.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _recipe.description == ''
                      ? const SizedBox.shrink()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description',
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .navTitleTextStyle,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              _recipe.description,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Divider(
                              color: CupertinoTheme.of(context)
                                  .primaryContrastingColor,
                            ),
                          ],
                        ),
                  const SizedBox(height: 10),
                  Text(
                    'Ingrédients',
                    style:
                        CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                  ),
                  const SizedBox(height: 10),
                  FutureBuilder(
                    future: getIngredientsByRecipeId(_recipe.id),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CupertinoActivityIndicator();
                      }
                      List<Ingredient> ingredients =
                          snapshot.data as List<Ingredient>;
                      if (snapshot.connectionState == ConnectionState.done &&
                          ingredients.isEmpty) {
                        return const Text('Aucun ingrédient');
                      }
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        cacheExtent: 0,
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        shrinkWrap: true,
                        itemCount: ingredients.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Text(
                              '- ${ingredients[index].text}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Divider(
                    color: CupertinoTheme.of(context).primaryContrastingColor,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Étapes',
                    style:
                        CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                  ),
                  const SizedBox(height: 10),
                  FutureBuilder(
                    future: getStepsByRecipeId(_recipe.id),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CupertinoActivityIndicator();
                      }
                      List<RecipeStep> steps =
                          snapshot.data as List<RecipeStep>;
                      if (snapshot.connectionState == ConnectionState.done &&
                          steps.isEmpty) {
                        return const Text('Aucune étape');
                      }
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        cacheExtent: 0,
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        shrinkWrap: true,
                        itemCount: steps.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Text(
                              '${index + 1} - ${steps[index].text}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
