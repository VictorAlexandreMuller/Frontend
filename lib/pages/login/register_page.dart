import 'package:festora/models/RegistroErroModel.dart';
import 'package:festora/models/UsuarioRegisterModel';
import 'package:festora/pages/login/login_page.dart';
import 'package:festora/services/registro_service.dart';
import 'package:festora/services/token_service.dart';
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
  void initState() {
    super.initState();
    verificarToken(context);
  }

   void verificarToken(BuildContext context) async {
    TokenService.verificarToken(context);
  }

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =TextEditingController();

  String _nomeError = '';
  String _emailError = '';
  String _passwordError = '';
  String _repeatPasswordError = '';

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  void _register() async {
    final nome = _nomeController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final repeatPassword = _repeatPasswordController.text;

    (bool, RegistroErroModel) result = await RegistroService().criarUsuario(
      UsuarioRegisterModel(
        nome: nome,
        email: email,
        password: password,
        repeatPassword: repeatPassword,
      ),
    );

    if (result.$1 == false) {
      setState(() {
        _nomeError = result.$2.nome;
        _emailError = result.$2.email;
        _passwordError = result.$2.senha;
        _repeatPasswordError = result.$2.senhaRepitida;
      });
    } else if (result.$1 == true) {
      Future.delayed(const Duration(milliseconds: 300), () {
        // Redireciona para o login
        context.goNamed(LoginPage.name);
        // Mostra o Snackbar após o redirecionamento
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cadastro realizado com sucesso!'),
            duration: Duration(seconds: 3),
          ),
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFd6a467),
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
    );
  }

  Widget homeTitle() {
    return const Text(
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
    return const Divider(
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
            controller: _nomeController,
          ),
          errorLabel(_nomeError),
          InputLogin(
            label: 'E-mail',
            isPassword: false,
            controller: _emailController,
          ),
          errorLabel(_emailError),
          InputLogin(
            label: 'Password',
            isPassword: true,
            controller: _passwordController,
          ),
          errorLabel(_passwordError),
          InputLogin(
            label: 'Repeat Password',
            isPassword: true,
            controller: _repeatPasswordController,
          ),
          errorLabel(_repeatPasswordError),
        ],
      ),
    );
  }

  Widget errorLabel(String error) {
    return Visibility(
      visible: error.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, left: 5),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            error,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        ),
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
                  text: 'Registrar',
                  enabled: true,
                  rounded: false,
                  onPressed: _register,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
