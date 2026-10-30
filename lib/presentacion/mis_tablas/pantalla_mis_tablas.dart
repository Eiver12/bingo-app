import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bingo_app/dominio/carton.dart';
import 'package:bingo_app/estado/proveedores.dart';
import 'package:bingo_app/presentacion/agregar_tabla/pantalla_agregar_tabla.dart';
import 'package:bingo_app/presentacion/comun/cuadricula_carton.dart';
import 'package:bingo_app/presentacion/nueva_partida/pantalla_nueva_partida.dart';
import 'package:bingo_app/presentacion/escanear/pantalla_escanear.dart';

class PantallaMisTablas extends ConsumerWidget {
  const PantallaMisTablas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartones = ref.watch(cartonesProvider);

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
                  'Aún no tienes tablas.\nAgrega la primera con el botón de abajo.',
                  textAlign: TextAlign.center,
                ),
              )
            : ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
                children: [
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
