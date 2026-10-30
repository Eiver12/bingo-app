import 'carton.dart';
import 'figuras.dart';
import 'progreso.dart';
import 'tipo_juego.dart';

/// Datos de una partida en curso.
class ConfigPartida {
  const ConfigPartida({
    required this.id,
    required this.tipo,
    required this.cartonIds,
    this.columnaDesignada,
  });

  final int id;
  final TipoJuego tipo;
  final List<int> cartonIds;
  final int? columnaDesignada;

  List<Set<int>> get figuras =>
      figurasGanadoras(tipo, columnaDesignada: columnaDesignada);

  String get descripcion => tipo == TipoJuego.columna
      ? '${tipo.nombre} ${letras[columnaDesignada!]}'
      : tipo.nombre;
}

/// Una tabla con su progreso en la partida.
class EstadoTabla {
  const EstadoTabla(this.carton, this.progreso);
  final Carton carton;
  final Progreso progreso;
}

/// Tablas ordenadas de la más cercana a ganar a la más lejana.
List<EstadoTabla> ordenarPorCercania(
  List<Carton> cartones,
  Set<int> cantadas,
  List<Set<int>> figuras,
) {
  final estados = [
    for (final c in cartones)
      EstadoTabla(c, calcularProgreso(c, cantadas, figuras)),
  ];
  estados.sort((a, b) => a.progreso.faltan.compareTo(b.progreso.faltan));
  return estados;
}
