import 'package:flutter/material.dart';
import 'package:bingo_app/dominio/partida.dart';
import 'package:bingo_app/dominio/progreso.dart';
import 'package:bingo_app/presentacion/comun/cuadricula_carton.dart';

class TarjetaProgreso extends StatelessWidget {
  const TarjetaProgreso({
    super.key,
    required this.estado,
    required this.cantadas,
  });

  final EstadoTabla estado;
  final Set<int> cantadas;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final p = estado.progreso;

    final mensaje = p.gano
        ? '¡BINGO!'
        : p.aUnaBalota
        ? '¡A una balota! Necesita el ${p.numerosFaltantes.first}'
        : 'Faltan ${p.faltan}';
    final colorMensaje = p.gano
        ? esquema.tertiary
        : p.aUnaBalota
        ? esquema.error
        : null;

    return Card(
      color: p.gano ? esquema.tertiaryContainer : null,
      child: ExpansionTile(
        initiallyExpanded: p.gano,
        title: Text(
          estado.carton.alias,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: p.porcentaje,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 4),
            Text(
              mensaje,
              style: TextStyle(
                color: colorMensaje,
                fontWeight: colorMensaje == null ? null : FontWeight.bold,
              ),
            ),
          ],
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          CuadriculaCarton(
            carton: estado.carton,
            marcadas: casillasMarcadas(estado.carton, cantadas),
            resaltadas: p.gano ? p.figura : const {},
          ),
        ],
      ),
    );
  }
}
