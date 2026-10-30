import 'package:drift/drift.dart';

import '../dominio/tipo_juego.dart';
import 'base_datos.dart';

class RepositorioPartidas {
  RepositorioPartidas(this._db);
  final BaseDatos _db;

  /// Crea la partida y le asocia las tablas en una sola transacción.
  Future<int> crear(
    TipoJuego tipo,
    List<int> cartonIds, {
    int? columnaDesignada,
  }) {
    return _db.transaction(() async {
      final id = await _db
          .into(_db.partidas)
          .insert(
            PartidasCompanion.insert(
              tipoJuego: tipo,
              columnaDesignada: Value(columnaDesignada),
            ),
          );
      for (final cartonId in cartonIds) {
        await _db
            .into(_db.partidaCartones)
            .insert(
              PartidaCartonesCompanion.insert(
                partidaId: id,
                cartonId: cartonId,
              ),
            );
      }
      return id;
    });
  }

  SimpleSelectStatement<$BalotasTable, Balota> _balotasDe(int partidaId) =>
      _db.select(_db.balotas)
        ..where((b) => b.partidaId.equals(partidaId))
        ..orderBy([(b) => OrderingTerm.asc(b.orden)]);

  Stream<List<int>> observarBalotas(int partidaId) =>
      _balotasDe(partidaId)
          .watch()
          .map((filas) => [for (final b in filas) b.numero]);

  Future<void> cantar(int partidaId, int numero) async {
    final actuales = await _balotasDe(partidaId).get();
    await _db
        .into(_db.balotas)
        .insert(
          BalotasCompanion.insert(
            partidaId: partidaId,
            numero: numero,
            orden: actuales.length + 1,
          ),
          mode: InsertMode.insertOrIgnore, // si ya se cantó, no pasa nada
        );
  }

  Future<void> deshacerUltima(int partidaId) async {
    final actuales = await _balotasDe(partidaId).get();
    if (actuales.isEmpty) return;
    final ultima = actuales.last.numero;
    await (_db.delete(_db.balotas)..where(
          (b) => b.partidaId.equals(partidaId) & b.numero.equals(ultima),
        ))
        .go();
  }

  Future<List<int>> cartonesDe(int partidaId) async {
    final filas = await (_db.select(
      _db.partidaCartones,
    )..where((pc) => pc.partidaId.equals(partidaId))).get();
    return [for (final f in filas) f.cartonId];
  }

  Future<void> finalizar(int partidaId) =>
      (_db.update(_db.partidas)..where((p) => p.id.equals(partidaId))).write(
        const PartidasCompanion(finalizada: Value(true)),
      );
}
