import 'package:flutter/cupertino.dart';
import 'package:meercook/model/recipe.dart';
import 'package:meercook/pages/recipes/components/editors/description_editor.dart';
import 'package:meercook/pages/recipes/components/editors/ingredients_editor.dart';
import 'package:meercook/pages/recipes/components/editors/steps_editor.dart';
import 'package:meercook/pages/recipes/components/editors/title_editor.dart';
import 'package:meercook/services/ingredient_service.dart';
import 'package:meercook/services/step_service.dart';

class RecipeEditor extends StatefulWidget {
  const RecipeEditor({
    Key? key,
  }) : super(key: key);

  @override
  State<RecipeEditor> createState() => _RecipeEditorState();
}

class _RecipeEditorState extends State<RecipeEditor> {
  late Recipe recipe;
  bool fetching = true;
  void fetchRecipeDetails() async {
    recipe.ingredients = await getIngredientsByRecipeId(recipe.id);
    recipe.steps = await getStepsByRecipeId(recipe.id);
    if (mounted) {
      setState(() {
        fetching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    if (route == null) return const SizedBox.shrink();
    recipe = route.settings.arguments as Recipe;
    fetchRecipeDetails();
    return CupertinoPageScaffold(
      child: Center(
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              previousPageTitle: 'Annuler',
              largeTitle: Text('Modifier ' + recipe.title),
            ),
            SliverToBoxAdapter(
              child: Hero(
                tag: 'recipe_${recipe.id}',
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
            const SliverToBoxAdapter(
              child: SizedBox(height: 16),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TitleEditor(recipe: recipe),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: DescriptionEditor(recipe: recipe),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: fetching
                    ? const CupertinoActivityIndicator()
                    : IngredientsEditor(recipe: recipe),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: fetching
                    ? const CupertinoActivityIndicator()
                    : StepsEditor(recipe: recipe),
              ),
            )
          ],
        ),
      ),
    );
  }
}
