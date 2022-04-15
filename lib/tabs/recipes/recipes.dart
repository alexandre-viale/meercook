import 'package:flutter/cupertino.dart';
import 'package:meercook/model/recipe.dart';
import 'package:meercook/tabs/recipes/components/recipe.dart';

class RecipesTab extends StatefulWidget {
  const RecipesTab({Key? key}) : super(key: key);
  @override
  State<RecipesTab> createState() => _RecipesTabState();
}

class _RecipesTabState extends State<RecipesTab> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Recettes'),
      ),
      child: Center(
        child: FutureBuilder(
          future: getRecipes(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              List<Recipe> recipesList = snapshot.data as List<Recipe>;
              return ListView.builder(
                itemCount: recipesList.length,
                itemBuilder: (context, index) {
                  if (recipesList.isNotEmpty) {
                    return RecipeWidget(
                      recipe: recipesList[index],
                    );
                  } else {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Aucune recette trouvée.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                },
              );
            } else {
              return const CupertinoActivityIndicator();
            }
          },
        ),
      ),
    );
  }
}
