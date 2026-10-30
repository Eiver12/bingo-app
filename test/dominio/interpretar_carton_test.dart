import 'package:flutter_test/flutter_test.dart';
import 'package:bingo_app/dominio/interpretar_carton.dart';

const tabla = [
  [9, 16, 42, 60, 73],
  [6, 27, 32, 48, 71],
  [11, 17, 0, 53, 67],
  [12, 25, 36, 55, 64],
  [3, 24, 38, 52, 68],
]; // tu foto 1

/// Simula los caracteres que leería el OCR de una tabla perfecta.
List<Simbolo> simbolosDe(List<List<int>> numeros) {
  const celda = 100.0, altoDigito = 50.0, anchoDigito = 28.0;
  final r = <Simbolo>[];
  for (var f = 0; f < 5; f++) {
    for (var c = 0; c < 5; c++) {
      final n = numeros[f][c];
      if (n == 0) continue;
      final texto = '$n';
      final cx = c * celda + celda / 2;
      final cy = 100 + f * celda + celda / 2; // 100 px de encabezado
      final inicio = cx - texto.length * anchoDigito / 2;
      for (var i = 0; i < texto.length; i++) {
        final izq = inicio + i * anchoDigito;
        r.add(
          Simbolo(
            texto[i],
            izq,
            cy - altoDigito / 2,
            izq + anchoDigito - 2,
            cy + altoDigito / 2,
          ),
        );
      }
    }
  }
  return r;
}

void main() {
  test('lee una tabla limpia sin dudas', () {
    final r = interpretarCarton(simbolosDe(tabla));
    expect(r.numeros, tabla);
    expect(r.dudosas, isEmpty);
    expect(r.leidas, 24);
  });

  test('ignora encabezado, bordes, centro y serial pequeño', () {
    final ruido = [
      for (final (i, l) in ['B', 'I', 'N', 'G', 'C'].indexed)
        Simbolo(l, i * 100.0 + 30, 20, i * 100.0 + 70, 70),
      const Simbolo('|', 90, 160, 94, 210), // borde de casilla
      for (final (i, d) in ['1', '.', '3', '0', '5'].indexed)
        Simbolo(d, 230.0 + i * 9, 340, 238.0 + i * 9, 360), // centro
      for (var i = 0; i < 20; i++)
        Simbolo('7', 20.0 + i * 12, 640, 30.0 + i * 12, 660), // serial
    ];
    final r = interpretarCarton([...simbolosDe(tabla), ...ruido]);
    expect(r.numeros, tabla);
    expect(r.dudosas, isEmpty);
  });

  test('elimina números leídos dos veces', () {
    final base = simbolosDe(tabla);
    final duplicados = [
      for (final s in base)
        Simbolo(s.texto, s.izq + 3, s.arriba + 2, s.der + 3, s.abajo + 2),
    ];
    final r = interpretarCarton([...base, ...duplicados]);
    expect(r.numeros, tabla);
  });

  test('una casilla que no se leyó queda marcada para revisar', () {
    final simbolos = simbolosDe(tabla)
      ..removeWhere(
        (s) => s.cx > 200 && s.cx < 300 && s.cy < 250,
      ); // quita el 42
    final r = interpretarCarton(simbolos);
    expect(r.numeros[0][2], isNull);
    expect(r.dudosas, {2});
    expect(r.leidas, 23);
  });
  test('un 11 leído como 1 queda marcado para revisar', () {
    // Quita el primer "1" del 11 (fila 3, columna B).
    final simbolos = simbolosDe(tabla)
      ..removeWhere((s) => s.texto == '1' && s.izq == 22 && s.cy == 350);
    final r = interpretarCarton(simbolos);
    expect(r.numeros[2][0], 1);
    expect(r.dudosas, contains(10));
  });
  test('una "o" pegada a un dígito se lee como 0 (prueba 2)', () {
    final simbolos = [
      for (final s in simbolosDe(tabla))
        // el 0 del 60 (fila 1, columna G) leído como letra "o"
        if (s.texto == '0' && s.cy == 150)
          Simbolo('o', s.izq, s.arriba, s.der, s.abajo)
        else
          s,
    ];
    final r = interpretarCarton(simbolos);
    expect(r.numeros[0][3], 60);
  });

  test('no une cifras vecinas si el número pasaría de 75 (prueba 4)', () {
    // "9" y "23" muy juntos, como en "9233850".
    const simbolos = [
      Simbolo('9', 0, 0, 28, 50),
      Simbolo('2', 32, 0, 60, 50),
      Simbolo('3', 62, 0, 90, 50),
    ];
    final r = interpretarCarton(simbolos);
    expect(r.numeros[0][0], 9);
    expect(r.numeros[0][1], 23);
  });

  test('avisa cuando la tabla parece de 90 balotas (prueba 1)', () {
    final simbolos = <Simbolo>[];
    for (final (i, par) in [('8', '5'), ('8', '3'), ('9', '0')].indexed) {
      final x = i * 100.0;
      simbolos
        ..add(Simbolo(par.$1, x, 0, x + 28, 50))
        ..add(Simbolo(par.$2, x + 30, 0, x + 58, 50));
    }
    expect(interpretarCarton(simbolos).otroFormato, isTrue);
    expect(interpretarCarton(simbolosDe(tabla)).otroFormato, isFalse);
  });
}
