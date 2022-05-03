import 'package:flutter/cupertino.dart';
import 'package:meercook/model/recipe.dart';

class RecipeEditor extends StatefulWidget {
  const RecipeEditor({
    Key? key,
  }) : super(key: key);

  @override
  State<RecipeEditor> createState() => _RecipeEditorState();
}

class _RecipeEditorState extends State<RecipeEditor> {
  late Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    if (route == null) return const SizedBox.shrink();
    Recipe recipe = route.settings.arguments as Recipe;

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
                  height: 250,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/login_background.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
