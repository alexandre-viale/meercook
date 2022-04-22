import 'package:flutter/cupertino.dart';
import 'package:meercook/model/recipe.dart';
import 'package:meercook/pages/recipes/components/recipe.dart';

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
    super.initState();
    fetchRecipes();
  }

  fetchRecipes() async {
    List<Recipe> _recipesList = await getRecipes();
    setState(() {
      recipesList = _recipesList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = const CupertinoDynamicColor.withBrightness(
      color: CupertinoColors.white,
      darkColor: CupertinoColors.black,
    ).resolveFrom(context);
    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
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
                      return RecipeWidget(
                        recipe: recipesList[index],
                        onTap: () => Navigator.pushNamed(
                          context,
                          '/recipe_details',
                          arguments: recipesList[index],
                        ),
                      );
                    },
                    childCount: recipesList.length,
                  ),
                )
              : const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: CupertinoActivityIndicator(radius: 14),
                  ),
                )
        ],
      ),
    );
  }
}
