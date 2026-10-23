import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import '../dominio/tipo_juego.dart';

part 'base_datos.g.dart';

@DataClassName('CartonRegistro')
class Cartones extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get alias => text()();
  TextColumn get numeros => text()(); // JSON con los 25 números
  TextColumn get fotoPath => text().nullable()();
  DateTimeColumn get creadoEn => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('PartidaRegistro')
class Partidas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tipoJuego => textEnum<TipoJuego>()();
  IntColumn get columnaDesignada => integer().nullable()();
  BoolColumn get finalizada => boolean().withDefault(const Constant(false))();
  DateTimeColumn get creadaEn => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('PartidaCarton')
class PartidaCartones extends Table {
  IntColumn get partidaId =>
      integer().references(Partidas, #id, onDelete: KeyAction.cascade)();
  IntColumn get cartonId =>
      integer().references(Cartones, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {partidaId, cartonId};
}

@DataClassName('Balota')
class Balotas extends Table {
  IntColumn get partidaId =>
      integer().references(Partidas, #id, onDelete: KeyAction.cascade)();
   // ignore: recursive_getters
  IntColumn get numero => integer().check(numero.isBetweenValues(1, 75))();
  IntColumn get orden => integer()();

  @override
  Set<Column> get primaryKey => {partidaId, numero}; // impide cantar dos veces
}

@DriftDatabase(tables: [Cartones, Partidas, PartidaCartones, Balotas])
class BaseDatos extends _$BaseDatos {
  /// Sin parámetro usa el archivo del celular; en pruebas se pasa una base en memoria.
  BaseDatos([QueryExecutor? ejecutor])
      : super(ejecutor ?? driftDatabase(name: 'bingo'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (detalles) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}