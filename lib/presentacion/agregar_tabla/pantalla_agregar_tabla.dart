import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bingo_app/dominio/carton.dart';
import 'package:bingo_app/estado/proveedores.dart';

class PantallaAgregarTabla extends ConsumerStatefulWidget {
  const PantallaAgregarTabla({super.key});

  @override
  ConsumerState<PantallaAgregarTabla> createState() => _PantallaAgregarTablaState();
}

class _PantallaAgregarTablaState extends ConsumerState<PantallaAgregarTabla> {
  final _alias = TextEditingController();
  final _casillas = List.generate(25, (_) => TextEditingController());
  List<String> _errores = [];

  @override
  void dispose() {
    _alias.dispose();
    for (final c in _casillas) {
      c.dispose();
    }
    super.dispose();
  }

  List<List<int>> _leerNumeros() => [
    for (var f = 0; f < 5; f++)
      [
        for (var c = 0; c < 5; c++)
          (f == 2 && c == 2) ? 0 : int.parse(_casillas[f * 5 + c].text),
      ],
  ];

  Future<void> _guardar() async {
    final vacias = [
      for (var i = 0; i < 25; i++)
        if (i != 12 && _casillas[i].text.trim().isEmpty) i,
    ];
    if (vacias.isNotEmpty) {
      setState(() => _errores = ['Faltan ${vacias.length} casillas por llenar']);
      return;
    }

    final numeros = _leerNumeros();
    final errores = Carton.validar(numeros);
    final alias = _alias.text.trim();
    if (alias.isEmpty) errores.insert(0, 'Escribe un nombre para la tabla');
    if (errores.isNotEmpty) {
      setState(() => _errores = errores);
      return;
    }

    await ref
        .read(repositorioCartonesProvider)
        .guardar(Carton(alias: alias, numeros: numeros));
    if (!mounted) return;
    Navigator.pop(context);
  }

  String _pista(int columna) {
    final (min, max) = rangosColumna[columna];
    return '$min-$max';
  }

  bool _fueraDeRango(int i) {
    final n = int.tryParse(_casillas[i].text);
    if (n == null) return false; // vacía: todavía no es error
    final (min, max) = rangosColumna[i % 5];
    return n < min || n > max;
  }

  Widget _casilla(int i, ThemeData tema) {
    final bordeError = OutlineInputBorder(
      borderSide: BorderSide(color: tema.colorScheme.error, width: 2),
    );
    return TextField(
      controller: _casillas[i],
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      expands: true, // ocupa todo el cuadro
      maxLines: null,
      maxLength: 2,
      textInputAction: TextInputAction.next,
      style: const TextStyle(fontSize: 20),
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        counterText: '',
        hintText: _pista(i % 5),
        hintStyle: const TextStyle(fontSize: 11),
        border: const OutlineInputBorder(),
        enabledBorder: _fueraDeRango(i) ? bordeError : null,
        focusedBorder: _fueraDeRango(i) ? bordeError : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar tabla a mano')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextField(
                controller: _alias,
                decoration: const InputDecoration(
                  labelText: 'Nombre de la tabla',
                  hintText: 'Ej: Tabla roja',
                ),
              ),
              const SizedBox(height: 16),
              Row(children: [
                for (final l in letras)
                  Expanded(
                    child: Center(child: Text(l, style: tema.textTheme.titleLarge)),
                  ),
              ]),
              const SizedBox(height: 8),
              GridView.count(
                crossAxisCount: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
                children: [
                  for (var i = 0; i < 25; i++)
                    i == 12
                        ? const Center(child: Text('LIBRE'))
                        : _casilla(i, tema),
                ],
              ),
              if (_errores.isNotEmpty) ...[
                const SizedBox(height: 12),
                for (final e in _errores)
                  Text('• $e', style: TextStyle(color: tema.colorScheme.error)),
              ],
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _guardar,
                icon: const Icon(Icons.save),
                label: const Text('Guardar tabla'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
