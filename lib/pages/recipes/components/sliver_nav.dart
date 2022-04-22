import 'package:flutter/cupertino.dart';
import 'package:meercook/model/recipe.dart';

class SliverNav extends StatefulWidget {
  const SliverNav({Key? key}) : super(key: key);

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
      middle: isSearchOpened
          ? AnimatedContainer(
              duration: const Duration(seconds: 1000),
              child: CupertinoSearchTextField(
                focusNode: searchFocus,
                placeholder: 'Ça marche pas encore',
                onSubmitted: (String value) {
                  print(value);
                },
              ),
            )
          : null,
      leading: CupertinoButton(
        padding: EdgeInsets.zero,
        child: isSearchOpened
            ? const Icon(CupertinoIcons.xmark_circle_fill)
            : const Icon(CupertinoIcons.search),
        onPressed: () {
          setState(() {
            isSearchOpened = !isSearchOpened;
            isSearchOpened ? searchFocus.requestFocus() : searchFocus.unfocus();
          });
        },
      ),
      trailing: CupertinoButton(
        padding: EdgeInsets.zero,
        child: const Icon(CupertinoIcons.add),
        onPressed: () {
          Navigator.of(context)
              .pushNamed('/recipes/editor', arguments: Recipe());
        },
      ),
    );
  }
}
