import 'package:festora/pages/event/ver_evento/detalhes_evento_page.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:festora/models/evento_model.dart';
import 'package:festora/services/evento_service.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});
  static const String routeName = '/agenda';

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  Map<DateTime, List<EventoModel>> eventosPorData = {};
  List<EventoModel> eventosSelecionados = [];
  DateTime diaSelecionado = DateTime.now();

  @override
  void initState() {
    super.initState();
    _carregarEventos();
  }

  Future<void> _carregarEventos() async {
    final eventos = await EventoService().listarEventosAtivos();
    final mapa = <DateTime, List<EventoModel>>{};

    print('EVENTOS CARREGADOS:');
    for (var e in eventos) {
      print('${e.titulo} - ${e.data}');
    }
    final formatador = DateFormat('dd/MM/yyyy HH:mm');
    for (var evento in eventos) {
      final data = formatador.parse(evento.data!); // ✅ CORRETO
      final dia = DateTime.utc(data.year, data.month, data.day);
      mapa[dia] = [...(mapa[dia] ?? []), evento];
    }

    final diaAtual = DateTime.utc(
      // <- UTC aqui também!
      diaSelecionado.year,
      diaSelecionado.month,
      diaSelecionado.day,
    );

    setState(() {
      eventosPorData = mapa;
      eventosSelecionados = mapa[diaAtual] ?? [];
    });
  }

  List<EventoModel> _obterEventosDoDia(DateTime dia) {
    final diaLocal = DateTime.utc(dia.year, dia.month, dia.day); // <- e aqui!
    return eventosPorData[diaLocal] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        title: const Text('Agenda de Eventos'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(
        children: [
          TableCalendar<EventoModel>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: diaSelecionado,
            eventLoader: _obterEventosDoDia,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.pinkAccent,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.transparent, // removemos o marcador padrão
              ),
            ),
            selectedDayPredicate: (day) => isSameDay(day, diaSelecionado),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                diaSelecionado = selectedDay;
                eventosSelecionados = _obterEventosDoDia(selectedDay);
              });
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, eventos) {
                if (eventos.isEmpty) return const SizedBox();

                return Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: eventos
                        .take(2)
                        .map((evento) => Text(
                              (evento as EventoModel)
                                      .titulo
                                      ?.split(' ')
                                      .first ??
                                  '',
                              style: const TextStyle(
                                fontSize: 9,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ))
                        .toList(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: eventosSelecionados.isEmpty
                ? const Center(child: Text('Nenhum evento neste dia.'))
                : ListView.builder(
                    itemCount: eventosSelecionados.length,
                    itemBuilder: (context, index) {
                      final evento = eventosSelecionados[index];
                      return ListTile(
                        title: Text(evento.titulo ?? 'Sem título'),
                        subtitle: Text(
                          DateFormat('dd/MM/yyyy HH:mm')
                              .format(DateTime.parse(evento.data!)),
                        ),
                        leading:
                            const Icon(Icons.event_note, color: Colors.pink),
                        onTap: () {
                          Navigator.of(context)
                              .pop(); // opcional: volta se estiver em bottomsheet
                          // Abrir a tela de detalhes
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => DetalhesEventoPage(evento: evento),
                          ));
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
