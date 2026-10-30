import 'carton.dart';

class Progreso {
  final double porcentaje; // 0.0 a 1.0
  final int faltan; // casillas que faltan
  final List<int> numerosFaltantes; // balotas que necesita
  final Set<int> figura; // figura más cercana (para resaltarla)

  const Progreso({
    required this.porcentaje,
    required this.faltan,
    required this.numerosFaltantes,
    required this.figura,
  });

  bool get gano => faltan == 0;
  bool get aUnaBalota => faltan == 1;
}

/// Casillas marcadas = números cantados + centro libre.
Set<int> casillasMarcadas(Carton carton, Set<int> cantadas) => {
  for (var i = 0; i < 25; i++)
    if (carton.numeroEn(i) == 0 || cantadas.contains(carton.numeroEn(i))) i,
};

/// Devuelve el progreso de la figura más cercana a completarse.
Progreso calcularProgreso(
  Carton carton,
  Set<int> cantadas,
  List<Set<int>> figuras,
) {
  final marcadas = casillasMarcadas(carton, cantadas);
  Progreso? mejor;
  for (final figura in figuras) {
    final pendientes = figura.difference(marcadas);
    if (mejor == null || pendientes.length < mejor.faltan) {
      mejor = Progreso(
        porcentaje: 1 - pendientes.length / figura.length,
        faltan: pendientes.length,
        numerosFaltantes: [for (final i in pendientes) carton.numeroEn(i)]
          ..sort(),
        figura: figura,
      );
    }
  }
  return mejor!;
}
