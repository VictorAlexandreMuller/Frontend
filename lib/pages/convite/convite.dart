import 'package:festora/models/evento_details_model.dart';
import 'package:festora/services/evento_service.dart';
import 'package:festora/services/token_service.dart';
import 'package:festora/services/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ConviteLinkPage extends StatefulWidget {
  const ConviteLinkPage({super.key});
  static const String routeName = 'convite';

  @override
  State<ConviteLinkPage> createState() => _ConviteLinkPageState();
}

class _ConviteLinkPageState extends State<ConviteLinkPage> {
  EventoDetails? evento;
  bool _carregado = false;

  @override
  void initState() {
    super.initState();
    TokenService.verificarToken(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_carregado) {
      carregarEvento();
      verificarParticipacao();
      _carregado = true;
    }
  }

  Future<void> verificarParticipacao() async {
    final eventoIdQuery = GoRouterState.of(context).uri.queryParameters['eventoId'];

    if (eventoIdQuery != null) {
      bool isParticipando = await UsuarioService().isParticipando(eventoIdQuery);
    if (isParticipando) {
      GoRouter.of(context).go('/menu');
    }
    }
  }

  Future<void> carregarEvento() async {
    final eventoIdQuery =
        GoRouterState.of(context).uri.queryParameters['eventoId'];

    if (eventoIdQuery != null) {
      final eventoDb = await EventoService().buscarEvento(eventoIdQuery);
      if (eventoDb.$1) {
        setState(() {
          evento = eventoDb.$2;
        });
      }
    }
  }

  Future<void> aceitarConvite() async {
    if (evento != null) {
      final resultado = await EventoService().participar(evento!.id);
      final sucesso = resultado.$1;
      final mensagem = resultado.$2;

      if (sucesso) {
        if (mounted) {
          GoRouter.of(context).go('/menu');
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(mensagem),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
        child: Center(
          child: Column(
            children: [
              const Text(
                "Doce Encontro",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              if (evento != null) ...[
                Text(
                  "${evento!.organizador.nome} te convidou para o ${evento!.tipo}: ${evento!.titulo}!",
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                EventoDetalhesCard(evento: evento!),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: aceitarConvite,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Aceitar"),
                ),
              ] else
                const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget do card de detalhes
class EventoDetalhesCard extends StatelessWidget {
  final EventoDetails evento;

  const EventoDetalhesCard({super.key, required this.evento});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              evento.titulo,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              evento.descricao,
              style: const TextStyle(fontSize: 16),
            ),
            const Divider(height: 32),
            _buildInfoItem('Tipo', evento.tipo),
            _buildInfoItem('Data e Hora', _formatarData(evento.data)),
            _buildInfoItem('Local', evento.endereco.local),
            _buildInfoItem(
              'Endereço',
              '${evento.endereco.rua}, ${evento.endereco.numero} - ${evento.endereco.cidade} - ${evento.endereco.estado}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$titulo: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Text(
              valor,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  String _formatarData(String? isoDate) {
    if (isoDate == null) return '';
    try {
      final date = DateTime.parse(isoDate);
      return DateFormat('dd/MM/yyyy HH:mm').format(date);
    } catch (e) {
      return isoDate;
    }
  }
}
