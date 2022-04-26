import 'package:flutter/cupertino.dart';
import 'package:meercook/model/recipe.dart';
import 'package:meercook/pages/recipes/components/recipe_element.dart';

import 'components/sliver_nav.dart';

class Recipes extends StatefulWidget {
  const Recipes({Key? key}) : super(key: key);

  @override
  State<Recipes> createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  List<Recipe> recipesList = [];

  @override
  void initState() {
    fetchRecipes();
    super.initState();
  }

  fetchRecipes() async {
    List<Recipe> _recipesList = await getRecipes();
    setState(() {
      recipesList = _recipesList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const SliverNav(),
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
                        onDelete: () => {
                          setState(() {
                            deleteRecipe(recipesList[index].id!);
                            recipesList.removeAt(index);
                          })
                        },
                      );
                    },
                    childCount: recipesList.length,
                  ),
                )
              : const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                    ),
                    child: CupertinoActivityIndicator(
                      radius: 14,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
