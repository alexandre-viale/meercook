import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:meercook/model/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isButtonDisabled = false;

  Map modalMessage = {
    200: 'Connexion réussie.',
    403: 'Mot de passe incorrect.',
    404: 'Nom d\'utilisateur inconnu.',
    500: 'Erreur interne.',
  };

  void login() async {
    if (emailController.text == '' ||
        passwordController.text == '' ||
        isButtonDisabled) {
      return;
    }
    setState(() {
      isButtonDisabled = true;
    });
    final User user = User(
      email: emailController.text,
      password: passwordController.text,
    );
    dynamic res = await user.login();
    res != 404 ? emailController.text = '' : null;
    res != 403 ? passwordController.text = '' : null;
    setState(() {
      isButtonDisabled = false;
    });
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Connexion'),
          content: Text(modalMessage[res] ?? 'Erreur inconnue.'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                if (res == 200) {
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacementNamed('/home');
                } else {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/login_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(30),
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: CupertinoColors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Connexion à Meercook',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.black,
                      ),
                    ),
                    const Divider(
                      height: 20,
                      color: CupertinoColors.systemGrey,
                    ),
                    const SizedBox(height: 20),
                    CupertinoTextField(
                      prefix: const Icon(CupertinoIcons.person_solid),
                      placeholder: "Nom d'utilisateur",
                      keyboardType: TextInputType.emailAddress,
                      autofocus: true,
                      controller: emailController,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: CupertinoColors.systemGrey,
                            width: 0.7,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CupertinoTextField(
                      prefix: const Icon(CupertinoIcons.padlock_solid),
                      placeholder: 'Mot de passe',
                      keyboardType: TextInputType.visiblePassword,
                      autofocus: true,
                      controller: passwordController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: CupertinoColors.systemGrey,
                            width: 0.7,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    CupertinoButton.filled(
                      child: isButtonDisabled
                          ? const CupertinoActivityIndicator()
                          : const Text('Connexion'),
                      onPressed: () => login(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
