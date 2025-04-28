import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:festora/models/evento_model.dart';
import 'package:festora/services/evento_service.dart';
import 'package:intl/intl.dart';
import 'package:festora/widgets/containers/animated_gradient_border_container.dart'; // Importe o widget da borda animada

class CriarEventoPage extends StatefulWidget {
  final String tipoEvento;

  const CriarEventoPage({super.key, required this.tipoEvento});

  static const String routeName = '/criar-evento';

  @override
  State<CriarEventoPage> createState() => _CriarEventoPageState();
}

class _CriarEventoPageState extends State<CriarEventoPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController dataController = TextEditingController();
  final TextEditingController localController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController ruaController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();

  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar ${widget.tipoEvento}"),
        flexibleSpace: const AnimatedGradientAppBarBackground(), // Use o gradiente no fundo da AppBar
        titleTextStyle: const TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: tituloController,
                    decoration: const InputDecoration(
                      labelText: 'Título',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(190, 237, 245, 1), width: 2.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().length < 10) {
                        return 'O título deve ter no mínimo 10 caracteres.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: descricaoController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Descrição',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(190, 237, 245, 1), width: 2.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().length < 10) {
                        return 'A descrição deve ter no mínimo 10 caracteres.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    initialValue: widget.tipoEvento,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Tipo de Evento',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: dataController,
                    decoration: const InputDecoration(
                      labelText: 'Data',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(190, 237, 245, 1), width: 2.0),
                      ),
                    ),
                    readOnly: true,
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              primaryColor: const Color.fromRGBO(190, 237, 245, 1),
                              hintColor: Colors.blueAccent,
                              colorScheme: const ColorScheme.light(primary: Color.fromRGBO(190, 237, 245, 1)),
                              buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null) {
                        setState(() {
                          selectedDate = picked;
                          dataController.text = DateFormat('dd/MM/yyyy').format(picked);
                        });
                      }
                    },
                    validator: (value) {
                      if (selectedDate == null) {
                        return 'Selecione uma data.';
                      }
                      if (selectedDate!.isBefore(DateTime.now())) {
                        return 'A data deve estar no futuro.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: localController,
                    decoration: const InputDecoration(
                      labelText: 'Local',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(190, 237, 245, 1), width: 2.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: estadoController,
                          decoration: const InputDecoration(
                            labelText: 'Estado',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromRGBO(190, 237, 245, 1), width: 2.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: TextFormField(
                          controller: cidadeController,
                          decoration: const InputDecoration(
                            labelText: 'Cidade',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromRGBO(190, 237, 245, 1), width: 2.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: ruaController,
                          decoration: const InputDecoration(
                            labelText: 'Rua',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromRGBO(190, 237, 245, 1), width: 2.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: numeroController,
                          decoration: const InputDecoration(
                            labelText: 'Número',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromRGBO(190, 237, 245, 1), width: 2.0),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  AnimatedGradientBorderContainer(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final numero = int.tryParse(numeroController.text) ?? 0;

                          final evento = EventoModel(
                            titulo: tituloController.text,
                            descricao: descricaoController.text,
                            tipo: widget.tipoEvento,
                            data: selectedDate?.toIso8601String() ?? '',
                            local: localController.text,
                            estado: estadoController.text,
                            cidade: cidadeController.text,
                            rua: ruaController.text,
                            numero: numero,
                          );

                          final sucesso = await EventoService().criarEvento(evento);

                          if (sucesso) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Evento criado com sucesso!')),
                            );
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Erro ao criar evento')),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Fundo branco
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Salvar", style: TextStyle(fontSize: 16, color: Colors.black87)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedGradientAppBarBackground extends StatefulWidget {
  const AnimatedGradientAppBarBackground({super.key});

  @override
  State<AnimatedGradientAppBarBackground> createState() => _AnimatedGradientAppBarBackgroundState();
}

class _AnimatedGradientAppBarBackgroundState extends State<AnimatedGradientAppBarBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true); // alterna azul ↔ rosa

    _colorAnimation = ColorTween(
      begin: const Color.fromRGBO(190, 237, 245, 1), // azul bebê
      end: const Color.fromRGBO(240, 203, 218, 1),   // rosa claro
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_colorAnimation.value!, _colorAnimation.value!.withOpacity(0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        );
      },
    );
  }
}