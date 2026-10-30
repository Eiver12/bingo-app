enum TipoJuego {
  linea('Por línea'),
  llena('Tabla llena'),
  columna('Por columna'),
  letraL('Letra L'),
  letraU('Letra U'),
  letraX('Letra X'),
  letraC('Letra C'),
  cuatroEsquinas('4 esquinas');

  const TipoJuego(this.nombre);
  final String nombre;
}
