import 'package:festora/widgets/dialogs/select_tipo_cha_dialog.dart';
import 'package:flutter/material.dart';
import 'package:festora/pages/menu/buscar_page.dart';
import 'package:festora/pages/menu/listagem_page.dart';
import 'package:festora/pages/menu/perfil_page.dart';
import 'package:festora/pages/menu/home_page.dart';
import 'package:festora/services/token_service.dart';
import 'package:festora/widgets/appBar/barra_de_navegacao.dart';
import 'package:go_router/go_router.dart';

class HomeSectionPage extends StatefulWidget {
  const HomeSectionPage({super.key});
  static const String name = 'HomeSectionPage';

  @override
  State<HomeSectionPage> createState() => _HomeSectionPageState();
}

class _HomeSectionPageState extends State<HomeSectionPage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  // Agora as keys estão acessíveis aqui
  final GlobalKey<HomePageState> _homeKey = GlobalKey<HomePageState>();
  final GlobalKey<ListagemPageState> _listagemKey =
      GlobalKey<ListagemPageState>();

  List<Widget> get _pages => [
        HomePage(
            key: _homeKey,
            onCreatePressed: () => _mostrarEscolhaDeCha(context)),
        const BuscarPage(),
        ListagemPage(key: _listagemKey),
        const PerfilPage(),
      ];

  @override
  void initState() {
    super.initState();
    _verificarLogin();
  }

  Future<void> _verificarLogin() async {
    await Future.delayed(const Duration(milliseconds: 200));
    await TokenService.verificarToken(context);
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: _currentIndex,
        onItemSelected: _onItemTapped,
        onCreatePressed: () {
          _mostrarEscolhaDeCha(context);
        },
      ),
    );
  }

  void _mostrarEscolhaDeCha(BuildContext context) async {
    final tipoEscolhido = await SelectTipoChaDialog.show(context);
    if (tipoEscolhido != null) {
      final result = await GoRouter.of(context).pushNamed<String>(
        'criar-evento',
        extra: tipoEscolhido,
      );

      if (result == 'evento_criado') {
        _homeKey.currentState?.carregarEventosAtivos();
        _listagemKey.currentState?.carregarEventos();
      }
    }
  }
}
