import 'package:go_router/go_router.dart';

class Redirecionar{
    void eventoDetails(context, String eventoId) {
    final uri = Uri.parse('/detalhes-evento?eventoId=$eventoId');
    GoRouter.of(context).go(uri.toString());
  }
}