import 'package:flutter/material.dart';
import 'package:bingo_app/dominio/carton.dart';

class TablaMaestra extends StatelessWidget {
  const TablaMaestra({
    super.key,
    required this.cantadas,
    required this.ultima,
    required this.alTocar,
  });

  final Set<int> cantadas;
  final int? ultima;
  final void Function(int numero) alTocar;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    return Column(children: [
      Row(children: [
        for (final l in letras)
          Expanded(
            child: Center(
              child: Text(l,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ),
      ]),
      const SizedBox(height: 4),
      Expanded(
        child: GridView.count(
          crossAxisCount: 5,
          childAspectRatio: 1.6,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: [
            // Recorre fila por fila: posición k -> número de su columna.
            for (var k = 0; k < 75; k++) _boton((k % 5) * 15 + (k ~/ 5) + 1, esquema),
          ],
        ),
      ),
    ]);
  }

  Widget _boton(int n, ColorScheme esquema) {
    final cantado = cantadas.contains(n);
    final esUltima = n == ultima;
    return Material(
      color: esUltima
          ? esquema.tertiary
          : cantado
          ? esquema.primary
          : esquema.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: cantado ? null : () => alTocar(n),
        child: Center(
          child: Text(
            '$n',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: esUltima
                  ? esquema.onTertiary
                  : cantado
                  ? esquema.onPrimary
                  : esquema.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}