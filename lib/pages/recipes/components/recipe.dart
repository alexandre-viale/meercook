import 'package:flutter/cupertino.dart';
import 'package:meercook/model/recipe.dart';

class RecipeWidget extends StatelessWidget {
  const RecipeWidget({
    Key? key,
    required this.recipe,
    required this.onTap,
  }) : super(key: key);

  final Recipe recipe;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/img/login_background.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            CupertinoColors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          onTap();
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
