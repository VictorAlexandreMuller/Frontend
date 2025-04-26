
import 'package:festora/models/login_model.dart';
import 'package:festora/pages/login/register_page.dart';
import 'package:festora/pages/menu/home_page.dart';
import 'package:festora/services/login_service.dart';
import 'package:festora/services/token_service.dart';
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

void verificarToken(BuildContext context) async {
  TokenService.verificarToken(context);
}

class _LoginPage extends State<LoginPage> {
    final TextEditingController _loginController = TextEditingController();
    final TextEditingController _senhaController = TextEditingController();

    @override
    void initState() {
      super.initState();
      verificarToken(context);
    }

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
      children: [
        InputLogin(
          label: 'Login',
          isPassword: false,
          controller: _loginController,
        ),
        InputLogin(
          label: 'Password',
          isPassword: true,
          controller: _senhaController,
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
            onPressed: () async {
              final login = _loginController.text;
              final senha = _senhaController.text;

              final sucesso = await LoginService().fazerLogin(LoginModel(
                email: login,
                senha: senha,
              ));
              if (sucesso == true) {
                context.goNamed(HomePage.name);
              } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Login ou senha incorretos")),
                );
              }
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
