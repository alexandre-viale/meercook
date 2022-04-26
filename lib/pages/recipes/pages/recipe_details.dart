import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meercook/model/ingredient.dart';
import 'package:meercook/model/recipe.dart';

class RecipeDetails extends StatefulWidget {
  const RecipeDetails({
    Key? key,
  }) : super(key: key);
  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  late Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    if (route == null) return const SizedBox.shrink();
    Recipe recipe = route.settings.arguments as Recipe;
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            previousPageTitle: 'Recettes',
            largeTitle: Text(recipe.title),
            trailing: CupertinoButton(
              child: const Icon(
                Icons.edit,
                color: CupertinoColors.activeOrange,
              ),
              onPressed: () => Navigator.pushNamed(
                context,
                '/recipes/editor',
                arguments: recipe,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style:
                        CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                  ),
                  const SizedBox(height: 10),
                  recipe.description == ''
                      ? const SizedBox.shrink()
                      : Text(
                          recipe.description,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                  const SizedBox(height: 10),
                  Divider(
                    color: CupertinoTheme.of(context).primaryContrastingColor,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Ingrédients',
                    style:
                        CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                  ),
                  const SizedBox(height: 10),
                  FutureBuilder(
                    future: getRecipeIngredients(recipe.id),
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
                        cacheExtent: 0,
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        shrinkWrap: true,
                        itemCount: ingredients.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Text(
                              '- ' + ingredients[index].text,
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
