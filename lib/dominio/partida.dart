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

/// Tablas que ganan justo con este número (no habían ganado antes).
List<EstadoTabla> recienGanadoras(
  List<Carton> cartones,
  Set<int> cantadas,
  int numero,
  List<Set<int>> figuras,
) {
  final antes = {
    for (final e in ordenarPorCercania(cartones, cantadas, figuras))
      if (e.progreso.gano) e.carton.id,
  };
  return [
    for (final e in ordenarPorCercania(cartones, {
      ...cantadas,
      numero,
    }, figuras))
      if (e.progreso.gano && !antes.contains(e.carton.id)) e,
  ];
}

/// Tablas que quedan a una balota justo con este número.
List<EstadoTabla> recienAUnaBalota(
  List<Carton> cartones,
  Set<int> cantadas,
  int numero,
  List<Set<int>> figuras,
) {
  final antes = {
    for (final e in ordenarPorCercania(cartones, cantadas, figuras))
      if (e.progreso.aUnaBalota) e.carton.id,
  };
  return [
    for (final e in ordenarPorCercania(cartones, {
      ...cantadas,
      numero,
    }, figuras))
      if (e.progreso.aUnaBalota && !antes.contains(e.carton.id)) e,
  ];
}
