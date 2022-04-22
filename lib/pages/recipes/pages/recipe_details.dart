import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meercook/model/recipe.dart';

class RecipeDetails extends StatefulWidget {
  const RecipeDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  late Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = const CupertinoDynamicColor.withBrightness(
      color: CupertinoColors.white,
      darkColor: CupertinoColors.black,
    ).resolveFrom(context);
    final Color textColor = const CupertinoDynamicColor.withBrightness(
      color: CupertinoColors.black,
      darkColor: CupertinoColors.white,
    ).resolveFrom(context);
    final route = ModalRoute.of(context);
    if (route == null) return const SizedBox.shrink();
    Recipe recipe = route.settings.arguments as Recipe;
    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      child: CustomScrollView(slivers: [
        SliverAppBar(
          backgroundColor: backgroundColor,
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
                Text(
                  recipe.title,
                  style: TextStyle(
                    fontSize: 30,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  recipe.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
      // Container(
      //   padding: const EdgeInsets.only(top: 95),
      //   child: Column(
      //     children: [
      //       Container(
      //         height: 200,
      //         decoration: const BoxDecoration(
      //           image: DecorationImage(
      //             image: AssetImage('assets/img/login_background.jpg'),
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //       ),
      //       Container(
      //         alignment: Alignment.center,
      //         child: Column(
      //           children: [
      //             const SizedBox(
      //               height: 10,
      //             ),
      //             const SizedBox(height: 20),
      //             Text(
      //               recipe.description +
      //                   '\n' +
      //                   recipe.description +
      //                   recipe.description +
      //                   '\n' +
      //                   recipe.description +
      //                   recipe.description +
      //                   '\n' +
      //                   recipe.description +
      //                   recipe.description +
      //                   '\n' +
      //                   recipe.description +
      //                   recipe.description +
      //                   '\n' +
      //                   recipe.description +
      //                   recipe.description +
      //                   '\n' +
      //                   recipe.description +
      //                   recipe.description +
      //                   '\n' +
      //                   recipe.description +
      //                   recipe.description +
      //                   '\n' +
      //                   recipe.description +
      //                   recipe.description +
      //                   '\n' +
      //                   recipe.description +
      //                   recipe.description +
      //                   '\n' +
      //                   recipe.description +
      //                   recipe.description +
      //                   '\n' +
      //                   recipe.description +
      //                   recipe.description +
      //                   '\n' +
      //                   recipe.description +
      //                   recipe.description +
      //                   recipe.description +
      //                   '\n' +
      //                   recipe.description +
      //                   recipe.description +
      //                   recipe.description +
      //                   '\n' +
      //                   recipe.description,
      //               style: TextStyle(
      //                 color: descriptionColor,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
