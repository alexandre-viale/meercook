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
    recipe = route.settings.arguments as Recipe;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(recipe.title),
      ),
      child: const Center(child: Text('Éditeur de recettes')),
    );
  }
}
