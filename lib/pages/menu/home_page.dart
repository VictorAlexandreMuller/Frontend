import 'package:flutter/material.dart';
import 'package:festora/models/evento_model.dart';
import 'package:festora/models/usuario_details_model' as u;
import 'package:festora/services/evento_service.dart';
import 'package:festora/services/token_service.dart';
import 'package:festora/services/usuario_service.dart';
import 'package:festora/widgets/appBar/custom_bottomnavigation.dart';
import 'package:festora/widgets/appBar/gradient_appbar.dart';
import 'package:festora/widgets/containers/animated_gradient_border_container.dart';
import 'package:festora/widgets/dialogs/select_tipo_cha_dialog.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String name = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedItem = 0;
  late u.UsuarioDetailsModel usuario;
  List<EventoModel> chas = [];
  late String usuarioNome = 'Carregando...';

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    await carregarEventosAtivos();
    await carregarUsuario();
    verificarToken(context);
  }

  Future<void> carregarEventosAtivos() async {
    final eventos = await EventoService().listarEventosAtivos();
    setState(() {
      chas = eventos;
    });
  }

  Future<void> carregarUsuario() async {
    final buscarUsuario = await UsuarioService().obterUsuario();
    setState(() {
      usuario = buscarUsuario;
      usuarioNome = buscarUsuario.nome;
    });
  }

  void verificarToken(BuildContext context) {
    TokenService.verificarToken(context);
  }

  void _onBNTapped(int index) {
    setState(() {
      selectedItem = index;
    });
  }

  final List<Map<String, dynamic>> funcoes = [
    {"icon": Icons.add, "label": "Criar Evento"},
    {"icon": Icons.calendar_today, "label": "Agenda"},
    {"icon": Icons.chat, "label": "Chat"},
    {"icon": Icons.list, "label": "Presentes"},
    {"icon": Icons.map, "label": "Localização"},
    {"icon": Icons.notifications, "label": "Notificações"},
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F3F3),
        appBar: GradientAppBar(usuarioNome),
        bottomNavigationBar: CustomBottomNavigation(
          currentIndex: selectedItem,
          onItemSelected: _onBNTapped,
          onCreatePressed: () => _mostrarEscolhaDeCha(context),
        ),
        body: RefreshIndicator(
          onRefresh: _carregarDados,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Column(
              children: [
                if (chas.isNotEmpty)
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: chas.length,
                      itemBuilder: (context, index) {
                        final evento = chas[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: SizedBox(
                            width: 250,
                            child: AnimatedGradientBorderContainer(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      evento.titulo ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      evento.descricao ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      _formatarData(evento.data),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                if (chas.isNotEmpty) const SizedBox(height: 20),
                const Divider(thickness: 1, color: Colors.black45),
                const SizedBox(height: 12),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1,
                    children: funcoes.map((item) {
                      return GestureDetector(
                        onTap: () {
                          if (item['label'] == 'Criar Evento') {
                            _mostrarEscolhaDeCha(context);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black45),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(item['icon'], size: 30, color: Colors.black),
                              const SizedBox(height: 8),
                              Text(
                                item['label'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _mostrarEscolhaDeCha(BuildContext context) {
    SelectTipoChaDialog.show(context);
  }

  String _formatarData(String? isoDate) {
    if (isoDate == null) return '';
    try {
      final date = DateTime.parse(isoDate);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return isoDate;
    }
  }
}
