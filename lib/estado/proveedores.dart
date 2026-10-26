import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bingo_app/datos/base_datos.dart';
import 'package:bingo_app/datos/repositorio_cartones.dart';
import 'package:bingo_app/datos/repositorio_partidas.dart';
import 'package:bingo_app/dominio/carton.dart';

/// Una sola base de datos para toda la app.
final baseDatosProvider = Provider<BaseDatos>((ref) {
  final db = BaseDatos();
  ref.onDispose(db.close);
  return db;
});

final repositorioCartonesProvider =
Provider((ref) => RepositorioCartones(ref.watch(baseDatosProvider)));

final repositorioPartidasProvider =
Provider((ref) => RepositorioPartidas(ref.watch(baseDatosProvider)));

/// Lista de tablas que se actualiza sola al guardar o eliminar.
final cartonesProvider = StreamProvider<List<Carton>>(
        (ref) => ref.watch(repositorioCartonesProvider).observarTodos());