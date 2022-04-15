import 'package:flutter/cupertino.dart';
import 'package:meercook/model/storer.dart';
import 'package:meercook/pages/default_page.dart';
import 'package:meercook/pages/login_page.dart';

void main() async {
  runApp(const Meercook());
}

class Meercook extends StatelessWidget {
  const Meercook({Key? key}) : super(key: key);
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
        '/home': (context) => const DefaultPage(),
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
          return const DefaultPage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
