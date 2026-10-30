import 'dart:io';

import 'package:flutter/painting.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:bingo_app/dominio/interpretar_carton.dart';

/// Lo que devuelve ML Kit, sin interpretar, más el tamaño de la imagen.
class LecturaCruda {
  const LecturaCruda({
    required this.elementos,
    required this.ancho,
    required this.alto,
  });

  final List<TextElement> elementos;
  final double ancho;
  final double alto;
}

class LectorOcr {
  final _reconocedor = TextRecognizer(script: TextRecognitionScript.latin);

  Future<LecturaCruda> leer(String ruta) async {
    final texto = await _reconocedor.processImage(
      InputImage.fromFilePath(ruta),
    );

    final imagen = await decodeImageFromList(await File(ruta).readAsBytes());
    final ancho = imagen.width.toDouble();
    final alto = imagen.height.toDouble();
    imagen.dispose();

    return LecturaCruda(
      elementos: [
        for (final b in texto.blocks)
          for (final l in b.lines) ...l.elements,
      ],
      ancho: ancho,
      alto: alto,
    );
  }

  Future<void> cerrar() => _reconocedor.close();

  /// Convierte la lectura de ML Kit en caracteres sueltos con su posición.
  static List<Simbolo> simbolos(LecturaCruda lectura) => [
    for (final e in lectura.elementos) ..._simbolosDe(e),
  ];

  static List<Simbolo> _simbolosDe(TextElement e) {
    if (e.symbols.isNotEmpty) {
      return [
        for (final s in e.symbols)
          Simbolo(
            s.text,
            s.boundingBox.left,
            s.boundingBox.top,
            s.boundingBox.right,
            s.boundingBox.bottom,
          ),
      ];
    }
    // Si ML Kit no entrega caracteres, se reparte el recuadro en partes iguales.
    final r = e.boundingBox;
    final ancho = r.width / e.text.length;
    return [
      for (var i = 0; i < e.text.length; i++)
        Simbolo(
          e.text[i],
          r.left + i * ancho,
          r.top,
          r.left + (i + 1) * ancho,
          r.bottom,
        ),
    ];
  }
}
