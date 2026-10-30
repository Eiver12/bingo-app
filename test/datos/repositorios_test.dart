import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bingo_app/datos/base_datos.dart';
import 'package:bingo_app/datos/repositorio_cartones.dart';
import 'package:bingo_app/datos/repositorio_partidas.dart';
import 'package:bingo_app/dominio/carton.dart';
import 'package:bingo_app/dominio/figuras.dart';
import 'package:bingo_app/dominio/progreso.dart';
import 'package:bingo_app/dominio/tipo_juego.dart';

final cartonDePrueba = Carton(
  alias: 'Prueba',
  numeros: [
    [5, 18, 33, 52, 70],
    [2, 20, 40, 47, 66],
    [9, 27, 0, 58, 61],
    [14, 16, 35, 49, 75],
    [1, 30, 44, 60, 63],
  ],
);

void main() {
  late BaseDatos db;
  late RepositorioCartones cartones;
  late RepositorioPartidas partidas;

  setUp(() {
    db = BaseDatos(NativeDatabase.memory());
    cartones = RepositorioCartones(db);
    partidas = RepositorioPartidas(db);
  });
  tearDown(() => db.close());

  test('guarda y recupera una tabla sin cambiar sus números', () async {
    final id = await cartones.guardar(cartonDePrueba);
    final todas = await cartones.observarTodos().first;
    expect(todas.single.id, id);
    expect(todas.single.numeros, cartonDePrueba.numeros);
  });

  test('cantar, ignorar repetidas y deshacer', () async {
    final cId = await cartones.guardar(cartonDePrueba);
    final pId = await partidas.crear(TipoJuego.cuatroEsquinas, [cId]);
    await partidas.cantar(pId, 5);
    await partidas.cantar(pId, 70);
    await partidas.cantar(pId, 5); // repetida
    expect(await partidas.observarBalotas(pId).first, [5, 70]);

    await partidas.deshacerUltima(pId);
    expect(await partidas.observarBalotas(pId).first, [5]);
  });

  test('borrar una tabla la quita de las partidas', () async {
    final cId = await cartones.guardar(cartonDePrueba);
    final pId = await partidas.crear(TipoJuego.linea, [cId]);
    await cartones.eliminar(cId);
    expect(await partidas.cartonesDe(pId), isEmpty);
  });

  test('integración: base de datos + lógica detectan al ganador', () async {
    final cId = await cartones.guardar(cartonDePrueba);
    final pId = await partidas.crear(TipoJuego.cuatroEsquinas, [cId]);
    for (final n in [5, 70, 1, 63]) {
      await partidas.cantar(pId, n);
    }
    final carton = (await cartones.observarTodos().first).single;
    final cantadas = (await partidas.observarBalotas(pId).first).toSet();
    final p = calcularProgreso(
      carton,
      cantadas,
      figurasGanadoras(TipoJuego.cuatroEsquinas),
    );
    expect(p.gano, isTrue);
  });

  test(
    'retoma la partida en curso y crear otra finaliza la anterior',
    () async {
      final cId = await cartones.guardar(cartonDePrueba);
      expect(await partidas.observarEnCurso().first, isNull);

      final p1 = await partidas.crear(TipoJuego.linea, [cId]);
      final enCurso = await partidas.observarEnCurso().first;
      expect(enCurso!.id, p1);
      expect(enCurso.cartonIds, [cId]);

      final p2 = await partidas.crear(TipoJuego.letraX, [cId]);
      expect((await partidas.observarEnCurso().first)!.id, p2);

      await partidas.finalizar(p2);
      expect(await partidas.observarEnCurso().first, isNull);
    },
  );
}
