import '../dominio/categoria.dart';
import '../dominio/planificador.dart';
import '../dominio/puerto.dart';

/// Adaptador SOLO para demostración en Chrome/escritorio, donde el plugin de
/// notificaciones locales no funciona. No muestra notificaciones del sistema:
/// simula el permiso y guarda la agenda para que la pantalla la muestre.
class PuertoDemo implements PuertoNotificaciones {
  bool _activas = false;
  final Map<int, PlanNotificacion> _agenda = {};

  @override
  Future<void> inicializar() async {}
  @override
  Future<bool> notificacionesActivas() async => _activas;
  @override
  Future<bool> pedirPermiso() async => _activas = true;
  @override
  Future<void> programar(PlanNotificacion plan) async => _agenda[plan.id] = plan;
  @override
  Future<void> mostrarAhora({
    required int id,
    required String titulo,
    required String cuerpo,
    required Categoria categoria,
    required String payload,
  }) async {}
  @override
  Future<void> cancelar(int id) async => _agenda.remove(id);
  @override
  Future<String?> payloadDeLanzamiento() async => null;
  @override
  void escucharToques(void Function(String? payload) alTocar) {}
  @override
  Future<void> abrirAjustes() async {}
}
