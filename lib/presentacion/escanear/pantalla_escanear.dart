import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bingo_app/datos/lector_ocr.dart';
import 'package:bingo_app/dominio/carton.dart';
import 'package:bingo_app/dominio/interpretar_carton.dart';
import 'package:bingo_app/estado/proveedores.dart';
import 'package:bingo_app/presentacion/agregar_tabla/pantalla_agregar_tabla.dart';

class PantallaEscanear extends ConsumerStatefulWidget {
  const PantallaEscanear({super.key});

  @override
  ConsumerState<PantallaEscanear> createState() => _PantallaEscanearState();
}

class _PantallaEscanearState extends ConsumerState<PantallaEscanear> {
  String? _ruta;
  LecturaCruda? _lectura;
  ResultadoLectura? _resultado;
  bool _cargando = false;

  Future<void> _escanear(ImageSource origen) async {
    final ruta = await ref.read(servicioFotoProvider).obtenerTabla(origen);
    if (ruta == null) return; // el usuario canceló
    setState(() => _cargando = true);
    final lectura = await ref.read(lectorOcrProvider).leer(ruta);
    final resultado = interpretarCarton(LectorOcr.simbolos(lectura));
    if (!mounted) return;
    setState(() {
      _ruta = ruta;
      _lectura = lectura;
      _resultado = resultado;
      _cargando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lectura = _lectura;
    final resultado = _resultado;

    return Scaffold(
      appBar: AppBar(title: const Text('Escanear tabla')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: _cargando
                      ? null
                      : () => _escanear(ImageSource.camera),
                  icon: const Icon(Icons.photo_camera),
                  label: const Text('Tomar foto'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _cargando
                      ? null
                      : () => _escanear(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Galería'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_cargando) const Center(child: CircularProgressIndicator()),
          if (resultado != null) ...[
            Text(
              'Leyó ${resultado.leidas} de 24 casillas'
              '${resultado.dudosas.isEmpty ? '' : ' · ${resultado.dudosas.length} por revisar'}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            _VistaPrevia(resultado),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PantallaAgregarTabla(
                    inicial: resultado.numeros,
                    dudosas: resultado.dudosas,
                    fotoPath: _ruta,
                  ),
                ),
              ),
              icon: const Icon(Icons.fact_check),
              label: const Text('Revisar y guardar'),
            ),
          ],
          if (lectura != null && _ruta != null) ...[
            const SizedBox(height: 16),
            ExpansionTile(
              title: const Text('Detalle del OCR'),
              tilePadding: EdgeInsets.zero,
              children: [
                const Text('🟩 número 1-75   🟧 B-I-N-G-O   🟥 se descarta'),
                const SizedBox(height: 8),
                AspectRatio(
                  aspectRatio: lectura.ancho / lectura.alto,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.file(File(_ruta!), fit: BoxFit.fill),
                      ),
                      Positioned.fill(
                        child: CustomPaint(painter: _PintorCajas(lectura)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final e in lectura.elementos)
                      Chip(
                        label: Text(e.text),
                        side: BorderSide(color: colorDeTexto(e.text), width: 2),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// Tabla interpretada: '?' = no leída; amarillo = revisar.
class _VistaPrevia extends StatelessWidget {
  const _VistaPrevia(this.resultado);
  final ResultadoLectura resultado;

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
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        GridView.count(
          crossAxisCount: 5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
          childAspectRatio: 1.4,
          children: [
            for (var i = 0; i < 25; i++)
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: resultado.dudosas.contains(i)
                      ? Colors.amber.withValues(alpha: 0.4)
                      : null,
                  border: Border.all(color: esquema.outlineVariant),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(switch (resultado.numeros[i ~/ 5][i % 5]) {
                  null => '?',
                  0 => '★',
                  final n => '$n',
                }, style: const TextStyle(fontSize: 18)),
              ),
          ],
        ),
      ],
    );
  }
}

enum TipoTexto { numero, encabezado, descartado }

TipoTexto tipoDeTexto(String texto) {
  final t = texto.trim().toUpperCase();
  if (const ['B', 'I', 'N', 'G', 'O', 'BINGO'].contains(t)) {
    return TipoTexto.encabezado;
  }
  final n = int.tryParse(t);
  if (n != null && n >= 1 && n <= 75) return TipoTexto.numero;
  return TipoTexto.descartado;
}

Color colorDeTexto(String texto) => switch (tipoDeTexto(texto)) {
  TipoTexto.numero => Colors.green,
  TipoTexto.encabezado => Colors.orange,
  TipoTexto.descartado => Colors.red,
};

class _PintorCajas extends CustomPainter {
  _PintorCajas(this.lectura);
  final LecturaCruda lectura;

  @override
  void paint(Canvas canvas, Size size) {
    final ex = size.width / lectura.ancho;
    final ey = size.height / lectura.alto;
    for (final e in lectura.elementos) {
      final r = e.boundingBox;
      final pincel = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..color = colorDeTexto(e.text);
      canvas.drawRect(
        Rect.fromLTRB(r.left * ex, r.top * ey, r.right * ex, r.bottom * ey),
        pincel,
      );
    }
  }

  @override
  bool shouldRepaint(_PintorCajas anterior) => anterior.lectura != lectura;
}
