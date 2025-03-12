import 'package:festora/pages/login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/button/button_login.dart';
import '../../widgets/input/input_login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static const String name = "RegisterPage";

  @override
  State<StatefulWidget> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
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
      "REGISTRO",
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
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          InputLogin(
            label: 'Nome',
            isPassword: false,
          ),
          InputLogin(
            label: 'E-mail',
            isPassword: false,
          ),
          InputLogin(
            label: 'Login',
            isPassword: false,
          ),
          InputLogin(
            label: 'Password',
            isPassword: true,
          ),
          InputLogin(
            label: 'Repeat Password',
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ButtonLogin(
                  text: 'Go Back',
                  enabled: true,
                  rounded: false,
                  onPressed: () {
                    context.goNamed(LoginPage.name);
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
