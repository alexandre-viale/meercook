import 'package:flutter/cupertino.dart';
import 'package:meercook/model/storer.dart';
import 'package:meercook/pages/login_page.dart';
import 'package:meercook/pages/recipes/recipes.dart';

void main() async {
  runApp(const Meercook());
}

class Meercook extends StatelessWidget {
  const Meercook({Key? key}) : super(key: key);
  final textColor = const CupertinoDynamicColor.withBrightness(
    color: Color.fromARGB(255, 0, 0, 0),
    darkColor: Color.fromARGB(255, 255, 255, 255),
  );
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: const Start(),
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.activeOrange,
        scaffoldBackgroundColor: CupertinoColors.white,
        textTheme: CupertinoTextThemeData(),
      ),
      routes: {
        '/start': (context) => const Start(),
        '/recipes': (context) => const Recipes(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Storer.getAccessToken(),
      builder: (context, snapshot) {
        if (snapshot.data != '') {
          return const Recipes();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   final textColor = const CupertinoDynamicColor.withBrightness(
//     color: Color.fromARGB(255, 0, 0, 0),
//     darkColor: Color.fromARGB(255, 255, 255, 255),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoApp(home: CupertinoPageScaffold(
//       child: Builder(
//         builder: (BuildContext context) {
//           return Container(
//             child: Text(
//               "Hello World",
//               style: TextStyle(
//                   color: CupertinoDynamicColor.resolve(textColor, context)),
//             ),
//           );
//         },
//       ),
//     ));
//   }
// }
