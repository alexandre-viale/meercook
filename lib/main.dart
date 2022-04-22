import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meercook/model/storer.dart';
import 'package:meercook/pages/login_page.dart';
import 'package:meercook/pages/recipes/pages/recipe_details.dart';
import 'package:meercook/pages/recipes/pages/recipe_editor.dart';
import 'package:meercook/pages/recipes/recipes.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

void main() async {
  runApp(const Meercook());
}

class Meercook extends StatefulWidget {
  const Meercook({Key? key}) : super(key: key);

  @override
  State<Meercook> createState() => _MeercookState();
}

class _MeercookState extends State<Meercook> {
  @override
  void initState() {
    setOptimalDisplayMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      home: const Start(),
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.activeOrange,
        scaffoldBackgroundColor: CupertinoColors.white,
        textTheme: CupertinoTextThemeData(
          primaryColor: CupertinoColors.activeOrange,
        ),
      ),
      routes: {
        '/recipes': (context) => const Recipes(),
        '/recipes/editor': (context) => const RecipeEditor(),
        '/recipes/details': (context) => const RecipeDetails(),
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

// Set refresh rate for specific phone
Future<void> setOptimalDisplayMode() async {
  final List<DisplayMode> supported = await FlutterDisplayMode.supported;
  final DisplayMode active = await FlutterDisplayMode.active;

  final List<DisplayMode> sameResolution = supported
      .where((DisplayMode m) =>
          m.width == active.width && m.height == active.height)
      .toList()
    ..sort((DisplayMode a, DisplayMode b) =>
        b.refreshRate.compareTo(a.refreshRate));

  final DisplayMode mostOptimalMode =
      sameResolution.isNotEmpty ? sameResolution.first : active;

  /// This setting is per session.
  /// Please ensure this was placed with `initState` of your root widget.
  await FlutterDisplayMode.setPreferredMode(mostOptimalMode);
}
