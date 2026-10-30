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

  static const _espacio = 4.0;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    return Column(
      children: [
        Row(
          children: [
            for (final l in letras)
              Expanded(
                child: Center(
                  child: Text(
                    l,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Expanded(
          child: LayoutBuilder(
            builder: (context, caja) {
              // Tamaño de cada botón para que 5 columnas x 15 filas quepan exactas.
              final ancho = (caja.maxWidth - _espacio * 4) / 5;
              final alto = (caja.maxHeight - _espacio * 14) / 15;
              if (ancho <= 0 || alto <= 0) return const SizedBox.shrink();
              final letra = (alto * 0.5).clamp(12.0, 20.0);

              return GridView.count(
                crossAxisCount: 5,
                childAspectRatio: ancho / alto,
                mainAxisSpacing: _espacio,
                crossAxisSpacing: _espacio,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // Recorre fila por fila: posición k -> número de su columna.
                  for (var k = 0; k < 75; k++)
                    _boton((k % 5) * 15 + (k ~/ 5) + 1, esquema, letra),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _boton(int n, ColorScheme esquema, double letra) {
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
              fontSize: letra,
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
