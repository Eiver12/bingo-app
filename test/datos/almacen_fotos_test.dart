import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:bingo_app/datos/almacen_fotos.dart';

void main() {
  late Directory temporal;

  setUp(() async {
    temporal = await Directory.systemTemp.createTemp('bingo_');
  });
  tearDown(() => temporal.delete(recursive: true));

  test('copia la foto a la carpeta de la app y la puede borrar', () async {
    final recorte = await File(
      '${temporal.path}/recorte.jpg',
    ).writeAsBytes([1, 2, 3]);
    final almacen = AlmacenFotos(carpetaBase: () async => temporal);

    final ruta = await almacen.guardar(recorte.path);
    expect(ruta, startsWith('${temporal.path}/fotos/tabla_'));
    expect(ruta, endsWith('.jpg'));
    expect(await File(ruta).readAsBytes(), [1, 2, 3]);

    await recorte.delete(); // como cuando Android vacía la caché
    expect(await File(ruta).exists(), isTrue);

    await almacen.borrar(ruta);
    expect(await File(ruta).exists(), isFalse);

    // Borrar algo que ya no existe, o una tabla sin foto, no falla.
    await almacen.borrar(ruta);
    await almacen.borrar(null);
  });
}
