import 'package:festora/models/RegistroErroModel.dart';
import 'package:festora/models/UsuarioRegisterModel';
import 'package:festora/pages/login/login_page.dart';
import 'package:festora/services/registro_service.dart';
import 'package:festora/services/token_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static const String name = "RegisterPage";

  @override
  State<StatefulWidget> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  bool _isLoading = false;
  RegistroErroModel _registroErros = RegistroErroModel();

  @override
  void initState() {
    super.initState();
    _verificarToken();
  }

  Future<void> _verificarToken() async {
    TokenService.verificarToken(context);
  }

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
      _registroErros = RegistroErroModel();
    });

    final nome = _nomeController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final repeatPassword = _repeatPasswordController.text;

    final (sucesso, erros) = await RegistroService().criarUsuario(
      UsuarioRegisterModel(
        nome: nome,
        email: email,
        password: password,
        repeatPassword: repeatPassword,
      ),
    );

    setState(() {
      _isLoading = false;
      _registroErros = erros;
    });

    if (sucesso == false) {
      setState(() {});
    } else if (sucesso == true) {
      Future.delayed(const Duration(milliseconds: 300), () {
        context.goNamed(LoginPage.name);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cadastro realizado com sucesso!'),
            duration: Duration(seconds: 3),
          ),
        );
      });
    }
  }

  Widget errorLabel(String? error) {
    return Visibility(
      visible: error != null && error.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, left: 5),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            error!,
            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade100,
        title: const Text("",
            style: TextStyle(color: Colors.pink)), // Título alterado
        iconTheme: const IconThemeData(color: Colors.pink),
        elevation: 0,
        leading: IconButton(
          // Adicionado a seta de voltar
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.goNamed(
                LoginPage.name); // Navega de volta para a tela de Login
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFCE4EC),
                  Color(0xFFE0F7FA),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08,
                  vertical: screenHeight * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Cadastre-se!", // Título menor e mais direto
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "PlayfairDisplay",
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink.shade400,
                      letterSpacing: 1.5,
                      shadows: const [
                        Shadow(
                          blurRadius: 2.0,
                          color: Color.fromRGBO(248, 187, 208, 1),
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _nomeController,
                    decoration: InputDecoration(
                      labelText: 'Nome Completo',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: const Icon(Icons.person_outline,
                          color: Color.fromRGBO(244, 143, 177, 1)),
                    ),
                  ),
                  errorLabel(_registroErros.nome),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: const Icon(Icons.email_outlined,
                          color: Color.fromRGBO(244, 143, 177, 1)),
                    ),
                  ),
                  errorLabel(_registroErros.email),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: const Icon(Icons.lock_outline,
                          color: Color.fromRGBO(244, 143, 177, 1)),
                    ),
                  ),
                  errorLabel(_registroErros.senha),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _repeatPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirmar Senha',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: const Icon(Icons.lock_outline,
                          color: Color.fromRGBO(244, 143, 177, 1)),
                    ),
                  ),
                  errorLabel(_registroErros.senhaRepitida),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade300,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                      elevation: 3,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white))
                        : const Text('Registrar'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
