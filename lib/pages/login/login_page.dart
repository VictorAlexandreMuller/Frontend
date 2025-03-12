import 'package:festora/pages/login/register_page.dart';
import 'package:festora/pages/menu/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/button/button_login.dart';
import '../../widgets/input/input_login.dart';

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
        backgroundColor: Color(0xFFd6a467),
        body: Container(child: homePage()),
      ),
    );
  }

  Widget homePage() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          homeTitle(),
          SizedBox(height: 50),
          mainDivider(),
          SizedBox(height: 20),
          inputGroup(),
          SizedBox(height: 25),
          buttonGroup(),
          SizedBox(height: 50),
          mainDivider(),
        ],
      ),
    );
  }

  Widget homeTitle() {
    return Text(
      "FESTORA",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: "Inder",
        fontSize: 23,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        letterSpacing: 3.0,
      ),
    );
  }

  Widget mainDivider() {
    return Divider(
      height: 1,
      thickness: 2,
      color: Colors.white,
      indent: 30,
      endIndent: 30,
    );
  }

  Widget inputGroup() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          InputLogin(
            label: 'Login',
            isPassword: false,
          ),
          InputLogin(
            label: 'Password',
            isPassword: true,
          ),
        ],
      ),
    );
  }

  Widget buttonGroup() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ButtonLogin(
            text: 'Enter',
            enabled: true,
            rounded: true,
            onPressed: () {
              context.goNamed(HomePage.name);
            },
          ),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ButtonLogin(
                  text: 'Sign Up',
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
                  text: 'Help',
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
