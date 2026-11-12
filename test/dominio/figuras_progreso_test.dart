import 'package:flutter_test/flutter_test.dart';
import 'package:bingo_app/dominio/carton.dart';
import 'package:bingo_app/dominio/figuras.dart';
import 'package:bingo_app/dominio/progreso.dart';
import 'package:bingo_app/dominio/tipo_juego.dart';

const numeros = [
  [5, 18, 33, 52, 70],
  [2, 20, 40, 47, 66],
  [9, 27, 0, 58, 61],
  [14, 16, 35, 49, 75],
  [1, 30, 44, 60, 63],
];
final carton = Carton(alias: 'Prueba', numeros: numeros);

List<List<int>> copiaCon(int f, int c, int valor) => [
  for (var i = 0; i < 5; i++)
    [
      for (var j = 0; j < 5; j++) (i == f && j == c) ? valor : numeros[i][j],
    ],
];

void main() {
  group('figuras', () {
    test('por línea: 5 filas, 5 columnas y 2 diagonales', () {
      final figuras = figurasGanadoras(TipoJuego.linea);
      expect(figuras, hasLength(12));
      expect(figuras.every((f) => f.length == 5), isTrue);
      expect(figuras, containsAll([diagonal1, diagonal2]));
    });

    test('tamaño de cada figura', () {
      int casillas(TipoJuego t) => figurasGanadoras(t).single.length;
      expect(casillas(TipoJuego.llena), 25);
      expect(casillas(TipoJuego.letraL), 9);
      expect(casillas(TipoJuego.letraU), 13);
      expect(casillas(TipoJuego.letraX), 9);
      expect(casillas(TipoJuego.letraC), 13);
      expect(figurasGanadoras(TipoJuego.cuatroEsquinas).single, {
        0,
        4,
        20,
        24,
      });
    });

    test('por columna usa la columna designada', () {
      expect(
        figurasGanadoras(TipoJuego.columna, columnaDesignada: 2).single,
        {2, 7, 12, 17, 22},
      );
      expect(
        () => figurasGanadoras(TipoJuego.columna),
        throwsArgumentError,
      );
    });
  });

  group('progreso', () {
    test('la casilla libre cuenta: la diagonal queda a una balota', () {
      final p = calcularProgreso(
        carton,
        {5, 20, 49},
        figurasGanadoras(TipoJuego.linea),
      );
      expect(p.figura, diagonal1);
      expect(p.aUnaBalota, isTrue);
      expect(p.numerosFaltantes, [63]);
      expect(p.porcentaje, closeTo(0.8, 0.001));
    });

    test('gana al completar la figura', () {
      final p = calcularProgreso(
        carton,
        {5, 70, 1, 63},
        figurasGanadoras(TipoJuego.cuatroEsquinas),
      );
      expect(p.gano, isTrue);
      expect(p.numerosFaltantes, isEmpty);
    });
  });

  group('validar tabla', () {
    test('una tabla correcta no tiene errores', () {
      expect(Carton.validar(numeros), isEmpty);
    });

    test('detecta número fuera de su columna y repetido', () {
      final errores = Carton.validar(copiaCon(0, 0, 20));
      expect(errores, contains('Fila 1, columna B: 20 no está entre 1 y 15'));
      expect(errores, contains('El número 20 está repetido'));
    });

    test('el centro debe ser la casilla libre', () {
      expect(
        Carton.validar(copiaCon(2, 2, 40)),
        contains('El centro debe ser la casilla libre (0)'),
      );
    });

    test('no deja crear una tabla inválida', () {
      expect(
        () => Carton(alias: 'Mala', numeros: copiaCon(0, 0, 99)),
        throwsArgumentError,
      );
    });
  });
}
