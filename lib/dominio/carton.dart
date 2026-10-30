/// Rangos válidos por columna en bingo de 75 balotas.
const rangosColumna = [(1, 15), (16, 30), (31, 45), (46, 60), (61, 75)];
const letras = ['B', 'I', 'N', 'G', 'O'];

class Carton {
  final int? id;
  final String alias;
  final List<List<int>> numeros; // [fila][columna]; 0 = casilla libre

  Carton({this.id, required this.alias, required this.numeros}) {
    final errores = validar(numeros);
    if (errores.isNotEmpty) throw ArgumentError(errores.join('\n'));
  }

  /// Número en la casilla 0..24 (fila * 5 + columna).
  int numeroEn(int casilla) => numeros[casilla ~/ 5][casilla % 5];

  static List<String> validar(List<List<int>> numeros) {
    if (numeros.length != 5 || numeros.any((f) => f.length != 5)) {
      return ['La tabla debe tener 5 filas y 5 columnas'];
    }
    final errores = <String>[];
    final vistos = <int>{};
    for (var f = 0; f < 5; f++) {
      for (var c = 0; c < 5; c++) {
        final n = numeros[f][c];
        if (f == 2 && c == 2) {
          if (n != 0) errores.add('El centro debe ser la casilla libre (0)');
          continue;
        }
        final (min, max) = rangosColumna[c];
        if (n < min || n > max) {
          errores.add(
            'Fila ${f + 1}, columna ${letras[c]}: $n no está entre $min y $max',
          );
        }
        if (!vistos.add(n)) errores.add('El número $n está repetido');
      }
    }
    return errores;
  }
}
