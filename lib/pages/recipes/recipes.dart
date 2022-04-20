import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:meercook/model/recipe.dart';
import 'package:meercook/pages/recipes/components/recipe.dart';

class Recipes extends StatefulWidget {
  const Recipes({Key? key}) : super(key: key);
  @override
  State<Recipes> createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  @override
  Widget build(BuildContext context) {
    final Color blackOrWhite = const CupertinoDynamicColor.withBrightness(
      color: CupertinoColors.white,
      darkColor: CupertinoColors.black,
    ).resolveFrom(context);
    return CupertinoPageScaffold(
      backgroundColor: blackOrWhite,
      resizeToAvoidBottomInset: false,
      navigationBar: const CupertinoNavigationBar(
        middle: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: CupertinoSearchTextField(
            placeholder: 'Rechercher une recette',
          ),
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: FutureBuilder(
              future: getRecipes(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  List<Recipe> recipesList = snapshot.data as List<Recipe>;
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 50),
                    shrinkWrap: true,
                    itemCount: recipesList.length,
                    itemBuilder: (context, index) {
                      if (recipesList.isNotEmpty) {
                        return RecipeWidget(
                          recipe: recipesList[index],
                        );
                      }
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Aucune recette trouvée.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CupertinoActivityIndicator(),
                      Text(
                        'Chargement',
                        style: TextStyle(
                          fontSize: 13,
                          color: blackOrWhite,
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          Positioned(
            bottom: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: CupertinoDynamicColor.withBrightness(
                      color: CupertinoColors.white.withOpacity(0.8),
                      darkColor: const Color.fromARGB(255, 30, 30, 30)
                          .withOpacity(0.8),
                    ).resolveFrom(context),
                  ),
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: const Icon(CupertinoIcons.add_circled),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/recipeEditor');
                        },
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
