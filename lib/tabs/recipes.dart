import 'package:flutter/cupertino.dart';

class RecipesTab extends StatefulWidget {
  const RecipesTab({Key? key}) : super(key: key);
  @override
  State<RecipesTab> createState() => _RecipesTabState();
}

class _RecipesTabState extends State<RecipesTab> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Recettes'),
        trailing: Text('Recettes'),
      ),
      child: Center(
        child: Text("Recipes"),
      ),
    );
  }
}
