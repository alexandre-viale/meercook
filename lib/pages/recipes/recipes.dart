import 'package:flutter/cupertino.dart';
import 'package:meercook/model/recipe.dart';
import 'package:meercook/services/recipe_service.dart';
import 'package:meercook/pages/recipes/components/recipe_element.dart';

import 'components/sliver_nav.dart';

class Recipes extends StatefulWidget {
  const Recipes({Key? key}) : super(key: key);

  @override
  State<Recipes> createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  List<Recipe> recipesList = [];
  List<Recipe> savedRecipesList = [];
  bool fetching = false;
  @override
  void initState() {
    fetchRecipes();
    super.initState();
  }

  fetchRecipes() async {
    setState(() => fetching = true);
    List<Recipe> _recipesList = await getRecipes();
    _recipesList.sort((a, b) => a.title.compareTo(b.title));
    setState(() {
      recipesList = savedRecipesList = _recipesList;
      fetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          SliverNav(
            onSearch: (filterValue) {
              setState(() {
                recipesList = savedRecipesList
                    .where((recipe) => recipe.title
                        .toLowerCase()
                        .contains(filterValue.toLowerCase()))
                    .toList();
              });
            },
            onStopSearch: () => setState(
              () {
                recipesList = savedRecipesList;
              },
            ),
          ),
          recipesList.isNotEmpty
              ? CupertinoSliverRefreshControl(
                  onRefresh: () async {
                    await fetchRecipes();
                  },
                )
              : const SliverToBoxAdapter(),
          recipesList.isNotEmpty
              ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return RecipeElement(
                        recipe: recipesList[index],
                        onTap: () => Navigator.pushNamed(
                          context,
                          '/recipes/details',
                          arguments: recipesList[index],
                        ),
                        onDelete: () async {
                          await deleteRecipe(recipesList[index].id!);
                          setState(() {
                            recipesList.removeAt(index);
                          });
                        },
                      );
                    },
                    childCount: recipesList.length,
                  ),
                )
              : SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: fetching == true
                        ? const CupertinoActivityIndicator(
                            radius: 14,
                          )
                        : Center(
                            child: Text(
                              'Aucune recette',
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .navTitleTextStyle,
                            ),
                          ),
                  ),
                ),
        ],
      ),
    );
  }
}
