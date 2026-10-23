// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_datos.dart';

// ignore_for_file: type=lint
class $CartonesTable extends Cartones
    with TableInfo<$CartonesTable, CartonRegistro> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CartonesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _aliasMeta = const VerificationMeta('alias');
  @override
  late final GeneratedColumn<String> alias = GeneratedColumn<String>(
    'alias',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numerosMeta = const VerificationMeta(
    'numeros',
  );
  @override
  late final GeneratedColumn<String> numeros = GeneratedColumn<String>(
    'numeros',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fotoPathMeta = const VerificationMeta(
    'fotoPath',
  );
  @override
  late final GeneratedColumn<String> fotoPath = GeneratedColumn<String>(
    'foto_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadoEn = GeneratedColumn<DateTime>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    alias,
    numeros,
    fotoPath,
    creadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cartones';
  @override
  VerificationContext validateIntegrity(
    Insertable<CartonRegistro> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('alias')) {
      context.handle(
        _aliasMeta,
        alias.isAcceptableOrUnknown(data['alias']!, _aliasMeta),
      );
    } else if (isInserting) {
      context.missing(_aliasMeta);
    }
    if (data.containsKey('numeros')) {
      context.handle(
        _numerosMeta,
        numeros.isAcceptableOrUnknown(data['numeros']!, _numerosMeta),
      );
    } else if (isInserting) {
      context.missing(_numerosMeta);
    }
    if (data.containsKey('foto_path')) {
      context.handle(
        _fotoPathMeta,
        fotoPath.isAcceptableOrUnknown(data['foto_path']!, _fotoPathMeta),
      );
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CartonRegistro map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CartonRegistro(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      alias: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alias'],
      )!,
      numeros: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}numeros'],
      )!,
      fotoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}foto_path'],
      ),
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creado_en'],
      )!,
    );
  }

  @override
  $CartonesTable createAlias(String alias) {
    return $CartonesTable(attachedDatabase, alias);
  }
}

class CartonRegistro extends DataClass implements Insertable<CartonRegistro> {
  final int id;
  final String alias;
  final String numeros;
  final String? fotoPath;
  final DateTime creadoEn;
  const CartonRegistro({
    required this.id,
    required this.alias,
    required this.numeros,
    this.fotoPath,
    required this.creadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['alias'] = Variable<String>(alias);
    map['numeros'] = Variable<String>(numeros);
    if (!nullToAbsent || fotoPath != null) {
      map['foto_path'] = Variable<String>(fotoPath);
    }
    map['creado_en'] = Variable<DateTime>(creadoEn);
    return map;
  }

  CartonesCompanion toCompanion(bool nullToAbsent) {
    return CartonesCompanion(
      id: Value(id),
      alias: Value(alias),
      numeros: Value(numeros),
      fotoPath: fotoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(fotoPath),
      creadoEn: Value(creadoEn),
    );
  }

  factory CartonRegistro.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CartonRegistro(
      id: serializer.fromJson<int>(json['id']),
      alias: serializer.fromJson<String>(json['alias']),
      numeros: serializer.fromJson<String>(json['numeros']),
      fotoPath: serializer.fromJson<String?>(json['fotoPath']),
      creadoEn: serializer.fromJson<DateTime>(json['creadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'alias': serializer.toJson<String>(alias),
      'numeros': serializer.toJson<String>(numeros),
      'fotoPath': serializer.toJson<String?>(fotoPath),
      'creadoEn': serializer.toJson<DateTime>(creadoEn),
    };
  }

  CartonRegistro copyWith({
    int? id,
    String? alias,
    String? numeros,
    Value<String?> fotoPath = const Value.absent(),
    DateTime? creadoEn,
  }) => CartonRegistro(
    id: id ?? this.id,
    alias: alias ?? this.alias,
    numeros: numeros ?? this.numeros,
    fotoPath: fotoPath.present ? fotoPath.value : this.fotoPath,
    creadoEn: creadoEn ?? this.creadoEn,
  );
  CartonRegistro copyWithCompanion(CartonesCompanion data) {
    return CartonRegistro(
      id: data.id.present ? data.id.value : this.id,
      alias: data.alias.present ? data.alias.value : this.alias,
      numeros: data.numeros.present ? data.numeros.value : this.numeros,
      fotoPath: data.fotoPath.present ? data.fotoPath.value : this.fotoPath,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CartonRegistro(')
          ..write('id: $id, ')
          ..write('alias: $alias, ')
          ..write('numeros: $numeros, ')
          ..write('fotoPath: $fotoPath, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, alias, numeros, fotoPath, creadoEn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartonRegistro &&
          other.id == this.id &&
          other.alias == this.alias &&
          other.numeros == this.numeros &&
          other.fotoPath == this.fotoPath &&
          other.creadoEn == this.creadoEn);
}

class CartonesCompanion extends UpdateCompanion<CartonRegistro> {
  final Value<int> id;
  final Value<String> alias;
  final Value<String> numeros;
  final Value<String?> fotoPath;
  final Value<DateTime> creadoEn;
  const CartonesCompanion({
    this.id = const Value.absent(),
    this.alias = const Value.absent(),
    this.numeros = const Value.absent(),
    this.fotoPath = const Value.absent(),
    this.creadoEn = const Value.absent(),
  });
  CartonesCompanion.insert({
    this.id = const Value.absent(),
    required String alias,
    required String numeros,
    this.fotoPath = const Value.absent(),
    this.creadoEn = const Value.absent(),
  }) : alias = Value(alias),
       numeros = Value(numeros);
  static Insertable<CartonRegistro> custom({
    Expression<int>? id,
    Expression<String>? alias,
    Expression<String>? numeros,
    Expression<String>? fotoPath,
    Expression<DateTime>? creadoEn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (alias != null) 'alias': alias,
      if (numeros != null) 'numeros': numeros,
      if (fotoPath != null) 'foto_path': fotoPath,
      if (creadoEn != null) 'creado_en': creadoEn,
    });
  }

  CartonesCompanion copyWith({
    Value<int>? id,
    Value<String>? alias,
    Value<String>? numeros,
    Value<String?>? fotoPath,
    Value<DateTime>? creadoEn,
  }) {
    return CartonesCompanion(
      id: id ?? this.id,
      alias: alias ?? this.alias,
      numeros: numeros ?? this.numeros,
      fotoPath: fotoPath ?? this.fotoPath,
      creadoEn: creadoEn ?? this.creadoEn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (alias.present) {
      map['alias'] = Variable<String>(alias.value);
    }
    if (numeros.present) {
      map['numeros'] = Variable<String>(numeros.value);
    }
    if (fotoPath.present) {
      map['foto_path'] = Variable<String>(fotoPath.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<DateTime>(creadoEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CartonesCompanion(')
          ..write('id: $id, ')
          ..write('alias: $alias, ')
          ..write('numeros: $numeros, ')
          ..write('fotoPath: $fotoPath, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }
}

class $PartidasTable extends Partidas
    with TableInfo<$PartidasTable, PartidaRegistro> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PartidasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<TipoJuego, String> tipoJuego =
      GeneratedColumn<String>(
        'tipo_juego',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TipoJuego>($PartidasTable.$convertertipoJuego);
  static const VerificationMeta _columnaDesignadaMeta = const VerificationMeta(
    'columnaDesignada',
  );
  @override
  late final GeneratedColumn<int> columnaDesignada = GeneratedColumn<int>(
    'columna_designada',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _finalizadaMeta = const VerificationMeta(
    'finalizada',
  );
  @override
  late final GeneratedColumn<bool> finalizada = GeneratedColumn<bool>(
    'finalizada',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("finalizada" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _creadaEnMeta = const VerificationMeta(
    'creadaEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadaEn = GeneratedColumn<DateTime>(
    'creada_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tipoJuego,
    columnaDesignada,
    finalizada,
    creadaEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'partidas';
  @override
  VerificationContext validateIntegrity(
    Insertable<PartidaRegistro> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('columna_designada')) {
      context.handle(
        _columnaDesignadaMeta,
        columnaDesignada.isAcceptableOrUnknown(
          data['columna_designada']!,
          _columnaDesignadaMeta,
        ),
      );
    }
    if (data.containsKey('finalizada')) {
      context.handle(
        _finalizadaMeta,
        finalizada.isAcceptableOrUnknown(data['finalizada']!, _finalizadaMeta),
      );
    }
    if (data.containsKey('creada_en')) {
      context.handle(
        _creadaEnMeta,
        creadaEn.isAcceptableOrUnknown(data['creada_en']!, _creadaEnMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PartidaRegistro map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PartidaRegistro(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tipoJuego: $PartidasTable.$convertertipoJuego.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}tipo_juego'],
        )!,
      ),
      columnaDesignada: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}columna_designada'],
      ),
      finalizada: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}finalizada'],
      )!,
      creadaEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creada_en'],
      )!,
    );
  }

  @override
  $PartidasTable createAlias(String alias) {
    return $PartidasTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TipoJuego, String, String> $convertertipoJuego =
      const EnumNameConverter<TipoJuego>(TipoJuego.values);
}

class PartidaRegistro extends DataClass implements Insertable<PartidaRegistro> {
  final int id;
  final TipoJuego tipoJuego;
  final int? columnaDesignada;
  final bool finalizada;
  final DateTime creadaEn;
  const PartidaRegistro({
    required this.id,
    required this.tipoJuego,
    this.columnaDesignada,
    required this.finalizada,
    required this.creadaEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['tipo_juego'] = Variable<String>(
        $PartidasTable.$convertertipoJuego.toSql(tipoJuego),
      );
    }
    if (!nullToAbsent || columnaDesignada != null) {
      map['columna_designada'] = Variable<int>(columnaDesignada);
    }
    map['finalizada'] = Variable<bool>(finalizada);
    map['creada_en'] = Variable<DateTime>(creadaEn);
    return map;
  }

  PartidasCompanion toCompanion(bool nullToAbsent) {
    return PartidasCompanion(
      id: Value(id),
      tipoJuego: Value(tipoJuego),
      columnaDesignada: columnaDesignada == null && nullToAbsent
          ? const Value.absent()
          : Value(columnaDesignada),
      finalizada: Value(finalizada),
      creadaEn: Value(creadaEn),
    );
  }

  factory PartidaRegistro.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PartidaRegistro(
      id: serializer.fromJson<int>(json['id']),
      tipoJuego: $PartidasTable.$convertertipoJuego.fromJson(
        serializer.fromJson<String>(json['tipoJuego']),
      ),
      columnaDesignada: serializer.fromJson<int?>(json['columnaDesignada']),
      finalizada: serializer.fromJson<bool>(json['finalizada']),
      creadaEn: serializer.fromJson<DateTime>(json['creadaEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tipoJuego': serializer.toJson<String>(
        $PartidasTable.$convertertipoJuego.toJson(tipoJuego),
      ),
      'columnaDesignada': serializer.toJson<int?>(columnaDesignada),
      'finalizada': serializer.toJson<bool>(finalizada),
      'creadaEn': serializer.toJson<DateTime>(creadaEn),
    };
  }

  PartidaRegistro copyWith({
    int? id,
    TipoJuego? tipoJuego,
    Value<int?> columnaDesignada = const Value.absent(),
    bool? finalizada,
    DateTime? creadaEn,
  }) => PartidaRegistro(
    id: id ?? this.id,
    tipoJuego: tipoJuego ?? this.tipoJuego,
    columnaDesignada: columnaDesignada.present
        ? columnaDesignada.value
        : this.columnaDesignada,
    finalizada: finalizada ?? this.finalizada,
    creadaEn: creadaEn ?? this.creadaEn,
  );
  PartidaRegistro copyWithCompanion(PartidasCompanion data) {
    return PartidaRegistro(
      id: data.id.present ? data.id.value : this.id,
      tipoJuego: data.tipoJuego.present ? data.tipoJuego.value : this.tipoJuego,
      columnaDesignada: data.columnaDesignada.present
          ? data.columnaDesignada.value
          : this.columnaDesignada,
      finalizada: data.finalizada.present
          ? data.finalizada.value
          : this.finalizada,
      creadaEn: data.creadaEn.present ? data.creadaEn.value : this.creadaEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PartidaRegistro(')
          ..write('id: $id, ')
          ..write('tipoJuego: $tipoJuego, ')
          ..write('columnaDesignada: $columnaDesignada, ')
          ..write('finalizada: $finalizada, ')
          ..write('creadaEn: $creadaEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, tipoJuego, columnaDesignada, finalizada, creadaEn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PartidaRegistro &&
          other.id == this.id &&
          other.tipoJuego == this.tipoJuego &&
          other.columnaDesignada == this.columnaDesignada &&
          other.finalizada == this.finalizada &&
          other.creadaEn == this.creadaEn);
}

class PartidasCompanion extends UpdateCompanion<PartidaRegistro> {
  final Value<int> id;
  final Value<TipoJuego> tipoJuego;
  final Value<int?> columnaDesignada;
  final Value<bool> finalizada;
  final Value<DateTime> creadaEn;
  const PartidasCompanion({
    this.id = const Value.absent(),
    this.tipoJuego = const Value.absent(),
    this.columnaDesignada = const Value.absent(),
    this.finalizada = const Value.absent(),
    this.creadaEn = const Value.absent(),
  });
  PartidasCompanion.insert({
    this.id = const Value.absent(),
    required TipoJuego tipoJuego,
    this.columnaDesignada = const Value.absent(),
    this.finalizada = const Value.absent(),
    this.creadaEn = const Value.absent(),
  }) : tipoJuego = Value(tipoJuego);
  static Insertable<PartidaRegistro> custom({
    Expression<int>? id,
    Expression<String>? tipoJuego,
    Expression<int>? columnaDesignada,
    Expression<bool>? finalizada,
    Expression<DateTime>? creadaEn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tipoJuego != null) 'tipo_juego': tipoJuego,
      if (columnaDesignada != null) 'columna_designada': columnaDesignada,
      if (finalizada != null) 'finalizada': finalizada,
      if (creadaEn != null) 'creada_en': creadaEn,
    });
  }

  PartidasCompanion copyWith({
    Value<int>? id,
    Value<TipoJuego>? tipoJuego,
    Value<int?>? columnaDesignada,
    Value<bool>? finalizada,
    Value<DateTime>? creadaEn,
  }) {
    return PartidasCompanion(
      id: id ?? this.id,
      tipoJuego: tipoJuego ?? this.tipoJuego,
      columnaDesignada: columnaDesignada ?? this.columnaDesignada,
      finalizada: finalizada ?? this.finalizada,
      creadaEn: creadaEn ?? this.creadaEn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tipoJuego.present) {
      map['tipo_juego'] = Variable<String>(
        $PartidasTable.$convertertipoJuego.toSql(tipoJuego.value),
      );
    }
    if (columnaDesignada.present) {
      map['columna_designada'] = Variable<int>(columnaDesignada.value);
    }
    if (finalizada.present) {
      map['finalizada'] = Variable<bool>(finalizada.value);
    }
    if (creadaEn.present) {
      map['creada_en'] = Variable<DateTime>(creadaEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartidasCompanion(')
          ..write('id: $id, ')
          ..write('tipoJuego: $tipoJuego, ')
          ..write('columnaDesignada: $columnaDesignada, ')
          ..write('finalizada: $finalizada, ')
          ..write('creadaEn: $creadaEn')
          ..write(')'))
        .toString();
  }
}

class $PartidaCartonesTable extends PartidaCartones
    with TableInfo<$PartidaCartonesTable, PartidaCarton> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PartidaCartonesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _partidaIdMeta = const VerificationMeta(
    'partidaId',
  );
  @override
  late final GeneratedColumn<int> partidaId = GeneratedColumn<int>(
    'partida_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES partidas (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _cartonIdMeta = const VerificationMeta(
    'cartonId',
  );
  @override
  late final GeneratedColumn<int> cartonId = GeneratedColumn<int>(
    'carton_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cartones (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [partidaId, cartonId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'partida_cartones';
  @override
  VerificationContext validateIntegrity(
    Insertable<PartidaCarton> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('partida_id')) {
      context.handle(
        _partidaIdMeta,
        partidaId.isAcceptableOrUnknown(data['partida_id']!, _partidaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_partidaIdMeta);
    }
    if (data.containsKey('carton_id')) {
      context.handle(
        _cartonIdMeta,
        cartonId.isAcceptableOrUnknown(data['carton_id']!, _cartonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cartonIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {partidaId, cartonId};
  @override
  PartidaCarton map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PartidaCarton(
      partidaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}partida_id'],
      )!,
      cartonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}carton_id'],
      )!,
    );
  }

  @override
  $PartidaCartonesTable createAlias(String alias) {
    return $PartidaCartonesTable(attachedDatabase, alias);
  }
}

class PartidaCarton extends DataClass implements Insertable<PartidaCarton> {
  final int partidaId;
  final int cartonId;
  const PartidaCarton({required this.partidaId, required this.cartonId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['partida_id'] = Variable<int>(partidaId);
    map['carton_id'] = Variable<int>(cartonId);
    return map;
  }

  PartidaCartonesCompanion toCompanion(bool nullToAbsent) {
    return PartidaCartonesCompanion(
      partidaId: Value(partidaId),
      cartonId: Value(cartonId),
    );
  }

  factory PartidaCarton.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PartidaCarton(
      partidaId: serializer.fromJson<int>(json['partidaId']),
      cartonId: serializer.fromJson<int>(json['cartonId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'partidaId': serializer.toJson<int>(partidaId),
      'cartonId': serializer.toJson<int>(cartonId),
    };
  }

  PartidaCarton copyWith({int? partidaId, int? cartonId}) => PartidaCarton(
    partidaId: partidaId ?? this.partidaId,
    cartonId: cartonId ?? this.cartonId,
  );
  PartidaCarton copyWithCompanion(PartidaCartonesCompanion data) {
    return PartidaCarton(
      partidaId: data.partidaId.present ? data.partidaId.value : this.partidaId,
      cartonId: data.cartonId.present ? data.cartonId.value : this.cartonId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PartidaCarton(')
          ..write('partidaId: $partidaId, ')
          ..write('cartonId: $cartonId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(partidaId, cartonId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PartidaCarton &&
          other.partidaId == this.partidaId &&
          other.cartonId == this.cartonId);
}

class PartidaCartonesCompanion extends UpdateCompanion<PartidaCarton> {
  final Value<int> partidaId;
  final Value<int> cartonId;
  final Value<int> rowid;
  const PartidaCartonesCompanion({
    this.partidaId = const Value.absent(),
    this.cartonId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PartidaCartonesCompanion.insert({
    required int partidaId,
    required int cartonId,
    this.rowid = const Value.absent(),
  }) : partidaId = Value(partidaId),
       cartonId = Value(cartonId);
  static Insertable<PartidaCarton> custom({
    Expression<int>? partidaId,
    Expression<int>? cartonId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (partidaId != null) 'partida_id': partidaId,
      if (cartonId != null) 'carton_id': cartonId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PartidaCartonesCompanion copyWith({
    Value<int>? partidaId,
    Value<int>? cartonId,
    Value<int>? rowid,
  }) {
    return PartidaCartonesCompanion(
      partidaId: partidaId ?? this.partidaId,
      cartonId: cartonId ?? this.cartonId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (partidaId.present) {
      map['partida_id'] = Variable<int>(partidaId.value);
    }
    if (cartonId.present) {
      map['carton_id'] = Variable<int>(cartonId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartidaCartonesCompanion(')
          ..write('partidaId: $partidaId, ')
          ..write('cartonId: $cartonId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BalotasTable extends Balotas with TableInfo<$BalotasTable, Balota> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BalotasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _partidaIdMeta = const VerificationMeta(
    'partidaId',
  );
  @override
  late final GeneratedColumn<int> partidaId = GeneratedColumn<int>(
    'partida_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES partidas (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _numeroMeta = const VerificationMeta('numero');
  @override
  late final GeneratedColumn<int> numero = GeneratedColumn<int>(
    'numero',
    aliasedName,
    false,
    check: () => ComparableExpr(numero).isBetweenValues(1, 75),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ordenMeta = const VerificationMeta('orden');
  @override
  late final GeneratedColumn<int> orden = GeneratedColumn<int>(
    'orden',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [partidaId, numero, orden];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'balotas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Balota> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('partida_id')) {
      context.handle(
        _partidaIdMeta,
        partidaId.isAcceptableOrUnknown(data['partida_id']!, _partidaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_partidaIdMeta);
    }
    if (data.containsKey('numero')) {
      context.handle(
        _numeroMeta,
        numero.isAcceptableOrUnknown(data['numero']!, _numeroMeta),
      );
    } else if (isInserting) {
      context.missing(_numeroMeta);
    }
    if (data.containsKey('orden')) {
      context.handle(
        _ordenMeta,
        orden.isAcceptableOrUnknown(data['orden']!, _ordenMeta),
      );
    } else if (isInserting) {
      context.missing(_ordenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {partidaId, numero};
  @override
  Balota map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Balota(
      partidaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}partida_id'],
      )!,
      numero: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}numero'],
      )!,
      orden: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}orden'],
      )!,
    );
  }

  @override
  $BalotasTable createAlias(String alias) {
    return $BalotasTable(attachedDatabase, alias);
  }
}

class Balota extends DataClass implements Insertable<Balota> {
  final int partidaId;
  final int numero;
  final int orden;
  const Balota({
    required this.partidaId,
    required this.numero,
    required this.orden,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['partida_id'] = Variable<int>(partidaId);
    map['numero'] = Variable<int>(numero);
    map['orden'] = Variable<int>(orden);
    return map;
  }

  BalotasCompanion toCompanion(bool nullToAbsent) {
    return BalotasCompanion(
      partidaId: Value(partidaId),
      numero: Value(numero),
      orden: Value(orden),
    );
  }

  factory Balota.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Balota(
      partidaId: serializer.fromJson<int>(json['partidaId']),
      numero: serializer.fromJson<int>(json['numero']),
      orden: serializer.fromJson<int>(json['orden']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'partidaId': serializer.toJson<int>(partidaId),
      'numero': serializer.toJson<int>(numero),
      'orden': serializer.toJson<int>(orden),
    };
  }

  Balota copyWith({int? partidaId, int? numero, int? orden}) => Balota(
    partidaId: partidaId ?? this.partidaId,
    numero: numero ?? this.numero,
    orden: orden ?? this.orden,
  );
  Balota copyWithCompanion(BalotasCompanion data) {
    return Balota(
      partidaId: data.partidaId.present ? data.partidaId.value : this.partidaId,
      numero: data.numero.present ? data.numero.value : this.numero,
      orden: data.orden.present ? data.orden.value : this.orden,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Balota(')
          ..write('partidaId: $partidaId, ')
          ..write('numero: $numero, ')
          ..write('orden: $orden')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(partidaId, numero, orden);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Balota &&
          other.partidaId == this.partidaId &&
          other.numero == this.numero &&
          other.orden == this.orden);
}

class BalotasCompanion extends UpdateCompanion<Balota> {
  final Value<int> partidaId;
  final Value<int> numero;
  final Value<int> orden;
  final Value<int> rowid;
  const BalotasCompanion({
    this.partidaId = const Value.absent(),
    this.numero = const Value.absent(),
    this.orden = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BalotasCompanion.insert({
    required int partidaId,
    required int numero,
    required int orden,
    this.rowid = const Value.absent(),
  }) : partidaId = Value(partidaId),
       numero = Value(numero),
       orden = Value(orden);
  static Insertable<Balota> custom({
    Expression<int>? partidaId,
    Expression<int>? numero,
    Expression<int>? orden,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (partidaId != null) 'partida_id': partidaId,
      if (numero != null) 'numero': numero,
      if (orden != null) 'orden': orden,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BalotasCompanion copyWith({
    Value<int>? partidaId,
    Value<int>? numero,
    Value<int>? orden,
    Value<int>? rowid,
  }) {
    return BalotasCompanion(
      partidaId: partidaId ?? this.partidaId,
      numero: numero ?? this.numero,
      orden: orden ?? this.orden,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (partidaId.present) {
      map['partida_id'] = Variable<int>(partidaId.value);
    }
    if (numero.present) {
      map['numero'] = Variable<int>(numero.value);
    }
    if (orden.present) {
      map['orden'] = Variable<int>(orden.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BalotasCompanion(')
          ..write('partidaId: $partidaId, ')
          ..write('numero: $numero, ')
          ..write('orden: $orden, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$BaseDatos extends GeneratedDatabase {
  _$BaseDatos(QueryExecutor e) : super(e);
  $BaseDatosManager get managers => $BaseDatosManager(this);
  late final $CartonesTable cartones = $CartonesTable(this);
  late final $PartidasTable partidas = $PartidasTable(this);
  late final $PartidaCartonesTable partidaCartones = $PartidaCartonesTable(
    this,
  );
  late final $BalotasTable balotas = $BalotasTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cartones,
    partidas,
    partidaCartones,
    balotas,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'partidas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('partida_cartones', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'cartones',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('partida_cartones', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'partidas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('balotas', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$CartonesTableCreateCompanionBuilder = CartonesCompanion Function({
  Value<int> id,
  required String alias,
  required String numeros,
  Value<String?> fotoPath,
  Value<DateTime> creadoEn,
});
typedef $$CartonesTableUpdateCompanionBuilder = CartonesCompanion Function({
  Value<int> id,
  Value<String> alias,
  Value<String> numeros,
  Value<String?> fotoPath,
  Value<DateTime> creadoEn,
});

final class $$CartonesTableReferences
    extends BaseReferences<_$BaseDatos, $CartonesTable, CartonRegistro> {
  $$CartonesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PartidaCartonesTable, List<PartidaCarton>>
  _partidaCartonesRefsTable(_$BaseDatos db) => MultiTypedResultKey.fromTable(
    db.partidaCartones,
    aliasName: 'cartones__id__partida_cartones__carton_id',
  );

  $$PartidaCartonesTableProcessedTableManager get partidaCartonesRefs {
    final manager = $$PartidaCartonesTableTableManager(
      $_db,
      $_db.partidaCartones,
    ).filter((f) => f.cartonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _partidaCartonesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CartonesTableFilterComposer
    extends Composer<_$BaseDatos, $CartonesTable> {
  $$CartonesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alias => $composableBuilder(
    column: $table.alias,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get numeros => $composableBuilder(
    column: $table.numeros,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fotoPath => $composableBuilder(
    column: $table.fotoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> partidaCartonesRefs(
    Expression<bool> Function($$PartidaCartonesTableFilterComposer f) f,
  ) {
    final $$PartidaCartonesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.partidaCartones,
      getReferencedColumn: (t) => t.cartonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartidaCartonesTableFilterComposer(
            $db: $db,
            $table: $db.partidaCartones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CartonesTableOrderingComposer
    extends Composer<_$BaseDatos, $CartonesTable> {
  $$CartonesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alias => $composableBuilder(
    column: $table.alias,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get numeros => $composableBuilder(
    column: $table.numeros,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fotoPath => $composableBuilder(
    column: $table.fotoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CartonesTableAnnotationComposer
    extends Composer<_$BaseDatos, $CartonesTable> {
  $$CartonesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get alias =>
      $composableBuilder(column: $table.alias, builder: (column) => column);

  GeneratedColumn<String> get numeros =>
      $composableBuilder(column: $table.numeros, builder: (column) => column);

  GeneratedColumn<String> get fotoPath =>
      $composableBuilder(column: $table.fotoPath, builder: (column) => column);

  GeneratedColumn<DateTime> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  Expression<T> partidaCartonesRefs<T extends Object>(
    Expression<T> Function($$PartidaCartonesTableAnnotationComposer a) f,
  ) {
    final $$PartidaCartonesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.partidaCartones,
      getReferencedColumn: (t) => t.cartonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartidaCartonesTableAnnotationComposer(
            $db: $db,
            $table: $db.partidaCartones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CartonesTableTableManager
    extends
        RootTableManager<
          _$BaseDatos,
          $CartonesTable,
          CartonRegistro,
          $$CartonesTableFilterComposer,
          $$CartonesTableOrderingComposer,
          $$CartonesTableAnnotationComposer,
          $$CartonesTableCreateCompanionBuilder,
          $$CartonesTableUpdateCompanionBuilder,
          (CartonRegistro, $$CartonesTableReferences),
          CartonRegistro,
          PrefetchHooks Function({bool partidaCartonesRefs})
        > {
  $$CartonesTableTableManager(_$BaseDatos db, $CartonesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CartonesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CartonesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CartonesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> alias = const Value.absent(),
                Value<String> numeros = const Value.absent(),
                Value<String?> fotoPath = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
              }) => CartonesCompanion(
                id: id,
                alias: alias,
                numeros: numeros,
                fotoPath: fotoPath,
                creadoEn: creadoEn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String alias,
                required String numeros,
                Value<String?> fotoPath = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
              }) => CartonesCompanion.insert(
                id: id,
                alias: alias,
                numeros: numeros,
                fotoPath: fotoPath,
                creadoEn: creadoEn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CartonesTable, CartonRegistro>(table),
                  $$CartonesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({partidaCartonesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (partidaCartonesRefs) db.partidaCartones,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (partidaCartonesRefs)
                    await $_getPrefetchedDataByColumns<
                      CartonRegistro,
                      $CartonesTable,
                      PartidaCarton,
                      $PartidaCartonesTable
                    >(
                      currentTable: table,
                      referencedTable: $$CartonesTableReferences
                          ._partidaCartonesRefsTable(db),
                      managerFromTypedResult: (p0) => $$CartonesTableReferences(
                        db,
                        table,
                        p0,
                      ).partidaCartonesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'carton_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CartonesTableProcessedTableManager =
    ProcessedTableManager<
      _$BaseDatos,
      $CartonesTable,
      CartonRegistro,
      $$CartonesTableFilterComposer,
      $$CartonesTableOrderingComposer,
      $$CartonesTableAnnotationComposer,
      $$CartonesTableCreateCompanionBuilder,
      $$CartonesTableUpdateCompanionBuilder,
      (CartonRegistro, $$CartonesTableReferences),
      CartonRegistro,
      PrefetchHooks Function({bool partidaCartonesRefs})
    >;
typedef $$PartidasTableCreateCompanionBuilder = PartidasCompanion Function({
  Value<int> id,
  required TipoJuego tipoJuego,
  Value<int?> columnaDesignada,
  Value<bool> finalizada,
  Value<DateTime> creadaEn,
});
typedef $$PartidasTableUpdateCompanionBuilder = PartidasCompanion Function({
  Value<int> id,
  Value<TipoJuego> tipoJuego,
  Value<int?> columnaDesignada,
  Value<bool> finalizada,
  Value<DateTime> creadaEn,
});

final class $$PartidasTableReferences
    extends BaseReferences<_$BaseDatos, $PartidasTable, PartidaRegistro> {
  $$PartidasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PartidaCartonesTable, List<PartidaCarton>>
  _partidaCartonesRefsTable(_$BaseDatos db) => MultiTypedResultKey.fromTable(
    db.partidaCartones,
    aliasName: 'partidas__id__partida_cartones__partida_id',
  );

  $$PartidaCartonesTableProcessedTableManager get partidaCartonesRefs {
    final manager = $$PartidaCartonesTableTableManager(
      $_db,
      $_db.partidaCartones,
    ).filter((f) => f.partidaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _partidaCartonesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BalotasTable, List<Balota>> _balotasRefsTable(
    _$BaseDatos db,
  ) => MultiTypedResultKey.fromTable(
    db.balotas,
    aliasName: 'partidas__id__balotas__partida_id',
  );

  $$BalotasTableProcessedTableManager get balotasRefs {
    final manager = $$BalotasTableTableManager(
      $_db,
      $_db.balotas,
    ).filter((f) => f.partidaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_balotasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PartidasTableFilterComposer
    extends Composer<_$BaseDatos, $PartidasTable> {
  $$PartidasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TipoJuego, TipoJuego, String> get tipoJuego =>
      $composableBuilder(
        column: $table.tipoJuego,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get columnaDesignada => $composableBuilder(
    column: $table.columnaDesignada,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get finalizada => $composableBuilder(
    column: $table.finalizada,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadaEn => $composableBuilder(
    column: $table.creadaEn,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> partidaCartonesRefs(
    Expression<bool> Function($$PartidaCartonesTableFilterComposer f) f,
  ) {
    final $$PartidaCartonesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.partidaCartones,
      getReferencedColumn: (t) => t.partidaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartidaCartonesTableFilterComposer(
            $db: $db,
            $table: $db.partidaCartones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> balotasRefs(
    Expression<bool> Function($$BalotasTableFilterComposer f) f,
  ) {
    final $$BalotasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.balotas,
      getReferencedColumn: (t) => t.partidaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BalotasTableFilterComposer(
            $db: $db,
            $table: $db.balotas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PartidasTableOrderingComposer
    extends Composer<_$BaseDatos, $PartidasTable> {
  $$PartidasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipoJuego => $composableBuilder(
    column: $table.tipoJuego,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get columnaDesignada => $composableBuilder(
    column: $table.columnaDesignada,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get finalizada => $composableBuilder(
    column: $table.finalizada,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadaEn => $composableBuilder(
    column: $table.creadaEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PartidasTableAnnotationComposer
    extends Composer<_$BaseDatos, $PartidasTable> {
  $$PartidasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TipoJuego, String> get tipoJuego =>
      $composableBuilder(column: $table.tipoJuego, builder: (column) => column);

  GeneratedColumn<int> get columnaDesignada => $composableBuilder(
    column: $table.columnaDesignada,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get finalizada => $composableBuilder(
    column: $table.finalizada,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get creadaEn =>
      $composableBuilder(column: $table.creadaEn, builder: (column) => column);

  Expression<T> partidaCartonesRefs<T extends Object>(
    Expression<T> Function($$PartidaCartonesTableAnnotationComposer a) f,
  ) {
    final $$PartidaCartonesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.partidaCartones,
      getReferencedColumn: (t) => t.partidaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartidaCartonesTableAnnotationComposer(
            $db: $db,
            $table: $db.partidaCartones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> balotasRefs<T extends Object>(
    Expression<T> Function($$BalotasTableAnnotationComposer a) f,
  ) {
    final $$BalotasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.balotas,
      getReferencedColumn: (t) => t.partidaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BalotasTableAnnotationComposer(
            $db: $db,
            $table: $db.balotas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PartidasTableTableManager
    extends
        RootTableManager<
          _$BaseDatos,
          $PartidasTable,
          PartidaRegistro,
          $$PartidasTableFilterComposer,
          $$PartidasTableOrderingComposer,
          $$PartidasTableAnnotationComposer,
          $$PartidasTableCreateCompanionBuilder,
          $$PartidasTableUpdateCompanionBuilder,
          (PartidaRegistro, $$PartidasTableReferences),
          PartidaRegistro,
          PrefetchHooks Function({bool partidaCartonesRefs, bool balotasRefs})
        > {
  $$PartidasTableTableManager(_$BaseDatos db, $PartidasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PartidasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PartidasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PartidasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<TipoJuego> tipoJuego = const Value.absent(),
                Value<int?> columnaDesignada = const Value.absent(),
                Value<bool> finalizada = const Value.absent(),
                Value<DateTime> creadaEn = const Value.absent(),
              }) => PartidasCompanion(
                id: id,
                tipoJuego: tipoJuego,
                columnaDesignada: columnaDesignada,
                finalizada: finalizada,
                creadaEn: creadaEn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required TipoJuego tipoJuego,
                Value<int?> columnaDesignada = const Value.absent(),
                Value<bool> finalizada = const Value.absent(),
                Value<DateTime> creadaEn = const Value.absent(),
              }) => PartidasCompanion.insert(
                id: id,
                tipoJuego: tipoJuego,
                columnaDesignada: columnaDesignada,
                finalizada: finalizada,
                creadaEn: creadaEn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PartidasTable, PartidaRegistro>(table),
                  $$PartidasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({partidaCartonesRefs = false, balotasRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (partidaCartonesRefs) db.partidaCartones,
                    if (balotasRefs) db.balotas,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (partidaCartonesRefs)
                        await $_getPrefetchedDataByColumns<
                          PartidaRegistro,
                          $PartidasTable,
                          PartidaCarton,
                          $PartidaCartonesTable
                        >(
                          currentTable: table,
                          referencedTable: $$PartidasTableReferences
                              ._partidaCartonesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PartidasTableReferences(
                                db,
                                table,
                                p0,
                              ).partidaCartonesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'partida_id',
                          typedResults: items,
                        ),
                      if (balotasRefs)
                        await $_getPrefetchedDataByColumns<
                          PartidaRegistro,
                          $PartidasTable,
                          Balota,
                          $BalotasTable
                        >(
                          currentTable: table,
                          referencedTable: $$PartidasTableReferences
                              ._balotasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PartidasTableReferences(
                                db,
                                table,
                                p0,
                              ).balotasRefs,
                          currentColumn: 'id',
                          referencedColumn: 'partida_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PartidasTableProcessedTableManager =
    ProcessedTableManager<
      _$BaseDatos,
      $PartidasTable,
      PartidaRegistro,
      $$PartidasTableFilterComposer,
      $$PartidasTableOrderingComposer,
      $$PartidasTableAnnotationComposer,
      $$PartidasTableCreateCompanionBuilder,
      $$PartidasTableUpdateCompanionBuilder,
      (PartidaRegistro, $$PartidasTableReferences),
      PartidaRegistro,
      PrefetchHooks Function({bool partidaCartonesRefs, bool balotasRefs})
    >;
typedef $$PartidaCartonesTableCreateCompanionBuilder =
    PartidaCartonesCompanion Function({
      required int partidaId,
      required int cartonId,
      Value<int> rowid,
    });
typedef $$PartidaCartonesTableUpdateCompanionBuilder =
    PartidaCartonesCompanion Function({
      Value<int> partidaId,
      Value<int> cartonId,
      Value<int> rowid,
    });

final class $$PartidaCartonesTableReferences
    extends BaseReferences<_$BaseDatos, $PartidaCartonesTable, PartidaCarton> {
  $$PartidaCartonesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PartidasTable _partidaIdTable(_$BaseDatos db) =>
      db.partidas.createAlias('partida_cartones__partida_id__partidas__id');

  $$PartidasTableProcessedTableManager get partidaId {
    final $_column = $_itemColumn<int>('partida_id')!;

    final manager = $$PartidasTableTableManager(
      $_db,
      $_db.partidas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_partidaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CartonesTable _cartonIdTable(_$BaseDatos db) =>
      db.cartones.createAlias('partida_cartones__carton_id__cartones__id');

  $$CartonesTableProcessedTableManager get cartonId {
    final $_column = $_itemColumn<int>('carton_id')!;

    final manager = $$CartonesTableTableManager(
      $_db,
      $_db.cartones,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cartonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PartidaCartonesTableFilterComposer
    extends Composer<_$BaseDatos, $PartidaCartonesTable> {
  $$PartidaCartonesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PartidasTableFilterComposer get partidaId {
    final $$PartidasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partidaId,
      referencedTable: $db.partidas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartidasTableFilterComposer(
            $db: $db,
            $table: $db.partidas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CartonesTableFilterComposer get cartonId {
    final $$CartonesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cartonId,
      referencedTable: $db.cartones,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CartonesTableFilterComposer(
            $db: $db,
            $table: $db.cartones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PartidaCartonesTableOrderingComposer
    extends Composer<_$BaseDatos, $PartidaCartonesTable> {
  $$PartidaCartonesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PartidasTableOrderingComposer get partidaId {
    final $$PartidasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partidaId,
      referencedTable: $db.partidas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartidasTableOrderingComposer(
            $db: $db,
            $table: $db.partidas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CartonesTableOrderingComposer get cartonId {
    final $$CartonesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cartonId,
      referencedTable: $db.cartones,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CartonesTableOrderingComposer(
            $db: $db,
            $table: $db.cartones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PartidaCartonesTableAnnotationComposer
    extends Composer<_$BaseDatos, $PartidaCartonesTable> {
  $$PartidaCartonesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PartidasTableAnnotationComposer get partidaId {
    final $$PartidasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partidaId,
      referencedTable: $db.partidas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartidasTableAnnotationComposer(
            $db: $db,
            $table: $db.partidas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CartonesTableAnnotationComposer get cartonId {
    final $$CartonesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cartonId,
      referencedTable: $db.cartones,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CartonesTableAnnotationComposer(
            $db: $db,
            $table: $db.cartones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PartidaCartonesTableTableManager
    extends
        RootTableManager<
          _$BaseDatos,
          $PartidaCartonesTable,
          PartidaCarton,
          $$PartidaCartonesTableFilterComposer,
          $$PartidaCartonesTableOrderingComposer,
          $$PartidaCartonesTableAnnotationComposer,
          $$PartidaCartonesTableCreateCompanionBuilder,
          $$PartidaCartonesTableUpdateCompanionBuilder,
          (PartidaCarton, $$PartidaCartonesTableReferences),
          PartidaCarton,
          PrefetchHooks Function({bool partidaId, bool cartonId})
        > {
  $$PartidaCartonesTableTableManager(
    _$BaseDatos db,
    $PartidaCartonesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PartidaCartonesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PartidaCartonesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PartidaCartonesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> partidaId = const Value.absent(),
                Value<int> cartonId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PartidaCartonesCompanion(
                partidaId: partidaId,
                cartonId: cartonId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int partidaId,
                required int cartonId,
                Value<int> rowid = const Value.absent(),
              }) => PartidaCartonesCompanion.insert(
                partidaId: partidaId,
                cartonId: cartonId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PartidaCartonesTable, PartidaCarton>(table),
                  $$PartidaCartonesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({partidaId = false, cartonId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (partidaId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.partidaId,
                        referencedTable: $$PartidaCartonesTableReferences
                            ._partidaIdTable(db),
                        referencedColumn: $$PartidaCartonesTableReferences
                            ._partidaIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (cartonId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.cartonId,
                        referencedTable: $$PartidaCartonesTableReferences
                            ._cartonIdTable(db),
                        referencedColumn: $$PartidaCartonesTableReferences
                            ._cartonIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PartidaCartonesTableProcessedTableManager =
    ProcessedTableManager<
      _$BaseDatos,
      $PartidaCartonesTable,
      PartidaCarton,
      $$PartidaCartonesTableFilterComposer,
      $$PartidaCartonesTableOrderingComposer,
      $$PartidaCartonesTableAnnotationComposer,
      $$PartidaCartonesTableCreateCompanionBuilder,
      $$PartidaCartonesTableUpdateCompanionBuilder,
      (PartidaCarton, $$PartidaCartonesTableReferences),
      PartidaCarton,
      PrefetchHooks Function({bool partidaId, bool cartonId})
    >;
typedef $$BalotasTableCreateCompanionBuilder = BalotasCompanion Function({
  required int partidaId,
  required int numero,
  required int orden,
  Value<int> rowid,
});
typedef $$BalotasTableUpdateCompanionBuilder = BalotasCompanion Function({
  Value<int> partidaId,
  Value<int> numero,
  Value<int> orden,
  Value<int> rowid,
});

final class $$BalotasTableReferences
    extends BaseReferences<_$BaseDatos, $BalotasTable, Balota> {
  $$BalotasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PartidasTable _partidaIdTable(_$BaseDatos db) =>
      db.partidas.createAlias('balotas__partida_id__partidas__id');

  $$PartidasTableProcessedTableManager get partidaId {
    final $_column = $_itemColumn<int>('partida_id')!;

    final manager = $$PartidasTableTableManager(
      $_db,
      $_db.partidas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_partidaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BalotasTableFilterComposer
    extends Composer<_$BaseDatos, $BalotasTable> {
  $$BalotasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get numero => $composableBuilder(
    column: $table.numero,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orden => $composableBuilder(
    column: $table.orden,
    builder: (column) => ColumnFilters(column),
  );

  $$PartidasTableFilterComposer get partidaId {
    final $$PartidasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partidaId,
      referencedTable: $db.partidas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartidasTableFilterComposer(
            $db: $db,
            $table: $db.partidas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BalotasTableOrderingComposer
    extends Composer<_$BaseDatos, $BalotasTable> {
  $$BalotasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get numero => $composableBuilder(
    column: $table.numero,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orden => $composableBuilder(
    column: $table.orden,
    builder: (column) => ColumnOrderings(column),
  );

  $$PartidasTableOrderingComposer get partidaId {
    final $$PartidasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partidaId,
      referencedTable: $db.partidas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartidasTableOrderingComposer(
            $db: $db,
            $table: $db.partidas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BalotasTableAnnotationComposer
    extends Composer<_$BaseDatos, $BalotasTable> {
  $$BalotasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get numero =>
      $composableBuilder(column: $table.numero, builder: (column) => column);

  GeneratedColumn<int> get orden =>
      $composableBuilder(column: $table.orden, builder: (column) => column);

  $$PartidasTableAnnotationComposer get partidaId {
    final $$PartidasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partidaId,
      referencedTable: $db.partidas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartidasTableAnnotationComposer(
            $db: $db,
            $table: $db.partidas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BalotasTableTableManager
    extends
        RootTableManager<
          _$BaseDatos,
          $BalotasTable,
          Balota,
          $$BalotasTableFilterComposer,
          $$BalotasTableOrderingComposer,
          $$BalotasTableAnnotationComposer,
          $$BalotasTableCreateCompanionBuilder,
          $$BalotasTableUpdateCompanionBuilder,
          (Balota, $$BalotasTableReferences),
          Balota,
          PrefetchHooks Function({bool partidaId})
        > {
  $$BalotasTableTableManager(_$BaseDatos db, $BalotasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BalotasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BalotasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BalotasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> partidaId = const Value.absent(),
                Value<int> numero = const Value.absent(),
                Value<int> orden = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BalotasCompanion(
                partidaId: partidaId,
                numero: numero,
                orden: orden,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int partidaId,
                required int numero,
                required int orden,
                Value<int> rowid = const Value.absent(),
              }) => BalotasCompanion.insert(
                partidaId: partidaId,
                numero: numero,
                orden: orden,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BalotasTable, Balota>(table),
                  $$BalotasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({partidaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (partidaId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.partidaId,
                        referencedTable: $$BalotasTableReferences
                            ._partidaIdTable(db),
                        referencedColumn: $$BalotasTableReferences
                            ._partidaIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BalotasTableProcessedTableManager =
    ProcessedTableManager<
      _$BaseDatos,
      $BalotasTable,
      Balota,
      $$BalotasTableFilterComposer,
      $$BalotasTableOrderingComposer,
      $$BalotasTableAnnotationComposer,
      $$BalotasTableCreateCompanionBuilder,
      $$BalotasTableUpdateCompanionBuilder,
      (Balota, $$BalotasTableReferences),
      Balota,
      PrefetchHooks Function({bool partidaId})
    >;

class $BaseDatosManager {
  final _$BaseDatos _db;
  $BaseDatosManager(this._db);
  $$CartonesTableTableManager get cartones =>
      $$CartonesTableTableManager(_db, _db.cartones);
  $$PartidasTableTableManager get partidas =>
      $$PartidasTableTableManager(_db, _db.partidas);
  $$PartidaCartonesTableTableManager get partidaCartones =>
      $$PartidaCartonesTableTableManager(_db, _db.partidaCartones);
  $$BalotasTableTableManager get balotas =>
      $$BalotasTableTableManager(_db, _db.balotas);
}
