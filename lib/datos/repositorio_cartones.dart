import 'dart:convert';
import 'package:drift/drift.dart';
import '../dominio/carton.dart';
import 'base_datos.dart';

class RepositorioCartones {
  RepositorioCartones(this._db);
  final BaseDatos _db;

  Future<int> guardar(Carton carton, {String? fotoPath}) {
    final plano = [for (final fila in carton.numeros) ...fila];
    return _db.into(_db.cartones).insert(CartonesCompanion.insert(
          alias: carton.alias,
          numeros: jsonEncode(plano),
          fotoPath: Value(fotoPath),
        ));
  }

  /// Emite la lista de nuevo cada vez que cambia la tabla en la base.
  Stream<List<Carton>> observarTodos() => _db
      .select(_db.cartones)
      .watch()
      .map((filas) => [for (final r in filas) _aDominio(r)]);

  Future<void> eliminar(int id) =>
      (_db.delete(_db.cartones)..where((t) => t.id.equals(id))).go();

  Carton _aDominio(CartonRegistro r) {
    final plano = (jsonDecode(r.numeros) as List).cast<int>();
    return Carton(id: r.id, alias: r.alias, numeros: [
      for (var f = 0; f < 5; f++) plano.sublist(f * 5, f * 5 + 5),
    ]);
  }
}