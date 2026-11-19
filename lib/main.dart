import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'dominio/gestor_permiso.dart';
import 'dominio/puerto.dart';
import 'dominio/reloj.dart';
import 'dominio/servicio.dart';
import 'infra/almacen_prefs.dart';
import 'infra/puerto_demo.dart';
import 'infra/puerto_real.dart';
import 'presentacion/ajolote_vm.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // En Chrome el plugin de notificaciones locales no funciona: usamos un
  // adaptador de demostración. En Android/iOS se usa el real.
  final PuertoNotificaciones puerto = kIsWeb ? PuertoDemo() : PuertoReal();
  await puerto.inicializar();

  final almacen = AlmacenPrefs(await SharedPreferences.getInstance());
  const reloj = RelojSistema();
  final servicio = ServicioAjolote(puerto: puerto, almacen: almacen, reloj: reloj);
  final gestor = GestorPermiso(puerto: puerto, almacen: almacen);
  final vm = AjoloteViewModel(servicio: servicio, gestor: gestor, reloj: reloj);

  puerto.escucharToques(vm.alTocarNotificacion);
  final destino = await servicio.destinoDeLanzamiento();

  runApp(AppAjolote(vm: vm, destinoInicial: destino));
}
