import 'package:flutter_test/flutter_test.dart';
import 'package:bingo_app/dominio/carton.dart';
import 'package:bingo_app/dominio/partida.dart';
import 'package:bingo_app/dominio/tipo_juego.dart';

final roja = Carton(id: 1, alias: 'Roja', numeros: [
  [5, 18, 33, 52, 70],
  [2, 20, 40, 47, 66],
  [9, 27, 0, 58, 61],
  [14, 16, 35, 49, 75],
  [1, 30, 44, 60, 63],
]);

final azul = Carton(id: 2, alias: 'Azul', numeros: [
  [3, 22, 31, 50, 68],
  [7, 19, 42, 55, 72],
  [11, 25, 0, 46, 64],
  [6, 29, 38, 57, 67],
  [12, 17, 45, 53, 74],
]);

void main() {
  test('ordena primero la tabla más cercana a ganar', () {
    const config = ConfigPartida(
        id: 1, tipo: TipoJuego.cuatroEsquinas, cartonIds: [1, 2]);
    final r = ordenarPorCercania([azul, roja], {5, 70, 1}, config.figuras);
    expect(r.first.carton.alias, 'Roja');
    expect(r.first.progreso.aUnaBalota, isTrue);
    expect(r.last.progreso.faltan, 4);
  });

  test('describe la columna designada con su letra', () {
    const config = ConfigPartida(
        id: 1, tipo: TipoJuego.columna, cartonIds: [1], columnaDesignada: 3);
    expect(config.descripcion, 'Por columna G');
  });
}