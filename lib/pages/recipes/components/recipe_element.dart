import 'package:flutter/cupertino.dart';
import 'package:meercook/model/recipe.dart';

class RecipeElement extends StatefulWidget {
  const RecipeElement({
    Key? key,
    required this.recipe,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  final Recipe recipe;
  final Function onTap;
  final Function onDelete;
  @override
  State<RecipeElement> createState() => _RecipeElementState();
}

class _RecipeElementState extends State<RecipeElement> {
  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenu(
      actions: [
        CupertinoContextMenuAction(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Modifier'),
              SizedBox(width: 8),
              Icon(CupertinoIcons.pencil),
            ],
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(
              context,
              '/recipes/editor',
              arguments: widget.recipe,
            );
          },
        ),
        CupertinoContextMenuAction(
          isDestructiveAction: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Supprimer'),
              SizedBox(width: 8),
              Icon(
                CupertinoIcons.delete_solid,
                color: CupertinoColors.destructiveRed,
              ),
            ],
          ),
          onPressed: () async {
            Navigator.pop(context);
            await showCupertinoDialog(
              context: context,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: const Text('Supprimer la recette'),
                  content: Text(
                    'Voulez-vous vraiment supprimer la recette "${widget.recipe.title}" ?',
                  ),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('Annuler'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    CupertinoDialogAction(
                      child: const Text('Supprimer'),
                      isDestructiveAction: true,
                      onPressed: () async {
                        Navigator.pop(context);
                        widget.onDelete();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
      child: Hero(
        tag: 'recipe_${widget.recipe.id}',
        child: Container(
          height: 70,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
              widget.onTap();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        widget.recipe.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.white,
                        ),
                      ),
                    ),
                  ),
                  const Icon(
                    CupertinoIcons.right_chevron,
                    color: CupertinoColors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
