import 'package:flutter/cupertino.dart';
import 'package:meercook/model/recipe.dart';

class RecipeWidget extends StatelessWidget {
  const RecipeWidget({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/img/login_background.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            CupertinoColors.black.withOpacity(0.6),
            BlendMode.darken,
          ),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          Navigator.pushNamed(context, '/recipeEditor', arguments: recipe);
        },
        child: Text(
          recipe.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: CupertinoColors.white,
          ),
        ),
      ),
    );
  }
}
