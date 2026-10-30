import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bingo_app/dominio/carton.dart';
import 'package:bingo_app/dominio/partida.dart';
import 'package:bingo_app/estado/proveedores.dart';
import 'package:bingo_app/presentacion/agregar_tabla/pantalla_agregar_tabla.dart';
import 'package:bingo_app/presentacion/comun/cuadricula_carton.dart';
import 'package:bingo_app/presentacion/escanear/pantalla_escanear.dart';
import 'package:bingo_app/presentacion/juego/pantalla_juego.dart';
import 'package:bingo_app/presentacion/nueva_partida/pantalla_nueva_partida.dart';

class PantallaMisTablas extends ConsumerWidget {
  const PantallaMisTablas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartones = ref.watch(cartonesProvider);
    final enCurso = ref.watch(partidaEnCursoProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis tablas'),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PantallaNuevaPartida()),
            ),
            icon: const Icon(Icons.play_arrow),
            label: const Text('Jugar'),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 'escanear',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PantallaEscanear()),
            ),
            icon: const Icon(Icons.document_scanner),
            label: const Text('Escanear'),
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            heroTag: 'manual',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PantallaAgregarTabla()),
            ),
            icon: const Icon(Icons.edit),
            label: const Text('Agregar a mano'),
          ),
        ],
      ),
      body: cartones.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error al cargar: $e')),
        data: (lista) => lista.isEmpty
            ? const Center(
                child: Text(
                  'Aún no tienes tablas.\n'
                  'Escanea o agrega la primera con los botones de abajo.',
                  textAlign: TextAlign.center,
                ),
              )
            : ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 160),
                children: [
                  if (enCurso != null) _TarjetaPartidaEnCurso(enCurso),
                  for (final carton in lista)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    carton.alias,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline),
                                  tooltip: 'Eliminar',
                                  onPressed: () =>
                                      _confirmarEliminar(context, ref, carton),
                                ),
                              ],
                            ),
                            CuadriculaCarton(carton: carton),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }

  Future<void> _confirmarEliminar(
    BuildContext context,
    WidgetRef ref,
    Carton carton,
  ) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¿Eliminar tabla?'),
        content: Text('Se eliminará "${carton.alias}".'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
    if (confirmado == true) {
      await ref.read(repositorioCartonesProvider).eliminar(carton.id!);
    }
  }
}

class _TarjetaPartidaEnCurso extends ConsumerWidget {
  const _TarjetaPartidaEnCurso(this.config);
  final ConfigPartida config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balotas = ref.watch(balotasProvider(config.id)).value?.length ?? 0;
    final tema = Theme.of(context);

    return Card(
      color: tema.colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Partida en curso', style: tema.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              '${config.descripcion} · ${config.cartonIds.length} '
              '${config.cartonIds.length == 1 ? 'tabla' : 'tablas'} · '
              '$balotas balotas cantadas',
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => ref
                      .read(repositorioPartidasProvider)
                      .finalizar(config.id),
                  child: const Text('Descartar'),
                ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PantallaJuego(config: config),
                    ),
                  ),
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Continuar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
