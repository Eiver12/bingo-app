import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bingo_app/dominio/carton.dart';
import 'package:bingo_app/dominio/partida.dart';
import 'package:bingo_app/dominio/tipo_juego.dart';
import 'package:bingo_app/estado/proveedores.dart';
import 'package:bingo_app/presentacion/juego/pantalla_juego.dart';

class PantallaNuevaPartida extends ConsumerStatefulWidget {
  const PantallaNuevaPartida({super.key});

  @override
  ConsumerState<PantallaNuevaPartida> createState() =>
      _PantallaNuevaPartidaState();
}

class _PantallaNuevaPartidaState extends ConsumerState<PantallaNuevaPartida> {
  TipoJuego _tipo = TipoJuego.linea;
  int _columna = 0;
  Set<int>? _seleccionadas; // null = todavía no se inicializa

  bool _empezando = false; // evita crear dos partidas con un doble toque

  Future<void> _empezar() async {
    if (_empezando) return;
    setState(() => _empezando = true);
    try {
      await _crearYAbrir();
    } finally {
      if (mounted) setState(() => _empezando = false);
    }
  }

  /// Crear una partida finaliza la que esté en curso: se pide permiso antes.
  Future<bool> _confirmarReemplazo() async {
    final enCurso = await ref.read(partidaEnCursoProvider.future);
    if (enCurso == null) return true;
    if (!mounted) return false;
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ya hay una partida en curso'),
        content: Text(
          'Si empiezas una nueva, la partida "${enCurso.descripcion}" '
          'se dará por terminada y no podrás retomarla.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Empezar nueva'),
          ),
        ],
      ),
    );
    return confirmado == true;
  }

  Future<void> _crearYAbrir() async {
    if (!await _confirmarReemplazo()) return;
    final ids = _seleccionadas!.toList();
    final columna = _tipo == TipoJuego.columna ? _columna : null;
    final id = await ref
        .read(repositorioPartidasProvider)
        .crear(_tipo, ids, columnaDesignada: columna);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => PantallaJuego(
          config: ConfigPartida(
            id: id,
            tipo: _tipo,
            cartonIds: ids,
            columnaDesignada: columna,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final cartones = ref.watch(cartonesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Nueva partida')),
      body: cartones.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error al cargar: $e')),
        data: (lista) {
          if (lista.isEmpty) {
            return const Center(
              child: Text('Primero agrega al menos una tabla.'),
            );
          }
          // Por defecto juegan todas las tablas.
          _seleccionadas ??= {for (final c in lista) c.id!};
          final seleccionadas = _seleccionadas!;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text('Tipo de juego', style: tema.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final t in TipoJuego.values)
                        ChoiceChip(
                          label: Text(t.nombre),
                          selected: _tipo == t,
                          onSelected: (_) => setState(() => _tipo = t),
                        ),
                    ],
                  ),
                  if (_tipo == TipoJuego.columna) ...[
                    const SizedBox(height: 16),
                    Text(
                      'Columna que pidió el juez',
                      style: tema.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    SegmentedButton<int>(
                      segments: [
                        for (var i = 0; i < 5; i++)
                          ButtonSegment(value: i, label: Text(letras[i])),
                      ],
                      selected: {_columna},
                      onSelectionChanged: (s) =>
                          setState(() => _columna = s.first),
                    ),
                  ],
                  const SizedBox(height: 24),
                  Text(
                    'Tablas que juegan (${seleccionadas.length})',
                    style: tema.textTheme.titleMedium,
                  ),
                  for (final c in lista)
                    CheckboxListTile(
                      title: Text(c.alias),
                      value: seleccionadas.contains(c.id),
                      onChanged: (v) => setState(() {
                        if (v == true) {
                          seleccionadas.add(c.id!);
                        } else {
                          seleccionadas.remove(c.id);
                        }
                      }),
                    ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: seleccionadas.isEmpty || _empezando
                        ? null
                        : _empezar,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Empezar partida'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
