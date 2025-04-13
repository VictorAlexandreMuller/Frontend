import 'package:festora/pages/login/register_page.dart';
import 'package:festora/pages/menu/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/button/button_login.dart';
import '../../widgets/input/input_login.dart';
import '../../widgets/background/animated_gradient_background.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String name = "LoginPage";

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F3F3), // ✅ branco gelo
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                homeTitle(),
                const SizedBox(height: 50),
                mainDivider(),
                const SizedBox(height: 20),
                inputGroup(),
                const SizedBox(height: 25),
                buttonGroup(),
                const SizedBox(height: 50),
                mainDivider(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget homeTitle() {
    return const Text(
      "DOCE ENCONTRO",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: "Inder",
        fontSize: 23,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
        letterSpacing: 3.0,
      ),
    );
  }

  Widget mainDivider() {
    return const Divider(
      height: 1,
      thickness: 2,
      color: Colors.black87,
      indent: 30,
      endIndent: 30,
    );
  }

  Widget inputGroup() {
    return Column(
      children: const [
        InputLogin(
          label: 'Login',
          isPassword: false,
        ),
        InputLogin(
          label: 'Password',
          isPassword: true,
        ),
      ],
    );
  }

  Widget buttonGroup() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ButtonLogin(
            text: 'Entrar',
            enabled: true,
            rounded: true,
            onPressed: () {
              context.goNamed(HomePage.name);
            },
          ),
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ButtonLogin(
                  text: 'Cadastrar',
                  enabled: true,
                  rounded: false,
                  onPressed: () {
                    context.goNamed(RegisterPage.name);
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ButtonLogin(
                  text: 'Ajuda',
                  enabled: true,
                  rounded: false,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
