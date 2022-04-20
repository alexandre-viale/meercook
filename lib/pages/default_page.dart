// import 'package:flutter/cupertino.dart';
// import 'package:meercook/tabs/recipes/pages/recipe_editor.dart';
// import 'package:meercook/tabs/recipes/recipes.dart';

// class DefaultPage extends StatelessWidget {
//   const DefaultPage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoTabScaffold(
//       tabBar: CupertinoTabBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(CupertinoIcons.book),
//             label: 'Recettes',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(CupertinoIcons.search),
//             label: 'Recherche',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(CupertinoIcons.square_favorites_alt),
//             label: 'Favoris',
//           ),
//         ],
//       ),
//       tabBuilder: (context, index) {
//         switch (index) {
//           case 0:
//             return CupertinoTabView(
//                 routes: {
//                   '/recipes': (context) => const RecipesTab(),
//                   '/recipeEditor': (context) => const RecipeEditor(),
//                 },
//                 builder: (context) {
//                   return const RecipesTab();
//                 });
//           case 1:
//             return CupertinoTabView(builder: (context) {
//               return const CupertinoPageScaffold(
//                 child: Center(
//                   child: Text('Rien ici pour l\'instant'),
//                 ),
//               );
//             });
//           case 2:
//             return CupertinoTabView(builder: (context) {
//               return const CupertinoPageScaffold(
//                 child: Center(
//                   child: Text('Rien ici pour l\'instant'),
//                 ),
//               );
//             });
//           default:
//             return CupertinoTabView(builder: (context) {
//               return const RecipesTab();
//             });
//         }
//       },
//     );
//   }
// }
