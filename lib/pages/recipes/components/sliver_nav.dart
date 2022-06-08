import 'package:flutter/cupertino.dart';
import 'package:meercook/model/recipe.dart';
import 'package:meercook/pages/recipes/pages/recipe_editor.dart';
import 'package:meercook/utils/callbacks.dart';

class SliverNav extends StatefulWidget {
  const SliverNav(
      {Key? key,
      required this.onSearch,
      required this.onStopSearch,
      required this.onRecipeCreated})
      : super(key: key);
  final StringCallback onSearch;
  final VoidCallback onStopSearch;
  final VoidCallback onRecipeCreated;
  @override
  State<SliverNav> createState() => _SliverNavState();
}

class _SliverNavState extends State<SliverNav> {
  bool isSearchOpened = false;
  FocusNode searchFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      largeTitle: const Text('Recettes'),
      leading: CupertinoButton(
        padding: EdgeInsets.zero,
        child: isSearchOpened
            ? const Icon(CupertinoIcons.xmark_circle_fill)
            : const Icon(CupertinoIcons.search),
        onPressed: () {
          setState(() {
            isSearchOpened = !isSearchOpened;
            if (!isSearchOpened) {
              widget.onStopSearch();
            }
            isSearchOpened ? searchFocus.requestFocus() : searchFocus.unfocus();
          });
        },
      ),
      middle: isSearchOpened
          ? AnimatedContainer(
              duration: const Duration(seconds: 1000),
              child: CupertinoSearchTextField(
                focusNode: searchFocus,
                placeholder: 'Rechercher une recette',
                onChanged: (String value) {
                  widget.onSearch(value);
                },
              ),
            )
          : null,
      trailing: CupertinoButton(
        padding: EdgeInsets.zero,
        child: const Icon(CupertinoIcons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => RecipeEditor(recipe: Recipe()),
            ),
          );
          widget.onRecipeCreated();
        },
      ),
    );
  }
}
