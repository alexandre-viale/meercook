import 'package:flutter/cupertino.dart';
import 'package:meercook/tabs/recipes.dart';
import 'package:meercook/model/storer.dart';

void main() {
  runApp(const Meercook());
}

class Meercook extends StatelessWidget {
  const Meercook({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: Home(),
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.activeOrange,
        scaffoldBackgroundColor: CupertinoColors.white,
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.book),
            label: 'Recettes',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Recherche',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_favorites_alt),
            label: 'Favoris',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return const RecipesTab();
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return const CupertinoPageScaffold(
                child: Center(
                  child: Text('Rechercher'),
                ),
              );
            });
          case 2:
            return CupertinoTabView(builder: (context) {
              return const CupertinoPageScaffold(
                child: Center(
                  child: Text('Favoris'),
                ),
              );
            });
          default:
            return CupertinoTabView(builder: (context) {
              return const CupertinoPageScaffold(
                child: RecipesTab(),
              );
            });
        }
      },
    );
  }
}
