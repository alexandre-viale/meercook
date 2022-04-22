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
    final Color blackOrWhite = const CupertinoDynamicColor.withBrightness(
      color: CupertinoColors.white,
      darkColor: CupertinoColors.black,
    ).resolveFrom(context);
    final route = ModalRoute.of(context);
    if (route == null) return const SizedBox.shrink();
    Recipe recipe = route.settings.arguments as Recipe;

    return CupertinoPageScaffold(
      backgroundColor: blackOrWhite,
      navigationBar: CupertinoNavigationBar(
        middle: Text(recipe.title == ''
            ? 'Nouvelle recette'
            : 'Modification d\'une recette'),
      ),
      child: const Center(
        child: Text('Éditeur de recettes ici'),
      ),
    );
  }
}
