import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bingo_app/dominio/carton.dart';
import 'package:bingo_app/dominio/partida.dart';
import 'package:bingo_app/estado/proveedores.dart';
import 'package:bingo_app/presentacion/juego/tabla_maestra.dart';
import 'package:bingo_app/presentacion/juego/tarjeta_progreso.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(12),
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
                flex: 3,
                child: TablaMaestra(
                  cantadas: cantadas,
                  ultima: ultima,
                  alTocar: (n) => _cantar(context, ref, n, cartones, cantadas),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                flex: 2,
                child: ListView(
                  children: [
                    for (final e in estados)
                      TarjetaProgreso(
                        key: ValueKey(e.carton.id),
                        estado: e,
                        cantadas: cantadas,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _conLetra(int n) => '${letras[(n - 1) ~/ 15]} $n';

  Future<void> _cantar(
    BuildContext context,
    WidgetRef ref,
    int numero,
    List<Carton> cartones,
    Set<int> cantadas,
  ) async {
    final figuras = config.figuras;
    final ganadorasAntes = ordenarPorCercania(
      cartones,
      cantadas,
      figuras,
    ).where((e) => e.progreso.gano).length;

    await ref.read(repositorioPartidasProvider).cantar(config.id, numero);

    final ganadoras = ordenarPorCercania(cartones, {
      ...cantadas,
      numero,
    }, figuras).where((e) => e.progreso.gano).toList();

    if (ganadoras.length > ganadorasAntes) {
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
