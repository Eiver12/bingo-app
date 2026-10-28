import 'package:flutter/material.dart';
import 'package:bingo_app/dominio/carton.dart';

class CuadriculaCarton extends StatelessWidget {
  const CuadriculaCarton({
    super.key,
    required this.carton,
    this.marcadas = const {},
    this.resaltadas = const {},
  });

  final Carton carton;
  final Set<int> marcadas;   // casillas 0..24 ya cantadas
  final Set<int> resaltadas; // casillas de la figura ganadora

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(children: [
          for (final l in letras)
            Expanded(
              child: Center(
                child: Text(l, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
        ]),
        const SizedBox(height: 4),
        GridView.count(
          crossAxisCount: 5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
          children: [for (var i = 0; i < 25; i++) _casilla(i, esquema)],
        ),
      ],
    );
  }

  Widget _casilla(int i, ColorScheme esquema) {
    final ganadora = resaltadas.contains(i);
    final marcada = marcadas.contains(i);

    final fondo = ganadora
        ? esquema.tertiary          // color fuerte: figura ganadora
        : marcada
        ? esquema.primaryContainer
        : esquema.surface;      // fondo neutro, distinto al de la tarjeta
    final texto = ganadora
        ? esquema.onTertiary
        : marcada
        ? esquema.onPrimaryContainer
        : esquema.onSurface;

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: fondo,
        border: Border.all(color: esquema.outlineVariant),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        carton.numeroEn(i) == 0 ? '★' : '${carton.numeroEn(i)}',
        style: TextStyle(
          fontSize: 16,
          color: texto,
          fontWeight: ganadora ? FontWeight.bold : null,
        ),
      ),
    );
  }
}