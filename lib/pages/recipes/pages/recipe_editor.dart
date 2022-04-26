import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      navigationBar: CupertinoNavigationBar(
        middle: Text(recipe.title == ''
            ? 'Nouvelle recette'
            : 'Modification d\'une recette'),
      ),
      child: Center(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/img/login_background.jpg',
                  fit: BoxFit.cover,
                  color: CupertinoColors.black.withOpacity(0.0),
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      recipe.description,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
