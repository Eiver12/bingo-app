import 'tipo_juego.dart';

Set<int> fila(int f) => {for (var c = 0; c < 5; c++) f * 5 + c};
Set<int> columna(int c) => {for (var f = 0; f < 5; f++) f * 5 + c};
const diagonal1 = {0, 6, 12, 18, 24};
const diagonal2 = {4, 8, 12, 16, 20};

/// Figuras válidas para ganar: basta completar UNA.
List<Set<int>> figurasGanadoras(TipoJuego tipo, {int? columnaDesignada}) =>
    switch (tipo) {
      TipoJuego.linea => [
        for (var i = 0; i < 5; i++) fila(i),
        for (var i = 0; i < 5; i++) columna(i),
        diagonal1,
        diagonal2,
      ],
      TipoJuego.llena => [
        {for (var i = 0; i < 25; i++) i},
      ],
      TipoJuego.columna => [
        columna(
          columnaDesignada ??
              (throw ArgumentError('Falta la columna designada')),
        ),
      ],
      TipoJuego.letraL => [columna(0).union(fila(4))],
      TipoJuego.letraU => [columna(0).union(columna(4)).union(fila(4))],
      TipoJuego.letraX => [diagonal1.union(diagonal2)],
      TipoJuego.letraC => [columna(0).union(fila(0)).union(fila(4))],
      TipoJuego.cuatroEsquinas => [
        {0, 4, 20, 24},
      ],
    };
