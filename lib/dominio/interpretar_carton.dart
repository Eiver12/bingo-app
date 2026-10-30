import 'dart:math';

/// Un carácter leído por el OCR, con su recuadro en píxeles de la foto.
class Simbolo {
  const Simbolo(this.texto, this.izq, this.arriba, this.der, this.abajo);

  final String texto;
  final double izq, arriba, der, abajo;

  double get cx => (izq + der) / 2;
  double get cy => (arriba + abajo) / 2;
  double get alto => abajo - arriba;
}

/// Resultado de interpretar una foto.
class ResultadoLectura {
  const ResultadoLectura(
    this.numeros,
    this.dudosas, {
    this.otroFormato = false,
  });

  final List<List<int?>> numeros; // [fila][columna]; 0 = libre; null = sin leer
  final Set<int> dudosas; // casillas 0..24 que el usuario debe revisar
  final bool otroFormato; // parece una tabla de otro tipo (ej.: 90 balotas)

  int get leidas =>
      [for (final f in numeros) ...f].where((n) => n != null && n != 0).length;
}

class _Grupo {
  _Grupo(Simbolo s) : simbolos = [s];
  final List<Simbolo> simbolos;

  double get der => simbolos.last.der;
  double get cx => (simbolos.first.izq + simbolos.last.der) / 2;
  double get cy =>
      simbolos.map((s) => s.cy).reduce((a, b) => a + b) / simbolos.length;
  String get texto => simbolos.map((s) => s.texto).join();
}

double _mediana(List<double> valores) {
  final ordenados = [...valores]..sort();
  return ordenados[ordenados.length ~/ 2];
}

int _columnaDe(int valor) => (valor - 1) ~/ 15;

Set<int> _todasMenosCentro() => {
  for (var i = 0; i < 25; i++)
    if (i != 12) i,
};

ResultadoLectura interpretarCarton(List<Simbolo> simbolos) {
  final numeros = List.generate(5, (_) => List<int?>.filled(5, null));
  numeros[2][2] = 0;

  // 1. Dígitos sueltos (descarta letras, bordes "|", puntos...).
  final esDigito = RegExp(r'^\d$');
  final soloDigitos = simbolos
      .where((s) => esDigito.hasMatch(s.texto))
      .toList();
  if (soloDigitos.isEmpty) {
    return ResultadoLectura(numeros, _todasMenosCentro());
  }
  final h = _mediana([for (final s in soloDigitos) s.alto]);

  // Una "o" pegada a un dígito es un cero mal leído ("537o" -> "5370").
  bool pegadaADigito(Simbolo s) => soloDigitos.any(
    (d) =>
        (d.cy - s.cy).abs() < h * 0.5 &&
        ((s.izq - d.der).abs() < h * 0.4 || (d.izq - s.der).abs() < h * 0.4),
  );
  final ceros = [
    for (final s in simbolos)
      if ((s.texto == 'o' || s.texto == 'O') && pegadaADigito(s))
        Simbolo('0', s.izq, s.arriba, s.der, s.abajo),
  ];

  // 2. Solo dígitos del tamaño normal (descarta serial, precio, ID).
  final digitos = [
    ...soloDigitos,
    ...ceros,
  ].where((s) => s.alto > h * 0.6 && s.alto < h * 1.6).toList();

  // 3. Quitar duplicados: mismo dígito en casi la misma posición.
  final unicos = <Simbolo>[];
  for (final s in digitos) {
    final repetido = unicos.any(
      (u) =>
          u.texto == s.texto &&
          (u.cx - s.cx).abs() < h * 0.3 &&
          (u.cy - s.cy).abs() < h * 0.3,
    );
    if (!repetido) unicos.add(s);
  }

  // 4. Unir dígitos muy cercanos en números de máximo 2 cifras.
  //    Nunca se une si el número empezaría por 0 o pasaría de 75.
  unicos.sort((a, b) => a.izq.compareTo(b.izq));
  final grupos = <_Grupo>[];
  var paresMayores = 0; // cifras pegadas que formarían números de 76 a 99
  for (final s in unicos) {
    _Grupo? destino;
    for (final g in grupos) {
      final mismaLinea = (g.cy - s.cy).abs() < h * 0.5;
      final separacion = s.izq - g.der;
      final cerca = separacion > -h * 0.3 && separacion < h * 0.4;
      if (!mismaLinea || !cerca || g.simbolos.length >= 2) continue;
      if (g.texto == '0') continue; // ningún número empieza por 0
      if (int.parse(g.texto + s.texto) > 75) {
        paresMayores++;
        continue;
      }
      destino = g;
      break;
    }
    if (destino == null) {
      grupos.add(_Grupo(s));
    } else {
      destino.simbolos.add(s);
    }
  }
  final otroFormato = paresMayores >= 3;

  // 5. Valores válidos (1 a 75).
  final leidos = <({int valor, double cx, double cy})>[];
  for (final g in grupos) {
    final v = int.parse(g.texto);
    if (v >= 1 && v <= 75) leidos.add((valor: v, cx: g.cx, cy: g.cy));
  }

  // 6. La columna sale del valor. Se descartan los números cuya posición
  //    horizontal está más cerca de otra columna (lecturas equivocadas).
  final centrosX = <int, double>{
    for (var c = 0; c < 5; c++)
      if (leidos.any((n) => _columnaDe(n.valor) == c))
        c: _mediana([
          for (final n in leidos)
            if (_columnaDe(n.valor) == c) n.cx,
        ]),
  };
  final validos = leidos.where((n) {
    final propia = centrosX[_columnaDe(n.valor)]!;
    return centrosX.values.every(
      (otra) => (n.cx - propia).abs() <= (n.cx - otra).abs(),
    );
  }).toList();
  if (validos.isEmpty) {
    return ResultadoLectura(
      numeros,
      _todasMenosCentro(),
      otroFormato: otroFormato,
    );
  }

  // 7. La fila sale de la altura, repartida entre la primera y la última fila.
  final yMin = validos.map((n) => n.cy).reduce(min);
  final yMax = validos.map((n) => n.cy).reduce(max);
  final altoFila = (yMax - yMin) / 4;
  final dudosas = <int>{};
  for (final n in validos) {
    final f = altoFila <= 0
        ? 0
        : ((n.cy - yMin) / altoFila).round().clamp(0, 4);
    final c = _columnaDe(n.valor);
    if (f == 2 && c == 2) continue; // casilla libre
    final actual = numeros[f][c];
    if (actual == null) {
      numeros[f][c] = n.valor;
      // Un número de una cifra corrido del centro probablemente perdió una
      // cifra (ej.: "11" leído como "1").
      if (n.valor < 10 && (n.cx - centrosX[c]!).abs() > h * 0.2) {
        dudosas.add(f * 5 + c);
      }
    } else if (actual != n.valor) {
      dudosas.add(f * 5 + c); // dos lecturas distintas en la misma casilla
    }
  }

  // 8. Casillas vacías o números repetidos quedan para revisar.
  final vistos = <int, int>{};
  for (var i = 0; i < 25; i++) {
    if (i == 12) continue;
    final v = numeros[i ~/ 5][i % 5];
    if (v == null) {
      dudosas.add(i);
    } else if (vistos.containsKey(v)) {
      dudosas
        ..add(i)
        ..add(vistos[v]!);
    } else {
      vistos[v] = i;
    }
  }
  return ResultadoLectura(numeros, dudosas, otroFormato: otroFormato);
}
