import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// Guarda las fotos de las tablas en una carpeta propia de la app.
///
/// El recorte de la cámara queda en la caché, que Android puede vaciar en
/// cualquier momento. Por eso, al guardar una tabla, su foto se copia aquí.
class AlmacenFotos {
  AlmacenFotos({Future<Directory> Function()? carpetaBase})
    : _carpetaBase = carpetaBase ?? getApplicationDocumentsDirectory;

  final Future<Directory> Function() _carpetaBase;

  /// Copia la foto a la carpeta "fotos" y devuelve la ruta nueva.
  Future<String> guardar(String rutaTemporal) async {
    final base = await _carpetaBase();
    final carpeta = await Directory('${base.path}/fotos').create(
      recursive: true,
    );
    final punto = rutaTemporal.lastIndexOf('.');
    final tipo = punto == -1 ? '.jpg' : rutaTemporal.substring(punto);
    final nombre = 'tabla_${DateTime.now().microsecondsSinceEpoch}$tipo';
    final copia = await File(rutaTemporal).copy('${carpeta.path}/$nombre');
    return copia.path;
  }

  /// Borra la foto si existe. No falla si ya no está.
  Future<void> borrar(String? ruta) async {
    if (ruta == null) return;
    final archivo = File(ruta);
    if (await archivo.exists()) await archivo.delete();
  }
}
