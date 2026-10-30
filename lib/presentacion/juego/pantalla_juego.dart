import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bingo_app/dominio/carton.dart';
import 'package:bingo_app/dominio/partida.dart';
import 'package:bingo_app/estado/proveedores.dart';
import 'package:bingo_app/presentacion/juego/tabla_maestra.dart';
import 'package:bingo_app/presentacion/juego/tarjeta_progreso.dart';

String _conLetra(int n) => '${letras[(n - 1) ~/ 15]} $n';

class PantallaJuego extends ConsumerWidget {
  const PantallaJuego({super.key, required this.config});

  final ConfigPartida config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balotas =
        ref.watch(balotasProvider(config.id)).value ?? const <int>[];
    final todas = ref.watch(cartonesProvider).value ?? const <Carton>[];
    final cartones = [
      for (final c in todas)
        if (config.cartonIds.contains(c.id)) c,
    ];
    final cantadas = balotas.toSet();
    final estados = ordenarPorCercania(cartones, cantadas, config.figuras);
    final ultima = balotas.isEmpty ? null : balotas.last;

    return Scaffold(
      appBar: AppBar(
        title: Text(config.descripcion),
        actions: [
          IconButton(
            icon: const Icon(Icons.undo),
            tooltip: 'Deshacer última balota',
            onPressed: balotas.isEmpty
                ? null
                : () => ref
                      .read(repositorioPartidasProvider)
                      .deshacerUltima(config.id),
          ),
          TextButton.icon(
            icon: const Icon(Icons.flag),
            label: const Text('Finalizar'),
            onPressed: () => _finalizar(context, ref),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, caja) {
            // Alto del panel cerrado: muestra solo el resumen.
            final pico = (caja.maxHeight * 0.13).clamp(90.0, 140.0);
            final minimo = pico / caja.maxHeight;

            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(12, 8, 12, pico + 8),
                  child: Column(
                    children: [
                      Text(
                        ultima == null
                            ? 'Toca cada número que cante el juez'
                            : 'Balotas: ${balotas.length}  ·  Última: ${_conLetra(ultima)}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: TablaMaestra(
                          cantadas: cantadas,
                          ultima: ultima,
                          alTocar: (n) =>
                              _cantar(context, ref, n, cartones, cantadas),
                        ),
                      ),
                    ],
                  ),
                ),
                DraggableScrollableSheet(
                  initialChildSize: minimo,
                  minChildSize: minimo,
                  maxChildSize: 0.85,
                  snap: true,
                  builder: (context, controlador) => _PanelTablas(
                    controlador: controlador,
                    estados: estados,
                    cantadas: cantadas,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _cantar(
    BuildContext context,
    WidgetRef ref,
    int numero,
    List<Carton> cartones,
    Set<int> cantadas,
  ) async {
    final figuras = config.figuras;
    final ganadoras = recienGanadoras(cartones, cantadas, numero, figuras);
    final aUna = recienAUnaBalota(cartones, cantadas, numero, figuras);

    await ref.read(repositorioPartidasProvider).cantar(config.id, numero);

    if (ganadoras.isNotEmpty) {
      await HapticFeedback.heavyImpact();
      if (!context.mounted) return;
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('¡BINGO!'),
          content: Text(
            'Ganó: ${ganadoras.map((e) => e.carton.alias).join(', ')}',
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Seguir'),
            ),
          ],
        ),
      );
    } else if (aUna.isNotEmpty) {
      await HapticFeedback.mediumImpact();
      if (!context.mounted) return;
      final detalle = aUna
          .map(
            (e) =>
                '${e.carton.alias} necesita el ${_conLetra(e.progreso.numerosFaltantes.first)}',
          )
          .join(' · ');
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('¡A una balota! $detalle'),
            duration: const Duration(seconds: 4),
          ),
        );
    }
  }

  Future<void> _finalizar(BuildContext context, WidgetRef ref) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¿Finalizar partida?'),
        content: const Text('Volverás a Mis tablas.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Finalizar'),
          ),
        ],
      ),
    );
    if (confirmado != true) return;
    await ref.read(repositorioPartidasProvider).finalizar(config.id);
    if (context.mounted) Navigator.pop(context);
  }
}

/// Panel inferior: resumen siempre visible y, al deslizarlo, todas las tablas.
class _PanelTablas extends StatelessWidget {
  const _PanelTablas({
    required this.controlador,
    required this.estados,
    required this.cantadas,
  });

  final ScrollController controlador;
  final List<EstadoTabla> estados;
  final Set<int> cantadas;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    return Material(
      elevation: 8,
      color: esquema.surfaceContainerLow,
      clipBehavior: Clip.antiAlias,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: ListView(
        controller: controlador,
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: esquema.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _Resumen(estados),
          const SizedBox(height: 8),
          for (final e in estados)
            TarjetaProgreso(
              key: ValueKey(e.carton.id),
              estado: e,
              cantadas: cantadas,
            ),
        ],
      ),
    );
  }
}

/// Una línea con la tabla más cercana a ganar.
class _Resumen extends StatelessWidget {
  const _Resumen(this.estados);
  final List<EstadoTabla> estados;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    if (estados.isEmpty) return const Text('No hay tablas en esta partida');

    final mejor = estados.first;
    final p = mejor.progreso;
    final estado = p.gano
        ? '¡BINGO!'
        : p.aUnaBalota
        ? 'necesita el ${_conLetra(p.numerosFaltantes.first)}'
        : 'faltan ${p.faltan}';
    final color = p.gano
        ? tema.colorScheme.tertiary
        : p.aUnaBalota
        ? tema.colorScheme.error
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Más cerca: ${mejor.carton.alias}',
                style: tema.textTheme.titleSmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              estado,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: p.porcentaje,
          minHeight: 6,
          borderRadius: BorderRadius.circular(3),
        ),
        const SizedBox(height: 4),
        Text(
          '${estados.length} ${estados.length == 1 ? 'tabla' : 'tablas'}'
          ' · desliza hacia arriba para verlas',
          style: tema.textTheme.bodySmall,
        ),
      ],
    );
  }
}
