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
          children: [
            for (var i = 0; i < 25; i++)
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: resaltadas.contains(i)
                      ? esquema.tertiaryContainer
                      : marcadas.contains(i)
                      ? esquema.primaryContainer
                      : null,
                  border: Border.all(color: esquema.outlineVariant),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  carton.numeroEn(i) == 0 ? '★' : '${carton.numeroEn(i)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ],
    );
  }
}