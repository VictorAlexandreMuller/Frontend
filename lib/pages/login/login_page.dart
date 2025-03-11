import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/button/button_login.dart';
import '../../widgets/input/input_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          homeTitle(),
          SizedBox(height: 50),
          mainDivider(),
          SizedBox(height: 20),
          inputGroup(),
          SizedBox(height: 50),
          buttonGroup()
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
        fontSize: 20,
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
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          InputLogin(
            label: 'Login',
          ),
          InputLogin(
            label: 'Password',
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
        ButtonLogin(
          text: 'Enter',
          enabled: true,
          rounded: true,
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonLogin(
              text: 'Sign Up',
              enabled: true,
              rounded: false,
            ),
            SizedBox(width: 10),
            ButtonLogin(
              text: 'Help',
              enabled: true,
              rounded: false,
            ),
          ],
        )
      ],
    );
  }
}
