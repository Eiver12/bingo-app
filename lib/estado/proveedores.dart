import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bingo_app/datos/base_datos.dart';
import 'package:bingo_app/datos/repositorio_cartones.dart';
import 'package:bingo_app/datos/repositorio_partidas.dart';
import 'package:bingo_app/dominio/carton.dart';
import 'package:bingo_app/datos/lector_ocr.dart';
import 'package:bingo_app/datos/servicio_foto.dart';
import 'package:bingo_app/dominio/partida.dart';

/// Una sola base de datos para toda la app.
final baseDatosProvider = Provider<BaseDatos>((ref) {
  final db = BaseDatos();
  ref.onDispose(db.close);
  return db;
});

final repositorioCartonesProvider = Provider(
  (ref) => RepositorioCartones(ref.watch(baseDatosProvider)),
);

final repositorioPartidasProvider = Provider(
  (ref) => RepositorioPartidas(ref.watch(baseDatosProvider)),
);

/// Lista de tablas que se actualiza sola al guardar o eliminar.
final cartonesProvider = StreamProvider<List<Carton>>(
  (ref) => ref.watch(repositorioCartonesProvider).observarTodos(),
);

/// Balotas cantadas de una partida, en orden. Se actualiza sola.
final balotasProvider = StreamProvider.family<List<int>, int>(
  (ref, partidaId) =>
      ref.watch(repositorioPartidasProvider).observarBalotas(partidaId),
);

final servicioFotoProvider = Provider((ref) => ServicioFoto());

final lectorOcrProvider = Provider((ref) {
  final lector = LectorOcr();
  ref.onDispose(lector.cerrar);
  return lector;
});

/// Partida sin terminar (null si no hay). Se actualiza sola.
final partidaEnCursoProvider = StreamProvider<ConfigPartida?>(
  (ref) => ref.watch(repositorioPartidasProvider).observarEnCurso(),
);
