// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BibleBooksTable extends BibleBooks
    with TableInfo<$BibleBooksTable, BibleBook> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BibleBooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameKoreanMeta = const VerificationMeta(
    'nameKorean',
  );
  @override
  late final GeneratedColumn<String> nameKorean = GeneratedColumn<String>(
    'name_korean',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 40,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _abbreviationMeta = const VerificationMeta(
    'abbreviation',
  );
  @override
  late final GeneratedColumn<String> abbreviation = GeneratedColumn<String>(
    'abbreviation',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _abbreviationKoreanMeta =
      const VerificationMeta('abbreviationKorean');
  @override
  late final GeneratedColumn<String> abbreviationKorean =
      GeneratedColumn<String>(
        'abbreviation_korean',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 1,
          maxTextLength: 10,
        ),
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _testamentMeta = const VerificationMeta(
    'testament',
  );
  @override
  late final GeneratedColumn<String> testament = GeneratedColumn<String>(
    'testament',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 2,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapterCountMeta = const VerificationMeta(
    'chapterCount',
  );
  @override
  late final GeneratedColumn<int> chapterCount = GeneratedColumn<int>(
    'chapter_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    nameKorean,
    abbreviation,
    abbreviationKorean,
    testament,
    orderIndex,
    chapterCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bible_books';
  @override
  VerificationContext validateIntegrity(
    Insertable<BibleBook> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('name_korean')) {
      context.handle(
        _nameKoreanMeta,
        nameKorean.isAcceptableOrUnknown(data['name_korean']!, _nameKoreanMeta),
      );
    } else if (isInserting) {
      context.missing(_nameKoreanMeta);
    }
    if (data.containsKey('abbreviation')) {
      context.handle(
        _abbreviationMeta,
        abbreviation.isAcceptableOrUnknown(
          data['abbreviation']!,
          _abbreviationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_abbreviationMeta);
    }
    if (data.containsKey('abbreviation_korean')) {
      context.handle(
        _abbreviationKoreanMeta,
        abbreviationKorean.isAcceptableOrUnknown(
          data['abbreviation_korean']!,
          _abbreviationKoreanMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_abbreviationKoreanMeta);
    }
    if (data.containsKey('testament')) {
      context.handle(
        _testamentMeta,
        testament.isAcceptableOrUnknown(data['testament']!, _testamentMeta),
      );
    } else if (isInserting) {
      context.missing(_testamentMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('chapter_count')) {
      context.handle(
        _chapterCountMeta,
        chapterCount.isAcceptableOrUnknown(
          data['chapter_count']!,
          _chapterCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_chapterCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BibleBook map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BibleBook(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      nameKorean:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name_korean'],
          )!,
      abbreviation:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}abbreviation'],
          )!,
      abbreviationKorean:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}abbreviation_korean'],
          )!,
      testament:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}testament'],
          )!,
      orderIndex:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}order_index'],
          )!,
      chapterCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}chapter_count'],
          )!,
    );
  }

  @override
  $BibleBooksTable createAlias(String alias) {
    return $BibleBooksTable(attachedDatabase, alias);
  }
}

class BibleBook extends DataClass implements Insertable<BibleBook> {
  final int id;
  final String name;
  final String nameKorean;
  final String abbreviation;
  final String abbreviationKorean;
  final String testament;
  final int orderIndex;
  final int chapterCount;
  const BibleBook({
    required this.id,
    required this.name,
    required this.nameKorean,
    required this.abbreviation,
    required this.abbreviationKorean,
    required this.testament,
    required this.orderIndex,
    required this.chapterCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['name_korean'] = Variable<String>(nameKorean);
    map['abbreviation'] = Variable<String>(abbreviation);
    map['abbreviation_korean'] = Variable<String>(abbreviationKorean);
    map['testament'] = Variable<String>(testament);
    map['order_index'] = Variable<int>(orderIndex);
    map['chapter_count'] = Variable<int>(chapterCount);
    return map;
  }

  BibleBooksCompanion toCompanion(bool nullToAbsent) {
    return BibleBooksCompanion(
      id: Value(id),
      name: Value(name),
      nameKorean: Value(nameKorean),
      abbreviation: Value(abbreviation),
      abbreviationKorean: Value(abbreviationKorean),
      testament: Value(testament),
      orderIndex: Value(orderIndex),
      chapterCount: Value(chapterCount),
    );
  }

  factory BibleBook.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BibleBook(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      nameKorean: serializer.fromJson<String>(json['nameKorean']),
      abbreviation: serializer.fromJson<String>(json['abbreviation']),
      abbreviationKorean: serializer.fromJson<String>(
        json['abbreviationKorean'],
      ),
      testament: serializer.fromJson<String>(json['testament']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      chapterCount: serializer.fromJson<int>(json['chapterCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'nameKorean': serializer.toJson<String>(nameKorean),
      'abbreviation': serializer.toJson<String>(abbreviation),
      'abbreviationKorean': serializer.toJson<String>(abbreviationKorean),
      'testament': serializer.toJson<String>(testament),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'chapterCount': serializer.toJson<int>(chapterCount),
    };
  }

  BibleBook copyWith({
    int? id,
    String? name,
    String? nameKorean,
    String? abbreviation,
    String? abbreviationKorean,
    String? testament,
    int? orderIndex,
    int? chapterCount,
  }) => BibleBook(
    id: id ?? this.id,
    name: name ?? this.name,
    nameKorean: nameKorean ?? this.nameKorean,
    abbreviation: abbreviation ?? this.abbreviation,
    abbreviationKorean: abbreviationKorean ?? this.abbreviationKorean,
    testament: testament ?? this.testament,
    orderIndex: orderIndex ?? this.orderIndex,
    chapterCount: chapterCount ?? this.chapterCount,
  );
  BibleBook copyWithCompanion(BibleBooksCompanion data) {
    return BibleBook(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      nameKorean:
          data.nameKorean.present ? data.nameKorean.value : this.nameKorean,
      abbreviation:
          data.abbreviation.present
              ? data.abbreviation.value
              : this.abbreviation,
      abbreviationKorean:
          data.abbreviationKorean.present
              ? data.abbreviationKorean.value
              : this.abbreviationKorean,
      testament: data.testament.present ? data.testament.value : this.testament,
      orderIndex:
          data.orderIndex.present ? data.orderIndex.value : this.orderIndex,
      chapterCount:
          data.chapterCount.present
              ? data.chapterCount.value
              : this.chapterCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BibleBook(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameKorean: $nameKorean, ')
          ..write('abbreviation: $abbreviation, ')
          ..write('abbreviationKorean: $abbreviationKorean, ')
          ..write('testament: $testament, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('chapterCount: $chapterCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    nameKorean,
    abbreviation,
    abbreviationKorean,
    testament,
    orderIndex,
    chapterCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BibleBook &&
          other.id == this.id &&
          other.name == this.name &&
          other.nameKorean == this.nameKorean &&
          other.abbreviation == this.abbreviation &&
          other.abbreviationKorean == this.abbreviationKorean &&
          other.testament == this.testament &&
          other.orderIndex == this.orderIndex &&
          other.chapterCount == this.chapterCount);
}

class BibleBooksCompanion extends UpdateCompanion<BibleBook> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> nameKorean;
  final Value<String> abbreviation;
  final Value<String> abbreviationKorean;
  final Value<String> testament;
  final Value<int> orderIndex;
  final Value<int> chapterCount;
  const BibleBooksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.nameKorean = const Value.absent(),
    this.abbreviation = const Value.absent(),
    this.abbreviationKorean = const Value.absent(),
    this.testament = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.chapterCount = const Value.absent(),
  });
  BibleBooksCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String nameKorean,
    required String abbreviation,
    required String abbreviationKorean,
    required String testament,
    required int orderIndex,
    required int chapterCount,
  }) : name = Value(name),
       nameKorean = Value(nameKorean),
       abbreviation = Value(abbreviation),
       abbreviationKorean = Value(abbreviationKorean),
       testament = Value(testament),
       orderIndex = Value(orderIndex),
       chapterCount = Value(chapterCount);
  static Insertable<BibleBook> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? nameKorean,
    Expression<String>? abbreviation,
    Expression<String>? abbreviationKorean,
    Expression<String>? testament,
    Expression<int>? orderIndex,
    Expression<int>? chapterCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (nameKorean != null) 'name_korean': nameKorean,
      if (abbreviation != null) 'abbreviation': abbreviation,
      if (abbreviationKorean != null) 'abbreviation_korean': abbreviationKorean,
      if (testament != null) 'testament': testament,
      if (orderIndex != null) 'order_index': orderIndex,
      if (chapterCount != null) 'chapter_count': chapterCount,
    });
  }

  BibleBooksCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? nameKorean,
    Value<String>? abbreviation,
    Value<String>? abbreviationKorean,
    Value<String>? testament,
    Value<int>? orderIndex,
    Value<int>? chapterCount,
  }) {
    return BibleBooksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      nameKorean: nameKorean ?? this.nameKorean,
      abbreviation: abbreviation ?? this.abbreviation,
      abbreviationKorean: abbreviationKorean ?? this.abbreviationKorean,
      testament: testament ?? this.testament,
      orderIndex: orderIndex ?? this.orderIndex,
      chapterCount: chapterCount ?? this.chapterCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nameKorean.present) {
      map['name_korean'] = Variable<String>(nameKorean.value);
    }
    if (abbreviation.present) {
      map['abbreviation'] = Variable<String>(abbreviation.value);
    }
    if (abbreviationKorean.present) {
      map['abbreviation_korean'] = Variable<String>(abbreviationKorean.value);
    }
    if (testament.present) {
      map['testament'] = Variable<String>(testament.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (chapterCount.present) {
      map['chapter_count'] = Variable<int>(chapterCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BibleBooksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameKorean: $nameKorean, ')
          ..write('abbreviation: $abbreviation, ')
          ..write('abbreviationKorean: $abbreviationKorean, ')
          ..write('testament: $testament, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('chapterCount: $chapterCount')
          ..write(')'))
        .toString();
  }
}

class $BibleTranslationsTable extends BibleTranslations
    with TableInfo<$BibleTranslationsTable, BibleTranslation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BibleTranslationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 5,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _copyrightMeta = const VerificationMeta(
    'copyright',
  );
  @override
  late final GeneratedColumn<String> copyright = GeneratedColumn<String>(
    'copyright',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalVersesMeta = const VerificationMeta(
    'totalVerses',
  );
  @override
  late final GeneratedColumn<int> totalVerses = GeneratedColumn<int>(
    'total_verses',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    code,
    name,
    language,
    copyright,
    totalVerses,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bible_translations';
  @override
  VerificationContext validateIntegrity(
    Insertable<BibleTranslation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('copyright')) {
      context.handle(
        _copyrightMeta,
        copyright.isAcceptableOrUnknown(data['copyright']!, _copyrightMeta),
      );
    } else if (isInserting) {
      context.missing(_copyrightMeta);
    }
    if (data.containsKey('total_verses')) {
      context.handle(
        _totalVersesMeta,
        totalVerses.isAcceptableOrUnknown(
          data['total_verses']!,
          _totalVersesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {code};
  @override
  BibleTranslation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BibleTranslation(
      code:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}code'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      language:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}language'],
          )!,
      copyright:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}copyright'],
          )!,
      totalVerses:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}total_verses'],
          )!,
    );
  }

  @override
  $BibleTranslationsTable createAlias(String alias) {
    return $BibleTranslationsTable(attachedDatabase, alias);
  }
}

class BibleTranslation extends DataClass
    implements Insertable<BibleTranslation> {
  final String code;
  final String name;
  final String language;
  final String copyright;
  final int totalVerses;
  const BibleTranslation({
    required this.code,
    required this.name,
    required this.language,
    required this.copyright,
    required this.totalVerses,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['language'] = Variable<String>(language);
    map['copyright'] = Variable<String>(copyright);
    map['total_verses'] = Variable<int>(totalVerses);
    return map;
  }

  BibleTranslationsCompanion toCompanion(bool nullToAbsent) {
    return BibleTranslationsCompanion(
      code: Value(code),
      name: Value(name),
      language: Value(language),
      copyright: Value(copyright),
      totalVerses: Value(totalVerses),
    );
  }

  factory BibleTranslation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BibleTranslation(
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      language: serializer.fromJson<String>(json['language']),
      copyright: serializer.fromJson<String>(json['copyright']),
      totalVerses: serializer.fromJson<int>(json['totalVerses']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'language': serializer.toJson<String>(language),
      'copyright': serializer.toJson<String>(copyright),
      'totalVerses': serializer.toJson<int>(totalVerses),
    };
  }

  BibleTranslation copyWith({
    String? code,
    String? name,
    String? language,
    String? copyright,
    int? totalVerses,
  }) => BibleTranslation(
    code: code ?? this.code,
    name: name ?? this.name,
    language: language ?? this.language,
    copyright: copyright ?? this.copyright,
    totalVerses: totalVerses ?? this.totalVerses,
  );
  BibleTranslation copyWithCompanion(BibleTranslationsCompanion data) {
    return BibleTranslation(
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      language: data.language.present ? data.language.value : this.language,
      copyright: data.copyright.present ? data.copyright.value : this.copyright,
      totalVerses:
          data.totalVerses.present ? data.totalVerses.value : this.totalVerses,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BibleTranslation(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('language: $language, ')
          ..write('copyright: $copyright, ')
          ..write('totalVerses: $totalVerses')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, name, language, copyright, totalVerses);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BibleTranslation &&
          other.code == this.code &&
          other.name == this.name &&
          other.language == this.language &&
          other.copyright == this.copyright &&
          other.totalVerses == this.totalVerses);
}

class BibleTranslationsCompanion extends UpdateCompanion<BibleTranslation> {
  final Value<String> code;
  final Value<String> name;
  final Value<String> language;
  final Value<String> copyright;
  final Value<int> totalVerses;
  final Value<int> rowid;
  const BibleTranslationsCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.language = const Value.absent(),
    this.copyright = const Value.absent(),
    this.totalVerses = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BibleTranslationsCompanion.insert({
    required String code,
    required String name,
    required String language,
    required String copyright,
    this.totalVerses = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : code = Value(code),
       name = Value(name),
       language = Value(language),
       copyright = Value(copyright);
  static Insertable<BibleTranslation> custom({
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? language,
    Expression<String>? copyright,
    Expression<int>? totalVerses,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (language != null) 'language': language,
      if (copyright != null) 'copyright': copyright,
      if (totalVerses != null) 'total_verses': totalVerses,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BibleTranslationsCompanion copyWith({
    Value<String>? code,
    Value<String>? name,
    Value<String>? language,
    Value<String>? copyright,
    Value<int>? totalVerses,
    Value<int>? rowid,
  }) {
    return BibleTranslationsCompanion(
      code: code ?? this.code,
      name: name ?? this.name,
      language: language ?? this.language,
      copyright: copyright ?? this.copyright,
      totalVerses: totalVerses ?? this.totalVerses,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (copyright.present) {
      map['copyright'] = Variable<String>(copyright.value);
    }
    if (totalVerses.present) {
      map['total_verses'] = Variable<int>(totalVerses.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BibleTranslationsCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('language: $language, ')
          ..write('copyright: $copyright, ')
          ..write('totalVerses: $totalVerses, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VerseTranslationsTable extends VerseTranslations
    with TableInfo<$VerseTranslationsTable, VerseTranslation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VerseTranslationsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _translationCodeMeta = const VerificationMeta(
    'translationCode',
  );
  @override
  late final GeneratedColumn<String> translationCode = GeneratedColumn<String>(
    'translation_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapterMeta = const VerificationMeta(
    'chapter',
  );
  @override
  late final GeneratedColumn<int> chapter = GeneratedColumn<int>(
    'chapter',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _verseMeta = const VerificationMeta('verse');
  @override
  late final GeneratedColumn<int> verse = GeneratedColumn<int>(
    'verse',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textContentMeta = const VerificationMeta(
    'textContent',
  );
  @override
  late final GeneratedColumn<String> textContent = GeneratedColumn<String>(
    'text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _strongRefsMeta = const VerificationMeta(
    'strongRefs',
  );
  @override
  late final GeneratedColumn<String> strongRefs = GeneratedColumn<String>(
    'strong_refs',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    translationCode,
    bookId,
    chapter,
    verse,
    textContent,
    strongRefs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'verse_translations';
  @override
  VerificationContext validateIntegrity(
    Insertable<VerseTranslation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('translation_code')) {
      context.handle(
        _translationCodeMeta,
        translationCode.isAcceptableOrUnknown(
          data['translation_code']!,
          _translationCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_translationCodeMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('chapter')) {
      context.handle(
        _chapterMeta,
        chapter.isAcceptableOrUnknown(data['chapter']!, _chapterMeta),
      );
    } else if (isInserting) {
      context.missing(_chapterMeta);
    }
    if (data.containsKey('verse')) {
      context.handle(
        _verseMeta,
        verse.isAcceptableOrUnknown(data['verse']!, _verseMeta),
      );
    } else if (isInserting) {
      context.missing(_verseMeta);
    }
    if (data.containsKey('text')) {
      context.handle(
        _textContentMeta,
        textContent.isAcceptableOrUnknown(data['text']!, _textContentMeta),
      );
    } else if (isInserting) {
      context.missing(_textContentMeta);
    }
    if (data.containsKey('strong_refs')) {
      context.handle(
        _strongRefsMeta,
        strongRefs.isAcceptableOrUnknown(data['strong_refs']!, _strongRefsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {translationCode, bookId, chapter, verse},
  ];
  @override
  VerseTranslation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VerseTranslation(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      translationCode:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}translation_code'],
          )!,
      bookId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}book_id'],
          )!,
      chapter:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}chapter'],
          )!,
      verse:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}verse'],
          )!,
      textContent:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}text'],
          )!,
      strongRefs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}strong_refs'],
      ),
    );
  }

  @override
  $VerseTranslationsTable createAlias(String alias) {
    return $VerseTranslationsTable(attachedDatabase, alias);
  }
}

class VerseTranslation extends DataClass
    implements Insertable<VerseTranslation> {
  final int id;
  final String translationCode;
  final int bookId;
  final int chapter;
  final int verse;
  final String textContent;
  final String? strongRefs;
  const VerseTranslation({
    required this.id,
    required this.translationCode,
    required this.bookId,
    required this.chapter,
    required this.verse,
    required this.textContent,
    this.strongRefs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['translation_code'] = Variable<String>(translationCode);
    map['book_id'] = Variable<int>(bookId);
    map['chapter'] = Variable<int>(chapter);
    map['verse'] = Variable<int>(verse);
    map['text'] = Variable<String>(textContent);
    if (!nullToAbsent || strongRefs != null) {
      map['strong_refs'] = Variable<String>(strongRefs);
    }
    return map;
  }

  VerseTranslationsCompanion toCompanion(bool nullToAbsent) {
    return VerseTranslationsCompanion(
      id: Value(id),
      translationCode: Value(translationCode),
      bookId: Value(bookId),
      chapter: Value(chapter),
      verse: Value(verse),
      textContent: Value(textContent),
      strongRefs:
          strongRefs == null && nullToAbsent
              ? const Value.absent()
              : Value(strongRefs),
    );
  }

  factory VerseTranslation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VerseTranslation(
      id: serializer.fromJson<int>(json['id']),
      translationCode: serializer.fromJson<String>(json['translationCode']),
      bookId: serializer.fromJson<int>(json['bookId']),
      chapter: serializer.fromJson<int>(json['chapter']),
      verse: serializer.fromJson<int>(json['verse']),
      textContent: serializer.fromJson<String>(json['textContent']),
      strongRefs: serializer.fromJson<String?>(json['strongRefs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'translationCode': serializer.toJson<String>(translationCode),
      'bookId': serializer.toJson<int>(bookId),
      'chapter': serializer.toJson<int>(chapter),
      'verse': serializer.toJson<int>(verse),
      'textContent': serializer.toJson<String>(textContent),
      'strongRefs': serializer.toJson<String?>(strongRefs),
    };
  }

  VerseTranslation copyWith({
    int? id,
    String? translationCode,
    int? bookId,
    int? chapter,
    int? verse,
    String? textContent,
    Value<String?> strongRefs = const Value.absent(),
  }) => VerseTranslation(
    id: id ?? this.id,
    translationCode: translationCode ?? this.translationCode,
    bookId: bookId ?? this.bookId,
    chapter: chapter ?? this.chapter,
    verse: verse ?? this.verse,
    textContent: textContent ?? this.textContent,
    strongRefs: strongRefs.present ? strongRefs.value : this.strongRefs,
  );
  VerseTranslation copyWithCompanion(VerseTranslationsCompanion data) {
    return VerseTranslation(
      id: data.id.present ? data.id.value : this.id,
      translationCode:
          data.translationCode.present
              ? data.translationCode.value
              : this.translationCode,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      chapter: data.chapter.present ? data.chapter.value : this.chapter,
      verse: data.verse.present ? data.verse.value : this.verse,
      textContent:
          data.textContent.present ? data.textContent.value : this.textContent,
      strongRefs:
          data.strongRefs.present ? data.strongRefs.value : this.strongRefs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VerseTranslation(')
          ..write('id: $id, ')
          ..write('translationCode: $translationCode, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse, ')
          ..write('textContent: $textContent, ')
          ..write('strongRefs: $strongRefs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    translationCode,
    bookId,
    chapter,
    verse,
    textContent,
    strongRefs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VerseTranslation &&
          other.id == this.id &&
          other.translationCode == this.translationCode &&
          other.bookId == this.bookId &&
          other.chapter == this.chapter &&
          other.verse == this.verse &&
          other.textContent == this.textContent &&
          other.strongRefs == this.strongRefs);
}

class VerseTranslationsCompanion extends UpdateCompanion<VerseTranslation> {
  final Value<int> id;
  final Value<String> translationCode;
  final Value<int> bookId;
  final Value<int> chapter;
  final Value<int> verse;
  final Value<String> textContent;
  final Value<String?> strongRefs;
  const VerseTranslationsCompanion({
    this.id = const Value.absent(),
    this.translationCode = const Value.absent(),
    this.bookId = const Value.absent(),
    this.chapter = const Value.absent(),
    this.verse = const Value.absent(),
    this.textContent = const Value.absent(),
    this.strongRefs = const Value.absent(),
  });
  VerseTranslationsCompanion.insert({
    this.id = const Value.absent(),
    required String translationCode,
    required int bookId,
    required int chapter,
    required int verse,
    required String textContent,
    this.strongRefs = const Value.absent(),
  }) : translationCode = Value(translationCode),
       bookId = Value(bookId),
       chapter = Value(chapter),
       verse = Value(verse),
       textContent = Value(textContent);
  static Insertable<VerseTranslation> custom({
    Expression<int>? id,
    Expression<String>? translationCode,
    Expression<int>? bookId,
    Expression<int>? chapter,
    Expression<int>? verse,
    Expression<String>? textContent,
    Expression<String>? strongRefs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (translationCode != null) 'translation_code': translationCode,
      if (bookId != null) 'book_id': bookId,
      if (chapter != null) 'chapter': chapter,
      if (verse != null) 'verse': verse,
      if (textContent != null) 'text': textContent,
      if (strongRefs != null) 'strong_refs': strongRefs,
    });
  }

  VerseTranslationsCompanion copyWith({
    Value<int>? id,
    Value<String>? translationCode,
    Value<int>? bookId,
    Value<int>? chapter,
    Value<int>? verse,
    Value<String>? textContent,
    Value<String?>? strongRefs,
  }) {
    return VerseTranslationsCompanion(
      id: id ?? this.id,
      translationCode: translationCode ?? this.translationCode,
      bookId: bookId ?? this.bookId,
      chapter: chapter ?? this.chapter,
      verse: verse ?? this.verse,
      textContent: textContent ?? this.textContent,
      strongRefs: strongRefs ?? this.strongRefs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (translationCode.present) {
      map['translation_code'] = Variable<String>(translationCode.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (chapter.present) {
      map['chapter'] = Variable<int>(chapter.value);
    }
    if (verse.present) {
      map['verse'] = Variable<int>(verse.value);
    }
    if (textContent.present) {
      map['text'] = Variable<String>(textContent.value);
    }
    if (strongRefs.present) {
      map['strong_refs'] = Variable<String>(strongRefs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VerseTranslationsCompanion(')
          ..write('id: $id, ')
          ..write('translationCode: $translationCode, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse, ')
          ..write('textContent: $textContent, ')
          ..write('strongRefs: $strongRefs')
          ..write(')'))
        .toString();
  }
}

class $CrossReferencesTable extends CrossReferences
    with TableInfo<$CrossReferencesTable, CrossReference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CrossReferencesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _fromBookIdMeta = const VerificationMeta(
    'fromBookId',
  );
  @override
  late final GeneratedColumn<int> fromBookId = GeneratedColumn<int>(
    'from_book_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fromChapterMeta = const VerificationMeta(
    'fromChapter',
  );
  @override
  late final GeneratedColumn<int> fromChapter = GeneratedColumn<int>(
    'from_chapter',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fromVerseMeta = const VerificationMeta(
    'fromVerse',
  );
  @override
  late final GeneratedColumn<int> fromVerse = GeneratedColumn<int>(
    'from_verse',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toBookIdMeta = const VerificationMeta(
    'toBookId',
  );
  @override
  late final GeneratedColumn<int> toBookId = GeneratedColumn<int>(
    'to_book_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toChapterMeta = const VerificationMeta(
    'toChapter',
  );
  @override
  late final GeneratedColumn<int> toChapter = GeneratedColumn<int>(
    'to_chapter',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toVerseMeta = const VerificationMeta(
    'toVerse',
  );
  @override
  late final GeneratedColumn<int> toVerse = GeneratedColumn<int>(
    'to_verse',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toVerseEndMeta = const VerificationMeta(
    'toVerseEnd',
  );
  @override
  late final GeneratedColumn<int> toVerseEnd = GeneratedColumn<int>(
    'to_verse_end',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rankMeta = const VerificationMeta('rank');
  @override
  late final GeneratedColumn<double> rank = GeneratedColumn<double>(
    'rank',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fromBookId,
    fromChapter,
    fromVerse,
    toBookId,
    toChapter,
    toVerse,
    toVerseEnd,
    rank,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cross_references';
  @override
  VerificationContext validateIntegrity(
    Insertable<CrossReference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('from_book_id')) {
      context.handle(
        _fromBookIdMeta,
        fromBookId.isAcceptableOrUnknown(
          data['from_book_id']!,
          _fromBookIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fromBookIdMeta);
    }
    if (data.containsKey('from_chapter')) {
      context.handle(
        _fromChapterMeta,
        fromChapter.isAcceptableOrUnknown(
          data['from_chapter']!,
          _fromChapterMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fromChapterMeta);
    }
    if (data.containsKey('from_verse')) {
      context.handle(
        _fromVerseMeta,
        fromVerse.isAcceptableOrUnknown(data['from_verse']!, _fromVerseMeta),
      );
    } else if (isInserting) {
      context.missing(_fromVerseMeta);
    }
    if (data.containsKey('to_book_id')) {
      context.handle(
        _toBookIdMeta,
        toBookId.isAcceptableOrUnknown(data['to_book_id']!, _toBookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_toBookIdMeta);
    }
    if (data.containsKey('to_chapter')) {
      context.handle(
        _toChapterMeta,
        toChapter.isAcceptableOrUnknown(data['to_chapter']!, _toChapterMeta),
      );
    } else if (isInserting) {
      context.missing(_toChapterMeta);
    }
    if (data.containsKey('to_verse')) {
      context.handle(
        _toVerseMeta,
        toVerse.isAcceptableOrUnknown(data['to_verse']!, _toVerseMeta),
      );
    } else if (isInserting) {
      context.missing(_toVerseMeta);
    }
    if (data.containsKey('to_verse_end')) {
      context.handle(
        _toVerseEndMeta,
        toVerseEnd.isAcceptableOrUnknown(
          data['to_verse_end']!,
          _toVerseEndMeta,
        ),
      );
    }
    if (data.containsKey('rank')) {
      context.handle(
        _rankMeta,
        rank.isAcceptableOrUnknown(data['rank']!, _rankMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CrossReference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CrossReference(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      fromBookId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}from_book_id'],
          )!,
      fromChapter:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}from_chapter'],
          )!,
      fromVerse:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}from_verse'],
          )!,
      toBookId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}to_book_id'],
          )!,
      toChapter:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}to_chapter'],
          )!,
      toVerse:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}to_verse'],
          )!,
      toVerseEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}to_verse_end'],
      ),
      rank:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}rank'],
          )!,
    );
  }

  @override
  $CrossReferencesTable createAlias(String alias) {
    return $CrossReferencesTable(attachedDatabase, alias);
  }
}

class CrossReference extends DataClass implements Insertable<CrossReference> {
  final int id;
  final int fromBookId;
  final int fromChapter;
  final int fromVerse;
  final int toBookId;
  final int toChapter;
  final int toVerse;
  final int? toVerseEnd;
  final double rank;
  const CrossReference({
    required this.id,
    required this.fromBookId,
    required this.fromChapter,
    required this.fromVerse,
    required this.toBookId,
    required this.toChapter,
    required this.toVerse,
    this.toVerseEnd,
    required this.rank,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['from_book_id'] = Variable<int>(fromBookId);
    map['from_chapter'] = Variable<int>(fromChapter);
    map['from_verse'] = Variable<int>(fromVerse);
    map['to_book_id'] = Variable<int>(toBookId);
    map['to_chapter'] = Variable<int>(toChapter);
    map['to_verse'] = Variable<int>(toVerse);
    if (!nullToAbsent || toVerseEnd != null) {
      map['to_verse_end'] = Variable<int>(toVerseEnd);
    }
    map['rank'] = Variable<double>(rank);
    return map;
  }

  CrossReferencesCompanion toCompanion(bool nullToAbsent) {
    return CrossReferencesCompanion(
      id: Value(id),
      fromBookId: Value(fromBookId),
      fromChapter: Value(fromChapter),
      fromVerse: Value(fromVerse),
      toBookId: Value(toBookId),
      toChapter: Value(toChapter),
      toVerse: Value(toVerse),
      toVerseEnd:
          toVerseEnd == null && nullToAbsent
              ? const Value.absent()
              : Value(toVerseEnd),
      rank: Value(rank),
    );
  }

  factory CrossReference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CrossReference(
      id: serializer.fromJson<int>(json['id']),
      fromBookId: serializer.fromJson<int>(json['fromBookId']),
      fromChapter: serializer.fromJson<int>(json['fromChapter']),
      fromVerse: serializer.fromJson<int>(json['fromVerse']),
      toBookId: serializer.fromJson<int>(json['toBookId']),
      toChapter: serializer.fromJson<int>(json['toChapter']),
      toVerse: serializer.fromJson<int>(json['toVerse']),
      toVerseEnd: serializer.fromJson<int?>(json['toVerseEnd']),
      rank: serializer.fromJson<double>(json['rank']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fromBookId': serializer.toJson<int>(fromBookId),
      'fromChapter': serializer.toJson<int>(fromChapter),
      'fromVerse': serializer.toJson<int>(fromVerse),
      'toBookId': serializer.toJson<int>(toBookId),
      'toChapter': serializer.toJson<int>(toChapter),
      'toVerse': serializer.toJson<int>(toVerse),
      'toVerseEnd': serializer.toJson<int?>(toVerseEnd),
      'rank': serializer.toJson<double>(rank),
    };
  }

  CrossReference copyWith({
    int? id,
    int? fromBookId,
    int? fromChapter,
    int? fromVerse,
    int? toBookId,
    int? toChapter,
    int? toVerse,
    Value<int?> toVerseEnd = const Value.absent(),
    double? rank,
  }) => CrossReference(
    id: id ?? this.id,
    fromBookId: fromBookId ?? this.fromBookId,
    fromChapter: fromChapter ?? this.fromChapter,
    fromVerse: fromVerse ?? this.fromVerse,
    toBookId: toBookId ?? this.toBookId,
    toChapter: toChapter ?? this.toChapter,
    toVerse: toVerse ?? this.toVerse,
    toVerseEnd: toVerseEnd.present ? toVerseEnd.value : this.toVerseEnd,
    rank: rank ?? this.rank,
  );
  CrossReference copyWithCompanion(CrossReferencesCompanion data) {
    return CrossReference(
      id: data.id.present ? data.id.value : this.id,
      fromBookId:
          data.fromBookId.present ? data.fromBookId.value : this.fromBookId,
      fromChapter:
          data.fromChapter.present ? data.fromChapter.value : this.fromChapter,
      fromVerse: data.fromVerse.present ? data.fromVerse.value : this.fromVerse,
      toBookId: data.toBookId.present ? data.toBookId.value : this.toBookId,
      toChapter: data.toChapter.present ? data.toChapter.value : this.toChapter,
      toVerse: data.toVerse.present ? data.toVerse.value : this.toVerse,
      toVerseEnd:
          data.toVerseEnd.present ? data.toVerseEnd.value : this.toVerseEnd,
      rank: data.rank.present ? data.rank.value : this.rank,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CrossReference(')
          ..write('id: $id, ')
          ..write('fromBookId: $fromBookId, ')
          ..write('fromChapter: $fromChapter, ')
          ..write('fromVerse: $fromVerse, ')
          ..write('toBookId: $toBookId, ')
          ..write('toChapter: $toChapter, ')
          ..write('toVerse: $toVerse, ')
          ..write('toVerseEnd: $toVerseEnd, ')
          ..write('rank: $rank')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fromBookId,
    fromChapter,
    fromVerse,
    toBookId,
    toChapter,
    toVerse,
    toVerseEnd,
    rank,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CrossReference &&
          other.id == this.id &&
          other.fromBookId == this.fromBookId &&
          other.fromChapter == this.fromChapter &&
          other.fromVerse == this.fromVerse &&
          other.toBookId == this.toBookId &&
          other.toChapter == this.toChapter &&
          other.toVerse == this.toVerse &&
          other.toVerseEnd == this.toVerseEnd &&
          other.rank == this.rank);
}

class CrossReferencesCompanion extends UpdateCompanion<CrossReference> {
  final Value<int> id;
  final Value<int> fromBookId;
  final Value<int> fromChapter;
  final Value<int> fromVerse;
  final Value<int> toBookId;
  final Value<int> toChapter;
  final Value<int> toVerse;
  final Value<int?> toVerseEnd;
  final Value<double> rank;
  const CrossReferencesCompanion({
    this.id = const Value.absent(),
    this.fromBookId = const Value.absent(),
    this.fromChapter = const Value.absent(),
    this.fromVerse = const Value.absent(),
    this.toBookId = const Value.absent(),
    this.toChapter = const Value.absent(),
    this.toVerse = const Value.absent(),
    this.toVerseEnd = const Value.absent(),
    this.rank = const Value.absent(),
  });
  CrossReferencesCompanion.insert({
    this.id = const Value.absent(),
    required int fromBookId,
    required int fromChapter,
    required int fromVerse,
    required int toBookId,
    required int toChapter,
    required int toVerse,
    this.toVerseEnd = const Value.absent(),
    this.rank = const Value.absent(),
  }) : fromBookId = Value(fromBookId),
       fromChapter = Value(fromChapter),
       fromVerse = Value(fromVerse),
       toBookId = Value(toBookId),
       toChapter = Value(toChapter),
       toVerse = Value(toVerse);
  static Insertable<CrossReference> custom({
    Expression<int>? id,
    Expression<int>? fromBookId,
    Expression<int>? fromChapter,
    Expression<int>? fromVerse,
    Expression<int>? toBookId,
    Expression<int>? toChapter,
    Expression<int>? toVerse,
    Expression<int>? toVerseEnd,
    Expression<double>? rank,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fromBookId != null) 'from_book_id': fromBookId,
      if (fromChapter != null) 'from_chapter': fromChapter,
      if (fromVerse != null) 'from_verse': fromVerse,
      if (toBookId != null) 'to_book_id': toBookId,
      if (toChapter != null) 'to_chapter': toChapter,
      if (toVerse != null) 'to_verse': toVerse,
      if (toVerseEnd != null) 'to_verse_end': toVerseEnd,
      if (rank != null) 'rank': rank,
    });
  }

  CrossReferencesCompanion copyWith({
    Value<int>? id,
    Value<int>? fromBookId,
    Value<int>? fromChapter,
    Value<int>? fromVerse,
    Value<int>? toBookId,
    Value<int>? toChapter,
    Value<int>? toVerse,
    Value<int?>? toVerseEnd,
    Value<double>? rank,
  }) {
    return CrossReferencesCompanion(
      id: id ?? this.id,
      fromBookId: fromBookId ?? this.fromBookId,
      fromChapter: fromChapter ?? this.fromChapter,
      fromVerse: fromVerse ?? this.fromVerse,
      toBookId: toBookId ?? this.toBookId,
      toChapter: toChapter ?? this.toChapter,
      toVerse: toVerse ?? this.toVerse,
      toVerseEnd: toVerseEnd ?? this.toVerseEnd,
      rank: rank ?? this.rank,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fromBookId.present) {
      map['from_book_id'] = Variable<int>(fromBookId.value);
    }
    if (fromChapter.present) {
      map['from_chapter'] = Variable<int>(fromChapter.value);
    }
    if (fromVerse.present) {
      map['from_verse'] = Variable<int>(fromVerse.value);
    }
    if (toBookId.present) {
      map['to_book_id'] = Variable<int>(toBookId.value);
    }
    if (toChapter.present) {
      map['to_chapter'] = Variable<int>(toChapter.value);
    }
    if (toVerse.present) {
      map['to_verse'] = Variable<int>(toVerse.value);
    }
    if (toVerseEnd.present) {
      map['to_verse_end'] = Variable<int>(toVerseEnd.value);
    }
    if (rank.present) {
      map['rank'] = Variable<double>(rank.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CrossReferencesCompanion(')
          ..write('id: $id, ')
          ..write('fromBookId: $fromBookId, ')
          ..write('fromChapter: $fromChapter, ')
          ..write('fromVerse: $fromVerse, ')
          ..write('toBookId: $toBookId, ')
          ..write('toChapter: $toChapter, ')
          ..write('toVerse: $toVerse, ')
          ..write('toVerseEnd: $toVerseEnd, ')
          ..write('rank: $rank')
          ..write(')'))
        .toString();
  }
}

class $DictionaryEntriesTable extends DictionaryEntries
    with TableInfo<$DictionaryEntriesTable, DictionaryEntryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DictionaryEntriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
    'word',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wordNormalizedMeta = const VerificationMeta(
    'wordNormalized',
  );
  @override
  late final GeneratedColumn<String> wordNormalized = GeneratedColumn<String>(
    'word_normalized',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ipaUsMeta = const VerificationMeta('ipaUs');
  @override
  late final GeneratedColumn<String> ipaUs = GeneratedColumn<String>(
    'ipa_us',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _ipaUkMeta = const VerificationMeta('ipaUk');
  @override
  late final GeneratedColumn<String> ipaUk = GeneratedColumn<String>(
    'ipa_uk',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _frequencyRankMeta = const VerificationMeta(
    'frequencyRank',
  );
  @override
  late final GeneratedColumn<int> frequencyRank = GeneratedColumn<int>(
    'frequency_rank',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(999999),
  );
  static const VerificationMeta _bibleFrequencyMeta = const VerificationMeta(
    'bibleFrequency',
  );
  @override
  late final GeneratedColumn<int> bibleFrequency = GeneratedColumn<int>(
    'bible_frequency',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _etymologyMeta = const VerificationMeta(
    'etymology',
  );
  @override
  late final GeneratedColumn<String> etymology = GeneratedColumn<String>(
    'etymology',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _koreanMeaningMeta = const VerificationMeta(
    'koreanMeaning',
  );
  @override
  late final GeneratedColumn<String> koreanMeaning = GeneratedColumn<String>(
    'korean_meaning',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _synonymsJsonMeta = const VerificationMeta(
    'synonymsJson',
  );
  @override
  late final GeneratedColumn<String> synonymsJson = GeneratedColumn<String>(
    'synonyms_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _antonymsJsonMeta = const VerificationMeta(
    'antonymsJson',
  );
  @override
  late final GeneratedColumn<String> antonymsJson = GeneratedColumn<String>(
    'antonyms_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _relatedWordsJsonMeta = const VerificationMeta(
    'relatedWordsJson',
  );
  @override
  late final GeneratedColumn<String> relatedWordsJson = GeneratedColumn<String>(
    'related_words_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    word,
    wordNormalized,
    ipaUs,
    ipaUk,
    frequencyRank,
    bibleFrequency,
    etymology,
    koreanMeaning,
    synonymsJson,
    antonymsJson,
    relatedWordsJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dictionary_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<DictionaryEntryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word')) {
      context.handle(
        _wordMeta,
        word.isAcceptableOrUnknown(data['word']!, _wordMeta),
      );
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('word_normalized')) {
      context.handle(
        _wordNormalizedMeta,
        wordNormalized.isAcceptableOrUnknown(
          data['word_normalized']!,
          _wordNormalizedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_wordNormalizedMeta);
    }
    if (data.containsKey('ipa_us')) {
      context.handle(
        _ipaUsMeta,
        ipaUs.isAcceptableOrUnknown(data['ipa_us']!, _ipaUsMeta),
      );
    }
    if (data.containsKey('ipa_uk')) {
      context.handle(
        _ipaUkMeta,
        ipaUk.isAcceptableOrUnknown(data['ipa_uk']!, _ipaUkMeta),
      );
    }
    if (data.containsKey('frequency_rank')) {
      context.handle(
        _frequencyRankMeta,
        frequencyRank.isAcceptableOrUnknown(
          data['frequency_rank']!,
          _frequencyRankMeta,
        ),
      );
    }
    if (data.containsKey('bible_frequency')) {
      context.handle(
        _bibleFrequencyMeta,
        bibleFrequency.isAcceptableOrUnknown(
          data['bible_frequency']!,
          _bibleFrequencyMeta,
        ),
      );
    }
    if (data.containsKey('etymology')) {
      context.handle(
        _etymologyMeta,
        etymology.isAcceptableOrUnknown(data['etymology']!, _etymologyMeta),
      );
    }
    if (data.containsKey('korean_meaning')) {
      context.handle(
        _koreanMeaningMeta,
        koreanMeaning.isAcceptableOrUnknown(
          data['korean_meaning']!,
          _koreanMeaningMeta,
        ),
      );
    }
    if (data.containsKey('synonyms_json')) {
      context.handle(
        _synonymsJsonMeta,
        synonymsJson.isAcceptableOrUnknown(
          data['synonyms_json']!,
          _synonymsJsonMeta,
        ),
      );
    }
    if (data.containsKey('antonyms_json')) {
      context.handle(
        _antonymsJsonMeta,
        antonymsJson.isAcceptableOrUnknown(
          data['antonyms_json']!,
          _antonymsJsonMeta,
        ),
      );
    }
    if (data.containsKey('related_words_json')) {
      context.handle(
        _relatedWordsJsonMeta,
        relatedWordsJson.isAcceptableOrUnknown(
          data['related_words_json']!,
          _relatedWordsJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {wordNormalized},
  ];
  @override
  DictionaryEntryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DictionaryEntryData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      word:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}word'],
          )!,
      wordNormalized:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}word_normalized'],
          )!,
      ipaUs:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}ipa_us'],
          )!,
      ipaUk:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}ipa_uk'],
          )!,
      frequencyRank:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}frequency_rank'],
          )!,
      bibleFrequency:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}bible_frequency'],
          )!,
      etymology:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}etymology'],
          )!,
      koreanMeaning:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}korean_meaning'],
          )!,
      synonymsJson:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}synonyms_json'],
          )!,
      antonymsJson:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}antonyms_json'],
          )!,
      relatedWordsJson:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}related_words_json'],
          )!,
    );
  }

  @override
  $DictionaryEntriesTable createAlias(String alias) {
    return $DictionaryEntriesTable(attachedDatabase, alias);
  }
}

class DictionaryEntryData extends DataClass
    implements Insertable<DictionaryEntryData> {
  final int id;
  final String word;
  final String wordNormalized;
  final String ipaUs;
  final String ipaUk;
  final int frequencyRank;
  final int bibleFrequency;
  final String etymology;
  final String koreanMeaning;
  final String synonymsJson;
  final String antonymsJson;
  final String relatedWordsJson;
  const DictionaryEntryData({
    required this.id,
    required this.word,
    required this.wordNormalized,
    required this.ipaUs,
    required this.ipaUk,
    required this.frequencyRank,
    required this.bibleFrequency,
    required this.etymology,
    required this.koreanMeaning,
    required this.synonymsJson,
    required this.antonymsJson,
    required this.relatedWordsJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word'] = Variable<String>(word);
    map['word_normalized'] = Variable<String>(wordNormalized);
    map['ipa_us'] = Variable<String>(ipaUs);
    map['ipa_uk'] = Variable<String>(ipaUk);
    map['frequency_rank'] = Variable<int>(frequencyRank);
    map['bible_frequency'] = Variable<int>(bibleFrequency);
    map['etymology'] = Variable<String>(etymology);
    map['korean_meaning'] = Variable<String>(koreanMeaning);
    map['synonyms_json'] = Variable<String>(synonymsJson);
    map['antonyms_json'] = Variable<String>(antonymsJson);
    map['related_words_json'] = Variable<String>(relatedWordsJson);
    return map;
  }

  DictionaryEntriesCompanion toCompanion(bool nullToAbsent) {
    return DictionaryEntriesCompanion(
      id: Value(id),
      word: Value(word),
      wordNormalized: Value(wordNormalized),
      ipaUs: Value(ipaUs),
      ipaUk: Value(ipaUk),
      frequencyRank: Value(frequencyRank),
      bibleFrequency: Value(bibleFrequency),
      etymology: Value(etymology),
      koreanMeaning: Value(koreanMeaning),
      synonymsJson: Value(synonymsJson),
      antonymsJson: Value(antonymsJson),
      relatedWordsJson: Value(relatedWordsJson),
    );
  }

  factory DictionaryEntryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DictionaryEntryData(
      id: serializer.fromJson<int>(json['id']),
      word: serializer.fromJson<String>(json['word']),
      wordNormalized: serializer.fromJson<String>(json['wordNormalized']),
      ipaUs: serializer.fromJson<String>(json['ipaUs']),
      ipaUk: serializer.fromJson<String>(json['ipaUk']),
      frequencyRank: serializer.fromJson<int>(json['frequencyRank']),
      bibleFrequency: serializer.fromJson<int>(json['bibleFrequency']),
      etymology: serializer.fromJson<String>(json['etymology']),
      koreanMeaning: serializer.fromJson<String>(json['koreanMeaning']),
      synonymsJson: serializer.fromJson<String>(json['synonymsJson']),
      antonymsJson: serializer.fromJson<String>(json['antonymsJson']),
      relatedWordsJson: serializer.fromJson<String>(json['relatedWordsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'word': serializer.toJson<String>(word),
      'wordNormalized': serializer.toJson<String>(wordNormalized),
      'ipaUs': serializer.toJson<String>(ipaUs),
      'ipaUk': serializer.toJson<String>(ipaUk),
      'frequencyRank': serializer.toJson<int>(frequencyRank),
      'bibleFrequency': serializer.toJson<int>(bibleFrequency),
      'etymology': serializer.toJson<String>(etymology),
      'koreanMeaning': serializer.toJson<String>(koreanMeaning),
      'synonymsJson': serializer.toJson<String>(synonymsJson),
      'antonymsJson': serializer.toJson<String>(antonymsJson),
      'relatedWordsJson': serializer.toJson<String>(relatedWordsJson),
    };
  }

  DictionaryEntryData copyWith({
    int? id,
    String? word,
    String? wordNormalized,
    String? ipaUs,
    String? ipaUk,
    int? frequencyRank,
    int? bibleFrequency,
    String? etymology,
    String? koreanMeaning,
    String? synonymsJson,
    String? antonymsJson,
    String? relatedWordsJson,
  }) => DictionaryEntryData(
    id: id ?? this.id,
    word: word ?? this.word,
    wordNormalized: wordNormalized ?? this.wordNormalized,
    ipaUs: ipaUs ?? this.ipaUs,
    ipaUk: ipaUk ?? this.ipaUk,
    frequencyRank: frequencyRank ?? this.frequencyRank,
    bibleFrequency: bibleFrequency ?? this.bibleFrequency,
    etymology: etymology ?? this.etymology,
    koreanMeaning: koreanMeaning ?? this.koreanMeaning,
    synonymsJson: synonymsJson ?? this.synonymsJson,
    antonymsJson: antonymsJson ?? this.antonymsJson,
    relatedWordsJson: relatedWordsJson ?? this.relatedWordsJson,
  );
  DictionaryEntryData copyWithCompanion(DictionaryEntriesCompanion data) {
    return DictionaryEntryData(
      id: data.id.present ? data.id.value : this.id,
      word: data.word.present ? data.word.value : this.word,
      wordNormalized:
          data.wordNormalized.present
              ? data.wordNormalized.value
              : this.wordNormalized,
      ipaUs: data.ipaUs.present ? data.ipaUs.value : this.ipaUs,
      ipaUk: data.ipaUk.present ? data.ipaUk.value : this.ipaUk,
      frequencyRank:
          data.frequencyRank.present
              ? data.frequencyRank.value
              : this.frequencyRank,
      bibleFrequency:
          data.bibleFrequency.present
              ? data.bibleFrequency.value
              : this.bibleFrequency,
      etymology: data.etymology.present ? data.etymology.value : this.etymology,
      koreanMeaning:
          data.koreanMeaning.present
              ? data.koreanMeaning.value
              : this.koreanMeaning,
      synonymsJson:
          data.synonymsJson.present
              ? data.synonymsJson.value
              : this.synonymsJson,
      antonymsJson:
          data.antonymsJson.present
              ? data.antonymsJson.value
              : this.antonymsJson,
      relatedWordsJson:
          data.relatedWordsJson.present
              ? data.relatedWordsJson.value
              : this.relatedWordsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DictionaryEntryData(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('wordNormalized: $wordNormalized, ')
          ..write('ipaUs: $ipaUs, ')
          ..write('ipaUk: $ipaUk, ')
          ..write('frequencyRank: $frequencyRank, ')
          ..write('bibleFrequency: $bibleFrequency, ')
          ..write('etymology: $etymology, ')
          ..write('koreanMeaning: $koreanMeaning, ')
          ..write('synonymsJson: $synonymsJson, ')
          ..write('antonymsJson: $antonymsJson, ')
          ..write('relatedWordsJson: $relatedWordsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    word,
    wordNormalized,
    ipaUs,
    ipaUk,
    frequencyRank,
    bibleFrequency,
    etymology,
    koreanMeaning,
    synonymsJson,
    antonymsJson,
    relatedWordsJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DictionaryEntryData &&
          other.id == this.id &&
          other.word == this.word &&
          other.wordNormalized == this.wordNormalized &&
          other.ipaUs == this.ipaUs &&
          other.ipaUk == this.ipaUk &&
          other.frequencyRank == this.frequencyRank &&
          other.bibleFrequency == this.bibleFrequency &&
          other.etymology == this.etymology &&
          other.koreanMeaning == this.koreanMeaning &&
          other.synonymsJson == this.synonymsJson &&
          other.antonymsJson == this.antonymsJson &&
          other.relatedWordsJson == this.relatedWordsJson);
}

class DictionaryEntriesCompanion extends UpdateCompanion<DictionaryEntryData> {
  final Value<int> id;
  final Value<String> word;
  final Value<String> wordNormalized;
  final Value<String> ipaUs;
  final Value<String> ipaUk;
  final Value<int> frequencyRank;
  final Value<int> bibleFrequency;
  final Value<String> etymology;
  final Value<String> koreanMeaning;
  final Value<String> synonymsJson;
  final Value<String> antonymsJson;
  final Value<String> relatedWordsJson;
  const DictionaryEntriesCompanion({
    this.id = const Value.absent(),
    this.word = const Value.absent(),
    this.wordNormalized = const Value.absent(),
    this.ipaUs = const Value.absent(),
    this.ipaUk = const Value.absent(),
    this.frequencyRank = const Value.absent(),
    this.bibleFrequency = const Value.absent(),
    this.etymology = const Value.absent(),
    this.koreanMeaning = const Value.absent(),
    this.synonymsJson = const Value.absent(),
    this.antonymsJson = const Value.absent(),
    this.relatedWordsJson = const Value.absent(),
  });
  DictionaryEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String word,
    required String wordNormalized,
    this.ipaUs = const Value.absent(),
    this.ipaUk = const Value.absent(),
    this.frequencyRank = const Value.absent(),
    this.bibleFrequency = const Value.absent(),
    this.etymology = const Value.absent(),
    this.koreanMeaning = const Value.absent(),
    this.synonymsJson = const Value.absent(),
    this.antonymsJson = const Value.absent(),
    this.relatedWordsJson = const Value.absent(),
  }) : word = Value(word),
       wordNormalized = Value(wordNormalized);
  static Insertable<DictionaryEntryData> custom({
    Expression<int>? id,
    Expression<String>? word,
    Expression<String>? wordNormalized,
    Expression<String>? ipaUs,
    Expression<String>? ipaUk,
    Expression<int>? frequencyRank,
    Expression<int>? bibleFrequency,
    Expression<String>? etymology,
    Expression<String>? koreanMeaning,
    Expression<String>? synonymsJson,
    Expression<String>? antonymsJson,
    Expression<String>? relatedWordsJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (word != null) 'word': word,
      if (wordNormalized != null) 'word_normalized': wordNormalized,
      if (ipaUs != null) 'ipa_us': ipaUs,
      if (ipaUk != null) 'ipa_uk': ipaUk,
      if (frequencyRank != null) 'frequency_rank': frequencyRank,
      if (bibleFrequency != null) 'bible_frequency': bibleFrequency,
      if (etymology != null) 'etymology': etymology,
      if (koreanMeaning != null) 'korean_meaning': koreanMeaning,
      if (synonymsJson != null) 'synonyms_json': synonymsJson,
      if (antonymsJson != null) 'antonyms_json': antonymsJson,
      if (relatedWordsJson != null) 'related_words_json': relatedWordsJson,
    });
  }

  DictionaryEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? word,
    Value<String>? wordNormalized,
    Value<String>? ipaUs,
    Value<String>? ipaUk,
    Value<int>? frequencyRank,
    Value<int>? bibleFrequency,
    Value<String>? etymology,
    Value<String>? koreanMeaning,
    Value<String>? synonymsJson,
    Value<String>? antonymsJson,
    Value<String>? relatedWordsJson,
  }) {
    return DictionaryEntriesCompanion(
      id: id ?? this.id,
      word: word ?? this.word,
      wordNormalized: wordNormalized ?? this.wordNormalized,
      ipaUs: ipaUs ?? this.ipaUs,
      ipaUk: ipaUk ?? this.ipaUk,
      frequencyRank: frequencyRank ?? this.frequencyRank,
      bibleFrequency: bibleFrequency ?? this.bibleFrequency,
      etymology: etymology ?? this.etymology,
      koreanMeaning: koreanMeaning ?? this.koreanMeaning,
      synonymsJson: synonymsJson ?? this.synonymsJson,
      antonymsJson: antonymsJson ?? this.antonymsJson,
      relatedWordsJson: relatedWordsJson ?? this.relatedWordsJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (wordNormalized.present) {
      map['word_normalized'] = Variable<String>(wordNormalized.value);
    }
    if (ipaUs.present) {
      map['ipa_us'] = Variable<String>(ipaUs.value);
    }
    if (ipaUk.present) {
      map['ipa_uk'] = Variable<String>(ipaUk.value);
    }
    if (frequencyRank.present) {
      map['frequency_rank'] = Variable<int>(frequencyRank.value);
    }
    if (bibleFrequency.present) {
      map['bible_frequency'] = Variable<int>(bibleFrequency.value);
    }
    if (etymology.present) {
      map['etymology'] = Variable<String>(etymology.value);
    }
    if (koreanMeaning.present) {
      map['korean_meaning'] = Variable<String>(koreanMeaning.value);
    }
    if (synonymsJson.present) {
      map['synonyms_json'] = Variable<String>(synonymsJson.value);
    }
    if (antonymsJson.present) {
      map['antonyms_json'] = Variable<String>(antonymsJson.value);
    }
    if (relatedWordsJson.present) {
      map['related_words_json'] = Variable<String>(relatedWordsJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DictionaryEntriesCompanion(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('wordNormalized: $wordNormalized, ')
          ..write('ipaUs: $ipaUs, ')
          ..write('ipaUk: $ipaUk, ')
          ..write('frequencyRank: $frequencyRank, ')
          ..write('bibleFrequency: $bibleFrequency, ')
          ..write('etymology: $etymology, ')
          ..write('koreanMeaning: $koreanMeaning, ')
          ..write('synonymsJson: $synonymsJson, ')
          ..write('antonymsJson: $antonymsJson, ')
          ..write('relatedWordsJson: $relatedWordsJson')
          ..write(')'))
        .toString();
  }
}

class $WordSensesTable extends WordSenses
    with TableInfo<$WordSensesTable, WordSenseData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordSensesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _entryIdMeta = const VerificationMeta(
    'entryId',
  );
  @override
  late final GeneratedColumn<int> entryId = GeneratedColumn<int>(
    'entry_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES dictionary_entries (id)',
    ),
  );
  static const VerificationMeta _partOfSpeechMeta = const VerificationMeta(
    'partOfSpeech',
  );
  @override
  late final GeneratedColumn<String> partOfSpeech = GeneratedColumn<String>(
    'part_of_speech',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 30,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senseOrderMeta = const VerificationMeta(
    'senseOrder',
  );
  @override
  late final GeneratedColumn<int> senseOrder = GeneratedColumn<int>(
    'sense_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _definitionMeta = const VerificationMeta(
    'definition',
  );
  @override
  late final GeneratedColumn<String> definition = GeneratedColumn<String>(
    'definition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _definitionKoMeta = const VerificationMeta(
    'definitionKo',
  );
  @override
  late final GeneratedColumn<String> definitionKo = GeneratedColumn<String>(
    'definition_ko',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _bibleDefinitionMeta = const VerificationMeta(
    'bibleDefinition',
  );
  @override
  late final GeneratedColumn<String> bibleDefinition = GeneratedColumn<String>(
    'bible_definition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _registerMeta = const VerificationMeta(
    'register',
  );
  @override
  late final GeneratedColumn<String> register = GeneratedColumn<String>(
    'register',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _isArchaicMeta = const VerificationMeta(
    'isArchaic',
  );
  @override
  late final GeneratedColumn<bool> isArchaic = GeneratedColumn<bool>(
    'is_archaic',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archaic" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entryId,
    partOfSpeech,
    senseOrder,
    definition,
    definitionKo,
    bibleDefinition,
    register,
    isArchaic,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_senses';
  @override
  VerificationContext validateIntegrity(
    Insertable<WordSenseData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entry_id')) {
      context.handle(
        _entryIdMeta,
        entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('part_of_speech')) {
      context.handle(
        _partOfSpeechMeta,
        partOfSpeech.isAcceptableOrUnknown(
          data['part_of_speech']!,
          _partOfSpeechMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_partOfSpeechMeta);
    }
    if (data.containsKey('sense_order')) {
      context.handle(
        _senseOrderMeta,
        senseOrder.isAcceptableOrUnknown(data['sense_order']!, _senseOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_senseOrderMeta);
    }
    if (data.containsKey('definition')) {
      context.handle(
        _definitionMeta,
        definition.isAcceptableOrUnknown(data['definition']!, _definitionMeta),
      );
    } else if (isInserting) {
      context.missing(_definitionMeta);
    }
    if (data.containsKey('definition_ko')) {
      context.handle(
        _definitionKoMeta,
        definitionKo.isAcceptableOrUnknown(
          data['definition_ko']!,
          _definitionKoMeta,
        ),
      );
    }
    if (data.containsKey('bible_definition')) {
      context.handle(
        _bibleDefinitionMeta,
        bibleDefinition.isAcceptableOrUnknown(
          data['bible_definition']!,
          _bibleDefinitionMeta,
        ),
      );
    }
    if (data.containsKey('register')) {
      context.handle(
        _registerMeta,
        register.isAcceptableOrUnknown(data['register']!, _registerMeta),
      );
    }
    if (data.containsKey('is_archaic')) {
      context.handle(
        _isArchaicMeta,
        isArchaic.isAcceptableOrUnknown(data['is_archaic']!, _isArchaicMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WordSenseData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordSenseData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      entryId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}entry_id'],
          )!,
      partOfSpeech:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}part_of_speech'],
          )!,
      senseOrder:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}sense_order'],
          )!,
      definition:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}definition'],
          )!,
      definitionKo:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}definition_ko'],
          )!,
      bibleDefinition:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}bible_definition'],
          )!,
      register:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}register'],
          )!,
      isArchaic:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_archaic'],
          )!,
    );
  }

  @override
  $WordSensesTable createAlias(String alias) {
    return $WordSensesTable(attachedDatabase, alias);
  }
}

class WordSenseData extends DataClass implements Insertable<WordSenseData> {
  final int id;
  final int entryId;
  final String partOfSpeech;
  final int senseOrder;
  final String definition;
  final String definitionKo;
  final String bibleDefinition;
  final String register;
  final bool isArchaic;
  const WordSenseData({
    required this.id,
    required this.entryId,
    required this.partOfSpeech,
    required this.senseOrder,
    required this.definition,
    required this.definitionKo,
    required this.bibleDefinition,
    required this.register,
    required this.isArchaic,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entry_id'] = Variable<int>(entryId);
    map['part_of_speech'] = Variable<String>(partOfSpeech);
    map['sense_order'] = Variable<int>(senseOrder);
    map['definition'] = Variable<String>(definition);
    map['definition_ko'] = Variable<String>(definitionKo);
    map['bible_definition'] = Variable<String>(bibleDefinition);
    map['register'] = Variable<String>(register);
    map['is_archaic'] = Variable<bool>(isArchaic);
    return map;
  }

  WordSensesCompanion toCompanion(bool nullToAbsent) {
    return WordSensesCompanion(
      id: Value(id),
      entryId: Value(entryId),
      partOfSpeech: Value(partOfSpeech),
      senseOrder: Value(senseOrder),
      definition: Value(definition),
      definitionKo: Value(definitionKo),
      bibleDefinition: Value(bibleDefinition),
      register: Value(register),
      isArchaic: Value(isArchaic),
    );
  }

  factory WordSenseData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordSenseData(
      id: serializer.fromJson<int>(json['id']),
      entryId: serializer.fromJson<int>(json['entryId']),
      partOfSpeech: serializer.fromJson<String>(json['partOfSpeech']),
      senseOrder: serializer.fromJson<int>(json['senseOrder']),
      definition: serializer.fromJson<String>(json['definition']),
      definitionKo: serializer.fromJson<String>(json['definitionKo']),
      bibleDefinition: serializer.fromJson<String>(json['bibleDefinition']),
      register: serializer.fromJson<String>(json['register']),
      isArchaic: serializer.fromJson<bool>(json['isArchaic']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entryId': serializer.toJson<int>(entryId),
      'partOfSpeech': serializer.toJson<String>(partOfSpeech),
      'senseOrder': serializer.toJson<int>(senseOrder),
      'definition': serializer.toJson<String>(definition),
      'definitionKo': serializer.toJson<String>(definitionKo),
      'bibleDefinition': serializer.toJson<String>(bibleDefinition),
      'register': serializer.toJson<String>(register),
      'isArchaic': serializer.toJson<bool>(isArchaic),
    };
  }

  WordSenseData copyWith({
    int? id,
    int? entryId,
    String? partOfSpeech,
    int? senseOrder,
    String? definition,
    String? definitionKo,
    String? bibleDefinition,
    String? register,
    bool? isArchaic,
  }) => WordSenseData(
    id: id ?? this.id,
    entryId: entryId ?? this.entryId,
    partOfSpeech: partOfSpeech ?? this.partOfSpeech,
    senseOrder: senseOrder ?? this.senseOrder,
    definition: definition ?? this.definition,
    definitionKo: definitionKo ?? this.definitionKo,
    bibleDefinition: bibleDefinition ?? this.bibleDefinition,
    register: register ?? this.register,
    isArchaic: isArchaic ?? this.isArchaic,
  );
  WordSenseData copyWithCompanion(WordSensesCompanion data) {
    return WordSenseData(
      id: data.id.present ? data.id.value : this.id,
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      partOfSpeech:
          data.partOfSpeech.present
              ? data.partOfSpeech.value
              : this.partOfSpeech,
      senseOrder:
          data.senseOrder.present ? data.senseOrder.value : this.senseOrder,
      definition:
          data.definition.present ? data.definition.value : this.definition,
      definitionKo:
          data.definitionKo.present
              ? data.definitionKo.value
              : this.definitionKo,
      bibleDefinition:
          data.bibleDefinition.present
              ? data.bibleDefinition.value
              : this.bibleDefinition,
      register: data.register.present ? data.register.value : this.register,
      isArchaic: data.isArchaic.present ? data.isArchaic.value : this.isArchaic,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordSenseData(')
          ..write('id: $id, ')
          ..write('entryId: $entryId, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('senseOrder: $senseOrder, ')
          ..write('definition: $definition, ')
          ..write('definitionKo: $definitionKo, ')
          ..write('bibleDefinition: $bibleDefinition, ')
          ..write('register: $register, ')
          ..write('isArchaic: $isArchaic')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entryId,
    partOfSpeech,
    senseOrder,
    definition,
    definitionKo,
    bibleDefinition,
    register,
    isArchaic,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordSenseData &&
          other.id == this.id &&
          other.entryId == this.entryId &&
          other.partOfSpeech == this.partOfSpeech &&
          other.senseOrder == this.senseOrder &&
          other.definition == this.definition &&
          other.definitionKo == this.definitionKo &&
          other.bibleDefinition == this.bibleDefinition &&
          other.register == this.register &&
          other.isArchaic == this.isArchaic);
}

class WordSensesCompanion extends UpdateCompanion<WordSenseData> {
  final Value<int> id;
  final Value<int> entryId;
  final Value<String> partOfSpeech;
  final Value<int> senseOrder;
  final Value<String> definition;
  final Value<String> definitionKo;
  final Value<String> bibleDefinition;
  final Value<String> register;
  final Value<bool> isArchaic;
  const WordSensesCompanion({
    this.id = const Value.absent(),
    this.entryId = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
    this.senseOrder = const Value.absent(),
    this.definition = const Value.absent(),
    this.definitionKo = const Value.absent(),
    this.bibleDefinition = const Value.absent(),
    this.register = const Value.absent(),
    this.isArchaic = const Value.absent(),
  });
  WordSensesCompanion.insert({
    this.id = const Value.absent(),
    required int entryId,
    required String partOfSpeech,
    required int senseOrder,
    required String definition,
    this.definitionKo = const Value.absent(),
    this.bibleDefinition = const Value.absent(),
    this.register = const Value.absent(),
    this.isArchaic = const Value.absent(),
  }) : entryId = Value(entryId),
       partOfSpeech = Value(partOfSpeech),
       senseOrder = Value(senseOrder),
       definition = Value(definition);
  static Insertable<WordSenseData> custom({
    Expression<int>? id,
    Expression<int>? entryId,
    Expression<String>? partOfSpeech,
    Expression<int>? senseOrder,
    Expression<String>? definition,
    Expression<String>? definitionKo,
    Expression<String>? bibleDefinition,
    Expression<String>? register,
    Expression<bool>? isArchaic,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entryId != null) 'entry_id': entryId,
      if (partOfSpeech != null) 'part_of_speech': partOfSpeech,
      if (senseOrder != null) 'sense_order': senseOrder,
      if (definition != null) 'definition': definition,
      if (definitionKo != null) 'definition_ko': definitionKo,
      if (bibleDefinition != null) 'bible_definition': bibleDefinition,
      if (register != null) 'register': register,
      if (isArchaic != null) 'is_archaic': isArchaic,
    });
  }

  WordSensesCompanion copyWith({
    Value<int>? id,
    Value<int>? entryId,
    Value<String>? partOfSpeech,
    Value<int>? senseOrder,
    Value<String>? definition,
    Value<String>? definitionKo,
    Value<String>? bibleDefinition,
    Value<String>? register,
    Value<bool>? isArchaic,
  }) {
    return WordSensesCompanion(
      id: id ?? this.id,
      entryId: entryId ?? this.entryId,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      senseOrder: senseOrder ?? this.senseOrder,
      definition: definition ?? this.definition,
      definitionKo: definitionKo ?? this.definitionKo,
      bibleDefinition: bibleDefinition ?? this.bibleDefinition,
      register: register ?? this.register,
      isArchaic: isArchaic ?? this.isArchaic,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entryId.present) {
      map['entry_id'] = Variable<int>(entryId.value);
    }
    if (partOfSpeech.present) {
      map['part_of_speech'] = Variable<String>(partOfSpeech.value);
    }
    if (senseOrder.present) {
      map['sense_order'] = Variable<int>(senseOrder.value);
    }
    if (definition.present) {
      map['definition'] = Variable<String>(definition.value);
    }
    if (definitionKo.present) {
      map['definition_ko'] = Variable<String>(definitionKo.value);
    }
    if (bibleDefinition.present) {
      map['bible_definition'] = Variable<String>(bibleDefinition.value);
    }
    if (register.present) {
      map['register'] = Variable<String>(register.value);
    }
    if (isArchaic.present) {
      map['is_archaic'] = Variable<bool>(isArchaic.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordSensesCompanion(')
          ..write('id: $id, ')
          ..write('entryId: $entryId, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('senseOrder: $senseOrder, ')
          ..write('definition: $definition, ')
          ..write('definitionKo: $definitionKo, ')
          ..write('bibleDefinition: $bibleDefinition, ')
          ..write('register: $register, ')
          ..write('isArchaic: $isArchaic')
          ..write(')'))
        .toString();
  }
}

class $WordExamplesTable extends WordExamples
    with TableInfo<$WordExamplesTable, WordExampleData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordExamplesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _senseIdMeta = const VerificationMeta(
    'senseId',
  );
  @override
  late final GeneratedColumn<int> senseId = GeneratedColumn<int>(
    'sense_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES word_senses (id)',
    ),
  );
  static const VerificationMeta _exampleTypeMeta = const VerificationMeta(
    'exampleType',
  );
  @override
  late final GeneratedColumn<String> exampleType = GeneratedColumn<String>(
    'example_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textContentMeta = const VerificationMeta(
    'textContent',
  );
  @override
  late final GeneratedColumn<String> textContent = GeneratedColumn<String>(
    'text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceReferenceMeta = const VerificationMeta(
    'sourceReference',
  );
  @override
  late final GeneratedColumn<String> sourceReference = GeneratedColumn<String>(
    'source_reference',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
    'book_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chapterMeta = const VerificationMeta(
    'chapter',
  );
  @override
  late final GeneratedColumn<int> chapter = GeneratedColumn<int>(
    'chapter',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _verseMeta = const VerificationMeta('verse');
  @override
  late final GeneratedColumn<int> verse = GeneratedColumn<int>(
    'verse',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    senseId,
    exampleType,
    textContent,
    sourceReference,
    bookId,
    chapter,
    verse,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_examples';
  @override
  VerificationContext validateIntegrity(
    Insertable<WordExampleData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sense_id')) {
      context.handle(
        _senseIdMeta,
        senseId.isAcceptableOrUnknown(data['sense_id']!, _senseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_senseIdMeta);
    }
    if (data.containsKey('example_type')) {
      context.handle(
        _exampleTypeMeta,
        exampleType.isAcceptableOrUnknown(
          data['example_type']!,
          _exampleTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exampleTypeMeta);
    }
    if (data.containsKey('text')) {
      context.handle(
        _textContentMeta,
        textContent.isAcceptableOrUnknown(data['text']!, _textContentMeta),
      );
    } else if (isInserting) {
      context.missing(_textContentMeta);
    }
    if (data.containsKey('source_reference')) {
      context.handle(
        _sourceReferenceMeta,
        sourceReference.isAcceptableOrUnknown(
          data['source_reference']!,
          _sourceReferenceMeta,
        ),
      );
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    }
    if (data.containsKey('chapter')) {
      context.handle(
        _chapterMeta,
        chapter.isAcceptableOrUnknown(data['chapter']!, _chapterMeta),
      );
    }
    if (data.containsKey('verse')) {
      context.handle(
        _verseMeta,
        verse.isAcceptableOrUnknown(data['verse']!, _verseMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WordExampleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordExampleData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      senseId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}sense_id'],
          )!,
      exampleType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}example_type'],
          )!,
      textContent:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}text'],
          )!,
      sourceReference:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}source_reference'],
          )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}book_id'],
      ),
      chapter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chapter'],
      ),
      verse: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}verse'],
      ),
    );
  }

  @override
  $WordExamplesTable createAlias(String alias) {
    return $WordExamplesTable(attachedDatabase, alias);
  }
}

class WordExampleData extends DataClass implements Insertable<WordExampleData> {
  final int id;
  final int senseId;
  final String exampleType;
  final String textContent;
  final String sourceReference;
  final int? bookId;
  final int? chapter;
  final int? verse;
  const WordExampleData({
    required this.id,
    required this.senseId,
    required this.exampleType,
    required this.textContent,
    required this.sourceReference,
    this.bookId,
    this.chapter,
    this.verse,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sense_id'] = Variable<int>(senseId);
    map['example_type'] = Variable<String>(exampleType);
    map['text'] = Variable<String>(textContent);
    map['source_reference'] = Variable<String>(sourceReference);
    if (!nullToAbsent || bookId != null) {
      map['book_id'] = Variable<int>(bookId);
    }
    if (!nullToAbsent || chapter != null) {
      map['chapter'] = Variable<int>(chapter);
    }
    if (!nullToAbsent || verse != null) {
      map['verse'] = Variable<int>(verse);
    }
    return map;
  }

  WordExamplesCompanion toCompanion(bool nullToAbsent) {
    return WordExamplesCompanion(
      id: Value(id),
      senseId: Value(senseId),
      exampleType: Value(exampleType),
      textContent: Value(textContent),
      sourceReference: Value(sourceReference),
      bookId:
          bookId == null && nullToAbsent ? const Value.absent() : Value(bookId),
      chapter:
          chapter == null && nullToAbsent
              ? const Value.absent()
              : Value(chapter),
      verse:
          verse == null && nullToAbsent ? const Value.absent() : Value(verse),
    );
  }

  factory WordExampleData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordExampleData(
      id: serializer.fromJson<int>(json['id']),
      senseId: serializer.fromJson<int>(json['senseId']),
      exampleType: serializer.fromJson<String>(json['exampleType']),
      textContent: serializer.fromJson<String>(json['textContent']),
      sourceReference: serializer.fromJson<String>(json['sourceReference']),
      bookId: serializer.fromJson<int?>(json['bookId']),
      chapter: serializer.fromJson<int?>(json['chapter']),
      verse: serializer.fromJson<int?>(json['verse']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'senseId': serializer.toJson<int>(senseId),
      'exampleType': serializer.toJson<String>(exampleType),
      'textContent': serializer.toJson<String>(textContent),
      'sourceReference': serializer.toJson<String>(sourceReference),
      'bookId': serializer.toJson<int?>(bookId),
      'chapter': serializer.toJson<int?>(chapter),
      'verse': serializer.toJson<int?>(verse),
    };
  }

  WordExampleData copyWith({
    int? id,
    int? senseId,
    String? exampleType,
    String? textContent,
    String? sourceReference,
    Value<int?> bookId = const Value.absent(),
    Value<int?> chapter = const Value.absent(),
    Value<int?> verse = const Value.absent(),
  }) => WordExampleData(
    id: id ?? this.id,
    senseId: senseId ?? this.senseId,
    exampleType: exampleType ?? this.exampleType,
    textContent: textContent ?? this.textContent,
    sourceReference: sourceReference ?? this.sourceReference,
    bookId: bookId.present ? bookId.value : this.bookId,
    chapter: chapter.present ? chapter.value : this.chapter,
    verse: verse.present ? verse.value : this.verse,
  );
  WordExampleData copyWithCompanion(WordExamplesCompanion data) {
    return WordExampleData(
      id: data.id.present ? data.id.value : this.id,
      senseId: data.senseId.present ? data.senseId.value : this.senseId,
      exampleType:
          data.exampleType.present ? data.exampleType.value : this.exampleType,
      textContent:
          data.textContent.present ? data.textContent.value : this.textContent,
      sourceReference:
          data.sourceReference.present
              ? data.sourceReference.value
              : this.sourceReference,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      chapter: data.chapter.present ? data.chapter.value : this.chapter,
      verse: data.verse.present ? data.verse.value : this.verse,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordExampleData(')
          ..write('id: $id, ')
          ..write('senseId: $senseId, ')
          ..write('exampleType: $exampleType, ')
          ..write('textContent: $textContent, ')
          ..write('sourceReference: $sourceReference, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    senseId,
    exampleType,
    textContent,
    sourceReference,
    bookId,
    chapter,
    verse,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordExampleData &&
          other.id == this.id &&
          other.senseId == this.senseId &&
          other.exampleType == this.exampleType &&
          other.textContent == this.textContent &&
          other.sourceReference == this.sourceReference &&
          other.bookId == this.bookId &&
          other.chapter == this.chapter &&
          other.verse == this.verse);
}

class WordExamplesCompanion extends UpdateCompanion<WordExampleData> {
  final Value<int> id;
  final Value<int> senseId;
  final Value<String> exampleType;
  final Value<String> textContent;
  final Value<String> sourceReference;
  final Value<int?> bookId;
  final Value<int?> chapter;
  final Value<int?> verse;
  const WordExamplesCompanion({
    this.id = const Value.absent(),
    this.senseId = const Value.absent(),
    this.exampleType = const Value.absent(),
    this.textContent = const Value.absent(),
    this.sourceReference = const Value.absent(),
    this.bookId = const Value.absent(),
    this.chapter = const Value.absent(),
    this.verse = const Value.absent(),
  });
  WordExamplesCompanion.insert({
    this.id = const Value.absent(),
    required int senseId,
    required String exampleType,
    required String textContent,
    this.sourceReference = const Value.absent(),
    this.bookId = const Value.absent(),
    this.chapter = const Value.absent(),
    this.verse = const Value.absent(),
  }) : senseId = Value(senseId),
       exampleType = Value(exampleType),
       textContent = Value(textContent);
  static Insertable<WordExampleData> custom({
    Expression<int>? id,
    Expression<int>? senseId,
    Expression<String>? exampleType,
    Expression<String>? textContent,
    Expression<String>? sourceReference,
    Expression<int>? bookId,
    Expression<int>? chapter,
    Expression<int>? verse,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (senseId != null) 'sense_id': senseId,
      if (exampleType != null) 'example_type': exampleType,
      if (textContent != null) 'text': textContent,
      if (sourceReference != null) 'source_reference': sourceReference,
      if (bookId != null) 'book_id': bookId,
      if (chapter != null) 'chapter': chapter,
      if (verse != null) 'verse': verse,
    });
  }

  WordExamplesCompanion copyWith({
    Value<int>? id,
    Value<int>? senseId,
    Value<String>? exampleType,
    Value<String>? textContent,
    Value<String>? sourceReference,
    Value<int?>? bookId,
    Value<int?>? chapter,
    Value<int?>? verse,
  }) {
    return WordExamplesCompanion(
      id: id ?? this.id,
      senseId: senseId ?? this.senseId,
      exampleType: exampleType ?? this.exampleType,
      textContent: textContent ?? this.textContent,
      sourceReference: sourceReference ?? this.sourceReference,
      bookId: bookId ?? this.bookId,
      chapter: chapter ?? this.chapter,
      verse: verse ?? this.verse,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (senseId.present) {
      map['sense_id'] = Variable<int>(senseId.value);
    }
    if (exampleType.present) {
      map['example_type'] = Variable<String>(exampleType.value);
    }
    if (textContent.present) {
      map['text'] = Variable<String>(textContent.value);
    }
    if (sourceReference.present) {
      map['source_reference'] = Variable<String>(sourceReference.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (chapter.present) {
      map['chapter'] = Variable<int>(chapter.value);
    }
    if (verse.present) {
      map['verse'] = Variable<int>(verse.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordExamplesCompanion(')
          ..write('id: $id, ')
          ..write('senseId: $senseId, ')
          ..write('exampleType: $exampleType, ')
          ..write('textContent: $textContent, ')
          ..write('sourceReference: $sourceReference, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse')
          ..write(')'))
        .toString();
  }
}

class $WordFormsTable extends WordForms
    with TableInfo<$WordFormsTable, WordFormData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordFormsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _entryIdMeta = const VerificationMeta(
    'entryId',
  );
  @override
  late final GeneratedColumn<int> entryId = GeneratedColumn<int>(
    'entry_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES dictionary_entries (id)',
    ),
  );
  static const VerificationMeta _formTypeMeta = const VerificationMeta(
    'formType',
  );
  @override
  late final GeneratedColumn<String> formType = GeneratedColumn<String>(
    'form_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 40,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _formMeta = const VerificationMeta('form');
  @override
  late final GeneratedColumn<String> form = GeneratedColumn<String>(
    'form',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, entryId, formType, form];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_forms';
  @override
  VerificationContext validateIntegrity(
    Insertable<WordFormData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entry_id')) {
      context.handle(
        _entryIdMeta,
        entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('form_type')) {
      context.handle(
        _formTypeMeta,
        formType.isAcceptableOrUnknown(data['form_type']!, _formTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_formTypeMeta);
    }
    if (data.containsKey('form')) {
      context.handle(
        _formMeta,
        form.isAcceptableOrUnknown(data['form']!, _formMeta),
      );
    } else if (isInserting) {
      context.missing(_formMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WordFormData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordFormData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      entryId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}entry_id'],
          )!,
      formType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}form_type'],
          )!,
      form:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}form'],
          )!,
    );
  }

  @override
  $WordFormsTable createAlias(String alias) {
    return $WordFormsTable(attachedDatabase, alias);
  }
}

class WordFormData extends DataClass implements Insertable<WordFormData> {
  final int id;
  final int entryId;
  final String formType;
  final String form;
  const WordFormData({
    required this.id,
    required this.entryId,
    required this.formType,
    required this.form,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entry_id'] = Variable<int>(entryId);
    map['form_type'] = Variable<String>(formType);
    map['form'] = Variable<String>(form);
    return map;
  }

  WordFormsCompanion toCompanion(bool nullToAbsent) {
    return WordFormsCompanion(
      id: Value(id),
      entryId: Value(entryId),
      formType: Value(formType),
      form: Value(form),
    );
  }

  factory WordFormData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordFormData(
      id: serializer.fromJson<int>(json['id']),
      entryId: serializer.fromJson<int>(json['entryId']),
      formType: serializer.fromJson<String>(json['formType']),
      form: serializer.fromJson<String>(json['form']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entryId': serializer.toJson<int>(entryId),
      'formType': serializer.toJson<String>(formType),
      'form': serializer.toJson<String>(form),
    };
  }

  WordFormData copyWith({
    int? id,
    int? entryId,
    String? formType,
    String? form,
  }) => WordFormData(
    id: id ?? this.id,
    entryId: entryId ?? this.entryId,
    formType: formType ?? this.formType,
    form: form ?? this.form,
  );
  WordFormData copyWithCompanion(WordFormsCompanion data) {
    return WordFormData(
      id: data.id.present ? data.id.value : this.id,
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      formType: data.formType.present ? data.formType.value : this.formType,
      form: data.form.present ? data.form.value : this.form,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordFormData(')
          ..write('id: $id, ')
          ..write('entryId: $entryId, ')
          ..write('formType: $formType, ')
          ..write('form: $form')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, entryId, formType, form);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordFormData &&
          other.id == this.id &&
          other.entryId == this.entryId &&
          other.formType == this.formType &&
          other.form == this.form);
}

class WordFormsCompanion extends UpdateCompanion<WordFormData> {
  final Value<int> id;
  final Value<int> entryId;
  final Value<String> formType;
  final Value<String> form;
  const WordFormsCompanion({
    this.id = const Value.absent(),
    this.entryId = const Value.absent(),
    this.formType = const Value.absent(),
    this.form = const Value.absent(),
  });
  WordFormsCompanion.insert({
    this.id = const Value.absent(),
    required int entryId,
    required String formType,
    required String form,
  }) : entryId = Value(entryId),
       formType = Value(formType),
       form = Value(form);
  static Insertable<WordFormData> custom({
    Expression<int>? id,
    Expression<int>? entryId,
    Expression<String>? formType,
    Expression<String>? form,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entryId != null) 'entry_id': entryId,
      if (formType != null) 'form_type': formType,
      if (form != null) 'form': form,
    });
  }

  WordFormsCompanion copyWith({
    Value<int>? id,
    Value<int>? entryId,
    Value<String>? formType,
    Value<String>? form,
  }) {
    return WordFormsCompanion(
      id: id ?? this.id,
      entryId: entryId ?? this.entryId,
      formType: formType ?? this.formType,
      form: form ?? this.form,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entryId.present) {
      map['entry_id'] = Variable<int>(entryId.value);
    }
    if (formType.present) {
      map['form_type'] = Variable<String>(formType.value);
    }
    if (form.present) {
      map['form'] = Variable<String>(form.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordFormsCompanion(')
          ..write('id: $id, ')
          ..write('entryId: $entryId, ')
          ..write('formType: $formType, ')
          ..write('form: $form')
          ..write(')'))
        .toString();
  }
}

class $WordnetSynsetsTable extends WordnetSynsets
    with TableInfo<$WordnetSynsetsTable, WordnetSynsetData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordnetSynsetsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _synsetIdMeta = const VerificationMeta(
    'synsetId',
  );
  @override
  late final GeneratedColumn<String> synsetId = GeneratedColumn<String>(
    'synset_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _posCodeMeta = const VerificationMeta(
    'posCode',
  );
  @override
  late final GeneratedColumn<String> posCode = GeneratedColumn<String>(
    'pos_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 1,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _definitionMeta = const VerificationMeta(
    'definition',
  );
  @override
  late final GeneratedColumn<String> definition = GeneratedColumn<String>(
    'definition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _examplesMeta = const VerificationMeta(
    'examples',
  );
  @override
  late final GeneratedColumn<String> examples = GeneratedColumn<String>(
    'examples',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    synsetId,
    posCode,
    definition,
    examples,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wordnet_synsets';
  @override
  VerificationContext validateIntegrity(
    Insertable<WordnetSynsetData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('synset_id')) {
      context.handle(
        _synsetIdMeta,
        synsetId.isAcceptableOrUnknown(data['synset_id']!, _synsetIdMeta),
      );
    } else if (isInserting) {
      context.missing(_synsetIdMeta);
    }
    if (data.containsKey('pos_code')) {
      context.handle(
        _posCodeMeta,
        posCode.isAcceptableOrUnknown(data['pos_code']!, _posCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_posCodeMeta);
    }
    if (data.containsKey('definition')) {
      context.handle(
        _definitionMeta,
        definition.isAcceptableOrUnknown(data['definition']!, _definitionMeta),
      );
    } else if (isInserting) {
      context.missing(_definitionMeta);
    }
    if (data.containsKey('examples')) {
      context.handle(
        _examplesMeta,
        examples.isAcceptableOrUnknown(data['examples']!, _examplesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {synsetId},
  ];
  @override
  WordnetSynsetData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordnetSynsetData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      synsetId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}synset_id'],
          )!,
      posCode:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}pos_code'],
          )!,
      definition:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}definition'],
          )!,
      examples:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}examples'],
          )!,
    );
  }

  @override
  $WordnetSynsetsTable createAlias(String alias) {
    return $WordnetSynsetsTable(attachedDatabase, alias);
  }
}

class WordnetSynsetData extends DataClass
    implements Insertable<WordnetSynsetData> {
  final int id;
  final String synsetId;
  final String posCode;
  final String definition;
  final String examples;
  const WordnetSynsetData({
    required this.id,
    required this.synsetId,
    required this.posCode,
    required this.definition,
    required this.examples,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['synset_id'] = Variable<String>(synsetId);
    map['pos_code'] = Variable<String>(posCode);
    map['definition'] = Variable<String>(definition);
    map['examples'] = Variable<String>(examples);
    return map;
  }

  WordnetSynsetsCompanion toCompanion(bool nullToAbsent) {
    return WordnetSynsetsCompanion(
      id: Value(id),
      synsetId: Value(synsetId),
      posCode: Value(posCode),
      definition: Value(definition),
      examples: Value(examples),
    );
  }

  factory WordnetSynsetData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordnetSynsetData(
      id: serializer.fromJson<int>(json['id']),
      synsetId: serializer.fromJson<String>(json['synsetId']),
      posCode: serializer.fromJson<String>(json['posCode']),
      definition: serializer.fromJson<String>(json['definition']),
      examples: serializer.fromJson<String>(json['examples']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'synsetId': serializer.toJson<String>(synsetId),
      'posCode': serializer.toJson<String>(posCode),
      'definition': serializer.toJson<String>(definition),
      'examples': serializer.toJson<String>(examples),
    };
  }

  WordnetSynsetData copyWith({
    int? id,
    String? synsetId,
    String? posCode,
    String? definition,
    String? examples,
  }) => WordnetSynsetData(
    id: id ?? this.id,
    synsetId: synsetId ?? this.synsetId,
    posCode: posCode ?? this.posCode,
    definition: definition ?? this.definition,
    examples: examples ?? this.examples,
  );
  WordnetSynsetData copyWithCompanion(WordnetSynsetsCompanion data) {
    return WordnetSynsetData(
      id: data.id.present ? data.id.value : this.id,
      synsetId: data.synsetId.present ? data.synsetId.value : this.synsetId,
      posCode: data.posCode.present ? data.posCode.value : this.posCode,
      definition:
          data.definition.present ? data.definition.value : this.definition,
      examples: data.examples.present ? data.examples.value : this.examples,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordnetSynsetData(')
          ..write('id: $id, ')
          ..write('synsetId: $synsetId, ')
          ..write('posCode: $posCode, ')
          ..write('definition: $definition, ')
          ..write('examples: $examples')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, synsetId, posCode, definition, examples);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordnetSynsetData &&
          other.id == this.id &&
          other.synsetId == this.synsetId &&
          other.posCode == this.posCode &&
          other.definition == this.definition &&
          other.examples == this.examples);
}

class WordnetSynsetsCompanion extends UpdateCompanion<WordnetSynsetData> {
  final Value<int> id;
  final Value<String> synsetId;
  final Value<String> posCode;
  final Value<String> definition;
  final Value<String> examples;
  const WordnetSynsetsCompanion({
    this.id = const Value.absent(),
    this.synsetId = const Value.absent(),
    this.posCode = const Value.absent(),
    this.definition = const Value.absent(),
    this.examples = const Value.absent(),
  });
  WordnetSynsetsCompanion.insert({
    this.id = const Value.absent(),
    required String synsetId,
    required String posCode,
    required String definition,
    this.examples = const Value.absent(),
  }) : synsetId = Value(synsetId),
       posCode = Value(posCode),
       definition = Value(definition);
  static Insertable<WordnetSynsetData> custom({
    Expression<int>? id,
    Expression<String>? synsetId,
    Expression<String>? posCode,
    Expression<String>? definition,
    Expression<String>? examples,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (synsetId != null) 'synset_id': synsetId,
      if (posCode != null) 'pos_code': posCode,
      if (definition != null) 'definition': definition,
      if (examples != null) 'examples': examples,
    });
  }

  WordnetSynsetsCompanion copyWith({
    Value<int>? id,
    Value<String>? synsetId,
    Value<String>? posCode,
    Value<String>? definition,
    Value<String>? examples,
  }) {
    return WordnetSynsetsCompanion(
      id: id ?? this.id,
      synsetId: synsetId ?? this.synsetId,
      posCode: posCode ?? this.posCode,
      definition: definition ?? this.definition,
      examples: examples ?? this.examples,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (synsetId.present) {
      map['synset_id'] = Variable<String>(synsetId.value);
    }
    if (posCode.present) {
      map['pos_code'] = Variable<String>(posCode.value);
    }
    if (definition.present) {
      map['definition'] = Variable<String>(definition.value);
    }
    if (examples.present) {
      map['examples'] = Variable<String>(examples.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordnetSynsetsCompanion(')
          ..write('id: $id, ')
          ..write('synsetId: $synsetId, ')
          ..write('posCode: $posCode, ')
          ..write('definition: $definition, ')
          ..write('examples: $examples')
          ..write(')'))
        .toString();
  }
}

class $WordnetLemmasTable extends WordnetLemmas
    with TableInfo<$WordnetLemmasTable, WordnetLemmaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordnetLemmasTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _entryIdMeta = const VerificationMeta(
    'entryId',
  );
  @override
  late final GeneratedColumn<int> entryId = GeneratedColumn<int>(
    'entry_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES dictionary_entries (id)',
    ),
  );
  static const VerificationMeta _synsetIdMeta = const VerificationMeta(
    'synsetId',
  );
  @override
  late final GeneratedColumn<int> synsetId = GeneratedColumn<int>(
    'synset_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES wordnet_synsets (id)',
    ),
  );
  static const VerificationMeta _lemmaOrderMeta = const VerificationMeta(
    'lemmaOrder',
  );
  @override
  late final GeneratedColumn<int> lemmaOrder = GeneratedColumn<int>(
    'lemma_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, entryId, synsetId, lemmaOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wordnet_lemmas';
  @override
  VerificationContext validateIntegrity(
    Insertable<WordnetLemmaData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entry_id')) {
      context.handle(
        _entryIdMeta,
        entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('synset_id')) {
      context.handle(
        _synsetIdMeta,
        synsetId.isAcceptableOrUnknown(data['synset_id']!, _synsetIdMeta),
      );
    } else if (isInserting) {
      context.missing(_synsetIdMeta);
    }
    if (data.containsKey('lemma_order')) {
      context.handle(
        _lemmaOrderMeta,
        lemmaOrder.isAcceptableOrUnknown(data['lemma_order']!, _lemmaOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WordnetLemmaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordnetLemmaData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      entryId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}entry_id'],
          )!,
      synsetId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}synset_id'],
          )!,
      lemmaOrder:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}lemma_order'],
          )!,
    );
  }

  @override
  $WordnetLemmasTable createAlias(String alias) {
    return $WordnetLemmasTable(attachedDatabase, alias);
  }
}

class WordnetLemmaData extends DataClass
    implements Insertable<WordnetLemmaData> {
  final int id;
  final int entryId;
  final int synsetId;
  final int lemmaOrder;
  const WordnetLemmaData({
    required this.id,
    required this.entryId,
    required this.synsetId,
    required this.lemmaOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entry_id'] = Variable<int>(entryId);
    map['synset_id'] = Variable<int>(synsetId);
    map['lemma_order'] = Variable<int>(lemmaOrder);
    return map;
  }

  WordnetLemmasCompanion toCompanion(bool nullToAbsent) {
    return WordnetLemmasCompanion(
      id: Value(id),
      entryId: Value(entryId),
      synsetId: Value(synsetId),
      lemmaOrder: Value(lemmaOrder),
    );
  }

  factory WordnetLemmaData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordnetLemmaData(
      id: serializer.fromJson<int>(json['id']),
      entryId: serializer.fromJson<int>(json['entryId']),
      synsetId: serializer.fromJson<int>(json['synsetId']),
      lemmaOrder: serializer.fromJson<int>(json['lemmaOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entryId': serializer.toJson<int>(entryId),
      'synsetId': serializer.toJson<int>(synsetId),
      'lemmaOrder': serializer.toJson<int>(lemmaOrder),
    };
  }

  WordnetLemmaData copyWith({
    int? id,
    int? entryId,
    int? synsetId,
    int? lemmaOrder,
  }) => WordnetLemmaData(
    id: id ?? this.id,
    entryId: entryId ?? this.entryId,
    synsetId: synsetId ?? this.synsetId,
    lemmaOrder: lemmaOrder ?? this.lemmaOrder,
  );
  WordnetLemmaData copyWithCompanion(WordnetLemmasCompanion data) {
    return WordnetLemmaData(
      id: data.id.present ? data.id.value : this.id,
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      synsetId: data.synsetId.present ? data.synsetId.value : this.synsetId,
      lemmaOrder:
          data.lemmaOrder.present ? data.lemmaOrder.value : this.lemmaOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordnetLemmaData(')
          ..write('id: $id, ')
          ..write('entryId: $entryId, ')
          ..write('synsetId: $synsetId, ')
          ..write('lemmaOrder: $lemmaOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, entryId, synsetId, lemmaOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordnetLemmaData &&
          other.id == this.id &&
          other.entryId == this.entryId &&
          other.synsetId == this.synsetId &&
          other.lemmaOrder == this.lemmaOrder);
}

class WordnetLemmasCompanion extends UpdateCompanion<WordnetLemmaData> {
  final Value<int> id;
  final Value<int> entryId;
  final Value<int> synsetId;
  final Value<int> lemmaOrder;
  const WordnetLemmasCompanion({
    this.id = const Value.absent(),
    this.entryId = const Value.absent(),
    this.synsetId = const Value.absent(),
    this.lemmaOrder = const Value.absent(),
  });
  WordnetLemmasCompanion.insert({
    this.id = const Value.absent(),
    required int entryId,
    required int synsetId,
    this.lemmaOrder = const Value.absent(),
  }) : entryId = Value(entryId),
       synsetId = Value(synsetId);
  static Insertable<WordnetLemmaData> custom({
    Expression<int>? id,
    Expression<int>? entryId,
    Expression<int>? synsetId,
    Expression<int>? lemmaOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entryId != null) 'entry_id': entryId,
      if (synsetId != null) 'synset_id': synsetId,
      if (lemmaOrder != null) 'lemma_order': lemmaOrder,
    });
  }

  WordnetLemmasCompanion copyWith({
    Value<int>? id,
    Value<int>? entryId,
    Value<int>? synsetId,
    Value<int>? lemmaOrder,
  }) {
    return WordnetLemmasCompanion(
      id: id ?? this.id,
      entryId: entryId ?? this.entryId,
      synsetId: synsetId ?? this.synsetId,
      lemmaOrder: lemmaOrder ?? this.lemmaOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entryId.present) {
      map['entry_id'] = Variable<int>(entryId.value);
    }
    if (synsetId.present) {
      map['synset_id'] = Variable<int>(synsetId.value);
    }
    if (lemmaOrder.present) {
      map['lemma_order'] = Variable<int>(lemmaOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordnetLemmasCompanion(')
          ..write('id: $id, ')
          ..write('entryId: $entryId, ')
          ..write('synsetId: $synsetId, ')
          ..write('lemmaOrder: $lemmaOrder')
          ..write(')'))
        .toString();
  }
}

class $WordnetRelationsTable extends WordnetRelations
    with TableInfo<$WordnetRelationsTable, WordnetRelationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordnetRelationsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _fromSynsetIdMeta = const VerificationMeta(
    'fromSynsetId',
  );
  @override
  late final GeneratedColumn<int> fromSynsetId = GeneratedColumn<int>(
    'from_synset_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES wordnet_synsets (id)',
    ),
  );
  static const VerificationMeta _toSynsetIdMeta = const VerificationMeta(
    'toSynsetId',
  );
  @override
  late final GeneratedColumn<int> toSynsetId = GeneratedColumn<int>(
    'to_synset_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES wordnet_synsets (id)',
    ),
  );
  static const VerificationMeta _relationTypeMeta = const VerificationMeta(
    'relationType',
  );
  @override
  late final GeneratedColumn<String> relationType = GeneratedColumn<String>(
    'relation_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 30,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fromSynsetId,
    toSynsetId,
    relationType,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wordnet_relations';
  @override
  VerificationContext validateIntegrity(
    Insertable<WordnetRelationData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('from_synset_id')) {
      context.handle(
        _fromSynsetIdMeta,
        fromSynsetId.isAcceptableOrUnknown(
          data['from_synset_id']!,
          _fromSynsetIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fromSynsetIdMeta);
    }
    if (data.containsKey('to_synset_id')) {
      context.handle(
        _toSynsetIdMeta,
        toSynsetId.isAcceptableOrUnknown(
          data['to_synset_id']!,
          _toSynsetIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_toSynsetIdMeta);
    }
    if (data.containsKey('relation_type')) {
      context.handle(
        _relationTypeMeta,
        relationType.isAcceptableOrUnknown(
          data['relation_type']!,
          _relationTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relationTypeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WordnetRelationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordnetRelationData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      fromSynsetId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}from_synset_id'],
          )!,
      toSynsetId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}to_synset_id'],
          )!,
      relationType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}relation_type'],
          )!,
    );
  }

  @override
  $WordnetRelationsTable createAlias(String alias) {
    return $WordnetRelationsTable(attachedDatabase, alias);
  }
}

class WordnetRelationData extends DataClass
    implements Insertable<WordnetRelationData> {
  final int id;
  final int fromSynsetId;
  final int toSynsetId;
  final String relationType;
  const WordnetRelationData({
    required this.id,
    required this.fromSynsetId,
    required this.toSynsetId,
    required this.relationType,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['from_synset_id'] = Variable<int>(fromSynsetId);
    map['to_synset_id'] = Variable<int>(toSynsetId);
    map['relation_type'] = Variable<String>(relationType);
    return map;
  }

  WordnetRelationsCompanion toCompanion(bool nullToAbsent) {
    return WordnetRelationsCompanion(
      id: Value(id),
      fromSynsetId: Value(fromSynsetId),
      toSynsetId: Value(toSynsetId),
      relationType: Value(relationType),
    );
  }

  factory WordnetRelationData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordnetRelationData(
      id: serializer.fromJson<int>(json['id']),
      fromSynsetId: serializer.fromJson<int>(json['fromSynsetId']),
      toSynsetId: serializer.fromJson<int>(json['toSynsetId']),
      relationType: serializer.fromJson<String>(json['relationType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fromSynsetId': serializer.toJson<int>(fromSynsetId),
      'toSynsetId': serializer.toJson<int>(toSynsetId),
      'relationType': serializer.toJson<String>(relationType),
    };
  }

  WordnetRelationData copyWith({
    int? id,
    int? fromSynsetId,
    int? toSynsetId,
    String? relationType,
  }) => WordnetRelationData(
    id: id ?? this.id,
    fromSynsetId: fromSynsetId ?? this.fromSynsetId,
    toSynsetId: toSynsetId ?? this.toSynsetId,
    relationType: relationType ?? this.relationType,
  );
  WordnetRelationData copyWithCompanion(WordnetRelationsCompanion data) {
    return WordnetRelationData(
      id: data.id.present ? data.id.value : this.id,
      fromSynsetId:
          data.fromSynsetId.present
              ? data.fromSynsetId.value
              : this.fromSynsetId,
      toSynsetId:
          data.toSynsetId.present ? data.toSynsetId.value : this.toSynsetId,
      relationType:
          data.relationType.present
              ? data.relationType.value
              : this.relationType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordnetRelationData(')
          ..write('id: $id, ')
          ..write('fromSynsetId: $fromSynsetId, ')
          ..write('toSynsetId: $toSynsetId, ')
          ..write('relationType: $relationType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fromSynsetId, toSynsetId, relationType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordnetRelationData &&
          other.id == this.id &&
          other.fromSynsetId == this.fromSynsetId &&
          other.toSynsetId == this.toSynsetId &&
          other.relationType == this.relationType);
}

class WordnetRelationsCompanion extends UpdateCompanion<WordnetRelationData> {
  final Value<int> id;
  final Value<int> fromSynsetId;
  final Value<int> toSynsetId;
  final Value<String> relationType;
  const WordnetRelationsCompanion({
    this.id = const Value.absent(),
    this.fromSynsetId = const Value.absent(),
    this.toSynsetId = const Value.absent(),
    this.relationType = const Value.absent(),
  });
  WordnetRelationsCompanion.insert({
    this.id = const Value.absent(),
    required int fromSynsetId,
    required int toSynsetId,
    required String relationType,
  }) : fromSynsetId = Value(fromSynsetId),
       toSynsetId = Value(toSynsetId),
       relationType = Value(relationType);
  static Insertable<WordnetRelationData> custom({
    Expression<int>? id,
    Expression<int>? fromSynsetId,
    Expression<int>? toSynsetId,
    Expression<String>? relationType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fromSynsetId != null) 'from_synset_id': fromSynsetId,
      if (toSynsetId != null) 'to_synset_id': toSynsetId,
      if (relationType != null) 'relation_type': relationType,
    });
  }

  WordnetRelationsCompanion copyWith({
    Value<int>? id,
    Value<int>? fromSynsetId,
    Value<int>? toSynsetId,
    Value<String>? relationType,
  }) {
    return WordnetRelationsCompanion(
      id: id ?? this.id,
      fromSynsetId: fromSynsetId ?? this.fromSynsetId,
      toSynsetId: toSynsetId ?? this.toSynsetId,
      relationType: relationType ?? this.relationType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fromSynsetId.present) {
      map['from_synset_id'] = Variable<int>(fromSynsetId.value);
    }
    if (toSynsetId.present) {
      map['to_synset_id'] = Variable<int>(toSynsetId.value);
    }
    if (relationType.present) {
      map['relation_type'] = Variable<String>(relationType.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordnetRelationsCompanion(')
          ..write('id: $id, ')
          ..write('fromSynsetId: $fromSynsetId, ')
          ..write('toSynsetId: $toSynsetId, ')
          ..write('relationType: $relationType')
          ..write(')'))
        .toString();
  }
}

class $StrongEntriesTable extends StrongEntries
    with TableInfo<$StrongEntriesTable, StrongEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StrongEntriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _strongNumberMeta = const VerificationMeta(
    'strongNumber',
  );
  @override
  late final GeneratedColumn<String> strongNumber = GeneratedColumn<String>(
    'strong_number',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _testamentMeta = const VerificationMeta(
    'testament',
  );
  @override
  late final GeneratedColumn<String> testament = GeneratedColumn<String>(
    'testament',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 2,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originalWordMeta = const VerificationMeta(
    'originalWord',
  );
  @override
  late final GeneratedColumn<String> originalWord = GeneratedColumn<String>(
    'original_word',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transliterationMeta = const VerificationMeta(
    'transliteration',
  );
  @override
  late final GeneratedColumn<String> transliteration = GeneratedColumn<String>(
    'transliteration',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _pronunciationMeta = const VerificationMeta(
    'pronunciation',
  );
  @override
  late final GeneratedColumn<String> pronunciation = GeneratedColumn<String>(
    'pronunciation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _partOfSpeechMeta = const VerificationMeta(
    'partOfSpeech',
  );
  @override
  late final GeneratedColumn<String> partOfSpeech = GeneratedColumn<String>(
    'part_of_speech',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _shortDefinitionMeta = const VerificationMeta(
    'shortDefinition',
  );
  @override
  late final GeneratedColumn<String> shortDefinition = GeneratedColumn<String>(
    'short_definition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullDefinitionMeta = const VerificationMeta(
    'fullDefinition',
  );
  @override
  late final GeneratedColumn<String> fullDefinition = GeneratedColumn<String>(
    'full_definition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _derivationMeta = const VerificationMeta(
    'derivation',
  );
  @override
  late final GeneratedColumn<String> derivation = GeneratedColumn<String>(
    'derivation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _kjvFrequencyMeta = const VerificationMeta(
    'kjvFrequency',
  );
  @override
  late final GeneratedColumn<int> kjvFrequency = GeneratedColumn<int>(
    'kjv_frequency',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    strongNumber,
    testament,
    originalWord,
    transliteration,
    pronunciation,
    partOfSpeech,
    shortDefinition,
    fullDefinition,
    derivation,
    kjvFrequency,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'strong_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<StrongEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('strong_number')) {
      context.handle(
        _strongNumberMeta,
        strongNumber.isAcceptableOrUnknown(
          data['strong_number']!,
          _strongNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_strongNumberMeta);
    }
    if (data.containsKey('testament')) {
      context.handle(
        _testamentMeta,
        testament.isAcceptableOrUnknown(data['testament']!, _testamentMeta),
      );
    } else if (isInserting) {
      context.missing(_testamentMeta);
    }
    if (data.containsKey('original_word')) {
      context.handle(
        _originalWordMeta,
        originalWord.isAcceptableOrUnknown(
          data['original_word']!,
          _originalWordMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalWordMeta);
    }
    if (data.containsKey('transliteration')) {
      context.handle(
        _transliterationMeta,
        transliteration.isAcceptableOrUnknown(
          data['transliteration']!,
          _transliterationMeta,
        ),
      );
    }
    if (data.containsKey('pronunciation')) {
      context.handle(
        _pronunciationMeta,
        pronunciation.isAcceptableOrUnknown(
          data['pronunciation']!,
          _pronunciationMeta,
        ),
      );
    }
    if (data.containsKey('part_of_speech')) {
      context.handle(
        _partOfSpeechMeta,
        partOfSpeech.isAcceptableOrUnknown(
          data['part_of_speech']!,
          _partOfSpeechMeta,
        ),
      );
    }
    if (data.containsKey('short_definition')) {
      context.handle(
        _shortDefinitionMeta,
        shortDefinition.isAcceptableOrUnknown(
          data['short_definition']!,
          _shortDefinitionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_shortDefinitionMeta);
    }
    if (data.containsKey('full_definition')) {
      context.handle(
        _fullDefinitionMeta,
        fullDefinition.isAcceptableOrUnknown(
          data['full_definition']!,
          _fullDefinitionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fullDefinitionMeta);
    }
    if (data.containsKey('derivation')) {
      context.handle(
        _derivationMeta,
        derivation.isAcceptableOrUnknown(data['derivation']!, _derivationMeta),
      );
    }
    if (data.containsKey('kjv_frequency')) {
      context.handle(
        _kjvFrequencyMeta,
        kjvFrequency.isAcceptableOrUnknown(
          data['kjv_frequency']!,
          _kjvFrequencyMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {strongNumber},
  ];
  @override
  StrongEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StrongEntry(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      strongNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}strong_number'],
          )!,
      testament:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}testament'],
          )!,
      originalWord:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}original_word'],
          )!,
      transliteration:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}transliteration'],
          )!,
      pronunciation:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}pronunciation'],
          )!,
      partOfSpeech:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}part_of_speech'],
          )!,
      shortDefinition:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}short_definition'],
          )!,
      fullDefinition:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}full_definition'],
          )!,
      derivation:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}derivation'],
          )!,
      kjvFrequency:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}kjv_frequency'],
          )!,
    );
  }

  @override
  $StrongEntriesTable createAlias(String alias) {
    return $StrongEntriesTable(attachedDatabase, alias);
  }
}

class StrongEntry extends DataClass implements Insertable<StrongEntry> {
  final int id;
  final String strongNumber;
  final String testament;
  final String originalWord;
  final String transliteration;
  final String pronunciation;
  final String partOfSpeech;
  final String shortDefinition;
  final String fullDefinition;
  final String derivation;
  final int kjvFrequency;
  const StrongEntry({
    required this.id,
    required this.strongNumber,
    required this.testament,
    required this.originalWord,
    required this.transliteration,
    required this.pronunciation,
    required this.partOfSpeech,
    required this.shortDefinition,
    required this.fullDefinition,
    required this.derivation,
    required this.kjvFrequency,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['strong_number'] = Variable<String>(strongNumber);
    map['testament'] = Variable<String>(testament);
    map['original_word'] = Variable<String>(originalWord);
    map['transliteration'] = Variable<String>(transliteration);
    map['pronunciation'] = Variable<String>(pronunciation);
    map['part_of_speech'] = Variable<String>(partOfSpeech);
    map['short_definition'] = Variable<String>(shortDefinition);
    map['full_definition'] = Variable<String>(fullDefinition);
    map['derivation'] = Variable<String>(derivation);
    map['kjv_frequency'] = Variable<int>(kjvFrequency);
    return map;
  }

  StrongEntriesCompanion toCompanion(bool nullToAbsent) {
    return StrongEntriesCompanion(
      id: Value(id),
      strongNumber: Value(strongNumber),
      testament: Value(testament),
      originalWord: Value(originalWord),
      transliteration: Value(transliteration),
      pronunciation: Value(pronunciation),
      partOfSpeech: Value(partOfSpeech),
      shortDefinition: Value(shortDefinition),
      fullDefinition: Value(fullDefinition),
      derivation: Value(derivation),
      kjvFrequency: Value(kjvFrequency),
    );
  }

  factory StrongEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StrongEntry(
      id: serializer.fromJson<int>(json['id']),
      strongNumber: serializer.fromJson<String>(json['strongNumber']),
      testament: serializer.fromJson<String>(json['testament']),
      originalWord: serializer.fromJson<String>(json['originalWord']),
      transliteration: serializer.fromJson<String>(json['transliteration']),
      pronunciation: serializer.fromJson<String>(json['pronunciation']),
      partOfSpeech: serializer.fromJson<String>(json['partOfSpeech']),
      shortDefinition: serializer.fromJson<String>(json['shortDefinition']),
      fullDefinition: serializer.fromJson<String>(json['fullDefinition']),
      derivation: serializer.fromJson<String>(json['derivation']),
      kjvFrequency: serializer.fromJson<int>(json['kjvFrequency']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'strongNumber': serializer.toJson<String>(strongNumber),
      'testament': serializer.toJson<String>(testament),
      'originalWord': serializer.toJson<String>(originalWord),
      'transliteration': serializer.toJson<String>(transliteration),
      'pronunciation': serializer.toJson<String>(pronunciation),
      'partOfSpeech': serializer.toJson<String>(partOfSpeech),
      'shortDefinition': serializer.toJson<String>(shortDefinition),
      'fullDefinition': serializer.toJson<String>(fullDefinition),
      'derivation': serializer.toJson<String>(derivation),
      'kjvFrequency': serializer.toJson<int>(kjvFrequency),
    };
  }

  StrongEntry copyWith({
    int? id,
    String? strongNumber,
    String? testament,
    String? originalWord,
    String? transliteration,
    String? pronunciation,
    String? partOfSpeech,
    String? shortDefinition,
    String? fullDefinition,
    String? derivation,
    int? kjvFrequency,
  }) => StrongEntry(
    id: id ?? this.id,
    strongNumber: strongNumber ?? this.strongNumber,
    testament: testament ?? this.testament,
    originalWord: originalWord ?? this.originalWord,
    transliteration: transliteration ?? this.transliteration,
    pronunciation: pronunciation ?? this.pronunciation,
    partOfSpeech: partOfSpeech ?? this.partOfSpeech,
    shortDefinition: shortDefinition ?? this.shortDefinition,
    fullDefinition: fullDefinition ?? this.fullDefinition,
    derivation: derivation ?? this.derivation,
    kjvFrequency: kjvFrequency ?? this.kjvFrequency,
  );
  StrongEntry copyWithCompanion(StrongEntriesCompanion data) {
    return StrongEntry(
      id: data.id.present ? data.id.value : this.id,
      strongNumber:
          data.strongNumber.present
              ? data.strongNumber.value
              : this.strongNumber,
      testament: data.testament.present ? data.testament.value : this.testament,
      originalWord:
          data.originalWord.present
              ? data.originalWord.value
              : this.originalWord,
      transliteration:
          data.transliteration.present
              ? data.transliteration.value
              : this.transliteration,
      pronunciation:
          data.pronunciation.present
              ? data.pronunciation.value
              : this.pronunciation,
      partOfSpeech:
          data.partOfSpeech.present
              ? data.partOfSpeech.value
              : this.partOfSpeech,
      shortDefinition:
          data.shortDefinition.present
              ? data.shortDefinition.value
              : this.shortDefinition,
      fullDefinition:
          data.fullDefinition.present
              ? data.fullDefinition.value
              : this.fullDefinition,
      derivation:
          data.derivation.present ? data.derivation.value : this.derivation,
      kjvFrequency:
          data.kjvFrequency.present
              ? data.kjvFrequency.value
              : this.kjvFrequency,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StrongEntry(')
          ..write('id: $id, ')
          ..write('strongNumber: $strongNumber, ')
          ..write('testament: $testament, ')
          ..write('originalWord: $originalWord, ')
          ..write('transliteration: $transliteration, ')
          ..write('pronunciation: $pronunciation, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('shortDefinition: $shortDefinition, ')
          ..write('fullDefinition: $fullDefinition, ')
          ..write('derivation: $derivation, ')
          ..write('kjvFrequency: $kjvFrequency')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    strongNumber,
    testament,
    originalWord,
    transliteration,
    pronunciation,
    partOfSpeech,
    shortDefinition,
    fullDefinition,
    derivation,
    kjvFrequency,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StrongEntry &&
          other.id == this.id &&
          other.strongNumber == this.strongNumber &&
          other.testament == this.testament &&
          other.originalWord == this.originalWord &&
          other.transliteration == this.transliteration &&
          other.pronunciation == this.pronunciation &&
          other.partOfSpeech == this.partOfSpeech &&
          other.shortDefinition == this.shortDefinition &&
          other.fullDefinition == this.fullDefinition &&
          other.derivation == this.derivation &&
          other.kjvFrequency == this.kjvFrequency);
}

class StrongEntriesCompanion extends UpdateCompanion<StrongEntry> {
  final Value<int> id;
  final Value<String> strongNumber;
  final Value<String> testament;
  final Value<String> originalWord;
  final Value<String> transliteration;
  final Value<String> pronunciation;
  final Value<String> partOfSpeech;
  final Value<String> shortDefinition;
  final Value<String> fullDefinition;
  final Value<String> derivation;
  final Value<int> kjvFrequency;
  const StrongEntriesCompanion({
    this.id = const Value.absent(),
    this.strongNumber = const Value.absent(),
    this.testament = const Value.absent(),
    this.originalWord = const Value.absent(),
    this.transliteration = const Value.absent(),
    this.pronunciation = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
    this.shortDefinition = const Value.absent(),
    this.fullDefinition = const Value.absent(),
    this.derivation = const Value.absent(),
    this.kjvFrequency = const Value.absent(),
  });
  StrongEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String strongNumber,
    required String testament,
    required String originalWord,
    this.transliteration = const Value.absent(),
    this.pronunciation = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
    required String shortDefinition,
    required String fullDefinition,
    this.derivation = const Value.absent(),
    this.kjvFrequency = const Value.absent(),
  }) : strongNumber = Value(strongNumber),
       testament = Value(testament),
       originalWord = Value(originalWord),
       shortDefinition = Value(shortDefinition),
       fullDefinition = Value(fullDefinition);
  static Insertable<StrongEntry> custom({
    Expression<int>? id,
    Expression<String>? strongNumber,
    Expression<String>? testament,
    Expression<String>? originalWord,
    Expression<String>? transliteration,
    Expression<String>? pronunciation,
    Expression<String>? partOfSpeech,
    Expression<String>? shortDefinition,
    Expression<String>? fullDefinition,
    Expression<String>? derivation,
    Expression<int>? kjvFrequency,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (strongNumber != null) 'strong_number': strongNumber,
      if (testament != null) 'testament': testament,
      if (originalWord != null) 'original_word': originalWord,
      if (transliteration != null) 'transliteration': transliteration,
      if (pronunciation != null) 'pronunciation': pronunciation,
      if (partOfSpeech != null) 'part_of_speech': partOfSpeech,
      if (shortDefinition != null) 'short_definition': shortDefinition,
      if (fullDefinition != null) 'full_definition': fullDefinition,
      if (derivation != null) 'derivation': derivation,
      if (kjvFrequency != null) 'kjv_frequency': kjvFrequency,
    });
  }

  StrongEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? strongNumber,
    Value<String>? testament,
    Value<String>? originalWord,
    Value<String>? transliteration,
    Value<String>? pronunciation,
    Value<String>? partOfSpeech,
    Value<String>? shortDefinition,
    Value<String>? fullDefinition,
    Value<String>? derivation,
    Value<int>? kjvFrequency,
  }) {
    return StrongEntriesCompanion(
      id: id ?? this.id,
      strongNumber: strongNumber ?? this.strongNumber,
      testament: testament ?? this.testament,
      originalWord: originalWord ?? this.originalWord,
      transliteration: transliteration ?? this.transliteration,
      pronunciation: pronunciation ?? this.pronunciation,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      shortDefinition: shortDefinition ?? this.shortDefinition,
      fullDefinition: fullDefinition ?? this.fullDefinition,
      derivation: derivation ?? this.derivation,
      kjvFrequency: kjvFrequency ?? this.kjvFrequency,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (strongNumber.present) {
      map['strong_number'] = Variable<String>(strongNumber.value);
    }
    if (testament.present) {
      map['testament'] = Variable<String>(testament.value);
    }
    if (originalWord.present) {
      map['original_word'] = Variable<String>(originalWord.value);
    }
    if (transliteration.present) {
      map['transliteration'] = Variable<String>(transliteration.value);
    }
    if (pronunciation.present) {
      map['pronunciation'] = Variable<String>(pronunciation.value);
    }
    if (partOfSpeech.present) {
      map['part_of_speech'] = Variable<String>(partOfSpeech.value);
    }
    if (shortDefinition.present) {
      map['short_definition'] = Variable<String>(shortDefinition.value);
    }
    if (fullDefinition.present) {
      map['full_definition'] = Variable<String>(fullDefinition.value);
    }
    if (derivation.present) {
      map['derivation'] = Variable<String>(derivation.value);
    }
    if (kjvFrequency.present) {
      map['kjv_frequency'] = Variable<int>(kjvFrequency.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StrongEntriesCompanion(')
          ..write('id: $id, ')
          ..write('strongNumber: $strongNumber, ')
          ..write('testament: $testament, ')
          ..write('originalWord: $originalWord, ')
          ..write('transliteration: $transliteration, ')
          ..write('pronunciation: $pronunciation, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('shortDefinition: $shortDefinition, ')
          ..write('fullDefinition: $fullDefinition, ')
          ..write('derivation: $derivation, ')
          ..write('kjvFrequency: $kjvFrequency')
          ..write(')'))
        .toString();
  }
}

class $VerseStrongMappingsTable extends VerseStrongMappings
    with TableInfo<$VerseStrongMappingsTable, VerseStrongMapping> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VerseStrongMappingsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapterMeta = const VerificationMeta(
    'chapter',
  );
  @override
  late final GeneratedColumn<int> chapter = GeneratedColumn<int>(
    'chapter',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _verseMeta = const VerificationMeta('verse');
  @override
  late final GeneratedColumn<int> verse = GeneratedColumn<int>(
    'verse',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wordPositionMeta = const VerificationMeta(
    'wordPosition',
  );
  @override
  late final GeneratedColumn<int> wordPosition = GeneratedColumn<int>(
    'word_position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kjvWordMeta = const VerificationMeta(
    'kjvWord',
  );
  @override
  late final GeneratedColumn<String> kjvWord = GeneratedColumn<String>(
    'kjv_word',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _strongNumberMeta = const VerificationMeta(
    'strongNumber',
  );
  @override
  late final GeneratedColumn<String> strongNumber = GeneratedColumn<String>(
    'strong_number',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bookId,
    chapter,
    verse,
    wordPosition,
    kjvWord,
    strongNumber,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'verse_strong_mappings';
  @override
  VerificationContext validateIntegrity(
    Insertable<VerseStrongMapping> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('chapter')) {
      context.handle(
        _chapterMeta,
        chapter.isAcceptableOrUnknown(data['chapter']!, _chapterMeta),
      );
    } else if (isInserting) {
      context.missing(_chapterMeta);
    }
    if (data.containsKey('verse')) {
      context.handle(
        _verseMeta,
        verse.isAcceptableOrUnknown(data['verse']!, _verseMeta),
      );
    } else if (isInserting) {
      context.missing(_verseMeta);
    }
    if (data.containsKey('word_position')) {
      context.handle(
        _wordPositionMeta,
        wordPosition.isAcceptableOrUnknown(
          data['word_position']!,
          _wordPositionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_wordPositionMeta);
    }
    if (data.containsKey('kjv_word')) {
      context.handle(
        _kjvWordMeta,
        kjvWord.isAcceptableOrUnknown(data['kjv_word']!, _kjvWordMeta),
      );
    } else if (isInserting) {
      context.missing(_kjvWordMeta);
    }
    if (data.containsKey('strong_number')) {
      context.handle(
        _strongNumberMeta,
        strongNumber.isAcceptableOrUnknown(
          data['strong_number']!,
          _strongNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_strongNumberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VerseStrongMapping map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VerseStrongMapping(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      bookId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}book_id'],
          )!,
      chapter:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}chapter'],
          )!,
      verse:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}verse'],
          )!,
      wordPosition:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}word_position'],
          )!,
      kjvWord:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}kjv_word'],
          )!,
      strongNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}strong_number'],
          )!,
    );
  }

  @override
  $VerseStrongMappingsTable createAlias(String alias) {
    return $VerseStrongMappingsTable(attachedDatabase, alias);
  }
}

class VerseStrongMapping extends DataClass
    implements Insertable<VerseStrongMapping> {
  final int id;
  final int bookId;
  final int chapter;
  final int verse;
  final int wordPosition;
  final String kjvWord;
  final String strongNumber;
  const VerseStrongMapping({
    required this.id,
    required this.bookId,
    required this.chapter,
    required this.verse,
    required this.wordPosition,
    required this.kjvWord,
    required this.strongNumber,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['book_id'] = Variable<int>(bookId);
    map['chapter'] = Variable<int>(chapter);
    map['verse'] = Variable<int>(verse);
    map['word_position'] = Variable<int>(wordPosition);
    map['kjv_word'] = Variable<String>(kjvWord);
    map['strong_number'] = Variable<String>(strongNumber);
    return map;
  }

  VerseStrongMappingsCompanion toCompanion(bool nullToAbsent) {
    return VerseStrongMappingsCompanion(
      id: Value(id),
      bookId: Value(bookId),
      chapter: Value(chapter),
      verse: Value(verse),
      wordPosition: Value(wordPosition),
      kjvWord: Value(kjvWord),
      strongNumber: Value(strongNumber),
    );
  }

  factory VerseStrongMapping.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VerseStrongMapping(
      id: serializer.fromJson<int>(json['id']),
      bookId: serializer.fromJson<int>(json['bookId']),
      chapter: serializer.fromJson<int>(json['chapter']),
      verse: serializer.fromJson<int>(json['verse']),
      wordPosition: serializer.fromJson<int>(json['wordPosition']),
      kjvWord: serializer.fromJson<String>(json['kjvWord']),
      strongNumber: serializer.fromJson<String>(json['strongNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bookId': serializer.toJson<int>(bookId),
      'chapter': serializer.toJson<int>(chapter),
      'verse': serializer.toJson<int>(verse),
      'wordPosition': serializer.toJson<int>(wordPosition),
      'kjvWord': serializer.toJson<String>(kjvWord),
      'strongNumber': serializer.toJson<String>(strongNumber),
    };
  }

  VerseStrongMapping copyWith({
    int? id,
    int? bookId,
    int? chapter,
    int? verse,
    int? wordPosition,
    String? kjvWord,
    String? strongNumber,
  }) => VerseStrongMapping(
    id: id ?? this.id,
    bookId: bookId ?? this.bookId,
    chapter: chapter ?? this.chapter,
    verse: verse ?? this.verse,
    wordPosition: wordPosition ?? this.wordPosition,
    kjvWord: kjvWord ?? this.kjvWord,
    strongNumber: strongNumber ?? this.strongNumber,
  );
  VerseStrongMapping copyWithCompanion(VerseStrongMappingsCompanion data) {
    return VerseStrongMapping(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      chapter: data.chapter.present ? data.chapter.value : this.chapter,
      verse: data.verse.present ? data.verse.value : this.verse,
      wordPosition:
          data.wordPosition.present
              ? data.wordPosition.value
              : this.wordPosition,
      kjvWord: data.kjvWord.present ? data.kjvWord.value : this.kjvWord,
      strongNumber:
          data.strongNumber.present
              ? data.strongNumber.value
              : this.strongNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VerseStrongMapping(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse, ')
          ..write('wordPosition: $wordPosition, ')
          ..write('kjvWord: $kjvWord, ')
          ..write('strongNumber: $strongNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bookId,
    chapter,
    verse,
    wordPosition,
    kjvWord,
    strongNumber,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VerseStrongMapping &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.chapter == this.chapter &&
          other.verse == this.verse &&
          other.wordPosition == this.wordPosition &&
          other.kjvWord == this.kjvWord &&
          other.strongNumber == this.strongNumber);
}

class VerseStrongMappingsCompanion extends UpdateCompanion<VerseStrongMapping> {
  final Value<int> id;
  final Value<int> bookId;
  final Value<int> chapter;
  final Value<int> verse;
  final Value<int> wordPosition;
  final Value<String> kjvWord;
  final Value<String> strongNumber;
  const VerseStrongMappingsCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.chapter = const Value.absent(),
    this.verse = const Value.absent(),
    this.wordPosition = const Value.absent(),
    this.kjvWord = const Value.absent(),
    this.strongNumber = const Value.absent(),
  });
  VerseStrongMappingsCompanion.insert({
    this.id = const Value.absent(),
    required int bookId,
    required int chapter,
    required int verse,
    required int wordPosition,
    required String kjvWord,
    required String strongNumber,
  }) : bookId = Value(bookId),
       chapter = Value(chapter),
       verse = Value(verse),
       wordPosition = Value(wordPosition),
       kjvWord = Value(kjvWord),
       strongNumber = Value(strongNumber);
  static Insertable<VerseStrongMapping> custom({
    Expression<int>? id,
    Expression<int>? bookId,
    Expression<int>? chapter,
    Expression<int>? verse,
    Expression<int>? wordPosition,
    Expression<String>? kjvWord,
    Expression<String>? strongNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (chapter != null) 'chapter': chapter,
      if (verse != null) 'verse': verse,
      if (wordPosition != null) 'word_position': wordPosition,
      if (kjvWord != null) 'kjv_word': kjvWord,
      if (strongNumber != null) 'strong_number': strongNumber,
    });
  }

  VerseStrongMappingsCompanion copyWith({
    Value<int>? id,
    Value<int>? bookId,
    Value<int>? chapter,
    Value<int>? verse,
    Value<int>? wordPosition,
    Value<String>? kjvWord,
    Value<String>? strongNumber,
  }) {
    return VerseStrongMappingsCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      chapter: chapter ?? this.chapter,
      verse: verse ?? this.verse,
      wordPosition: wordPosition ?? this.wordPosition,
      kjvWord: kjvWord ?? this.kjvWord,
      strongNumber: strongNumber ?? this.strongNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (chapter.present) {
      map['chapter'] = Variable<int>(chapter.value);
    }
    if (verse.present) {
      map['verse'] = Variable<int>(verse.value);
    }
    if (wordPosition.present) {
      map['word_position'] = Variable<int>(wordPosition.value);
    }
    if (kjvWord.present) {
      map['kjv_word'] = Variable<String>(kjvWord.value);
    }
    if (strongNumber.present) {
      map['strong_number'] = Variable<String>(strongNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VerseStrongMappingsCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse, ')
          ..write('wordPosition: $wordPosition, ')
          ..write('kjvWord: $kjvWord, ')
          ..write('strongNumber: $strongNumber')
          ..write(')'))
        .toString();
  }
}

class $GrammarRulesTable extends GrammarRules
    with TableInfo<$GrammarRulesTable, GrammarRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GrammarRulesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _ruleTypeMeta = const VerificationMeta(
    'ruleType',
  );
  @override
  late final GeneratedColumn<String> ruleType = GeneratedColumn<String>(
    'rule_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 30,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patternMeta = const VerificationMeta(
    'pattern',
  );
  @override
  late final GeneratedColumn<String> pattern = GeneratedColumn<String>(
    'pattern',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ruleType,
    pattern,
    label,
    description,
    priority,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'grammar_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<GrammarRule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('rule_type')) {
      context.handle(
        _ruleTypeMeta,
        ruleType.isAcceptableOrUnknown(data['rule_type']!, _ruleTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_ruleTypeMeta);
    }
    if (data.containsKey('pattern')) {
      context.handle(
        _patternMeta,
        pattern.isAcceptableOrUnknown(data['pattern']!, _patternMeta),
      );
    } else if (isInserting) {
      context.missing(_patternMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GrammarRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GrammarRule(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      ruleType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}rule_type'],
          )!,
      pattern:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}pattern'],
          )!,
      label:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}label'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
      priority:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}priority'],
          )!,
    );
  }

  @override
  $GrammarRulesTable createAlias(String alias) {
    return $GrammarRulesTable(attachedDatabase, alias);
  }
}

class GrammarRule extends DataClass implements Insertable<GrammarRule> {
  final int id;
  final String ruleType;
  final String pattern;
  final String label;
  final String description;
  final int priority;
  const GrammarRule({
    required this.id,
    required this.ruleType,
    required this.pattern,
    required this.label,
    required this.description,
    required this.priority,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['rule_type'] = Variable<String>(ruleType);
    map['pattern'] = Variable<String>(pattern);
    map['label'] = Variable<String>(label);
    map['description'] = Variable<String>(description);
    map['priority'] = Variable<int>(priority);
    return map;
  }

  GrammarRulesCompanion toCompanion(bool nullToAbsent) {
    return GrammarRulesCompanion(
      id: Value(id),
      ruleType: Value(ruleType),
      pattern: Value(pattern),
      label: Value(label),
      description: Value(description),
      priority: Value(priority),
    );
  }

  factory GrammarRule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GrammarRule(
      id: serializer.fromJson<int>(json['id']),
      ruleType: serializer.fromJson<String>(json['ruleType']),
      pattern: serializer.fromJson<String>(json['pattern']),
      label: serializer.fromJson<String>(json['label']),
      description: serializer.fromJson<String>(json['description']),
      priority: serializer.fromJson<int>(json['priority']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ruleType': serializer.toJson<String>(ruleType),
      'pattern': serializer.toJson<String>(pattern),
      'label': serializer.toJson<String>(label),
      'description': serializer.toJson<String>(description),
      'priority': serializer.toJson<int>(priority),
    };
  }

  GrammarRule copyWith({
    int? id,
    String? ruleType,
    String? pattern,
    String? label,
    String? description,
    int? priority,
  }) => GrammarRule(
    id: id ?? this.id,
    ruleType: ruleType ?? this.ruleType,
    pattern: pattern ?? this.pattern,
    label: label ?? this.label,
    description: description ?? this.description,
    priority: priority ?? this.priority,
  );
  GrammarRule copyWithCompanion(GrammarRulesCompanion data) {
    return GrammarRule(
      id: data.id.present ? data.id.value : this.id,
      ruleType: data.ruleType.present ? data.ruleType.value : this.ruleType,
      pattern: data.pattern.present ? data.pattern.value : this.pattern,
      label: data.label.present ? data.label.value : this.label,
      description:
          data.description.present ? data.description.value : this.description,
      priority: data.priority.present ? data.priority.value : this.priority,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GrammarRule(')
          ..write('id: $id, ')
          ..write('ruleType: $ruleType, ')
          ..write('pattern: $pattern, ')
          ..write('label: $label, ')
          ..write('description: $description, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ruleType, pattern, label, description, priority);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GrammarRule &&
          other.id == this.id &&
          other.ruleType == this.ruleType &&
          other.pattern == this.pattern &&
          other.label == this.label &&
          other.description == this.description &&
          other.priority == this.priority);
}

class GrammarRulesCompanion extends UpdateCompanion<GrammarRule> {
  final Value<int> id;
  final Value<String> ruleType;
  final Value<String> pattern;
  final Value<String> label;
  final Value<String> description;
  final Value<int> priority;
  const GrammarRulesCompanion({
    this.id = const Value.absent(),
    this.ruleType = const Value.absent(),
    this.pattern = const Value.absent(),
    this.label = const Value.absent(),
    this.description = const Value.absent(),
    this.priority = const Value.absent(),
  });
  GrammarRulesCompanion.insert({
    this.id = const Value.absent(),
    required String ruleType,
    required String pattern,
    required String label,
    this.description = const Value.absent(),
    this.priority = const Value.absent(),
  }) : ruleType = Value(ruleType),
       pattern = Value(pattern),
       label = Value(label);
  static Insertable<GrammarRule> custom({
    Expression<int>? id,
    Expression<String>? ruleType,
    Expression<String>? pattern,
    Expression<String>? label,
    Expression<String>? description,
    Expression<int>? priority,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ruleType != null) 'rule_type': ruleType,
      if (pattern != null) 'pattern': pattern,
      if (label != null) 'label': label,
      if (description != null) 'description': description,
      if (priority != null) 'priority': priority,
    });
  }

  GrammarRulesCompanion copyWith({
    Value<int>? id,
    Value<String>? ruleType,
    Value<String>? pattern,
    Value<String>? label,
    Value<String>? description,
    Value<int>? priority,
  }) {
    return GrammarRulesCompanion(
      id: id ?? this.id,
      ruleType: ruleType ?? this.ruleType,
      pattern: pattern ?? this.pattern,
      label: label ?? this.label,
      description: description ?? this.description,
      priority: priority ?? this.priority,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ruleType.present) {
      map['rule_type'] = Variable<String>(ruleType.value);
    }
    if (pattern.present) {
      map['pattern'] = Variable<String>(pattern.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GrammarRulesCompanion(')
          ..write('id: $id, ')
          ..write('ruleType: $ruleType, ')
          ..write('pattern: $pattern, ')
          ..write('label: $label, ')
          ..write('description: $description, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }
}

class $PosLookupTable extends PosLookup
    with TableInfo<$PosLookupTable, PosLookupData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PosLookupTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
    'word',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wordNormalizedMeta = const VerificationMeta(
    'wordNormalized',
  );
  @override
  late final GeneratedColumn<String> wordNormalized = GeneratedColumn<String>(
    'word_normalized',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _primaryPosMeta = const VerificationMeta(
    'primaryPos',
  );
  @override
  late final GeneratedColumn<String> primaryPos = GeneratedColumn<String>(
    'primary_pos',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 30,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _allPosMeta = const VerificationMeta('allPos');
  @override
  late final GeneratedColumn<String> allPos = GeneratedColumn<String>(
    'all_pos',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    word,
    wordNormalized,
    primaryPos,
    allPos,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pos_lookup';
  @override
  VerificationContext validateIntegrity(
    Insertable<PosLookupData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word')) {
      context.handle(
        _wordMeta,
        word.isAcceptableOrUnknown(data['word']!, _wordMeta),
      );
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('word_normalized')) {
      context.handle(
        _wordNormalizedMeta,
        wordNormalized.isAcceptableOrUnknown(
          data['word_normalized']!,
          _wordNormalizedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_wordNormalizedMeta);
    }
    if (data.containsKey('primary_pos')) {
      context.handle(
        _primaryPosMeta,
        primaryPos.isAcceptableOrUnknown(data['primary_pos']!, _primaryPosMeta),
      );
    } else if (isInserting) {
      context.missing(_primaryPosMeta);
    }
    if (data.containsKey('all_pos')) {
      context.handle(
        _allPosMeta,
        allPos.isAcceptableOrUnknown(data['all_pos']!, _allPosMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {wordNormalized},
  ];
  @override
  PosLookupData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PosLookupData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      word:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}word'],
          )!,
      wordNormalized:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}word_normalized'],
          )!,
      primaryPos:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}primary_pos'],
          )!,
      allPos:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}all_pos'],
          )!,
    );
  }

  @override
  $PosLookupTable createAlias(String alias) {
    return $PosLookupTable(attachedDatabase, alias);
  }
}

class PosLookupData extends DataClass implements Insertable<PosLookupData> {
  final int id;
  final String word;
  final String wordNormalized;
  final String primaryPos;
  final String allPos;
  const PosLookupData({
    required this.id,
    required this.word,
    required this.wordNormalized,
    required this.primaryPos,
    required this.allPos,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word'] = Variable<String>(word);
    map['word_normalized'] = Variable<String>(wordNormalized);
    map['primary_pos'] = Variable<String>(primaryPos);
    map['all_pos'] = Variable<String>(allPos);
    return map;
  }

  PosLookupCompanion toCompanion(bool nullToAbsent) {
    return PosLookupCompanion(
      id: Value(id),
      word: Value(word),
      wordNormalized: Value(wordNormalized),
      primaryPos: Value(primaryPos),
      allPos: Value(allPos),
    );
  }

  factory PosLookupData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PosLookupData(
      id: serializer.fromJson<int>(json['id']),
      word: serializer.fromJson<String>(json['word']),
      wordNormalized: serializer.fromJson<String>(json['wordNormalized']),
      primaryPos: serializer.fromJson<String>(json['primaryPos']),
      allPos: serializer.fromJson<String>(json['allPos']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'word': serializer.toJson<String>(word),
      'wordNormalized': serializer.toJson<String>(wordNormalized),
      'primaryPos': serializer.toJson<String>(primaryPos),
      'allPos': serializer.toJson<String>(allPos),
    };
  }

  PosLookupData copyWith({
    int? id,
    String? word,
    String? wordNormalized,
    String? primaryPos,
    String? allPos,
  }) => PosLookupData(
    id: id ?? this.id,
    word: word ?? this.word,
    wordNormalized: wordNormalized ?? this.wordNormalized,
    primaryPos: primaryPos ?? this.primaryPos,
    allPos: allPos ?? this.allPos,
  );
  PosLookupData copyWithCompanion(PosLookupCompanion data) {
    return PosLookupData(
      id: data.id.present ? data.id.value : this.id,
      word: data.word.present ? data.word.value : this.word,
      wordNormalized:
          data.wordNormalized.present
              ? data.wordNormalized.value
              : this.wordNormalized,
      primaryPos:
          data.primaryPos.present ? data.primaryPos.value : this.primaryPos,
      allPos: data.allPos.present ? data.allPos.value : this.allPos,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PosLookupData(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('wordNormalized: $wordNormalized, ')
          ..write('primaryPos: $primaryPos, ')
          ..write('allPos: $allPos')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, word, wordNormalized, primaryPos, allPos);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PosLookupData &&
          other.id == this.id &&
          other.word == this.word &&
          other.wordNormalized == this.wordNormalized &&
          other.primaryPos == this.primaryPos &&
          other.allPos == this.allPos);
}

class PosLookupCompanion extends UpdateCompanion<PosLookupData> {
  final Value<int> id;
  final Value<String> word;
  final Value<String> wordNormalized;
  final Value<String> primaryPos;
  final Value<String> allPos;
  const PosLookupCompanion({
    this.id = const Value.absent(),
    this.word = const Value.absent(),
    this.wordNormalized = const Value.absent(),
    this.primaryPos = const Value.absent(),
    this.allPos = const Value.absent(),
  });
  PosLookupCompanion.insert({
    this.id = const Value.absent(),
    required String word,
    required String wordNormalized,
    required String primaryPos,
    this.allPos = const Value.absent(),
  }) : word = Value(word),
       wordNormalized = Value(wordNormalized),
       primaryPos = Value(primaryPos);
  static Insertable<PosLookupData> custom({
    Expression<int>? id,
    Expression<String>? word,
    Expression<String>? wordNormalized,
    Expression<String>? primaryPos,
    Expression<String>? allPos,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (word != null) 'word': word,
      if (wordNormalized != null) 'word_normalized': wordNormalized,
      if (primaryPos != null) 'primary_pos': primaryPos,
      if (allPos != null) 'all_pos': allPos,
    });
  }

  PosLookupCompanion copyWith({
    Value<int>? id,
    Value<String>? word,
    Value<String>? wordNormalized,
    Value<String>? primaryPos,
    Value<String>? allPos,
  }) {
    return PosLookupCompanion(
      id: id ?? this.id,
      word: word ?? this.word,
      wordNormalized: wordNormalized ?? this.wordNormalized,
      primaryPos: primaryPos ?? this.primaryPos,
      allPos: allPos ?? this.allPos,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (wordNormalized.present) {
      map['word_normalized'] = Variable<String>(wordNormalized.value);
    }
    if (primaryPos.present) {
      map['primary_pos'] = Variable<String>(primaryPos.value);
    }
    if (allPos.present) {
      map['all_pos'] = Variable<String>(allPos.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PosLookupCompanion(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('wordNormalized: $wordNormalized, ')
          ..write('primaryPos: $primaryPos, ')
          ..write('allPos: $allPos')
          ..write(')'))
        .toString();
  }
}

class $BookmarksTable extends Bookmarks
    with TableInfo<$BookmarksTable, Bookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _translationCodeMeta = const VerificationMeta(
    'translationCode',
  );
  @override
  late final GeneratedColumn<String> translationCode = GeneratedColumn<String>(
    'translation_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapterMeta = const VerificationMeta(
    'chapter',
  );
  @override
  late final GeneratedColumn<int> chapter = GeneratedColumn<int>(
    'chapter',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _verseMeta = const VerificationMeta('verse');
  @override
  late final GeneratedColumn<int> verse = GeneratedColumn<int>(
    'verse',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncPendingMeta = const VerificationMeta(
    'syncPending',
  );
  @override
  late final GeneratedColumn<bool> syncPending = GeneratedColumn<bool>(
    'sync_pending',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sync_pending" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    translationCode,
    bookId,
    chapter,
    verse,
    note,
    createdAt,
    serverId,
    syncPending,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Bookmark> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('translation_code')) {
      context.handle(
        _translationCodeMeta,
        translationCode.isAcceptableOrUnknown(
          data['translation_code']!,
          _translationCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_translationCodeMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('chapter')) {
      context.handle(
        _chapterMeta,
        chapter.isAcceptableOrUnknown(data['chapter']!, _chapterMeta),
      );
    } else if (isInserting) {
      context.missing(_chapterMeta);
    }
    if (data.containsKey('verse')) {
      context.handle(
        _verseMeta,
        verse.isAcceptableOrUnknown(data['verse']!, _verseMeta),
      );
    } else if (isInserting) {
      context.missing(_verseMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('sync_pending')) {
      context.handle(
        _syncPendingMeta,
        syncPending.isAcceptableOrUnknown(
          data['sync_pending']!,
          _syncPendingMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {translationCode, bookId, chapter, verse},
  ];
  @override
  Bookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bookmark(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      translationCode:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}translation_code'],
          )!,
      bookId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}book_id'],
          )!,
      chapter:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}chapter'],
          )!,
      verse:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}verse'],
          )!,
      note:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}note'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      ),
      syncPending:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}sync_pending'],
          )!,
    );
  }

  @override
  $BookmarksTable createAlias(String alias) {
    return $BookmarksTable(attachedDatabase, alias);
  }
}

class Bookmark extends DataClass implements Insertable<Bookmark> {
  final int id;
  final String translationCode;
  final int bookId;
  final int chapter;
  final int verse;
  final String note;
  final DateTime createdAt;
  final String? serverId;
  final bool syncPending;
  const Bookmark({
    required this.id,
    required this.translationCode,
    required this.bookId,
    required this.chapter,
    required this.verse,
    required this.note,
    required this.createdAt,
    this.serverId,
    required this.syncPending,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['translation_code'] = Variable<String>(translationCode);
    map['book_id'] = Variable<int>(bookId);
    map['chapter'] = Variable<int>(chapter);
    map['verse'] = Variable<int>(verse);
    map['note'] = Variable<String>(note);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    map['sync_pending'] = Variable<bool>(syncPending);
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(
      id: Value(id),
      translationCode: Value(translationCode),
      bookId: Value(bookId),
      chapter: Value(chapter),
      verse: Value(verse),
      note: Value(note),
      createdAt: Value(createdAt),
      serverId:
          serverId == null && nullToAbsent
              ? const Value.absent()
              : Value(serverId),
      syncPending: Value(syncPending),
    );
  }

  factory Bookmark.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bookmark(
      id: serializer.fromJson<int>(json['id']),
      translationCode: serializer.fromJson<String>(json['translationCode']),
      bookId: serializer.fromJson<int>(json['bookId']),
      chapter: serializer.fromJson<int>(json['chapter']),
      verse: serializer.fromJson<int>(json['verse']),
      note: serializer.fromJson<String>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      serverId: serializer.fromJson<String?>(json['serverId']),
      syncPending: serializer.fromJson<bool>(json['syncPending']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'translationCode': serializer.toJson<String>(translationCode),
      'bookId': serializer.toJson<int>(bookId),
      'chapter': serializer.toJson<int>(chapter),
      'verse': serializer.toJson<int>(verse),
      'note': serializer.toJson<String>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'serverId': serializer.toJson<String?>(serverId),
      'syncPending': serializer.toJson<bool>(syncPending),
    };
  }

  Bookmark copyWith({
    int? id,
    String? translationCode,
    int? bookId,
    int? chapter,
    int? verse,
    String? note,
    DateTime? createdAt,
    Value<String?> serverId = const Value.absent(),
    bool? syncPending,
  }) => Bookmark(
    id: id ?? this.id,
    translationCode: translationCode ?? this.translationCode,
    bookId: bookId ?? this.bookId,
    chapter: chapter ?? this.chapter,
    verse: verse ?? this.verse,
    note: note ?? this.note,
    createdAt: createdAt ?? this.createdAt,
    serverId: serverId.present ? serverId.value : this.serverId,
    syncPending: syncPending ?? this.syncPending,
  );
  Bookmark copyWithCompanion(BookmarksCompanion data) {
    return Bookmark(
      id: data.id.present ? data.id.value : this.id,
      translationCode:
          data.translationCode.present
              ? data.translationCode.value
              : this.translationCode,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      chapter: data.chapter.present ? data.chapter.value : this.chapter,
      verse: data.verse.present ? data.verse.value : this.verse,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      syncPending:
          data.syncPending.present ? data.syncPending.value : this.syncPending,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bookmark(')
          ..write('id: $id, ')
          ..write('translationCode: $translationCode, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('serverId: $serverId, ')
          ..write('syncPending: $syncPending')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    translationCode,
    bookId,
    chapter,
    verse,
    note,
    createdAt,
    serverId,
    syncPending,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bookmark &&
          other.id == this.id &&
          other.translationCode == this.translationCode &&
          other.bookId == this.bookId &&
          other.chapter == this.chapter &&
          other.verse == this.verse &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.serverId == this.serverId &&
          other.syncPending == this.syncPending);
}

class BookmarksCompanion extends UpdateCompanion<Bookmark> {
  final Value<int> id;
  final Value<String> translationCode;
  final Value<int> bookId;
  final Value<int> chapter;
  final Value<int> verse;
  final Value<String> note;
  final Value<DateTime> createdAt;
  final Value<String?> serverId;
  final Value<bool> syncPending;
  const BookmarksCompanion({
    this.id = const Value.absent(),
    this.translationCode = const Value.absent(),
    this.bookId = const Value.absent(),
    this.chapter = const Value.absent(),
    this.verse = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.serverId = const Value.absent(),
    this.syncPending = const Value.absent(),
  });
  BookmarksCompanion.insert({
    this.id = const Value.absent(),
    required String translationCode,
    required int bookId,
    required int chapter,
    required int verse,
    this.note = const Value.absent(),
    required DateTime createdAt,
    this.serverId = const Value.absent(),
    this.syncPending = const Value.absent(),
  }) : translationCode = Value(translationCode),
       bookId = Value(bookId),
       chapter = Value(chapter),
       verse = Value(verse),
       createdAt = Value(createdAt);
  static Insertable<Bookmark> custom({
    Expression<int>? id,
    Expression<String>? translationCode,
    Expression<int>? bookId,
    Expression<int>? chapter,
    Expression<int>? verse,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<String>? serverId,
    Expression<bool>? syncPending,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (translationCode != null) 'translation_code': translationCode,
      if (bookId != null) 'book_id': bookId,
      if (chapter != null) 'chapter': chapter,
      if (verse != null) 'verse': verse,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (serverId != null) 'server_id': serverId,
      if (syncPending != null) 'sync_pending': syncPending,
    });
  }

  BookmarksCompanion copyWith({
    Value<int>? id,
    Value<String>? translationCode,
    Value<int>? bookId,
    Value<int>? chapter,
    Value<int>? verse,
    Value<String>? note,
    Value<DateTime>? createdAt,
    Value<String?>? serverId,
    Value<bool>? syncPending,
  }) {
    return BookmarksCompanion(
      id: id ?? this.id,
      translationCode: translationCode ?? this.translationCode,
      bookId: bookId ?? this.bookId,
      chapter: chapter ?? this.chapter,
      verse: verse ?? this.verse,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      serverId: serverId ?? this.serverId,
      syncPending: syncPending ?? this.syncPending,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (translationCode.present) {
      map['translation_code'] = Variable<String>(translationCode.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (chapter.present) {
      map['chapter'] = Variable<int>(chapter.value);
    }
    if (verse.present) {
      map['verse'] = Variable<int>(verse.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (syncPending.present) {
      map['sync_pending'] = Variable<bool>(syncPending.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksCompanion(')
          ..write('id: $id, ')
          ..write('translationCode: $translationCode, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('serverId: $serverId, ')
          ..write('syncPending: $syncPending')
          ..write(')'))
        .toString();
  }
}

class $MemosTable extends Memos with TableInfo<$MemosTable, Memo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MemosTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapterMeta = const VerificationMeta(
    'chapter',
  );
  @override
  late final GeneratedColumn<int> chapter = GeneratedColumn<int>(
    'chapter',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _verseMeta = const VerificationMeta('verse');
  @override
  late final GeneratedColumn<int> verse = GeneratedColumn<int>(
    'verse',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncPendingMeta = const VerificationMeta(
    'syncPending',
  );
  @override
  late final GeneratedColumn<bool> syncPending = GeneratedColumn<bool>(
    'sync_pending',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sync_pending" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bookId,
    chapter,
    verse,
    content,
    createdAt,
    updatedAt,
    serverId,
    syncPending,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'memos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Memo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('chapter')) {
      context.handle(
        _chapterMeta,
        chapter.isAcceptableOrUnknown(data['chapter']!, _chapterMeta),
      );
    } else if (isInserting) {
      context.missing(_chapterMeta);
    }
    if (data.containsKey('verse')) {
      context.handle(
        _verseMeta,
        verse.isAcceptableOrUnknown(data['verse']!, _verseMeta),
      );
    } else if (isInserting) {
      context.missing(_verseMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('sync_pending')) {
      context.handle(
        _syncPendingMeta,
        syncPending.isAcceptableOrUnknown(
          data['sync_pending']!,
          _syncPendingMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Memo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Memo(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      bookId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}book_id'],
          )!,
      chapter:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}chapter'],
          )!,
      verse:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}verse'],
          )!,
      content:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}content'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      ),
      syncPending:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}sync_pending'],
          )!,
    );
  }

  @override
  $MemosTable createAlias(String alias) {
    return $MemosTable(attachedDatabase, alias);
  }
}

class Memo extends DataClass implements Insertable<Memo> {
  final int id;
  final int bookId;
  final int chapter;
  final int verse;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? serverId;
  final bool syncPending;
  const Memo({
    required this.id,
    required this.bookId,
    required this.chapter,
    required this.verse,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.serverId,
    required this.syncPending,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['book_id'] = Variable<int>(bookId);
    map['chapter'] = Variable<int>(chapter);
    map['verse'] = Variable<int>(verse);
    map['content'] = Variable<String>(content);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    map['sync_pending'] = Variable<bool>(syncPending);
    return map;
  }

  MemosCompanion toCompanion(bool nullToAbsent) {
    return MemosCompanion(
      id: Value(id),
      bookId: Value(bookId),
      chapter: Value(chapter),
      verse: Value(verse),
      content: Value(content),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      serverId:
          serverId == null && nullToAbsent
              ? const Value.absent()
              : Value(serverId),
      syncPending: Value(syncPending),
    );
  }

  factory Memo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Memo(
      id: serializer.fromJson<int>(json['id']),
      bookId: serializer.fromJson<int>(json['bookId']),
      chapter: serializer.fromJson<int>(json['chapter']),
      verse: serializer.fromJson<int>(json['verse']),
      content: serializer.fromJson<String>(json['content']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      serverId: serializer.fromJson<String?>(json['serverId']),
      syncPending: serializer.fromJson<bool>(json['syncPending']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bookId': serializer.toJson<int>(bookId),
      'chapter': serializer.toJson<int>(chapter),
      'verse': serializer.toJson<int>(verse),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'serverId': serializer.toJson<String?>(serverId),
      'syncPending': serializer.toJson<bool>(syncPending),
    };
  }

  Memo copyWith({
    int? id,
    int? bookId,
    int? chapter,
    int? verse,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<String?> serverId = const Value.absent(),
    bool? syncPending,
  }) => Memo(
    id: id ?? this.id,
    bookId: bookId ?? this.bookId,
    chapter: chapter ?? this.chapter,
    verse: verse ?? this.verse,
    content: content ?? this.content,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    serverId: serverId.present ? serverId.value : this.serverId,
    syncPending: syncPending ?? this.syncPending,
  );
  Memo copyWithCompanion(MemosCompanion data) {
    return Memo(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      chapter: data.chapter.present ? data.chapter.value : this.chapter,
      verse: data.verse.present ? data.verse.value : this.verse,
      content: data.content.present ? data.content.value : this.content,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      syncPending:
          data.syncPending.present ? data.syncPending.value : this.syncPending,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Memo(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('serverId: $serverId, ')
          ..write('syncPending: $syncPending')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bookId,
    chapter,
    verse,
    content,
    createdAt,
    updatedAt,
    serverId,
    syncPending,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Memo &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.chapter == this.chapter &&
          other.verse == this.verse &&
          other.content == this.content &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.serverId == this.serverId &&
          other.syncPending == this.syncPending);
}

class MemosCompanion extends UpdateCompanion<Memo> {
  final Value<int> id;
  final Value<int> bookId;
  final Value<int> chapter;
  final Value<int> verse;
  final Value<String> content;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String?> serverId;
  final Value<bool> syncPending;
  const MemosCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.chapter = const Value.absent(),
    this.verse = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.serverId = const Value.absent(),
    this.syncPending = const Value.absent(),
  });
  MemosCompanion.insert({
    this.id = const Value.absent(),
    required int bookId,
    required int chapter,
    required int verse,
    required String content,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.serverId = const Value.absent(),
    this.syncPending = const Value.absent(),
  }) : bookId = Value(bookId),
       chapter = Value(chapter),
       verse = Value(verse),
       content = Value(content),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Memo> custom({
    Expression<int>? id,
    Expression<int>? bookId,
    Expression<int>? chapter,
    Expression<int>? verse,
    Expression<String>? content,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? serverId,
    Expression<bool>? syncPending,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (chapter != null) 'chapter': chapter,
      if (verse != null) 'verse': verse,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (serverId != null) 'server_id': serverId,
      if (syncPending != null) 'sync_pending': syncPending,
    });
  }

  MemosCompanion copyWith({
    Value<int>? id,
    Value<int>? bookId,
    Value<int>? chapter,
    Value<int>? verse,
    Value<String>? content,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String?>? serverId,
    Value<bool>? syncPending,
  }) {
    return MemosCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      chapter: chapter ?? this.chapter,
      verse: verse ?? this.verse,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      serverId: serverId ?? this.serverId,
      syncPending: syncPending ?? this.syncPending,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (chapter.present) {
      map['chapter'] = Variable<int>(chapter.value);
    }
    if (verse.present) {
      map['verse'] = Variable<int>(verse.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (syncPending.present) {
      map['sync_pending'] = Variable<bool>(syncPending.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MemosCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('serverId: $serverId, ')
          ..write('syncPending: $syncPending')
          ..write(')'))
        .toString();
  }
}

class $HighlightsTable extends Highlights
    with TableInfo<$HighlightsTable, Highlight> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HighlightsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapterMeta = const VerificationMeta(
    'chapter',
  );
  @override
  late final GeneratedColumn<int> chapter = GeneratedColumn<int>(
    'chapter',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _verseMeta = const VerificationMeta('verse');
  @override
  late final GeneratedColumn<int> verse = GeneratedColumn<int>(
    'verse',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _translationCodeMeta = const VerificationMeta(
    'translationCode',
  );
  @override
  late final GeneratedColumn<String> translationCode = GeneratedColumn<String>(
    'translation_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wordStartMeta = const VerificationMeta(
    'wordStart',
  );
  @override
  late final GeneratedColumn<int> wordStart = GeneratedColumn<int>(
    'word_start',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wordEndMeta = const VerificationMeta(
    'wordEnd',
  );
  @override
  late final GeneratedColumn<int> wordEnd = GeneratedColumn<int>(
    'word_end',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bookId,
    chapter,
    verse,
    translationCode,
    wordStart,
    wordEnd,
    color,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'highlights';
  @override
  VerificationContext validateIntegrity(
    Insertable<Highlight> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('chapter')) {
      context.handle(
        _chapterMeta,
        chapter.isAcceptableOrUnknown(data['chapter']!, _chapterMeta),
      );
    } else if (isInserting) {
      context.missing(_chapterMeta);
    }
    if (data.containsKey('verse')) {
      context.handle(
        _verseMeta,
        verse.isAcceptableOrUnknown(data['verse']!, _verseMeta),
      );
    } else if (isInserting) {
      context.missing(_verseMeta);
    }
    if (data.containsKey('translation_code')) {
      context.handle(
        _translationCodeMeta,
        translationCode.isAcceptableOrUnknown(
          data['translation_code']!,
          _translationCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_translationCodeMeta);
    }
    if (data.containsKey('word_start')) {
      context.handle(
        _wordStartMeta,
        wordStart.isAcceptableOrUnknown(data['word_start']!, _wordStartMeta),
      );
    } else if (isInserting) {
      context.missing(_wordStartMeta);
    }
    if (data.containsKey('word_end')) {
      context.handle(
        _wordEndMeta,
        wordEnd.isAcceptableOrUnknown(data['word_end']!, _wordEndMeta),
      );
    } else if (isInserting) {
      context.missing(_wordEndMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Highlight map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Highlight(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      bookId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}book_id'],
          )!,
      chapter:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}chapter'],
          )!,
      verse:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}verse'],
          )!,
      translationCode:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}translation_code'],
          )!,
      wordStart:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}word_start'],
          )!,
      wordEnd:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}word_end'],
          )!,
      color:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}color'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $HighlightsTable createAlias(String alias) {
    return $HighlightsTable(attachedDatabase, alias);
  }
}

class Highlight extends DataClass implements Insertable<Highlight> {
  final int id;
  final int bookId;
  final int chapter;
  final int verse;
  final String translationCode;
  final int wordStart;
  final int wordEnd;
  final String color;
  final DateTime createdAt;
  const Highlight({
    required this.id,
    required this.bookId,
    required this.chapter,
    required this.verse,
    required this.translationCode,
    required this.wordStart,
    required this.wordEnd,
    required this.color,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['book_id'] = Variable<int>(bookId);
    map['chapter'] = Variable<int>(chapter);
    map['verse'] = Variable<int>(verse);
    map['translation_code'] = Variable<String>(translationCode);
    map['word_start'] = Variable<int>(wordStart);
    map['word_end'] = Variable<int>(wordEnd);
    map['color'] = Variable<String>(color);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HighlightsCompanion toCompanion(bool nullToAbsent) {
    return HighlightsCompanion(
      id: Value(id),
      bookId: Value(bookId),
      chapter: Value(chapter),
      verse: Value(verse),
      translationCode: Value(translationCode),
      wordStart: Value(wordStart),
      wordEnd: Value(wordEnd),
      color: Value(color),
      createdAt: Value(createdAt),
    );
  }

  factory Highlight.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Highlight(
      id: serializer.fromJson<int>(json['id']),
      bookId: serializer.fromJson<int>(json['bookId']),
      chapter: serializer.fromJson<int>(json['chapter']),
      verse: serializer.fromJson<int>(json['verse']),
      translationCode: serializer.fromJson<String>(json['translationCode']),
      wordStart: serializer.fromJson<int>(json['wordStart']),
      wordEnd: serializer.fromJson<int>(json['wordEnd']),
      color: serializer.fromJson<String>(json['color']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bookId': serializer.toJson<int>(bookId),
      'chapter': serializer.toJson<int>(chapter),
      'verse': serializer.toJson<int>(verse),
      'translationCode': serializer.toJson<String>(translationCode),
      'wordStart': serializer.toJson<int>(wordStart),
      'wordEnd': serializer.toJson<int>(wordEnd),
      'color': serializer.toJson<String>(color),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Highlight copyWith({
    int? id,
    int? bookId,
    int? chapter,
    int? verse,
    String? translationCode,
    int? wordStart,
    int? wordEnd,
    String? color,
    DateTime? createdAt,
  }) => Highlight(
    id: id ?? this.id,
    bookId: bookId ?? this.bookId,
    chapter: chapter ?? this.chapter,
    verse: verse ?? this.verse,
    translationCode: translationCode ?? this.translationCode,
    wordStart: wordStart ?? this.wordStart,
    wordEnd: wordEnd ?? this.wordEnd,
    color: color ?? this.color,
    createdAt: createdAt ?? this.createdAt,
  );
  Highlight copyWithCompanion(HighlightsCompanion data) {
    return Highlight(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      chapter: data.chapter.present ? data.chapter.value : this.chapter,
      verse: data.verse.present ? data.verse.value : this.verse,
      translationCode:
          data.translationCode.present
              ? data.translationCode.value
              : this.translationCode,
      wordStart: data.wordStart.present ? data.wordStart.value : this.wordStart,
      wordEnd: data.wordEnd.present ? data.wordEnd.value : this.wordEnd,
      color: data.color.present ? data.color.value : this.color,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Highlight(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse, ')
          ..write('translationCode: $translationCode, ')
          ..write('wordStart: $wordStart, ')
          ..write('wordEnd: $wordEnd, ')
          ..write('color: $color, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bookId,
    chapter,
    verse,
    translationCode,
    wordStart,
    wordEnd,
    color,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Highlight &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.chapter == this.chapter &&
          other.verse == this.verse &&
          other.translationCode == this.translationCode &&
          other.wordStart == this.wordStart &&
          other.wordEnd == this.wordEnd &&
          other.color == this.color &&
          other.createdAt == this.createdAt);
}

class HighlightsCompanion extends UpdateCompanion<Highlight> {
  final Value<int> id;
  final Value<int> bookId;
  final Value<int> chapter;
  final Value<int> verse;
  final Value<String> translationCode;
  final Value<int> wordStart;
  final Value<int> wordEnd;
  final Value<String> color;
  final Value<DateTime> createdAt;
  const HighlightsCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.chapter = const Value.absent(),
    this.verse = const Value.absent(),
    this.translationCode = const Value.absent(),
    this.wordStart = const Value.absent(),
    this.wordEnd = const Value.absent(),
    this.color = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HighlightsCompanion.insert({
    this.id = const Value.absent(),
    required int bookId,
    required int chapter,
    required int verse,
    required String translationCode,
    required int wordStart,
    required int wordEnd,
    required String color,
    required DateTime createdAt,
  }) : bookId = Value(bookId),
       chapter = Value(chapter),
       verse = Value(verse),
       translationCode = Value(translationCode),
       wordStart = Value(wordStart),
       wordEnd = Value(wordEnd),
       color = Value(color),
       createdAt = Value(createdAt);
  static Insertable<Highlight> custom({
    Expression<int>? id,
    Expression<int>? bookId,
    Expression<int>? chapter,
    Expression<int>? verse,
    Expression<String>? translationCode,
    Expression<int>? wordStart,
    Expression<int>? wordEnd,
    Expression<String>? color,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (chapter != null) 'chapter': chapter,
      if (verse != null) 'verse': verse,
      if (translationCode != null) 'translation_code': translationCode,
      if (wordStart != null) 'word_start': wordStart,
      if (wordEnd != null) 'word_end': wordEnd,
      if (color != null) 'color': color,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HighlightsCompanion copyWith({
    Value<int>? id,
    Value<int>? bookId,
    Value<int>? chapter,
    Value<int>? verse,
    Value<String>? translationCode,
    Value<int>? wordStart,
    Value<int>? wordEnd,
    Value<String>? color,
    Value<DateTime>? createdAt,
  }) {
    return HighlightsCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      chapter: chapter ?? this.chapter,
      verse: verse ?? this.verse,
      translationCode: translationCode ?? this.translationCode,
      wordStart: wordStart ?? this.wordStart,
      wordEnd: wordEnd ?? this.wordEnd,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (chapter.present) {
      map['chapter'] = Variable<int>(chapter.value);
    }
    if (verse.present) {
      map['verse'] = Variable<int>(verse.value);
    }
    if (translationCode.present) {
      map['translation_code'] = Variable<String>(translationCode.value);
    }
    if (wordStart.present) {
      map['word_start'] = Variable<int>(wordStart.value);
    }
    if (wordEnd.present) {
      map['word_end'] = Variable<int>(wordEnd.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HighlightsCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse, ')
          ..write('translationCode: $translationCode, ')
          ..write('wordStart: $wordStart, ')
          ..write('wordEnd: $wordEnd, ')
          ..write('color: $color, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $VocabularyItemsTable extends VocabularyItems
    with TableInfo<$VocabularyItemsTable, VocabularyItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VocabularyItemsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
    'word',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wordNormalizedMeta = const VerificationMeta(
    'wordNormalized',
  );
  @override
  late final GeneratedColumn<String> wordNormalized = GeneratedColumn<String>(
    'word_normalized',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _partOfSpeechMeta = const VerificationMeta(
    'partOfSpeech',
  );
  @override
  late final GeneratedColumn<String> partOfSpeech = GeneratedColumn<String>(
    'part_of_speech',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 30,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _definitionMeta = const VerificationMeta(
    'definition',
  );
  @override
  late final GeneratedColumn<String> definition = GeneratedColumn<String>(
    'definition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bibleDefinitionMeta = const VerificationMeta(
    'bibleDefinition',
  );
  @override
  late final GeneratedColumn<String> bibleDefinition = GeneratedColumn<String>(
    'bible_definition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _ipaMeta = const VerificationMeta('ipa');
  @override
  late final GeneratedColumn<String> ipa = GeneratedColumn<String>(
    'ipa',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _chapterMeta = const VerificationMeta(
    'chapter',
  );
  @override
  late final GeneratedColumn<int> chapter = GeneratedColumn<int>(
    'chapter',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _verseMeta = const VerificationMeta('verse');
  @override
  late final GeneratedColumn<int> verse = GeneratedColumn<int>(
    'verse',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _translationCodeMeta = const VerificationMeta(
    'translationCode',
  );
  @override
  late final GeneratedColumn<String> translationCode = GeneratedColumn<String>(
    'translation_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _masteryLevelMeta = const VerificationMeta(
    'masteryLevel',
  );
  @override
  late final GeneratedColumn<int> masteryLevel = GeneratedColumn<int>(
    'mastery_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _reviewCountMeta = const VerificationMeta(
    'reviewCount',
  );
  @override
  late final GeneratedColumn<int> reviewCount = GeneratedColumn<int>(
    'review_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _correctCountMeta = const VerificationMeta(
    'correctCount',
  );
  @override
  late final GeneratedColumn<int> correctCount = GeneratedColumn<int>(
    'correct_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _repetitionsMeta = const VerificationMeta(
    'repetitions',
  );
  @override
  late final GeneratedColumn<int> repetitions = GeneratedColumn<int>(
    'repetitions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _easeFactorMeta = const VerificationMeta(
    'easeFactor',
  );
  @override
  late final GeneratedColumn<double> easeFactor = GeneratedColumn<double>(
    'ease_factor',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(2.5),
  );
  static const VerificationMeta _intervalDaysMeta = const VerificationMeta(
    'intervalDays',
  );
  @override
  late final GeneratedColumn<int> intervalDays = GeneratedColumn<int>(
    'interval_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _addedAtMeta = const VerificationMeta(
    'addedAt',
  );
  @override
  late final GeneratedColumn<DateTime> addedAt = GeneratedColumn<DateTime>(
    'added_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextReviewAtMeta = const VerificationMeta(
    'nextReviewAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextReviewAt = GeneratedColumn<DateTime>(
    'next_review_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastReviewedAtMeta = const VerificationMeta(
    'lastReviewedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastReviewedAt =
      GeneratedColumn<DateTime>(
        'last_reviewed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isLearnedMeta = const VerificationMeta(
    'isLearned',
  );
  @override
  late final GeneratedColumn<bool> isLearned = GeneratedColumn<bool>(
    'is_learned',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_learned" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    word,
    wordNormalized,
    partOfSpeech,
    definition,
    bibleDefinition,
    ipa,
    bookId,
    chapter,
    verse,
    translationCode,
    note,
    masteryLevel,
    reviewCount,
    correctCount,
    repetitions,
    easeFactor,
    intervalDays,
    addedAt,
    nextReviewAt,
    lastReviewedAt,
    isLearned,
    isFavorite,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vocabulary_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<VocabularyItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word')) {
      context.handle(
        _wordMeta,
        word.isAcceptableOrUnknown(data['word']!, _wordMeta),
      );
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('word_normalized')) {
      context.handle(
        _wordNormalizedMeta,
        wordNormalized.isAcceptableOrUnknown(
          data['word_normalized']!,
          _wordNormalizedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_wordNormalizedMeta);
    }
    if (data.containsKey('part_of_speech')) {
      context.handle(
        _partOfSpeechMeta,
        partOfSpeech.isAcceptableOrUnknown(
          data['part_of_speech']!,
          _partOfSpeechMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_partOfSpeechMeta);
    }
    if (data.containsKey('definition')) {
      context.handle(
        _definitionMeta,
        definition.isAcceptableOrUnknown(data['definition']!, _definitionMeta),
      );
    } else if (isInserting) {
      context.missing(_definitionMeta);
    }
    if (data.containsKey('bible_definition')) {
      context.handle(
        _bibleDefinitionMeta,
        bibleDefinition.isAcceptableOrUnknown(
          data['bible_definition']!,
          _bibleDefinitionMeta,
        ),
      );
    }
    if (data.containsKey('ipa')) {
      context.handle(
        _ipaMeta,
        ipa.isAcceptableOrUnknown(data['ipa']!, _ipaMeta),
      );
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    }
    if (data.containsKey('chapter')) {
      context.handle(
        _chapterMeta,
        chapter.isAcceptableOrUnknown(data['chapter']!, _chapterMeta),
      );
    }
    if (data.containsKey('verse')) {
      context.handle(
        _verseMeta,
        verse.isAcceptableOrUnknown(data['verse']!, _verseMeta),
      );
    }
    if (data.containsKey('translation_code')) {
      context.handle(
        _translationCodeMeta,
        translationCode.isAcceptableOrUnknown(
          data['translation_code']!,
          _translationCodeMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('mastery_level')) {
      context.handle(
        _masteryLevelMeta,
        masteryLevel.isAcceptableOrUnknown(
          data['mastery_level']!,
          _masteryLevelMeta,
        ),
      );
    }
    if (data.containsKey('review_count')) {
      context.handle(
        _reviewCountMeta,
        reviewCount.isAcceptableOrUnknown(
          data['review_count']!,
          _reviewCountMeta,
        ),
      );
    }
    if (data.containsKey('correct_count')) {
      context.handle(
        _correctCountMeta,
        correctCount.isAcceptableOrUnknown(
          data['correct_count']!,
          _correctCountMeta,
        ),
      );
    }
    if (data.containsKey('repetitions')) {
      context.handle(
        _repetitionsMeta,
        repetitions.isAcceptableOrUnknown(
          data['repetitions']!,
          _repetitionsMeta,
        ),
      );
    }
    if (data.containsKey('ease_factor')) {
      context.handle(
        _easeFactorMeta,
        easeFactor.isAcceptableOrUnknown(data['ease_factor']!, _easeFactorMeta),
      );
    }
    if (data.containsKey('interval_days')) {
      context.handle(
        _intervalDaysMeta,
        intervalDays.isAcceptableOrUnknown(
          data['interval_days']!,
          _intervalDaysMeta,
        ),
      );
    }
    if (data.containsKey('added_at')) {
      context.handle(
        _addedAtMeta,
        addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_addedAtMeta);
    }
    if (data.containsKey('next_review_at')) {
      context.handle(
        _nextReviewAtMeta,
        nextReviewAt.isAcceptableOrUnknown(
          data['next_review_at']!,
          _nextReviewAtMeta,
        ),
      );
    }
    if (data.containsKey('last_reviewed_at')) {
      context.handle(
        _lastReviewedAtMeta,
        lastReviewedAt.isAcceptableOrUnknown(
          data['last_reviewed_at']!,
          _lastReviewedAtMeta,
        ),
      );
    }
    if (data.containsKey('is_learned')) {
      context.handle(
        _isLearnedMeta,
        isLearned.isAcceptableOrUnknown(data['is_learned']!, _isLearnedMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {word, partOfSpeech},
  ];
  @override
  VocabularyItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VocabularyItem(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      word:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}word'],
          )!,
      wordNormalized:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}word_normalized'],
          )!,
      partOfSpeech:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}part_of_speech'],
          )!,
      definition:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}definition'],
          )!,
      bibleDefinition:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}bible_definition'],
          )!,
      ipa:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}ipa'],
          )!,
      bookId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}book_id'],
          )!,
      chapter:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}chapter'],
          )!,
      verse:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}verse'],
          )!,
      translationCode:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}translation_code'],
          )!,
      note:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}note'],
          )!,
      masteryLevel:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}mastery_level'],
          )!,
      reviewCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}review_count'],
          )!,
      correctCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}correct_count'],
          )!,
      repetitions:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}repetitions'],
          )!,
      easeFactor:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}ease_factor'],
          )!,
      intervalDays:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}interval_days'],
          )!,
      addedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}added_at'],
          )!,
      nextReviewAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_review_at'],
      ),
      lastReviewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_reviewed_at'],
      ),
      isLearned:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_learned'],
          )!,
      isFavorite:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_favorite'],
          )!,
    );
  }

  @override
  $VocabularyItemsTable createAlias(String alias) {
    return $VocabularyItemsTable(attachedDatabase, alias);
  }
}

class VocabularyItem extends DataClass implements Insertable<VocabularyItem> {
  final int id;
  final String word;
  final String wordNormalized;
  final String partOfSpeech;
  final String definition;
  final String bibleDefinition;
  final String ipa;
  final int bookId;
  final int chapter;
  final int verse;
  final String translationCode;
  final String note;
  final int masteryLevel;
  final int reviewCount;
  final int correctCount;
  final int repetitions;
  final double easeFactor;
  final int intervalDays;
  final DateTime addedAt;
  final DateTime? nextReviewAt;
  final DateTime? lastReviewedAt;
  final bool isLearned;
  final bool isFavorite;
  const VocabularyItem({
    required this.id,
    required this.word,
    required this.wordNormalized,
    required this.partOfSpeech,
    required this.definition,
    required this.bibleDefinition,
    required this.ipa,
    required this.bookId,
    required this.chapter,
    required this.verse,
    required this.translationCode,
    required this.note,
    required this.masteryLevel,
    required this.reviewCount,
    required this.correctCount,
    required this.repetitions,
    required this.easeFactor,
    required this.intervalDays,
    required this.addedAt,
    this.nextReviewAt,
    this.lastReviewedAt,
    required this.isLearned,
    required this.isFavorite,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word'] = Variable<String>(word);
    map['word_normalized'] = Variable<String>(wordNormalized);
    map['part_of_speech'] = Variable<String>(partOfSpeech);
    map['definition'] = Variable<String>(definition);
    map['bible_definition'] = Variable<String>(bibleDefinition);
    map['ipa'] = Variable<String>(ipa);
    map['book_id'] = Variable<int>(bookId);
    map['chapter'] = Variable<int>(chapter);
    map['verse'] = Variable<int>(verse);
    map['translation_code'] = Variable<String>(translationCode);
    map['note'] = Variable<String>(note);
    map['mastery_level'] = Variable<int>(masteryLevel);
    map['review_count'] = Variable<int>(reviewCount);
    map['correct_count'] = Variable<int>(correctCount);
    map['repetitions'] = Variable<int>(repetitions);
    map['ease_factor'] = Variable<double>(easeFactor);
    map['interval_days'] = Variable<int>(intervalDays);
    map['added_at'] = Variable<DateTime>(addedAt);
    if (!nullToAbsent || nextReviewAt != null) {
      map['next_review_at'] = Variable<DateTime>(nextReviewAt);
    }
    if (!nullToAbsent || lastReviewedAt != null) {
      map['last_reviewed_at'] = Variable<DateTime>(lastReviewedAt);
    }
    map['is_learned'] = Variable<bool>(isLearned);
    map['is_favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  VocabularyItemsCompanion toCompanion(bool nullToAbsent) {
    return VocabularyItemsCompanion(
      id: Value(id),
      word: Value(word),
      wordNormalized: Value(wordNormalized),
      partOfSpeech: Value(partOfSpeech),
      definition: Value(definition),
      bibleDefinition: Value(bibleDefinition),
      ipa: Value(ipa),
      bookId: Value(bookId),
      chapter: Value(chapter),
      verse: Value(verse),
      translationCode: Value(translationCode),
      note: Value(note),
      masteryLevel: Value(masteryLevel),
      reviewCount: Value(reviewCount),
      correctCount: Value(correctCount),
      repetitions: Value(repetitions),
      easeFactor: Value(easeFactor),
      intervalDays: Value(intervalDays),
      addedAt: Value(addedAt),
      nextReviewAt:
          nextReviewAt == null && nullToAbsent
              ? const Value.absent()
              : Value(nextReviewAt),
      lastReviewedAt:
          lastReviewedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(lastReviewedAt),
      isLearned: Value(isLearned),
      isFavorite: Value(isFavorite),
    );
  }

  factory VocabularyItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VocabularyItem(
      id: serializer.fromJson<int>(json['id']),
      word: serializer.fromJson<String>(json['word']),
      wordNormalized: serializer.fromJson<String>(json['wordNormalized']),
      partOfSpeech: serializer.fromJson<String>(json['partOfSpeech']),
      definition: serializer.fromJson<String>(json['definition']),
      bibleDefinition: serializer.fromJson<String>(json['bibleDefinition']),
      ipa: serializer.fromJson<String>(json['ipa']),
      bookId: serializer.fromJson<int>(json['bookId']),
      chapter: serializer.fromJson<int>(json['chapter']),
      verse: serializer.fromJson<int>(json['verse']),
      translationCode: serializer.fromJson<String>(json['translationCode']),
      note: serializer.fromJson<String>(json['note']),
      masteryLevel: serializer.fromJson<int>(json['masteryLevel']),
      reviewCount: serializer.fromJson<int>(json['reviewCount']),
      correctCount: serializer.fromJson<int>(json['correctCount']),
      repetitions: serializer.fromJson<int>(json['repetitions']),
      easeFactor: serializer.fromJson<double>(json['easeFactor']),
      intervalDays: serializer.fromJson<int>(json['intervalDays']),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
      nextReviewAt: serializer.fromJson<DateTime?>(json['nextReviewAt']),
      lastReviewedAt: serializer.fromJson<DateTime?>(json['lastReviewedAt']),
      isLearned: serializer.fromJson<bool>(json['isLearned']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'word': serializer.toJson<String>(word),
      'wordNormalized': serializer.toJson<String>(wordNormalized),
      'partOfSpeech': serializer.toJson<String>(partOfSpeech),
      'definition': serializer.toJson<String>(definition),
      'bibleDefinition': serializer.toJson<String>(bibleDefinition),
      'ipa': serializer.toJson<String>(ipa),
      'bookId': serializer.toJson<int>(bookId),
      'chapter': serializer.toJson<int>(chapter),
      'verse': serializer.toJson<int>(verse),
      'translationCode': serializer.toJson<String>(translationCode),
      'note': serializer.toJson<String>(note),
      'masteryLevel': serializer.toJson<int>(masteryLevel),
      'reviewCount': serializer.toJson<int>(reviewCount),
      'correctCount': serializer.toJson<int>(correctCount),
      'repetitions': serializer.toJson<int>(repetitions),
      'easeFactor': serializer.toJson<double>(easeFactor),
      'intervalDays': serializer.toJson<int>(intervalDays),
      'addedAt': serializer.toJson<DateTime>(addedAt),
      'nextReviewAt': serializer.toJson<DateTime?>(nextReviewAt),
      'lastReviewedAt': serializer.toJson<DateTime?>(lastReviewedAt),
      'isLearned': serializer.toJson<bool>(isLearned),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  VocabularyItem copyWith({
    int? id,
    String? word,
    String? wordNormalized,
    String? partOfSpeech,
    String? definition,
    String? bibleDefinition,
    String? ipa,
    int? bookId,
    int? chapter,
    int? verse,
    String? translationCode,
    String? note,
    int? masteryLevel,
    int? reviewCount,
    int? correctCount,
    int? repetitions,
    double? easeFactor,
    int? intervalDays,
    DateTime? addedAt,
    Value<DateTime?> nextReviewAt = const Value.absent(),
    Value<DateTime?> lastReviewedAt = const Value.absent(),
    bool? isLearned,
    bool? isFavorite,
  }) => VocabularyItem(
    id: id ?? this.id,
    word: word ?? this.word,
    wordNormalized: wordNormalized ?? this.wordNormalized,
    partOfSpeech: partOfSpeech ?? this.partOfSpeech,
    definition: definition ?? this.definition,
    bibleDefinition: bibleDefinition ?? this.bibleDefinition,
    ipa: ipa ?? this.ipa,
    bookId: bookId ?? this.bookId,
    chapter: chapter ?? this.chapter,
    verse: verse ?? this.verse,
    translationCode: translationCode ?? this.translationCode,
    note: note ?? this.note,
    masteryLevel: masteryLevel ?? this.masteryLevel,
    reviewCount: reviewCount ?? this.reviewCount,
    correctCount: correctCount ?? this.correctCount,
    repetitions: repetitions ?? this.repetitions,
    easeFactor: easeFactor ?? this.easeFactor,
    intervalDays: intervalDays ?? this.intervalDays,
    addedAt: addedAt ?? this.addedAt,
    nextReviewAt: nextReviewAt.present ? nextReviewAt.value : this.nextReviewAt,
    lastReviewedAt:
        lastReviewedAt.present ? lastReviewedAt.value : this.lastReviewedAt,
    isLearned: isLearned ?? this.isLearned,
    isFavorite: isFavorite ?? this.isFavorite,
  );
  VocabularyItem copyWithCompanion(VocabularyItemsCompanion data) {
    return VocabularyItem(
      id: data.id.present ? data.id.value : this.id,
      word: data.word.present ? data.word.value : this.word,
      wordNormalized:
          data.wordNormalized.present
              ? data.wordNormalized.value
              : this.wordNormalized,
      partOfSpeech:
          data.partOfSpeech.present
              ? data.partOfSpeech.value
              : this.partOfSpeech,
      definition:
          data.definition.present ? data.definition.value : this.definition,
      bibleDefinition:
          data.bibleDefinition.present
              ? data.bibleDefinition.value
              : this.bibleDefinition,
      ipa: data.ipa.present ? data.ipa.value : this.ipa,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      chapter: data.chapter.present ? data.chapter.value : this.chapter,
      verse: data.verse.present ? data.verse.value : this.verse,
      translationCode:
          data.translationCode.present
              ? data.translationCode.value
              : this.translationCode,
      note: data.note.present ? data.note.value : this.note,
      masteryLevel:
          data.masteryLevel.present
              ? data.masteryLevel.value
              : this.masteryLevel,
      reviewCount:
          data.reviewCount.present ? data.reviewCount.value : this.reviewCount,
      correctCount:
          data.correctCount.present
              ? data.correctCount.value
              : this.correctCount,
      repetitions:
          data.repetitions.present ? data.repetitions.value : this.repetitions,
      easeFactor:
          data.easeFactor.present ? data.easeFactor.value : this.easeFactor,
      intervalDays:
          data.intervalDays.present
              ? data.intervalDays.value
              : this.intervalDays,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
      nextReviewAt:
          data.nextReviewAt.present
              ? data.nextReviewAt.value
              : this.nextReviewAt,
      lastReviewedAt:
          data.lastReviewedAt.present
              ? data.lastReviewedAt.value
              : this.lastReviewedAt,
      isLearned: data.isLearned.present ? data.isLearned.value : this.isLearned,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VocabularyItem(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('wordNormalized: $wordNormalized, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('definition: $definition, ')
          ..write('bibleDefinition: $bibleDefinition, ')
          ..write('ipa: $ipa, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse, ')
          ..write('translationCode: $translationCode, ')
          ..write('note: $note, ')
          ..write('masteryLevel: $masteryLevel, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('correctCount: $correctCount, ')
          ..write('repetitions: $repetitions, ')
          ..write('easeFactor: $easeFactor, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('addedAt: $addedAt, ')
          ..write('nextReviewAt: $nextReviewAt, ')
          ..write('lastReviewedAt: $lastReviewedAt, ')
          ..write('isLearned: $isLearned, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    word,
    wordNormalized,
    partOfSpeech,
    definition,
    bibleDefinition,
    ipa,
    bookId,
    chapter,
    verse,
    translationCode,
    note,
    masteryLevel,
    reviewCount,
    correctCount,
    repetitions,
    easeFactor,
    intervalDays,
    addedAt,
    nextReviewAt,
    lastReviewedAt,
    isLearned,
    isFavorite,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VocabularyItem &&
          other.id == this.id &&
          other.word == this.word &&
          other.wordNormalized == this.wordNormalized &&
          other.partOfSpeech == this.partOfSpeech &&
          other.definition == this.definition &&
          other.bibleDefinition == this.bibleDefinition &&
          other.ipa == this.ipa &&
          other.bookId == this.bookId &&
          other.chapter == this.chapter &&
          other.verse == this.verse &&
          other.translationCode == this.translationCode &&
          other.note == this.note &&
          other.masteryLevel == this.masteryLevel &&
          other.reviewCount == this.reviewCount &&
          other.correctCount == this.correctCount &&
          other.repetitions == this.repetitions &&
          other.easeFactor == this.easeFactor &&
          other.intervalDays == this.intervalDays &&
          other.addedAt == this.addedAt &&
          other.nextReviewAt == this.nextReviewAt &&
          other.lastReviewedAt == this.lastReviewedAt &&
          other.isLearned == this.isLearned &&
          other.isFavorite == this.isFavorite);
}

class VocabularyItemsCompanion extends UpdateCompanion<VocabularyItem> {
  final Value<int> id;
  final Value<String> word;
  final Value<String> wordNormalized;
  final Value<String> partOfSpeech;
  final Value<String> definition;
  final Value<String> bibleDefinition;
  final Value<String> ipa;
  final Value<int> bookId;
  final Value<int> chapter;
  final Value<int> verse;
  final Value<String> translationCode;
  final Value<String> note;
  final Value<int> masteryLevel;
  final Value<int> reviewCount;
  final Value<int> correctCount;
  final Value<int> repetitions;
  final Value<double> easeFactor;
  final Value<int> intervalDays;
  final Value<DateTime> addedAt;
  final Value<DateTime?> nextReviewAt;
  final Value<DateTime?> lastReviewedAt;
  final Value<bool> isLearned;
  final Value<bool> isFavorite;
  const VocabularyItemsCompanion({
    this.id = const Value.absent(),
    this.word = const Value.absent(),
    this.wordNormalized = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
    this.definition = const Value.absent(),
    this.bibleDefinition = const Value.absent(),
    this.ipa = const Value.absent(),
    this.bookId = const Value.absent(),
    this.chapter = const Value.absent(),
    this.verse = const Value.absent(),
    this.translationCode = const Value.absent(),
    this.note = const Value.absent(),
    this.masteryLevel = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.repetitions = const Value.absent(),
    this.easeFactor = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.addedAt = const Value.absent(),
    this.nextReviewAt = const Value.absent(),
    this.lastReviewedAt = const Value.absent(),
    this.isLearned = const Value.absent(),
    this.isFavorite = const Value.absent(),
  });
  VocabularyItemsCompanion.insert({
    this.id = const Value.absent(),
    required String word,
    required String wordNormalized,
    required String partOfSpeech,
    required String definition,
    this.bibleDefinition = const Value.absent(),
    this.ipa = const Value.absent(),
    this.bookId = const Value.absent(),
    this.chapter = const Value.absent(),
    this.verse = const Value.absent(),
    this.translationCode = const Value.absent(),
    this.note = const Value.absent(),
    this.masteryLevel = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.repetitions = const Value.absent(),
    this.easeFactor = const Value.absent(),
    this.intervalDays = const Value.absent(),
    required DateTime addedAt,
    this.nextReviewAt = const Value.absent(),
    this.lastReviewedAt = const Value.absent(),
    this.isLearned = const Value.absent(),
    this.isFavorite = const Value.absent(),
  }) : word = Value(word),
       wordNormalized = Value(wordNormalized),
       partOfSpeech = Value(partOfSpeech),
       definition = Value(definition),
       addedAt = Value(addedAt);
  static Insertable<VocabularyItem> custom({
    Expression<int>? id,
    Expression<String>? word,
    Expression<String>? wordNormalized,
    Expression<String>? partOfSpeech,
    Expression<String>? definition,
    Expression<String>? bibleDefinition,
    Expression<String>? ipa,
    Expression<int>? bookId,
    Expression<int>? chapter,
    Expression<int>? verse,
    Expression<String>? translationCode,
    Expression<String>? note,
    Expression<int>? masteryLevel,
    Expression<int>? reviewCount,
    Expression<int>? correctCount,
    Expression<int>? repetitions,
    Expression<double>? easeFactor,
    Expression<int>? intervalDays,
    Expression<DateTime>? addedAt,
    Expression<DateTime>? nextReviewAt,
    Expression<DateTime>? lastReviewedAt,
    Expression<bool>? isLearned,
    Expression<bool>? isFavorite,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (word != null) 'word': word,
      if (wordNormalized != null) 'word_normalized': wordNormalized,
      if (partOfSpeech != null) 'part_of_speech': partOfSpeech,
      if (definition != null) 'definition': definition,
      if (bibleDefinition != null) 'bible_definition': bibleDefinition,
      if (ipa != null) 'ipa': ipa,
      if (bookId != null) 'book_id': bookId,
      if (chapter != null) 'chapter': chapter,
      if (verse != null) 'verse': verse,
      if (translationCode != null) 'translation_code': translationCode,
      if (note != null) 'note': note,
      if (masteryLevel != null) 'mastery_level': masteryLevel,
      if (reviewCount != null) 'review_count': reviewCount,
      if (correctCount != null) 'correct_count': correctCount,
      if (repetitions != null) 'repetitions': repetitions,
      if (easeFactor != null) 'ease_factor': easeFactor,
      if (intervalDays != null) 'interval_days': intervalDays,
      if (addedAt != null) 'added_at': addedAt,
      if (nextReviewAt != null) 'next_review_at': nextReviewAt,
      if (lastReviewedAt != null) 'last_reviewed_at': lastReviewedAt,
      if (isLearned != null) 'is_learned': isLearned,
      if (isFavorite != null) 'is_favorite': isFavorite,
    });
  }

  VocabularyItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? word,
    Value<String>? wordNormalized,
    Value<String>? partOfSpeech,
    Value<String>? definition,
    Value<String>? bibleDefinition,
    Value<String>? ipa,
    Value<int>? bookId,
    Value<int>? chapter,
    Value<int>? verse,
    Value<String>? translationCode,
    Value<String>? note,
    Value<int>? masteryLevel,
    Value<int>? reviewCount,
    Value<int>? correctCount,
    Value<int>? repetitions,
    Value<double>? easeFactor,
    Value<int>? intervalDays,
    Value<DateTime>? addedAt,
    Value<DateTime?>? nextReviewAt,
    Value<DateTime?>? lastReviewedAt,
    Value<bool>? isLearned,
    Value<bool>? isFavorite,
  }) {
    return VocabularyItemsCompanion(
      id: id ?? this.id,
      word: word ?? this.word,
      wordNormalized: wordNormalized ?? this.wordNormalized,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      definition: definition ?? this.definition,
      bibleDefinition: bibleDefinition ?? this.bibleDefinition,
      ipa: ipa ?? this.ipa,
      bookId: bookId ?? this.bookId,
      chapter: chapter ?? this.chapter,
      verse: verse ?? this.verse,
      translationCode: translationCode ?? this.translationCode,
      note: note ?? this.note,
      masteryLevel: masteryLevel ?? this.masteryLevel,
      reviewCount: reviewCount ?? this.reviewCount,
      correctCount: correctCount ?? this.correctCount,
      repetitions: repetitions ?? this.repetitions,
      easeFactor: easeFactor ?? this.easeFactor,
      intervalDays: intervalDays ?? this.intervalDays,
      addedAt: addedAt ?? this.addedAt,
      nextReviewAt: nextReviewAt ?? this.nextReviewAt,
      lastReviewedAt: lastReviewedAt ?? this.lastReviewedAt,
      isLearned: isLearned ?? this.isLearned,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (wordNormalized.present) {
      map['word_normalized'] = Variable<String>(wordNormalized.value);
    }
    if (partOfSpeech.present) {
      map['part_of_speech'] = Variable<String>(partOfSpeech.value);
    }
    if (definition.present) {
      map['definition'] = Variable<String>(definition.value);
    }
    if (bibleDefinition.present) {
      map['bible_definition'] = Variable<String>(bibleDefinition.value);
    }
    if (ipa.present) {
      map['ipa'] = Variable<String>(ipa.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (chapter.present) {
      map['chapter'] = Variable<int>(chapter.value);
    }
    if (verse.present) {
      map['verse'] = Variable<int>(verse.value);
    }
    if (translationCode.present) {
      map['translation_code'] = Variable<String>(translationCode.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (masteryLevel.present) {
      map['mastery_level'] = Variable<int>(masteryLevel.value);
    }
    if (reviewCount.present) {
      map['review_count'] = Variable<int>(reviewCount.value);
    }
    if (correctCount.present) {
      map['correct_count'] = Variable<int>(correctCount.value);
    }
    if (repetitions.present) {
      map['repetitions'] = Variable<int>(repetitions.value);
    }
    if (easeFactor.present) {
      map['ease_factor'] = Variable<double>(easeFactor.value);
    }
    if (intervalDays.present) {
      map['interval_days'] = Variable<int>(intervalDays.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    if (nextReviewAt.present) {
      map['next_review_at'] = Variable<DateTime>(nextReviewAt.value);
    }
    if (lastReviewedAt.present) {
      map['last_reviewed_at'] = Variable<DateTime>(lastReviewedAt.value);
    }
    if (isLearned.present) {
      map['is_learned'] = Variable<bool>(isLearned.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VocabularyItemsCompanion(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('wordNormalized: $wordNormalized, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('definition: $definition, ')
          ..write('bibleDefinition: $bibleDefinition, ')
          ..write('ipa: $ipa, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse, ')
          ..write('translationCode: $translationCode, ')
          ..write('note: $note, ')
          ..write('masteryLevel: $masteryLevel, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('correctCount: $correctCount, ')
          ..write('repetitions: $repetitions, ')
          ..write('easeFactor: $easeFactor, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('addedAt: $addedAt, ')
          ..write('nextReviewAt: $nextReviewAt, ')
          ..write('lastReviewedAt: $lastReviewedAt, ')
          ..write('isLearned: $isLearned, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }
}

class $ReviewSessionsTable extends ReviewSessions
    with TableInfo<$ReviewSessionsTable, ReviewSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewSessionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalCountMeta = const VerificationMeta(
    'totalCount',
  );
  @override
  late final GeneratedColumn<int> totalCount = GeneratedColumn<int>(
    'total_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctCountMeta = const VerificationMeta(
    'correctCount',
  );
  @override
  late final GeneratedColumn<int> correctCount = GeneratedColumn<int>(
    'correct_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _sessionTypeMeta = const VerificationMeta(
    'sessionType',
  );
  @override
  late final GeneratedColumn<String> sessionType = GeneratedColumn<String>(
    'session_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startedAt,
    completedAt,
    totalCount,
    correctCount,
    sessionType,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'review_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReviewSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('total_count')) {
      context.handle(
        _totalCountMeta,
        totalCount.isAcceptableOrUnknown(data['total_count']!, _totalCountMeta),
      );
    } else if (isInserting) {
      context.missing(_totalCountMeta);
    }
    if (data.containsKey('correct_count')) {
      context.handle(
        _correctCountMeta,
        correctCount.isAcceptableOrUnknown(
          data['correct_count']!,
          _correctCountMeta,
        ),
      );
    }
    if (data.containsKey('session_type')) {
      context.handle(
        _sessionTypeMeta,
        sessionType.isAcceptableOrUnknown(
          data['session_type']!,
          _sessionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sessionTypeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReviewSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewSession(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      startedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}started_at'],
          )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      totalCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}total_count'],
          )!,
      correctCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}correct_count'],
          )!,
      sessionType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}session_type'],
          )!,
    );
  }

  @override
  $ReviewSessionsTable createAlias(String alias) {
    return $ReviewSessionsTable(attachedDatabase, alias);
  }
}

class ReviewSession extends DataClass implements Insertable<ReviewSession> {
  final int id;
  final DateTime startedAt;
  final DateTime? completedAt;
  final int totalCount;
  final int correctCount;
  final String sessionType;
  const ReviewSession({
    required this.id,
    required this.startedAt,
    this.completedAt,
    required this.totalCount,
    required this.correctCount,
    required this.sessionType,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['total_count'] = Variable<int>(totalCount);
    map['correct_count'] = Variable<int>(correctCount);
    map['session_type'] = Variable<String>(sessionType);
    return map;
  }

  ReviewSessionsCompanion toCompanion(bool nullToAbsent) {
    return ReviewSessionsCompanion(
      id: Value(id),
      startedAt: Value(startedAt),
      completedAt:
          completedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(completedAt),
      totalCount: Value(totalCount),
      correctCount: Value(correctCount),
      sessionType: Value(sessionType),
    );
  }

  factory ReviewSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewSession(
      id: serializer.fromJson<int>(json['id']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      totalCount: serializer.fromJson<int>(json['totalCount']),
      correctCount: serializer.fromJson<int>(json['correctCount']),
      sessionType: serializer.fromJson<String>(json['sessionType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'totalCount': serializer.toJson<int>(totalCount),
      'correctCount': serializer.toJson<int>(correctCount),
      'sessionType': serializer.toJson<String>(sessionType),
    };
  }

  ReviewSession copyWith({
    int? id,
    DateTime? startedAt,
    Value<DateTime?> completedAt = const Value.absent(),
    int? totalCount,
    int? correctCount,
    String? sessionType,
  }) => ReviewSession(
    id: id ?? this.id,
    startedAt: startedAt ?? this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    totalCount: totalCount ?? this.totalCount,
    correctCount: correctCount ?? this.correctCount,
    sessionType: sessionType ?? this.sessionType,
  );
  ReviewSession copyWithCompanion(ReviewSessionsCompanion data) {
    return ReviewSession(
      id: data.id.present ? data.id.value : this.id,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      totalCount:
          data.totalCount.present ? data.totalCount.value : this.totalCount,
      correctCount:
          data.correctCount.present
              ? data.correctCount.value
              : this.correctCount,
      sessionType:
          data.sessionType.present ? data.sessionType.value : this.sessionType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReviewSession(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('totalCount: $totalCount, ')
          ..write('correctCount: $correctCount, ')
          ..write('sessionType: $sessionType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    startedAt,
    completedAt,
    totalCount,
    correctCount,
    sessionType,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewSession &&
          other.id == this.id &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.totalCount == this.totalCount &&
          other.correctCount == this.correctCount &&
          other.sessionType == this.sessionType);
}

class ReviewSessionsCompanion extends UpdateCompanion<ReviewSession> {
  final Value<int> id;
  final Value<DateTime> startedAt;
  final Value<DateTime?> completedAt;
  final Value<int> totalCount;
  final Value<int> correctCount;
  final Value<String> sessionType;
  const ReviewSessionsCompanion({
    this.id = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.totalCount = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.sessionType = const Value.absent(),
  });
  ReviewSessionsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime startedAt,
    this.completedAt = const Value.absent(),
    required int totalCount,
    this.correctCount = const Value.absent(),
    required String sessionType,
  }) : startedAt = Value(startedAt),
       totalCount = Value(totalCount),
       sessionType = Value(sessionType);
  static Insertable<ReviewSession> custom({
    Expression<int>? id,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<int>? totalCount,
    Expression<int>? correctCount,
    Expression<String>? sessionType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (totalCount != null) 'total_count': totalCount,
      if (correctCount != null) 'correct_count': correctCount,
      if (sessionType != null) 'session_type': sessionType,
    });
  }

  ReviewSessionsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? startedAt,
    Value<DateTime?>? completedAt,
    Value<int>? totalCount,
    Value<int>? correctCount,
    Value<String>? sessionType,
  }) {
    return ReviewSessionsCompanion(
      id: id ?? this.id,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      totalCount: totalCount ?? this.totalCount,
      correctCount: correctCount ?? this.correctCount,
      sessionType: sessionType ?? this.sessionType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (totalCount.present) {
      map['total_count'] = Variable<int>(totalCount.value);
    }
    if (correctCount.present) {
      map['correct_count'] = Variable<int>(correctCount.value);
    }
    if (sessionType.present) {
      map['session_type'] = Variable<String>(sessionType.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewSessionsCompanion(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('totalCount: $totalCount, ')
          ..write('correctCount: $correctCount, ')
          ..write('sessionType: $sessionType')
          ..write(')'))
        .toString();
  }
}

class $ReviewAnswersTable extends ReviewAnswers
    with TableInfo<$ReviewAnswersTable, ReviewAnswer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewAnswersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES review_sessions (id)',
    ),
  );
  static const VerificationMeta _vocabularyIdMeta = const VerificationMeta(
    'vocabularyId',
  );
  @override
  late final GeneratedColumn<int> vocabularyId = GeneratedColumn<int>(
    'vocabulary_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vocabulary_items (id)',
    ),
  );
  static const VerificationMeta _isCorrectMeta = const VerificationMeta(
    'isCorrect',
  );
  @override
  late final GeneratedColumn<bool> isCorrect = GeneratedColumn<bool>(
    'is_correct',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_correct" IN (0, 1))',
    ),
  );
  static const VerificationMeta _responseTimeMsMeta = const VerificationMeta(
    'responseTimeMs',
  );
  @override
  late final GeneratedColumn<int> responseTimeMs = GeneratedColumn<int>(
    'response_time_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answeredAtMeta = const VerificationMeta(
    'answeredAt',
  );
  @override
  late final GeneratedColumn<DateTime> answeredAt = GeneratedColumn<DateTime>(
    'answered_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    vocabularyId,
    isCorrect,
    responseTimeMs,
    answeredAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'review_answers';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReviewAnswer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('vocabulary_id')) {
      context.handle(
        _vocabularyIdMeta,
        vocabularyId.isAcceptableOrUnknown(
          data['vocabulary_id']!,
          _vocabularyIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_vocabularyIdMeta);
    }
    if (data.containsKey('is_correct')) {
      context.handle(
        _isCorrectMeta,
        isCorrect.isAcceptableOrUnknown(data['is_correct']!, _isCorrectMeta),
      );
    } else if (isInserting) {
      context.missing(_isCorrectMeta);
    }
    if (data.containsKey('response_time_ms')) {
      context.handle(
        _responseTimeMsMeta,
        responseTimeMs.isAcceptableOrUnknown(
          data['response_time_ms']!,
          _responseTimeMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_responseTimeMsMeta);
    }
    if (data.containsKey('answered_at')) {
      context.handle(
        _answeredAtMeta,
        answeredAt.isAcceptableOrUnknown(data['answered_at']!, _answeredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_answeredAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReviewAnswer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewAnswer(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      sessionId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}session_id'],
          )!,
      vocabularyId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}vocabulary_id'],
          )!,
      isCorrect:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_correct'],
          )!,
      responseTimeMs:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}response_time_ms'],
          )!,
      answeredAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}answered_at'],
          )!,
    );
  }

  @override
  $ReviewAnswersTable createAlias(String alias) {
    return $ReviewAnswersTable(attachedDatabase, alias);
  }
}

class ReviewAnswer extends DataClass implements Insertable<ReviewAnswer> {
  final int id;
  final int sessionId;
  final int vocabularyId;
  final bool isCorrect;
  final int responseTimeMs;
  final DateTime answeredAt;
  const ReviewAnswer({
    required this.id,
    required this.sessionId,
    required this.vocabularyId,
    required this.isCorrect,
    required this.responseTimeMs,
    required this.answeredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<int>(sessionId);
    map['vocabulary_id'] = Variable<int>(vocabularyId);
    map['is_correct'] = Variable<bool>(isCorrect);
    map['response_time_ms'] = Variable<int>(responseTimeMs);
    map['answered_at'] = Variable<DateTime>(answeredAt);
    return map;
  }

  ReviewAnswersCompanion toCompanion(bool nullToAbsent) {
    return ReviewAnswersCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      vocabularyId: Value(vocabularyId),
      isCorrect: Value(isCorrect),
      responseTimeMs: Value(responseTimeMs),
      answeredAt: Value(answeredAt),
    );
  }

  factory ReviewAnswer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewAnswer(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<int>(json['sessionId']),
      vocabularyId: serializer.fromJson<int>(json['vocabularyId']),
      isCorrect: serializer.fromJson<bool>(json['isCorrect']),
      responseTimeMs: serializer.fromJson<int>(json['responseTimeMs']),
      answeredAt: serializer.fromJson<DateTime>(json['answeredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<int>(sessionId),
      'vocabularyId': serializer.toJson<int>(vocabularyId),
      'isCorrect': serializer.toJson<bool>(isCorrect),
      'responseTimeMs': serializer.toJson<int>(responseTimeMs),
      'answeredAt': serializer.toJson<DateTime>(answeredAt),
    };
  }

  ReviewAnswer copyWith({
    int? id,
    int? sessionId,
    int? vocabularyId,
    bool? isCorrect,
    int? responseTimeMs,
    DateTime? answeredAt,
  }) => ReviewAnswer(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    vocabularyId: vocabularyId ?? this.vocabularyId,
    isCorrect: isCorrect ?? this.isCorrect,
    responseTimeMs: responseTimeMs ?? this.responseTimeMs,
    answeredAt: answeredAt ?? this.answeredAt,
  );
  ReviewAnswer copyWithCompanion(ReviewAnswersCompanion data) {
    return ReviewAnswer(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      vocabularyId:
          data.vocabularyId.present
              ? data.vocabularyId.value
              : this.vocabularyId,
      isCorrect: data.isCorrect.present ? data.isCorrect.value : this.isCorrect,
      responseTimeMs:
          data.responseTimeMs.present
              ? data.responseTimeMs.value
              : this.responseTimeMs,
      answeredAt:
          data.answeredAt.present ? data.answeredAt.value : this.answeredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReviewAnswer(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('vocabularyId: $vocabularyId, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('responseTimeMs: $responseTimeMs, ')
          ..write('answeredAt: $answeredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    vocabularyId,
    isCorrect,
    responseTimeMs,
    answeredAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewAnswer &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.vocabularyId == this.vocabularyId &&
          other.isCorrect == this.isCorrect &&
          other.responseTimeMs == this.responseTimeMs &&
          other.answeredAt == this.answeredAt);
}

class ReviewAnswersCompanion extends UpdateCompanion<ReviewAnswer> {
  final Value<int> id;
  final Value<int> sessionId;
  final Value<int> vocabularyId;
  final Value<bool> isCorrect;
  final Value<int> responseTimeMs;
  final Value<DateTime> answeredAt;
  const ReviewAnswersCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.vocabularyId = const Value.absent(),
    this.isCorrect = const Value.absent(),
    this.responseTimeMs = const Value.absent(),
    this.answeredAt = const Value.absent(),
  });
  ReviewAnswersCompanion.insert({
    this.id = const Value.absent(),
    required int sessionId,
    required int vocabularyId,
    required bool isCorrect,
    required int responseTimeMs,
    required DateTime answeredAt,
  }) : sessionId = Value(sessionId),
       vocabularyId = Value(vocabularyId),
       isCorrect = Value(isCorrect),
       responseTimeMs = Value(responseTimeMs),
       answeredAt = Value(answeredAt);
  static Insertable<ReviewAnswer> custom({
    Expression<int>? id,
    Expression<int>? sessionId,
    Expression<int>? vocabularyId,
    Expression<bool>? isCorrect,
    Expression<int>? responseTimeMs,
    Expression<DateTime>? answeredAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (vocabularyId != null) 'vocabulary_id': vocabularyId,
      if (isCorrect != null) 'is_correct': isCorrect,
      if (responseTimeMs != null) 'response_time_ms': responseTimeMs,
      if (answeredAt != null) 'answered_at': answeredAt,
    });
  }

  ReviewAnswersCompanion copyWith({
    Value<int>? id,
    Value<int>? sessionId,
    Value<int>? vocabularyId,
    Value<bool>? isCorrect,
    Value<int>? responseTimeMs,
    Value<DateTime>? answeredAt,
  }) {
    return ReviewAnswersCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      vocabularyId: vocabularyId ?? this.vocabularyId,
      isCorrect: isCorrect ?? this.isCorrect,
      responseTimeMs: responseTimeMs ?? this.responseTimeMs,
      answeredAt: answeredAt ?? this.answeredAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (vocabularyId.present) {
      map['vocabulary_id'] = Variable<int>(vocabularyId.value);
    }
    if (isCorrect.present) {
      map['is_correct'] = Variable<bool>(isCorrect.value);
    }
    if (responseTimeMs.present) {
      map['response_time_ms'] = Variable<int>(responseTimeMs.value);
    }
    if (answeredAt.present) {
      map['answered_at'] = Variable<DateTime>(answeredAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewAnswersCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('vocabularyId: $vocabularyId, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('responseTimeMs: $responseTimeMs, ')
          ..write('answeredAt: $answeredAt')
          ..write(')'))
        .toString();
  }
}

class $ReadingHistoryTable extends ReadingHistory
    with TableInfo<$ReadingHistoryTable, ReadingHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingHistoryTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapterMeta = const VerificationMeta(
    'chapter',
  );
  @override
  late final GeneratedColumn<int> chapter = GeneratedColumn<int>(
    'chapter',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _translationCodeMeta = const VerificationMeta(
    'translationCode',
  );
  @override
  late final GeneratedColumn<String> translationCode = GeneratedColumn<String>(
    'translation_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accessedAtMeta = const VerificationMeta(
    'accessedAt',
  );
  @override
  late final GeneratedColumn<DateTime> accessedAt = GeneratedColumn<DateTime>(
    'accessed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastVerseReadMeta = const VerificationMeta(
    'lastVerseRead',
  );
  @override
  late final GeneratedColumn<int> lastVerseRead = GeneratedColumn<int>(
    'last_verse_read',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bookId,
    chapter,
    translationCode,
    accessedAt,
    durationSeconds,
    lastVerseRead,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReadingHistoryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('chapter')) {
      context.handle(
        _chapterMeta,
        chapter.isAcceptableOrUnknown(data['chapter']!, _chapterMeta),
      );
    } else if (isInserting) {
      context.missing(_chapterMeta);
    }
    if (data.containsKey('translation_code')) {
      context.handle(
        _translationCodeMeta,
        translationCode.isAcceptableOrUnknown(
          data['translation_code']!,
          _translationCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_translationCodeMeta);
    }
    if (data.containsKey('accessed_at')) {
      context.handle(
        _accessedAtMeta,
        accessedAt.isAcceptableOrUnknown(data['accessed_at']!, _accessedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_accessedAtMeta);
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('last_verse_read')) {
      context.handle(
        _lastVerseReadMeta,
        lastVerseRead.isAcceptableOrUnknown(
          data['last_verse_read']!,
          _lastVerseReadMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReadingHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadingHistoryData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      bookId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}book_id'],
          )!,
      chapter:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}chapter'],
          )!,
      translationCode:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}translation_code'],
          )!,
      accessedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}accessed_at'],
          )!,
      durationSeconds:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}duration_seconds'],
          )!,
      lastVerseRead:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}last_verse_read'],
          )!,
    );
  }

  @override
  $ReadingHistoryTable createAlias(String alias) {
    return $ReadingHistoryTable(attachedDatabase, alias);
  }
}

class ReadingHistoryData extends DataClass
    implements Insertable<ReadingHistoryData> {
  final int id;
  final int bookId;
  final int chapter;
  final String translationCode;
  final DateTime accessedAt;
  final int durationSeconds;
  final int lastVerseRead;
  const ReadingHistoryData({
    required this.id,
    required this.bookId,
    required this.chapter,
    required this.translationCode,
    required this.accessedAt,
    required this.durationSeconds,
    required this.lastVerseRead,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['book_id'] = Variable<int>(bookId);
    map['chapter'] = Variable<int>(chapter);
    map['translation_code'] = Variable<String>(translationCode);
    map['accessed_at'] = Variable<DateTime>(accessedAt);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    map['last_verse_read'] = Variable<int>(lastVerseRead);
    return map;
  }

  ReadingHistoryCompanion toCompanion(bool nullToAbsent) {
    return ReadingHistoryCompanion(
      id: Value(id),
      bookId: Value(bookId),
      chapter: Value(chapter),
      translationCode: Value(translationCode),
      accessedAt: Value(accessedAt),
      durationSeconds: Value(durationSeconds),
      lastVerseRead: Value(lastVerseRead),
    );
  }

  factory ReadingHistoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadingHistoryData(
      id: serializer.fromJson<int>(json['id']),
      bookId: serializer.fromJson<int>(json['bookId']),
      chapter: serializer.fromJson<int>(json['chapter']),
      translationCode: serializer.fromJson<String>(json['translationCode']),
      accessedAt: serializer.fromJson<DateTime>(json['accessedAt']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      lastVerseRead: serializer.fromJson<int>(json['lastVerseRead']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bookId': serializer.toJson<int>(bookId),
      'chapter': serializer.toJson<int>(chapter),
      'translationCode': serializer.toJson<String>(translationCode),
      'accessedAt': serializer.toJson<DateTime>(accessedAt),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'lastVerseRead': serializer.toJson<int>(lastVerseRead),
    };
  }

  ReadingHistoryData copyWith({
    int? id,
    int? bookId,
    int? chapter,
    String? translationCode,
    DateTime? accessedAt,
    int? durationSeconds,
    int? lastVerseRead,
  }) => ReadingHistoryData(
    id: id ?? this.id,
    bookId: bookId ?? this.bookId,
    chapter: chapter ?? this.chapter,
    translationCode: translationCode ?? this.translationCode,
    accessedAt: accessedAt ?? this.accessedAt,
    durationSeconds: durationSeconds ?? this.durationSeconds,
    lastVerseRead: lastVerseRead ?? this.lastVerseRead,
  );
  ReadingHistoryData copyWithCompanion(ReadingHistoryCompanion data) {
    return ReadingHistoryData(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      chapter: data.chapter.present ? data.chapter.value : this.chapter,
      translationCode:
          data.translationCode.present
              ? data.translationCode.value
              : this.translationCode,
      accessedAt:
          data.accessedAt.present ? data.accessedAt.value : this.accessedAt,
      durationSeconds:
          data.durationSeconds.present
              ? data.durationSeconds.value
              : this.durationSeconds,
      lastVerseRead:
          data.lastVerseRead.present
              ? data.lastVerseRead.value
              : this.lastVerseRead,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReadingHistoryData(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('translationCode: $translationCode, ')
          ..write('accessedAt: $accessedAt, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('lastVerseRead: $lastVerseRead')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bookId,
    chapter,
    translationCode,
    accessedAt,
    durationSeconds,
    lastVerseRead,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadingHistoryData &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.chapter == this.chapter &&
          other.translationCode == this.translationCode &&
          other.accessedAt == this.accessedAt &&
          other.durationSeconds == this.durationSeconds &&
          other.lastVerseRead == this.lastVerseRead);
}

class ReadingHistoryCompanion extends UpdateCompanion<ReadingHistoryData> {
  final Value<int> id;
  final Value<int> bookId;
  final Value<int> chapter;
  final Value<String> translationCode;
  final Value<DateTime> accessedAt;
  final Value<int> durationSeconds;
  final Value<int> lastVerseRead;
  const ReadingHistoryCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.chapter = const Value.absent(),
    this.translationCode = const Value.absent(),
    this.accessedAt = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.lastVerseRead = const Value.absent(),
  });
  ReadingHistoryCompanion.insert({
    this.id = const Value.absent(),
    required int bookId,
    required int chapter,
    required String translationCode,
    required DateTime accessedAt,
    this.durationSeconds = const Value.absent(),
    this.lastVerseRead = const Value.absent(),
  }) : bookId = Value(bookId),
       chapter = Value(chapter),
       translationCode = Value(translationCode),
       accessedAt = Value(accessedAt);
  static Insertable<ReadingHistoryData> custom({
    Expression<int>? id,
    Expression<int>? bookId,
    Expression<int>? chapter,
    Expression<String>? translationCode,
    Expression<DateTime>? accessedAt,
    Expression<int>? durationSeconds,
    Expression<int>? lastVerseRead,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (chapter != null) 'chapter': chapter,
      if (translationCode != null) 'translation_code': translationCode,
      if (accessedAt != null) 'accessed_at': accessedAt,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (lastVerseRead != null) 'last_verse_read': lastVerseRead,
    });
  }

  ReadingHistoryCompanion copyWith({
    Value<int>? id,
    Value<int>? bookId,
    Value<int>? chapter,
    Value<String>? translationCode,
    Value<DateTime>? accessedAt,
    Value<int>? durationSeconds,
    Value<int>? lastVerseRead,
  }) {
    return ReadingHistoryCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      chapter: chapter ?? this.chapter,
      translationCode: translationCode ?? this.translationCode,
      accessedAt: accessedAt ?? this.accessedAt,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      lastVerseRead: lastVerseRead ?? this.lastVerseRead,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (chapter.present) {
      map['chapter'] = Variable<int>(chapter.value);
    }
    if (translationCode.present) {
      map['translation_code'] = Variable<String>(translationCode.value);
    }
    if (accessedAt.present) {
      map['accessed_at'] = Variable<DateTime>(accessedAt.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (lastVerseRead.present) {
      map['last_verse_read'] = Variable<int>(lastVerseRead.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingHistoryCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('translationCode: $translationCode, ')
          ..write('accessedAt: $accessedAt, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('lastVerseRead: $lastVerseRead')
          ..write(')'))
        .toString();
  }
}

class $ReadingTabsTable extends ReadingTabs
    with TableInfo<$ReadingTabsTable, ReadingTabData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingTabsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _chapterMeta = const VerificationMeta(
    'chapter',
  );
  @override
  late final GeneratedColumn<int> chapter = GeneratedColumn<int>(
    'chapter',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _translationCodeMeta = const VerificationMeta(
    'translationCode',
  );
  @override
  late final GeneratedColumn<String> translationCode = GeneratedColumn<String>(
    'translation_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('KJV'),
  );
  static const VerificationMeta _isParallelViewMeta = const VerificationMeta(
    'isParallelView',
  );
  @override
  late final GeneratedColumn<bool> isParallelView = GeneratedColumn<bool>(
    'is_parallel_view',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_parallel_view" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _parallelTranslationCodeMeta =
      const VerificationMeta('parallelTranslationCode');
  @override
  late final GeneratedColumn<String> parallelTranslationCode =
      GeneratedColumn<String>(
        'parallel_translation_code',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('KOREAN_RV'),
      );
  static const VerificationMeta _scrollVerseMeta = const VerificationMeta(
    'scrollVerse',
  );
  @override
  late final GeneratedColumn<int> scrollVerse = GeneratedColumn<int>(
    'scroll_verse',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _scrollFractionMeta = const VerificationMeta(
    'scrollFraction',
  );
  @override
  late final GeneratedColumn<double> scrollFraction = GeneratedColumn<double>(
    'scroll_fraction',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _scrollOffsetMeta = const VerificationMeta(
    'scrollOffset',
  );
  @override
  late final GeneratedColumn<double> scrollOffset = GeneratedColumn<double>(
    'scroll_offset',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bookId,
    chapter,
    translationCode,
    isParallelView,
    parallelTranslationCode,
    scrollVerse,
    scrollFraction,
    scrollOffset,
    sortOrder,
    isActive,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_tabs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReadingTabData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    }
    if (data.containsKey('chapter')) {
      context.handle(
        _chapterMeta,
        chapter.isAcceptableOrUnknown(data['chapter']!, _chapterMeta),
      );
    }
    if (data.containsKey('translation_code')) {
      context.handle(
        _translationCodeMeta,
        translationCode.isAcceptableOrUnknown(
          data['translation_code']!,
          _translationCodeMeta,
        ),
      );
    }
    if (data.containsKey('is_parallel_view')) {
      context.handle(
        _isParallelViewMeta,
        isParallelView.isAcceptableOrUnknown(
          data['is_parallel_view']!,
          _isParallelViewMeta,
        ),
      );
    }
    if (data.containsKey('parallel_translation_code')) {
      context.handle(
        _parallelTranslationCodeMeta,
        parallelTranslationCode.isAcceptableOrUnknown(
          data['parallel_translation_code']!,
          _parallelTranslationCodeMeta,
        ),
      );
    }
    if (data.containsKey('scroll_verse')) {
      context.handle(
        _scrollVerseMeta,
        scrollVerse.isAcceptableOrUnknown(
          data['scroll_verse']!,
          _scrollVerseMeta,
        ),
      );
    }
    if (data.containsKey('scroll_fraction')) {
      context.handle(
        _scrollFractionMeta,
        scrollFraction.isAcceptableOrUnknown(
          data['scroll_fraction']!,
          _scrollFractionMeta,
        ),
      );
    }
    if (data.containsKey('scroll_offset')) {
      context.handle(
        _scrollOffsetMeta,
        scrollOffset.isAcceptableOrUnknown(
          data['scroll_offset']!,
          _scrollOffsetMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReadingTabData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadingTabData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      bookId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}book_id'],
          )!,
      chapter:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}chapter'],
          )!,
      translationCode:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}translation_code'],
          )!,
      isParallelView:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_parallel_view'],
          )!,
      parallelTranslationCode:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}parallel_translation_code'],
          )!,
      scrollVerse:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}scroll_verse'],
          )!,
      scrollFraction:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}scroll_fraction'],
          )!,
      scrollOffset:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}scroll_offset'],
          )!,
      sortOrder:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}sort_order'],
          )!,
      isActive:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_active'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $ReadingTabsTable createAlias(String alias) {
    return $ReadingTabsTable(attachedDatabase, alias);
  }
}

class ReadingTabData extends DataClass implements Insertable<ReadingTabData> {
  final int id;
  final int bookId;
  final int chapter;
  final String translationCode;
  final bool isParallelView;
  final String parallelTranslationCode;
  final int scrollVerse;
  final double scrollFraction;
  final double scrollOffset;
  final int sortOrder;
  final bool isActive;
  final DateTime updatedAt;
  const ReadingTabData({
    required this.id,
    required this.bookId,
    required this.chapter,
    required this.translationCode,
    required this.isParallelView,
    required this.parallelTranslationCode,
    required this.scrollVerse,
    required this.scrollFraction,
    required this.scrollOffset,
    required this.sortOrder,
    required this.isActive,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['book_id'] = Variable<int>(bookId);
    map['chapter'] = Variable<int>(chapter);
    map['translation_code'] = Variable<String>(translationCode);
    map['is_parallel_view'] = Variable<bool>(isParallelView);
    map['parallel_translation_code'] = Variable<String>(
      parallelTranslationCode,
    );
    map['scroll_verse'] = Variable<int>(scrollVerse);
    map['scroll_fraction'] = Variable<double>(scrollFraction);
    map['scroll_offset'] = Variable<double>(scrollOffset);
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_active'] = Variable<bool>(isActive);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ReadingTabsCompanion toCompanion(bool nullToAbsent) {
    return ReadingTabsCompanion(
      id: Value(id),
      bookId: Value(bookId),
      chapter: Value(chapter),
      translationCode: Value(translationCode),
      isParallelView: Value(isParallelView),
      parallelTranslationCode: Value(parallelTranslationCode),
      scrollVerse: Value(scrollVerse),
      scrollFraction: Value(scrollFraction),
      scrollOffset: Value(scrollOffset),
      sortOrder: Value(sortOrder),
      isActive: Value(isActive),
      updatedAt: Value(updatedAt),
    );
  }

  factory ReadingTabData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadingTabData(
      id: serializer.fromJson<int>(json['id']),
      bookId: serializer.fromJson<int>(json['bookId']),
      chapter: serializer.fromJson<int>(json['chapter']),
      translationCode: serializer.fromJson<String>(json['translationCode']),
      isParallelView: serializer.fromJson<bool>(json['isParallelView']),
      parallelTranslationCode: serializer.fromJson<String>(
        json['parallelTranslationCode'],
      ),
      scrollVerse: serializer.fromJson<int>(json['scrollVerse']),
      scrollFraction: serializer.fromJson<double>(json['scrollFraction']),
      scrollOffset: serializer.fromJson<double>(json['scrollOffset']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bookId': serializer.toJson<int>(bookId),
      'chapter': serializer.toJson<int>(chapter),
      'translationCode': serializer.toJson<String>(translationCode),
      'isParallelView': serializer.toJson<bool>(isParallelView),
      'parallelTranslationCode': serializer.toJson<String>(
        parallelTranslationCode,
      ),
      'scrollVerse': serializer.toJson<int>(scrollVerse),
      'scrollFraction': serializer.toJson<double>(scrollFraction),
      'scrollOffset': serializer.toJson<double>(scrollOffset),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isActive': serializer.toJson<bool>(isActive),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ReadingTabData copyWith({
    int? id,
    int? bookId,
    int? chapter,
    String? translationCode,
    bool? isParallelView,
    String? parallelTranslationCode,
    int? scrollVerse,
    double? scrollFraction,
    double? scrollOffset,
    int? sortOrder,
    bool? isActive,
    DateTime? updatedAt,
  }) => ReadingTabData(
    id: id ?? this.id,
    bookId: bookId ?? this.bookId,
    chapter: chapter ?? this.chapter,
    translationCode: translationCode ?? this.translationCode,
    isParallelView: isParallelView ?? this.isParallelView,
    parallelTranslationCode:
        parallelTranslationCode ?? this.parallelTranslationCode,
    scrollVerse: scrollVerse ?? this.scrollVerse,
    scrollFraction: scrollFraction ?? this.scrollFraction,
    scrollOffset: scrollOffset ?? this.scrollOffset,
    sortOrder: sortOrder ?? this.sortOrder,
    isActive: isActive ?? this.isActive,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ReadingTabData copyWithCompanion(ReadingTabsCompanion data) {
    return ReadingTabData(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      chapter: data.chapter.present ? data.chapter.value : this.chapter,
      translationCode:
          data.translationCode.present
              ? data.translationCode.value
              : this.translationCode,
      isParallelView:
          data.isParallelView.present
              ? data.isParallelView.value
              : this.isParallelView,
      parallelTranslationCode:
          data.parallelTranslationCode.present
              ? data.parallelTranslationCode.value
              : this.parallelTranslationCode,
      scrollVerse:
          data.scrollVerse.present ? data.scrollVerse.value : this.scrollVerse,
      scrollFraction:
          data.scrollFraction.present
              ? data.scrollFraction.value
              : this.scrollFraction,
      scrollOffset:
          data.scrollOffset.present
              ? data.scrollOffset.value
              : this.scrollOffset,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReadingTabData(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('translationCode: $translationCode, ')
          ..write('isParallelView: $isParallelView, ')
          ..write('parallelTranslationCode: $parallelTranslationCode, ')
          ..write('scrollVerse: $scrollVerse, ')
          ..write('scrollFraction: $scrollFraction, ')
          ..write('scrollOffset: $scrollOffset, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bookId,
    chapter,
    translationCode,
    isParallelView,
    parallelTranslationCode,
    scrollVerse,
    scrollFraction,
    scrollOffset,
    sortOrder,
    isActive,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadingTabData &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.chapter == this.chapter &&
          other.translationCode == this.translationCode &&
          other.isParallelView == this.isParallelView &&
          other.parallelTranslationCode == this.parallelTranslationCode &&
          other.scrollVerse == this.scrollVerse &&
          other.scrollFraction == this.scrollFraction &&
          other.scrollOffset == this.scrollOffset &&
          other.sortOrder == this.sortOrder &&
          other.isActive == this.isActive &&
          other.updatedAt == this.updatedAt);
}

class ReadingTabsCompanion extends UpdateCompanion<ReadingTabData> {
  final Value<int> id;
  final Value<int> bookId;
  final Value<int> chapter;
  final Value<String> translationCode;
  final Value<bool> isParallelView;
  final Value<String> parallelTranslationCode;
  final Value<int> scrollVerse;
  final Value<double> scrollFraction;
  final Value<double> scrollOffset;
  final Value<int> sortOrder;
  final Value<bool> isActive;
  final Value<DateTime> updatedAt;
  const ReadingTabsCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.chapter = const Value.absent(),
    this.translationCode = const Value.absent(),
    this.isParallelView = const Value.absent(),
    this.parallelTranslationCode = const Value.absent(),
    this.scrollVerse = const Value.absent(),
    this.scrollFraction = const Value.absent(),
    this.scrollOffset = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ReadingTabsCompanion.insert({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.chapter = const Value.absent(),
    this.translationCode = const Value.absent(),
    this.isParallelView = const Value.absent(),
    this.parallelTranslationCode = const Value.absent(),
    this.scrollVerse = const Value.absent(),
    this.scrollFraction = const Value.absent(),
    this.scrollOffset = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime updatedAt,
  }) : updatedAt = Value(updatedAt);
  static Insertable<ReadingTabData> custom({
    Expression<int>? id,
    Expression<int>? bookId,
    Expression<int>? chapter,
    Expression<String>? translationCode,
    Expression<bool>? isParallelView,
    Expression<String>? parallelTranslationCode,
    Expression<int>? scrollVerse,
    Expression<double>? scrollFraction,
    Expression<double>? scrollOffset,
    Expression<int>? sortOrder,
    Expression<bool>? isActive,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (chapter != null) 'chapter': chapter,
      if (translationCode != null) 'translation_code': translationCode,
      if (isParallelView != null) 'is_parallel_view': isParallelView,
      if (parallelTranslationCode != null)
        'parallel_translation_code': parallelTranslationCode,
      if (scrollVerse != null) 'scroll_verse': scrollVerse,
      if (scrollFraction != null) 'scroll_fraction': scrollFraction,
      if (scrollOffset != null) 'scroll_offset': scrollOffset,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isActive != null) 'is_active': isActive,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ReadingTabsCompanion copyWith({
    Value<int>? id,
    Value<int>? bookId,
    Value<int>? chapter,
    Value<String>? translationCode,
    Value<bool>? isParallelView,
    Value<String>? parallelTranslationCode,
    Value<int>? scrollVerse,
    Value<double>? scrollFraction,
    Value<double>? scrollOffset,
    Value<int>? sortOrder,
    Value<bool>? isActive,
    Value<DateTime>? updatedAt,
  }) {
    return ReadingTabsCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      chapter: chapter ?? this.chapter,
      translationCode: translationCode ?? this.translationCode,
      isParallelView: isParallelView ?? this.isParallelView,
      parallelTranslationCode:
          parallelTranslationCode ?? this.parallelTranslationCode,
      scrollVerse: scrollVerse ?? this.scrollVerse,
      scrollFraction: scrollFraction ?? this.scrollFraction,
      scrollOffset: scrollOffset ?? this.scrollOffset,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (chapter.present) {
      map['chapter'] = Variable<int>(chapter.value);
    }
    if (translationCode.present) {
      map['translation_code'] = Variable<String>(translationCode.value);
    }
    if (isParallelView.present) {
      map['is_parallel_view'] = Variable<bool>(isParallelView.value);
    }
    if (parallelTranslationCode.present) {
      map['parallel_translation_code'] = Variable<String>(
        parallelTranslationCode.value,
      );
    }
    if (scrollVerse.present) {
      map['scroll_verse'] = Variable<int>(scrollVerse.value);
    }
    if (scrollFraction.present) {
      map['scroll_fraction'] = Variable<double>(scrollFraction.value);
    }
    if (scrollOffset.present) {
      map['scroll_offset'] = Variable<double>(scrollOffset.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingTabsCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('translationCode: $translationCode, ')
          ..write('isParallelView: $isParallelView, ')
          ..write('parallelTranslationCode: $parallelTranslationCode, ')
          ..write('scrollVerse: $scrollVerse, ')
          ..write('scrollFraction: $scrollFraction, ')
          ..write('scrollOffset: $scrollOffset, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ReadingPlansTable extends ReadingPlans
    with TableInfo<$ReadingPlansTable, ReadingPlan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingPlansTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetEndDateMeta = const VerificationMeta(
    'targetEndDate',
  );
  @override
  late final GeneratedColumn<DateTime> targetEndDate =
      GeneratedColumn<DateTime>(
        'target_end_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _totalDaysMeta = const VerificationMeta(
    'totalDays',
  );
  @override
  late final GeneratedColumn<int> totalDays = GeneratedColumn<int>(
    'total_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedDaysMeta = const VerificationMeta(
    'completedDays',
  );
  @override
  late final GeneratedColumn<int> completedDays = GeneratedColumn<int>(
    'completed_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    startDate,
    targetEndDate,
    isActive,
    totalDays,
    completedDays,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReadingPlan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('target_end_date')) {
      context.handle(
        _targetEndDateMeta,
        targetEndDate.isAcceptableOrUnknown(
          data['target_end_date']!,
          _targetEndDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetEndDateMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('total_days')) {
      context.handle(
        _totalDaysMeta,
        totalDays.isAcceptableOrUnknown(data['total_days']!, _totalDaysMeta),
      );
    } else if (isInserting) {
      context.missing(_totalDaysMeta);
    }
    if (data.containsKey('completed_days')) {
      context.handle(
        _completedDaysMeta,
        completedDays.isAcceptableOrUnknown(
          data['completed_days']!,
          _completedDaysMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReadingPlan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadingPlan(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
      startDate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}start_date'],
          )!,
      targetEndDate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}target_end_date'],
          )!,
      isActive:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_active'],
          )!,
      totalDays:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}total_days'],
          )!,
      completedDays:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}completed_days'],
          )!,
    );
  }

  @override
  $ReadingPlansTable createAlias(String alias) {
    return $ReadingPlansTable(attachedDatabase, alias);
  }
}

class ReadingPlan extends DataClass implements Insertable<ReadingPlan> {
  final int id;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime targetEndDate;
  final bool isActive;
  final int totalDays;
  final int completedDays;
  const ReadingPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.targetEndDate,
    required this.isActive,
    required this.totalDays,
    required this.completedDays,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['start_date'] = Variable<DateTime>(startDate);
    map['target_end_date'] = Variable<DateTime>(targetEndDate);
    map['is_active'] = Variable<bool>(isActive);
    map['total_days'] = Variable<int>(totalDays);
    map['completed_days'] = Variable<int>(completedDays);
    return map;
  }

  ReadingPlansCompanion toCompanion(bool nullToAbsent) {
    return ReadingPlansCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      startDate: Value(startDate),
      targetEndDate: Value(targetEndDate),
      isActive: Value(isActive),
      totalDays: Value(totalDays),
      completedDays: Value(completedDays),
    );
  }

  factory ReadingPlan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadingPlan(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      targetEndDate: serializer.fromJson<DateTime>(json['targetEndDate']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      totalDays: serializer.fromJson<int>(json['totalDays']),
      completedDays: serializer.fromJson<int>(json['completedDays']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'startDate': serializer.toJson<DateTime>(startDate),
      'targetEndDate': serializer.toJson<DateTime>(targetEndDate),
      'isActive': serializer.toJson<bool>(isActive),
      'totalDays': serializer.toJson<int>(totalDays),
      'completedDays': serializer.toJson<int>(completedDays),
    };
  }

  ReadingPlan copyWith({
    int? id,
    String? name,
    String? description,
    DateTime? startDate,
    DateTime? targetEndDate,
    bool? isActive,
    int? totalDays,
    int? completedDays,
  }) => ReadingPlan(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    startDate: startDate ?? this.startDate,
    targetEndDate: targetEndDate ?? this.targetEndDate,
    isActive: isActive ?? this.isActive,
    totalDays: totalDays ?? this.totalDays,
    completedDays: completedDays ?? this.completedDays,
  );
  ReadingPlan copyWithCompanion(ReadingPlansCompanion data) {
    return ReadingPlan(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      targetEndDate:
          data.targetEndDate.present
              ? data.targetEndDate.value
              : this.targetEndDate,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      totalDays: data.totalDays.present ? data.totalDays.value : this.totalDays,
      completedDays:
          data.completedDays.present
              ? data.completedDays.value
              : this.completedDays,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReadingPlan(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('startDate: $startDate, ')
          ..write('targetEndDate: $targetEndDate, ')
          ..write('isActive: $isActive, ')
          ..write('totalDays: $totalDays, ')
          ..write('completedDays: $completedDays')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    startDate,
    targetEndDate,
    isActive,
    totalDays,
    completedDays,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadingPlan &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.startDate == this.startDate &&
          other.targetEndDate == this.targetEndDate &&
          other.isActive == this.isActive &&
          other.totalDays == this.totalDays &&
          other.completedDays == this.completedDays);
}

class ReadingPlansCompanion extends UpdateCompanion<ReadingPlan> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<DateTime> startDate;
  final Value<DateTime> targetEndDate;
  final Value<bool> isActive;
  final Value<int> totalDays;
  final Value<int> completedDays;
  const ReadingPlansCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.startDate = const Value.absent(),
    this.targetEndDate = const Value.absent(),
    this.isActive = const Value.absent(),
    this.totalDays = const Value.absent(),
    this.completedDays = const Value.absent(),
  });
  ReadingPlansCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required DateTime startDate,
    required DateTime targetEndDate,
    this.isActive = const Value.absent(),
    required int totalDays,
    this.completedDays = const Value.absent(),
  }) : name = Value(name),
       startDate = Value(startDate),
       targetEndDate = Value(targetEndDate),
       totalDays = Value(totalDays);
  static Insertable<ReadingPlan> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? startDate,
    Expression<DateTime>? targetEndDate,
    Expression<bool>? isActive,
    Expression<int>? totalDays,
    Expression<int>? completedDays,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (startDate != null) 'start_date': startDate,
      if (targetEndDate != null) 'target_end_date': targetEndDate,
      if (isActive != null) 'is_active': isActive,
      if (totalDays != null) 'total_days': totalDays,
      if (completedDays != null) 'completed_days': completedDays,
    });
  }

  ReadingPlansCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? description,
    Value<DateTime>? startDate,
    Value<DateTime>? targetEndDate,
    Value<bool>? isActive,
    Value<int>? totalDays,
    Value<int>? completedDays,
  }) {
    return ReadingPlansCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      targetEndDate: targetEndDate ?? this.targetEndDate,
      isActive: isActive ?? this.isActive,
      totalDays: totalDays ?? this.totalDays,
      completedDays: completedDays ?? this.completedDays,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (targetEndDate.present) {
      map['target_end_date'] = Variable<DateTime>(targetEndDate.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (totalDays.present) {
      map['total_days'] = Variable<int>(totalDays.value);
    }
    if (completedDays.present) {
      map['completed_days'] = Variable<int>(completedDays.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingPlansCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('startDate: $startDate, ')
          ..write('targetEndDate: $targetEndDate, ')
          ..write('isActive: $isActive, ')
          ..write('totalDays: $totalDays, ')
          ..write('completedDays: $completedDays')
          ..write(')'))
        .toString();
  }
}

class $ChapterReadingPositionsTable extends ChapterReadingPositions
    with TableInfo<$ChapterReadingPositionsTable, ChapterReadingPositionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChapterReadingPositionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _readingTabIdMeta = const VerificationMeta(
    'readingTabId',
  );
  @override
  late final GeneratedColumn<int> readingTabId = GeneratedColumn<int>(
    'reading_tab_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES reading_tabs (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapterMeta = const VerificationMeta(
    'chapter',
  );
  @override
  late final GeneratedColumn<int> chapter = GeneratedColumn<int>(
    'chapter',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scrollVerseMeta = const VerificationMeta(
    'scrollVerse',
  );
  @override
  late final GeneratedColumn<int> scrollVerse = GeneratedColumn<int>(
    'scroll_verse',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _scrollFractionMeta = const VerificationMeta(
    'scrollFraction',
  );
  @override
  late final GeneratedColumn<double> scrollFraction = GeneratedColumn<double>(
    'scroll_fraction',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _scrollOffsetMeta = const VerificationMeta(
    'scrollOffset',
  );
  @override
  late final GeneratedColumn<double> scrollOffset = GeneratedColumn<double>(
    'scroll_offset',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    readingTabId,
    bookId,
    chapter,
    scrollVerse,
    scrollFraction,
    scrollOffset,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chapter_reading_positions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChapterReadingPositionData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('reading_tab_id')) {
      context.handle(
        _readingTabIdMeta,
        readingTabId.isAcceptableOrUnknown(
          data['reading_tab_id']!,
          _readingTabIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_readingTabIdMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('chapter')) {
      context.handle(
        _chapterMeta,
        chapter.isAcceptableOrUnknown(data['chapter']!, _chapterMeta),
      );
    } else if (isInserting) {
      context.missing(_chapterMeta);
    }
    if (data.containsKey('scroll_verse')) {
      context.handle(
        _scrollVerseMeta,
        scrollVerse.isAcceptableOrUnknown(
          data['scroll_verse']!,
          _scrollVerseMeta,
        ),
      );
    }
    if (data.containsKey('scroll_fraction')) {
      context.handle(
        _scrollFractionMeta,
        scrollFraction.isAcceptableOrUnknown(
          data['scroll_fraction']!,
          _scrollFractionMeta,
        ),
      );
    }
    if (data.containsKey('scroll_offset')) {
      context.handle(
        _scrollOffsetMeta,
        scrollOffset.isAcceptableOrUnknown(
          data['scroll_offset']!,
          _scrollOffsetMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {readingTabId, bookId, chapter};
  @override
  ChapterReadingPositionData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChapterReadingPositionData(
      readingTabId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}reading_tab_id'],
          )!,
      bookId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}book_id'],
          )!,
      chapter:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}chapter'],
          )!,
      scrollVerse:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}scroll_verse'],
          )!,
      scrollFraction:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}scroll_fraction'],
          )!,
      scrollOffset:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}scroll_offset'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $ChapterReadingPositionsTable createAlias(String alias) {
    return $ChapterReadingPositionsTable(attachedDatabase, alias);
  }
}

class ChapterReadingPositionData extends DataClass
    implements Insertable<ChapterReadingPositionData> {
  final int readingTabId;
  final int bookId;
  final int chapter;
  final int scrollVerse;
  final double scrollFraction;
  final double scrollOffset;
  final DateTime updatedAt;
  const ChapterReadingPositionData({
    required this.readingTabId,
    required this.bookId,
    required this.chapter,
    required this.scrollVerse,
    required this.scrollFraction,
    required this.scrollOffset,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['reading_tab_id'] = Variable<int>(readingTabId);
    map['book_id'] = Variable<int>(bookId);
    map['chapter'] = Variable<int>(chapter);
    map['scroll_verse'] = Variable<int>(scrollVerse);
    map['scroll_fraction'] = Variable<double>(scrollFraction);
    map['scroll_offset'] = Variable<double>(scrollOffset);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ChapterReadingPositionsCompanion toCompanion(bool nullToAbsent) {
    return ChapterReadingPositionsCompanion(
      readingTabId: Value(readingTabId),
      bookId: Value(bookId),
      chapter: Value(chapter),
      scrollVerse: Value(scrollVerse),
      scrollFraction: Value(scrollFraction),
      scrollOffset: Value(scrollOffset),
      updatedAt: Value(updatedAt),
    );
  }

  factory ChapterReadingPositionData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChapterReadingPositionData(
      readingTabId: serializer.fromJson<int>(json['readingTabId']),
      bookId: serializer.fromJson<int>(json['bookId']),
      chapter: serializer.fromJson<int>(json['chapter']),
      scrollVerse: serializer.fromJson<int>(json['scrollVerse']),
      scrollFraction: serializer.fromJson<double>(json['scrollFraction']),
      scrollOffset: serializer.fromJson<double>(json['scrollOffset']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'readingTabId': serializer.toJson<int>(readingTabId),
      'bookId': serializer.toJson<int>(bookId),
      'chapter': serializer.toJson<int>(chapter),
      'scrollVerse': serializer.toJson<int>(scrollVerse),
      'scrollFraction': serializer.toJson<double>(scrollFraction),
      'scrollOffset': serializer.toJson<double>(scrollOffset),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ChapterReadingPositionData copyWith({
    int? readingTabId,
    int? bookId,
    int? chapter,
    int? scrollVerse,
    double? scrollFraction,
    double? scrollOffset,
    DateTime? updatedAt,
  }) => ChapterReadingPositionData(
    readingTabId: readingTabId ?? this.readingTabId,
    bookId: bookId ?? this.bookId,
    chapter: chapter ?? this.chapter,
    scrollVerse: scrollVerse ?? this.scrollVerse,
    scrollFraction: scrollFraction ?? this.scrollFraction,
    scrollOffset: scrollOffset ?? this.scrollOffset,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ChapterReadingPositionData copyWithCompanion(
    ChapterReadingPositionsCompanion data,
  ) {
    return ChapterReadingPositionData(
      readingTabId:
          data.readingTabId.present
              ? data.readingTabId.value
              : this.readingTabId,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      chapter: data.chapter.present ? data.chapter.value : this.chapter,
      scrollVerse:
          data.scrollVerse.present ? data.scrollVerse.value : this.scrollVerse,
      scrollFraction:
          data.scrollFraction.present
              ? data.scrollFraction.value
              : this.scrollFraction,
      scrollOffset:
          data.scrollOffset.present
              ? data.scrollOffset.value
              : this.scrollOffset,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChapterReadingPositionData(')
          ..write('readingTabId: $readingTabId, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('scrollVerse: $scrollVerse, ')
          ..write('scrollFraction: $scrollFraction, ')
          ..write('scrollOffset: $scrollOffset, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    readingTabId,
    bookId,
    chapter,
    scrollVerse,
    scrollFraction,
    scrollOffset,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChapterReadingPositionData &&
          other.readingTabId == this.readingTabId &&
          other.bookId == this.bookId &&
          other.chapter == this.chapter &&
          other.scrollVerse == this.scrollVerse &&
          other.scrollFraction == this.scrollFraction &&
          other.scrollOffset == this.scrollOffset &&
          other.updatedAt == this.updatedAt);
}

class ChapterReadingPositionsCompanion
    extends UpdateCompanion<ChapterReadingPositionData> {
  final Value<int> readingTabId;
  final Value<int> bookId;
  final Value<int> chapter;
  final Value<int> scrollVerse;
  final Value<double> scrollFraction;
  final Value<double> scrollOffset;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ChapterReadingPositionsCompanion({
    this.readingTabId = const Value.absent(),
    this.bookId = const Value.absent(),
    this.chapter = const Value.absent(),
    this.scrollVerse = const Value.absent(),
    this.scrollFraction = const Value.absent(),
    this.scrollOffset = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChapterReadingPositionsCompanion.insert({
    required int readingTabId,
    required int bookId,
    required int chapter,
    this.scrollVerse = const Value.absent(),
    this.scrollFraction = const Value.absent(),
    this.scrollOffset = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : readingTabId = Value(readingTabId),
       bookId = Value(bookId),
       chapter = Value(chapter),
       updatedAt = Value(updatedAt);
  static Insertable<ChapterReadingPositionData> custom({
    Expression<int>? readingTabId,
    Expression<int>? bookId,
    Expression<int>? chapter,
    Expression<int>? scrollVerse,
    Expression<double>? scrollFraction,
    Expression<double>? scrollOffset,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (readingTabId != null) 'reading_tab_id': readingTabId,
      if (bookId != null) 'book_id': bookId,
      if (chapter != null) 'chapter': chapter,
      if (scrollVerse != null) 'scroll_verse': scrollVerse,
      if (scrollFraction != null) 'scroll_fraction': scrollFraction,
      if (scrollOffset != null) 'scroll_offset': scrollOffset,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChapterReadingPositionsCompanion copyWith({
    Value<int>? readingTabId,
    Value<int>? bookId,
    Value<int>? chapter,
    Value<int>? scrollVerse,
    Value<double>? scrollFraction,
    Value<double>? scrollOffset,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ChapterReadingPositionsCompanion(
      readingTabId: readingTabId ?? this.readingTabId,
      bookId: bookId ?? this.bookId,
      chapter: chapter ?? this.chapter,
      scrollVerse: scrollVerse ?? this.scrollVerse,
      scrollFraction: scrollFraction ?? this.scrollFraction,
      scrollOffset: scrollOffset ?? this.scrollOffset,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (readingTabId.present) {
      map['reading_tab_id'] = Variable<int>(readingTabId.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (chapter.present) {
      map['chapter'] = Variable<int>(chapter.value);
    }
    if (scrollVerse.present) {
      map['scroll_verse'] = Variable<int>(scrollVerse.value);
    }
    if (scrollFraction.present) {
      map['scroll_fraction'] = Variable<double>(scrollFraction.value);
    }
    if (scrollOffset.present) {
      map['scroll_offset'] = Variable<double>(scrollOffset.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChapterReadingPositionsCompanion(')
          ..write('readingTabId: $readingTabId, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('scrollVerse: $scrollVerse, ')
          ..write('scrollFraction: $scrollFraction, ')
          ..write('scrollOffset: $scrollOffset, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BibleBooksTable bibleBooks = $BibleBooksTable(this);
  late final $BibleTranslationsTable bibleTranslations =
      $BibleTranslationsTable(this);
  late final $VerseTranslationsTable verseTranslations =
      $VerseTranslationsTable(this);
  late final $CrossReferencesTable crossReferences = $CrossReferencesTable(
    this,
  );
  late final $DictionaryEntriesTable dictionaryEntries =
      $DictionaryEntriesTable(this);
  late final $WordSensesTable wordSenses = $WordSensesTable(this);
  late final $WordExamplesTable wordExamples = $WordExamplesTable(this);
  late final $WordFormsTable wordForms = $WordFormsTable(this);
  late final $WordnetSynsetsTable wordnetSynsets = $WordnetSynsetsTable(this);
  late final $WordnetLemmasTable wordnetLemmas = $WordnetLemmasTable(this);
  late final $WordnetRelationsTable wordnetRelations = $WordnetRelationsTable(
    this,
  );
  late final $StrongEntriesTable strongEntries = $StrongEntriesTable(this);
  late final $VerseStrongMappingsTable verseStrongMappings =
      $VerseStrongMappingsTable(this);
  late final $GrammarRulesTable grammarRules = $GrammarRulesTable(this);
  late final $PosLookupTable posLookup = $PosLookupTable(this);
  late final $BookmarksTable bookmarks = $BookmarksTable(this);
  late final $MemosTable memos = $MemosTable(this);
  late final $HighlightsTable highlights = $HighlightsTable(this);
  late final $VocabularyItemsTable vocabularyItems = $VocabularyItemsTable(
    this,
  );
  late final $ReviewSessionsTable reviewSessions = $ReviewSessionsTable(this);
  late final $ReviewAnswersTable reviewAnswers = $ReviewAnswersTable(this);
  late final $ReadingHistoryTable readingHistory = $ReadingHistoryTable(this);
  late final $ReadingTabsTable readingTabs = $ReadingTabsTable(this);
  late final $ReadingPlansTable readingPlans = $ReadingPlansTable(this);
  late final $ChapterReadingPositionsTable chapterReadingPositions =
      $ChapterReadingPositionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    bibleBooks,
    bibleTranslations,
    verseTranslations,
    crossReferences,
    dictionaryEntries,
    wordSenses,
    wordExamples,
    wordForms,
    wordnetSynsets,
    wordnetLemmas,
    wordnetRelations,
    strongEntries,
    verseStrongMappings,
    grammarRules,
    posLookup,
    bookmarks,
    memos,
    highlights,
    vocabularyItems,
    reviewSessions,
    reviewAnswers,
    readingHistory,
    readingTabs,
    readingPlans,
    chapterReadingPositions,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'reading_tabs',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('chapter_reading_positions', kind: UpdateKind.delete),
      ],
    ),
  ]);
}

typedef $$BibleBooksTableCreateCompanionBuilder =
    BibleBooksCompanion Function({
      Value<int> id,
      required String name,
      required String nameKorean,
      required String abbreviation,
      required String abbreviationKorean,
      required String testament,
      required int orderIndex,
      required int chapterCount,
    });
typedef $$BibleBooksTableUpdateCompanionBuilder =
    BibleBooksCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> nameKorean,
      Value<String> abbreviation,
      Value<String> abbreviationKorean,
      Value<String> testament,
      Value<int> orderIndex,
      Value<int> chapterCount,
    });

class $$BibleBooksTableFilterComposer
    extends Composer<_$AppDatabase, $BibleBooksTable> {
  $$BibleBooksTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameKorean => $composableBuilder(
    column: $table.nameKorean,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get abbreviation => $composableBuilder(
    column: $table.abbreviation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get abbreviationKorean => $composableBuilder(
    column: $table.abbreviationKorean,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get testament => $composableBuilder(
    column: $table.testament,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapterCount => $composableBuilder(
    column: $table.chapterCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BibleBooksTableOrderingComposer
    extends Composer<_$AppDatabase, $BibleBooksTable> {
  $$BibleBooksTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameKorean => $composableBuilder(
    column: $table.nameKorean,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get abbreviation => $composableBuilder(
    column: $table.abbreviation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get abbreviationKorean => $composableBuilder(
    column: $table.abbreviationKorean,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get testament => $composableBuilder(
    column: $table.testament,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapterCount => $composableBuilder(
    column: $table.chapterCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BibleBooksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BibleBooksTable> {
  $$BibleBooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get nameKorean => $composableBuilder(
    column: $table.nameKorean,
    builder: (column) => column,
  );

  GeneratedColumn<String> get abbreviation => $composableBuilder(
    column: $table.abbreviation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get abbreviationKorean => $composableBuilder(
    column: $table.abbreviationKorean,
    builder: (column) => column,
  );

  GeneratedColumn<String> get testament =>
      $composableBuilder(column: $table.testament, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get chapterCount => $composableBuilder(
    column: $table.chapterCount,
    builder: (column) => column,
  );
}

class $$BibleBooksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BibleBooksTable,
          BibleBook,
          $$BibleBooksTableFilterComposer,
          $$BibleBooksTableOrderingComposer,
          $$BibleBooksTableAnnotationComposer,
          $$BibleBooksTableCreateCompanionBuilder,
          $$BibleBooksTableUpdateCompanionBuilder,
          (
            BibleBook,
            BaseReferences<_$AppDatabase, $BibleBooksTable, BibleBook>,
          ),
          BibleBook,
          PrefetchHooks Function()
        > {
  $$BibleBooksTableTableManager(_$AppDatabase db, $BibleBooksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$BibleBooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$BibleBooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$BibleBooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> nameKorean = const Value.absent(),
                Value<String> abbreviation = const Value.absent(),
                Value<String> abbreviationKorean = const Value.absent(),
                Value<String> testament = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<int> chapterCount = const Value.absent(),
              }) => BibleBooksCompanion(
                id: id,
                name: name,
                nameKorean: nameKorean,
                abbreviation: abbreviation,
                abbreviationKorean: abbreviationKorean,
                testament: testament,
                orderIndex: orderIndex,
                chapterCount: chapterCount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String nameKorean,
                required String abbreviation,
                required String abbreviationKorean,
                required String testament,
                required int orderIndex,
                required int chapterCount,
              }) => BibleBooksCompanion.insert(
                id: id,
                name: name,
                nameKorean: nameKorean,
                abbreviation: abbreviation,
                abbreviationKorean: abbreviationKorean,
                testament: testament,
                orderIndex: orderIndex,
                chapterCount: chapterCount,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BibleBooksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BibleBooksTable,
      BibleBook,
      $$BibleBooksTableFilterComposer,
      $$BibleBooksTableOrderingComposer,
      $$BibleBooksTableAnnotationComposer,
      $$BibleBooksTableCreateCompanionBuilder,
      $$BibleBooksTableUpdateCompanionBuilder,
      (BibleBook, BaseReferences<_$AppDatabase, $BibleBooksTable, BibleBook>),
      BibleBook,
      PrefetchHooks Function()
    >;
typedef $$BibleTranslationsTableCreateCompanionBuilder =
    BibleTranslationsCompanion Function({
      required String code,
      required String name,
      required String language,
      required String copyright,
      Value<int> totalVerses,
      Value<int> rowid,
    });
typedef $$BibleTranslationsTableUpdateCompanionBuilder =
    BibleTranslationsCompanion Function({
      Value<String> code,
      Value<String> name,
      Value<String> language,
      Value<String> copyright,
      Value<int> totalVerses,
      Value<int> rowid,
    });

class $$BibleTranslationsTableFilterComposer
    extends Composer<_$AppDatabase, $BibleTranslationsTable> {
  $$BibleTranslationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get copyright => $composableBuilder(
    column: $table.copyright,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalVerses => $composableBuilder(
    column: $table.totalVerses,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BibleTranslationsTableOrderingComposer
    extends Composer<_$AppDatabase, $BibleTranslationsTable> {
  $$BibleTranslationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get copyright => $composableBuilder(
    column: $table.copyright,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalVerses => $composableBuilder(
    column: $table.totalVerses,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BibleTranslationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BibleTranslationsTable> {
  $$BibleTranslationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get copyright =>
      $composableBuilder(column: $table.copyright, builder: (column) => column);

  GeneratedColumn<int> get totalVerses => $composableBuilder(
    column: $table.totalVerses,
    builder: (column) => column,
  );
}

class $$BibleTranslationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BibleTranslationsTable,
          BibleTranslation,
          $$BibleTranslationsTableFilterComposer,
          $$BibleTranslationsTableOrderingComposer,
          $$BibleTranslationsTableAnnotationComposer,
          $$BibleTranslationsTableCreateCompanionBuilder,
          $$BibleTranslationsTableUpdateCompanionBuilder,
          (
            BibleTranslation,
            BaseReferences<
              _$AppDatabase,
              $BibleTranslationsTable,
              BibleTranslation
            >,
          ),
          BibleTranslation,
          PrefetchHooks Function()
        > {
  $$BibleTranslationsTableTableManager(
    _$AppDatabase db,
    $BibleTranslationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$BibleTranslationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$BibleTranslationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$BibleTranslationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<String> copyright = const Value.absent(),
                Value<int> totalVerses = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BibleTranslationsCompanion(
                code: code,
                name: name,
                language: language,
                copyright: copyright,
                totalVerses: totalVerses,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String code,
                required String name,
                required String language,
                required String copyright,
                Value<int> totalVerses = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BibleTranslationsCompanion.insert(
                code: code,
                name: name,
                language: language,
                copyright: copyright,
                totalVerses: totalVerses,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BibleTranslationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BibleTranslationsTable,
      BibleTranslation,
      $$BibleTranslationsTableFilterComposer,
      $$BibleTranslationsTableOrderingComposer,
      $$BibleTranslationsTableAnnotationComposer,
      $$BibleTranslationsTableCreateCompanionBuilder,
      $$BibleTranslationsTableUpdateCompanionBuilder,
      (
        BibleTranslation,
        BaseReferences<
          _$AppDatabase,
          $BibleTranslationsTable,
          BibleTranslation
        >,
      ),
      BibleTranslation,
      PrefetchHooks Function()
    >;
typedef $$VerseTranslationsTableCreateCompanionBuilder =
    VerseTranslationsCompanion Function({
      Value<int> id,
      required String translationCode,
      required int bookId,
      required int chapter,
      required int verse,
      required String textContent,
      Value<String?> strongRefs,
    });
typedef $$VerseTranslationsTableUpdateCompanionBuilder =
    VerseTranslationsCompanion Function({
      Value<int> id,
      Value<String> translationCode,
      Value<int> bookId,
      Value<int> chapter,
      Value<int> verse,
      Value<String> textContent,
      Value<String?> strongRefs,
    });

class $$VerseTranslationsTableFilterComposer
    extends Composer<_$AppDatabase, $VerseTranslationsTable> {
  $$VerseTranslationsTableFilterComposer({
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

  ColumnFilters<String> get translationCode => $composableBuilder(
    column: $table.translationCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get verse => $composableBuilder(
    column: $table.verse,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get strongRefs => $composableBuilder(
    column: $table.strongRefs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VerseTranslationsTableOrderingComposer
    extends Composer<_$AppDatabase, $VerseTranslationsTable> {
  $$VerseTranslationsTableOrderingComposer({
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

  ColumnOrderings<String> get translationCode => $composableBuilder(
    column: $table.translationCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get verse => $composableBuilder(
    column: $table.verse,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get strongRefs => $composableBuilder(
    column: $table.strongRefs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VerseTranslationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VerseTranslationsTable> {
  $$VerseTranslationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get translationCode => $composableBuilder(
    column: $table.translationCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bookId =>
      $composableBuilder(column: $table.bookId, builder: (column) => column);

  GeneratedColumn<int> get chapter =>
      $composableBuilder(column: $table.chapter, builder: (column) => column);

  GeneratedColumn<int> get verse =>
      $composableBuilder(column: $table.verse, builder: (column) => column);

  GeneratedColumn<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get strongRefs => $composableBuilder(
    column: $table.strongRefs,
    builder: (column) => column,
  );
}

class $$VerseTranslationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VerseTranslationsTable,
          VerseTranslation,
          $$VerseTranslationsTableFilterComposer,
          $$VerseTranslationsTableOrderingComposer,
          $$VerseTranslationsTableAnnotationComposer,
          $$VerseTranslationsTableCreateCompanionBuilder,
          $$VerseTranslationsTableUpdateCompanionBuilder,
          (
            VerseTranslation,
            BaseReferences<
              _$AppDatabase,
              $VerseTranslationsTable,
              VerseTranslation
            >,
          ),
          VerseTranslation,
          PrefetchHooks Function()
        > {
  $$VerseTranslationsTableTableManager(
    _$AppDatabase db,
    $VerseTranslationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$VerseTranslationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$VerseTranslationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$VerseTranslationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> translationCode = const Value.absent(),
                Value<int> bookId = const Value.absent(),
                Value<int> chapter = const Value.absent(),
                Value<int> verse = const Value.absent(),
                Value<String> textContent = const Value.absent(),
                Value<String?> strongRefs = const Value.absent(),
              }) => VerseTranslationsCompanion(
                id: id,
                translationCode: translationCode,
                bookId: bookId,
                chapter: chapter,
                verse: verse,
                textContent: textContent,
                strongRefs: strongRefs,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String translationCode,
                required int bookId,
                required int chapter,
                required int verse,
                required String textContent,
                Value<String?> strongRefs = const Value.absent(),
              }) => VerseTranslationsCompanion.insert(
                id: id,
                translationCode: translationCode,
                bookId: bookId,
                chapter: chapter,
                verse: verse,
                textContent: textContent,
                strongRefs: strongRefs,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VerseTranslationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VerseTranslationsTable,
      VerseTranslation,
      $$VerseTranslationsTableFilterComposer,
      $$VerseTranslationsTableOrderingComposer,
      $$VerseTranslationsTableAnnotationComposer,
      $$VerseTranslationsTableCreateCompanionBuilder,
      $$VerseTranslationsTableUpdateCompanionBuilder,
      (
        VerseTranslation,
        BaseReferences<
          _$AppDatabase,
          $VerseTranslationsTable,
          VerseTranslation
        >,
      ),
      VerseTranslation,
      PrefetchHooks Function()
    >;
typedef $$CrossReferencesTableCreateCompanionBuilder =
    CrossReferencesCompanion Function({
      Value<int> id,
      required int fromBookId,
      required int fromChapter,
      required int fromVerse,
      required int toBookId,
      required int toChapter,
      required int toVerse,
      Value<int?> toVerseEnd,
      Value<double> rank,
    });
typedef $$CrossReferencesTableUpdateCompanionBuilder =
    CrossReferencesCompanion Function({
      Value<int> id,
      Value<int> fromBookId,
      Value<int> fromChapter,
      Value<int> fromVerse,
      Value<int> toBookId,
      Value<int> toChapter,
      Value<int> toVerse,
      Value<int?> toVerseEnd,
      Value<double> rank,
    });

class $$CrossReferencesTableFilterComposer
    extends Composer<_$AppDatabase, $CrossReferencesTable> {
  $$CrossReferencesTableFilterComposer({
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

  ColumnFilters<int> get fromBookId => $composableBuilder(
    column: $table.fromBookId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fromChapter => $composableBuilder(
    column: $table.fromChapter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fromVerse => $composableBuilder(
    column: $table.fromVerse,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get toBookId => $composableBuilder(
    column: $table.toBookId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get toChapter => $composableBuilder(
    column: $table.toChapter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get toVerse => $composableBuilder(
    column: $table.toVerse,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get toVerseEnd => $composableBuilder(
    column: $table.toVerseEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rank => $composableBuilder(
    column: $table.rank,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CrossReferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $CrossReferencesTable> {
  $$CrossReferencesTableOrderingComposer({
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

  ColumnOrderings<int> get fromBookId => $composableBuilder(
    column: $table.fromBookId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fromChapter => $composableBuilder(
    column: $table.fromChapter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fromVerse => $composableBuilder(
    column: $table.fromVerse,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get toBookId => $composableBuilder(
    column: $table.toBookId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get toChapter => $composableBuilder(
    column: $table.toChapter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get toVerse => $composableBuilder(
    column: $table.toVerse,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get toVerseEnd => $composableBuilder(
    column: $table.toVerseEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rank => $composableBuilder(
    column: $table.rank,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CrossReferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CrossReferencesTable> {
  $$CrossReferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get fromBookId => $composableBuilder(
    column: $table.fromBookId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fromChapter => $composableBuilder(
    column: $table.fromChapter,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fromVerse =>
      $composableBuilder(column: $table.fromVerse, builder: (column) => column);

  GeneratedColumn<int> get toBookId =>
      $composableBuilder(column: $table.toBookId, builder: (column) => column);

  GeneratedColumn<int> get toChapter =>
      $composableBuilder(column: $table.toChapter, builder: (column) => column);

  GeneratedColumn<int> get toVerse =>
      $composableBuilder(column: $table.toVerse, builder: (column) => column);

  GeneratedColumn<int> get toVerseEnd => $composableBuilder(
    column: $table.toVerseEnd,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rank =>
      $composableBuilder(column: $table.rank, builder: (column) => column);
}

class $$CrossReferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CrossReferencesTable,
          CrossReference,
          $$CrossReferencesTableFilterComposer,
          $$CrossReferencesTableOrderingComposer,
          $$CrossReferencesTableAnnotationComposer,
          $$CrossReferencesTableCreateCompanionBuilder,
          $$CrossReferencesTableUpdateCompanionBuilder,
          (
            CrossReference,
            BaseReferences<
              _$AppDatabase,
              $CrossReferencesTable,
              CrossReference
            >,
          ),
          CrossReference,
          PrefetchHooks Function()
        > {
  $$CrossReferencesTableTableManager(
    _$AppDatabase db,
    $CrossReferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$CrossReferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$CrossReferencesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$CrossReferencesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> fromBookId = const Value.absent(),
                Value<int> fromChapter = const Value.absent(),
                Value<int> fromVerse = const Value.absent(),
                Value<int> toBookId = const Value.absent(),
                Value<int> toChapter = const Value.absent(),
                Value<int> toVerse = const Value.absent(),
                Value<int?> toVerseEnd = const Value.absent(),
                Value<double> rank = const Value.absent(),
              }) => CrossReferencesCompanion(
                id: id,
                fromBookId: fromBookId,
                fromChapter: fromChapter,
                fromVerse: fromVerse,
                toBookId: toBookId,
                toChapter: toChapter,
                toVerse: toVerse,
                toVerseEnd: toVerseEnd,
                rank: rank,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int fromBookId,
                required int fromChapter,
                required int fromVerse,
                required int toBookId,
                required int toChapter,
                required int toVerse,
                Value<int?> toVerseEnd = const Value.absent(),
                Value<double> rank = const Value.absent(),
              }) => CrossReferencesCompanion.insert(
                id: id,
                fromBookId: fromBookId,
                fromChapter: fromChapter,
                fromVerse: fromVerse,
                toBookId: toBookId,
                toChapter: toChapter,
                toVerse: toVerse,
                toVerseEnd: toVerseEnd,
                rank: rank,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CrossReferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CrossReferencesTable,
      CrossReference,
      $$CrossReferencesTableFilterComposer,
      $$CrossReferencesTableOrderingComposer,
      $$CrossReferencesTableAnnotationComposer,
      $$CrossReferencesTableCreateCompanionBuilder,
      $$CrossReferencesTableUpdateCompanionBuilder,
      (
        CrossReference,
        BaseReferences<_$AppDatabase, $CrossReferencesTable, CrossReference>,
      ),
      CrossReference,
      PrefetchHooks Function()
    >;
typedef $$DictionaryEntriesTableCreateCompanionBuilder =
    DictionaryEntriesCompanion Function({
      Value<int> id,
      required String word,
      required String wordNormalized,
      Value<String> ipaUs,
      Value<String> ipaUk,
      Value<int> frequencyRank,
      Value<int> bibleFrequency,
      Value<String> etymology,
      Value<String> koreanMeaning,
      Value<String> synonymsJson,
      Value<String> antonymsJson,
      Value<String> relatedWordsJson,
    });
typedef $$DictionaryEntriesTableUpdateCompanionBuilder =
    DictionaryEntriesCompanion Function({
      Value<int> id,
      Value<String> word,
      Value<String> wordNormalized,
      Value<String> ipaUs,
      Value<String> ipaUk,
      Value<int> frequencyRank,
      Value<int> bibleFrequency,
      Value<String> etymology,
      Value<String> koreanMeaning,
      Value<String> synonymsJson,
      Value<String> antonymsJson,
      Value<String> relatedWordsJson,
    });

final class $$DictionaryEntriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $DictionaryEntriesTable,
          DictionaryEntryData
        > {
  $$DictionaryEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$WordSensesTable, List<WordSenseData>>
  _wordSensesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.wordSenses,
    aliasName: $_aliasNameGenerator(
      db.dictionaryEntries.id,
      db.wordSenses.entryId,
    ),
  );

  $$WordSensesTableProcessedTableManager get wordSensesRefs {
    final manager = $$WordSensesTableTableManager(
      $_db,
      $_db.wordSenses,
    ).filter((f) => f.entryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_wordSensesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WordFormsTable, List<WordFormData>>
  _wordFormsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.wordForms,
    aliasName: $_aliasNameGenerator(
      db.dictionaryEntries.id,
      db.wordForms.entryId,
    ),
  );

  $$WordFormsTableProcessedTableManager get wordFormsRefs {
    final manager = $$WordFormsTableTableManager(
      $_db,
      $_db.wordForms,
    ).filter((f) => f.entryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_wordFormsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WordnetLemmasTable, List<WordnetLemmaData>>
  _wordnetLemmasRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.wordnetLemmas,
    aliasName: $_aliasNameGenerator(
      db.dictionaryEntries.id,
      db.wordnetLemmas.entryId,
    ),
  );

  $$WordnetLemmasTableProcessedTableManager get wordnetLemmasRefs {
    final manager = $$WordnetLemmasTableTableManager(
      $_db,
      $_db.wordnetLemmas,
    ).filter((f) => f.entryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_wordnetLemmasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DictionaryEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $DictionaryEntriesTable> {
  $$DictionaryEntriesTableFilterComposer({
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

  ColumnFilters<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wordNormalized => $composableBuilder(
    column: $table.wordNormalized,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ipaUs => $composableBuilder(
    column: $table.ipaUs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ipaUk => $composableBuilder(
    column: $table.ipaUk,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get frequencyRank => $composableBuilder(
    column: $table.frequencyRank,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bibleFrequency => $composableBuilder(
    column: $table.bibleFrequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get etymology => $composableBuilder(
    column: $table.etymology,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get koreanMeaning => $composableBuilder(
    column: $table.koreanMeaning,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get synonymsJson => $composableBuilder(
    column: $table.synonymsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get antonymsJson => $composableBuilder(
    column: $table.antonymsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relatedWordsJson => $composableBuilder(
    column: $table.relatedWordsJson,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> wordSensesRefs(
    Expression<bool> Function($$WordSensesTableFilterComposer f) f,
  ) {
    final $$WordSensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordSenses,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordSensesTableFilterComposer(
            $db: $db,
            $table: $db.wordSenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> wordFormsRefs(
    Expression<bool> Function($$WordFormsTableFilterComposer f) f,
  ) {
    final $$WordFormsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordForms,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordFormsTableFilterComposer(
            $db: $db,
            $table: $db.wordForms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> wordnetLemmasRefs(
    Expression<bool> Function($$WordnetLemmasTableFilterComposer f) f,
  ) {
    final $$WordnetLemmasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordnetLemmas,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordnetLemmasTableFilterComposer(
            $db: $db,
            $table: $db.wordnetLemmas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DictionaryEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $DictionaryEntriesTable> {
  $$DictionaryEntriesTableOrderingComposer({
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

  ColumnOrderings<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wordNormalized => $composableBuilder(
    column: $table.wordNormalized,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ipaUs => $composableBuilder(
    column: $table.ipaUs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ipaUk => $composableBuilder(
    column: $table.ipaUk,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get frequencyRank => $composableBuilder(
    column: $table.frequencyRank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bibleFrequency => $composableBuilder(
    column: $table.bibleFrequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get etymology => $composableBuilder(
    column: $table.etymology,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get koreanMeaning => $composableBuilder(
    column: $table.koreanMeaning,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get synonymsJson => $composableBuilder(
    column: $table.synonymsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get antonymsJson => $composableBuilder(
    column: $table.antonymsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relatedWordsJson => $composableBuilder(
    column: $table.relatedWordsJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DictionaryEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DictionaryEntriesTable> {
  $$DictionaryEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<String> get wordNormalized => $composableBuilder(
    column: $table.wordNormalized,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ipaUs =>
      $composableBuilder(column: $table.ipaUs, builder: (column) => column);

  GeneratedColumn<String> get ipaUk =>
      $composableBuilder(column: $table.ipaUk, builder: (column) => column);

  GeneratedColumn<int> get frequencyRank => $composableBuilder(
    column: $table.frequencyRank,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bibleFrequency => $composableBuilder(
    column: $table.bibleFrequency,
    builder: (column) => column,
  );

  GeneratedColumn<String> get etymology =>
      $composableBuilder(column: $table.etymology, builder: (column) => column);

  GeneratedColumn<String> get koreanMeaning => $composableBuilder(
    column: $table.koreanMeaning,
    builder: (column) => column,
  );

  GeneratedColumn<String> get synonymsJson => $composableBuilder(
    column: $table.synonymsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get antonymsJson => $composableBuilder(
    column: $table.antonymsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get relatedWordsJson => $composableBuilder(
    column: $table.relatedWordsJson,
    builder: (column) => column,
  );

  Expression<T> wordSensesRefs<T extends Object>(
    Expression<T> Function($$WordSensesTableAnnotationComposer a) f,
  ) {
    final $$WordSensesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordSenses,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordSensesTableAnnotationComposer(
            $db: $db,
            $table: $db.wordSenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> wordFormsRefs<T extends Object>(
    Expression<T> Function($$WordFormsTableAnnotationComposer a) f,
  ) {
    final $$WordFormsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordForms,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordFormsTableAnnotationComposer(
            $db: $db,
            $table: $db.wordForms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> wordnetLemmasRefs<T extends Object>(
    Expression<T> Function($$WordnetLemmasTableAnnotationComposer a) f,
  ) {
    final $$WordnetLemmasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordnetLemmas,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordnetLemmasTableAnnotationComposer(
            $db: $db,
            $table: $db.wordnetLemmas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DictionaryEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DictionaryEntriesTable,
          DictionaryEntryData,
          $$DictionaryEntriesTableFilterComposer,
          $$DictionaryEntriesTableOrderingComposer,
          $$DictionaryEntriesTableAnnotationComposer,
          $$DictionaryEntriesTableCreateCompanionBuilder,
          $$DictionaryEntriesTableUpdateCompanionBuilder,
          (DictionaryEntryData, $$DictionaryEntriesTableReferences),
          DictionaryEntryData,
          PrefetchHooks Function({
            bool wordSensesRefs,
            bool wordFormsRefs,
            bool wordnetLemmasRefs,
          })
        > {
  $$DictionaryEntriesTableTableManager(
    _$AppDatabase db,
    $DictionaryEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$DictionaryEntriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$DictionaryEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$DictionaryEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> word = const Value.absent(),
                Value<String> wordNormalized = const Value.absent(),
                Value<String> ipaUs = const Value.absent(),
                Value<String> ipaUk = const Value.absent(),
                Value<int> frequencyRank = const Value.absent(),
                Value<int> bibleFrequency = const Value.absent(),
                Value<String> etymology = const Value.absent(),
                Value<String> koreanMeaning = const Value.absent(),
                Value<String> synonymsJson = const Value.absent(),
                Value<String> antonymsJson = const Value.absent(),
                Value<String> relatedWordsJson = const Value.absent(),
              }) => DictionaryEntriesCompanion(
                id: id,
                word: word,
                wordNormalized: wordNormalized,
                ipaUs: ipaUs,
                ipaUk: ipaUk,
                frequencyRank: frequencyRank,
                bibleFrequency: bibleFrequency,
                etymology: etymology,
                koreanMeaning: koreanMeaning,
                synonymsJson: synonymsJson,
                antonymsJson: antonymsJson,
                relatedWordsJson: relatedWordsJson,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String word,
                required String wordNormalized,
                Value<String> ipaUs = const Value.absent(),
                Value<String> ipaUk = const Value.absent(),
                Value<int> frequencyRank = const Value.absent(),
                Value<int> bibleFrequency = const Value.absent(),
                Value<String> etymology = const Value.absent(),
                Value<String> koreanMeaning = const Value.absent(),
                Value<String> synonymsJson = const Value.absent(),
                Value<String> antonymsJson = const Value.absent(),
                Value<String> relatedWordsJson = const Value.absent(),
              }) => DictionaryEntriesCompanion.insert(
                id: id,
                word: word,
                wordNormalized: wordNormalized,
                ipaUs: ipaUs,
                ipaUk: ipaUk,
                frequencyRank: frequencyRank,
                bibleFrequency: bibleFrequency,
                etymology: etymology,
                koreanMeaning: koreanMeaning,
                synonymsJson: synonymsJson,
                antonymsJson: antonymsJson,
                relatedWordsJson: relatedWordsJson,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$DictionaryEntriesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            wordSensesRefs = false,
            wordFormsRefs = false,
            wordnetLemmasRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (wordSensesRefs) db.wordSenses,
                if (wordFormsRefs) db.wordForms,
                if (wordnetLemmasRefs) db.wordnetLemmas,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (wordSensesRefs)
                    await $_getPrefetchedData<
                      DictionaryEntryData,
                      $DictionaryEntriesTable,
                      WordSenseData
                    >(
                      currentTable: table,
                      referencedTable: $$DictionaryEntriesTableReferences
                          ._wordSensesRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$DictionaryEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).wordSensesRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.entryId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (wordFormsRefs)
                    await $_getPrefetchedData<
                      DictionaryEntryData,
                      $DictionaryEntriesTable,
                      WordFormData
                    >(
                      currentTable: table,
                      referencedTable: $$DictionaryEntriesTableReferences
                          ._wordFormsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$DictionaryEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).wordFormsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.entryId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (wordnetLemmasRefs)
                    await $_getPrefetchedData<
                      DictionaryEntryData,
                      $DictionaryEntriesTable,
                      WordnetLemmaData
                    >(
                      currentTable: table,
                      referencedTable: $$DictionaryEntriesTableReferences
                          ._wordnetLemmasRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$DictionaryEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).wordnetLemmasRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.entryId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DictionaryEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DictionaryEntriesTable,
      DictionaryEntryData,
      $$DictionaryEntriesTableFilterComposer,
      $$DictionaryEntriesTableOrderingComposer,
      $$DictionaryEntriesTableAnnotationComposer,
      $$DictionaryEntriesTableCreateCompanionBuilder,
      $$DictionaryEntriesTableUpdateCompanionBuilder,
      (DictionaryEntryData, $$DictionaryEntriesTableReferences),
      DictionaryEntryData,
      PrefetchHooks Function({
        bool wordSensesRefs,
        bool wordFormsRefs,
        bool wordnetLemmasRefs,
      })
    >;
typedef $$WordSensesTableCreateCompanionBuilder =
    WordSensesCompanion Function({
      Value<int> id,
      required int entryId,
      required String partOfSpeech,
      required int senseOrder,
      required String definition,
      Value<String> definitionKo,
      Value<String> bibleDefinition,
      Value<String> register,
      Value<bool> isArchaic,
    });
typedef $$WordSensesTableUpdateCompanionBuilder =
    WordSensesCompanion Function({
      Value<int> id,
      Value<int> entryId,
      Value<String> partOfSpeech,
      Value<int> senseOrder,
      Value<String> definition,
      Value<String> definitionKo,
      Value<String> bibleDefinition,
      Value<String> register,
      Value<bool> isArchaic,
    });

final class $$WordSensesTableReferences
    extends BaseReferences<_$AppDatabase, $WordSensesTable, WordSenseData> {
  $$WordSensesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DictionaryEntriesTable _entryIdTable(_$AppDatabase db) =>
      db.dictionaryEntries.createAlias(
        $_aliasNameGenerator(db.wordSenses.entryId, db.dictionaryEntries.id),
      );

  $$DictionaryEntriesTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<int>('entry_id')!;

    final manager = $$DictionaryEntriesTableTableManager(
      $_db,
      $_db.dictionaryEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$WordExamplesTable, List<WordExampleData>>
  _wordExamplesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.wordExamples,
    aliasName: $_aliasNameGenerator(db.wordSenses.id, db.wordExamples.senseId),
  );

  $$WordExamplesTableProcessedTableManager get wordExamplesRefs {
    final manager = $$WordExamplesTableTableManager(
      $_db,
      $_db.wordExamples,
    ).filter((f) => f.senseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_wordExamplesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WordSensesTableFilterComposer
    extends Composer<_$AppDatabase, $WordSensesTable> {
  $$WordSensesTableFilterComposer({
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

  ColumnFilters<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get senseOrder => $composableBuilder(
    column: $table.senseOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get definitionKo => $composableBuilder(
    column: $table.definitionKo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bibleDefinition => $composableBuilder(
    column: $table.bibleDefinition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get register => $composableBuilder(
    column: $table.register,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchaic => $composableBuilder(
    column: $table.isArchaic,
    builder: (column) => ColumnFilters(column),
  );

  $$DictionaryEntriesTableFilterComposer get entryId {
    final $$DictionaryEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.dictionaryEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DictionaryEntriesTableFilterComposer(
            $db: $db,
            $table: $db.dictionaryEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> wordExamplesRefs(
    Expression<bool> Function($$WordExamplesTableFilterComposer f) f,
  ) {
    final $$WordExamplesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordExamples,
      getReferencedColumn: (t) => t.senseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordExamplesTableFilterComposer(
            $db: $db,
            $table: $db.wordExamples,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WordSensesTableOrderingComposer
    extends Composer<_$AppDatabase, $WordSensesTable> {
  $$WordSensesTableOrderingComposer({
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

  ColumnOrderings<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get senseOrder => $composableBuilder(
    column: $table.senseOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get definitionKo => $composableBuilder(
    column: $table.definitionKo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bibleDefinition => $composableBuilder(
    column: $table.bibleDefinition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get register => $composableBuilder(
    column: $table.register,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchaic => $composableBuilder(
    column: $table.isArchaic,
    builder: (column) => ColumnOrderings(column),
  );

  $$DictionaryEntriesTableOrderingComposer get entryId {
    final $$DictionaryEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.dictionaryEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DictionaryEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.dictionaryEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordSensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordSensesTable> {
  $$WordSensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => column,
  );

  GeneratedColumn<int> get senseOrder => $composableBuilder(
    column: $table.senseOrder,
    builder: (column) => column,
  );

  GeneratedColumn<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => column,
  );

  GeneratedColumn<String> get definitionKo => $composableBuilder(
    column: $table.definitionKo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bibleDefinition => $composableBuilder(
    column: $table.bibleDefinition,
    builder: (column) => column,
  );

  GeneratedColumn<String> get register =>
      $composableBuilder(column: $table.register, builder: (column) => column);

  GeneratedColumn<bool> get isArchaic =>
      $composableBuilder(column: $table.isArchaic, builder: (column) => column);

  $$DictionaryEntriesTableAnnotationComposer get entryId {
    final $$DictionaryEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.entryId,
          referencedTable: $db.dictionaryEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DictionaryEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.dictionaryEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> wordExamplesRefs<T extends Object>(
    Expression<T> Function($$WordExamplesTableAnnotationComposer a) f,
  ) {
    final $$WordExamplesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordExamples,
      getReferencedColumn: (t) => t.senseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordExamplesTableAnnotationComposer(
            $db: $db,
            $table: $db.wordExamples,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WordSensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordSensesTable,
          WordSenseData,
          $$WordSensesTableFilterComposer,
          $$WordSensesTableOrderingComposer,
          $$WordSensesTableAnnotationComposer,
          $$WordSensesTableCreateCompanionBuilder,
          $$WordSensesTableUpdateCompanionBuilder,
          (WordSenseData, $$WordSensesTableReferences),
          WordSenseData,
          PrefetchHooks Function({bool entryId, bool wordExamplesRefs})
        > {
  $$WordSensesTableTableManager(_$AppDatabase db, $WordSensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$WordSensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$WordSensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$WordSensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> entryId = const Value.absent(),
                Value<String> partOfSpeech = const Value.absent(),
                Value<int> senseOrder = const Value.absent(),
                Value<String> definition = const Value.absent(),
                Value<String> definitionKo = const Value.absent(),
                Value<String> bibleDefinition = const Value.absent(),
                Value<String> register = const Value.absent(),
                Value<bool> isArchaic = const Value.absent(),
              }) => WordSensesCompanion(
                id: id,
                entryId: entryId,
                partOfSpeech: partOfSpeech,
                senseOrder: senseOrder,
                definition: definition,
                definitionKo: definitionKo,
                bibleDefinition: bibleDefinition,
                register: register,
                isArchaic: isArchaic,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int entryId,
                required String partOfSpeech,
                required int senseOrder,
                required String definition,
                Value<String> definitionKo = const Value.absent(),
                Value<String> bibleDefinition = const Value.absent(),
                Value<String> register = const Value.absent(),
                Value<bool> isArchaic = const Value.absent(),
              }) => WordSensesCompanion.insert(
                id: id,
                entryId: entryId,
                partOfSpeech: partOfSpeech,
                senseOrder: senseOrder,
                definition: definition,
                definitionKo: definitionKo,
                bibleDefinition: bibleDefinition,
                register: register,
                isArchaic: isArchaic,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$WordSensesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({entryId = false, wordExamplesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (wordExamplesRefs) db.wordExamples],
              addJoins: <
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
                if (entryId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.entryId,
                            referencedTable: $$WordSensesTableReferences
                                ._entryIdTable(db),
                            referencedColumn:
                                $$WordSensesTableReferences
                                    ._entryIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (wordExamplesRefs)
                    await $_getPrefetchedData<
                      WordSenseData,
                      $WordSensesTable,
                      WordExampleData
                    >(
                      currentTable: table,
                      referencedTable: $$WordSensesTableReferences
                          ._wordExamplesRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$WordSensesTableReferences(
                                db,
                                table,
                                p0,
                              ).wordExamplesRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.senseId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$WordSensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordSensesTable,
      WordSenseData,
      $$WordSensesTableFilterComposer,
      $$WordSensesTableOrderingComposer,
      $$WordSensesTableAnnotationComposer,
      $$WordSensesTableCreateCompanionBuilder,
      $$WordSensesTableUpdateCompanionBuilder,
      (WordSenseData, $$WordSensesTableReferences),
      WordSenseData,
      PrefetchHooks Function({bool entryId, bool wordExamplesRefs})
    >;
typedef $$WordExamplesTableCreateCompanionBuilder =
    WordExamplesCompanion Function({
      Value<int> id,
      required int senseId,
      required String exampleType,
      required String textContent,
      Value<String> sourceReference,
      Value<int?> bookId,
      Value<int?> chapter,
      Value<int?> verse,
    });
typedef $$WordExamplesTableUpdateCompanionBuilder =
    WordExamplesCompanion Function({
      Value<int> id,
      Value<int> senseId,
      Value<String> exampleType,
      Value<String> textContent,
      Value<String> sourceReference,
      Value<int?> bookId,
      Value<int?> chapter,
      Value<int?> verse,
    });

final class $$WordExamplesTableReferences
    extends BaseReferences<_$AppDatabase, $WordExamplesTable, WordExampleData> {
  $$WordExamplesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WordSensesTable _senseIdTable(_$AppDatabase db) =>
      db.wordSenses.createAlias(
        $_aliasNameGenerator(db.wordExamples.senseId, db.wordSenses.id),
      );

  $$WordSensesTableProcessedTableManager get senseId {
    final $_column = $_itemColumn<int>('sense_id')!;

    final manager = $$WordSensesTableTableManager(
      $_db,
      $_db.wordSenses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_senseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WordExamplesTableFilterComposer
    extends Composer<_$AppDatabase, $WordExamplesTable> {
  $$WordExamplesTableFilterComposer({
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

  ColumnFilters<String> get exampleType => $composableBuilder(
    column: $table.exampleType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceReference => $composableBuilder(
    column: $table.sourceReference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get verse => $composableBuilder(
    column: $table.verse,
    builder: (column) => ColumnFilters(column),
  );

  $$WordSensesTableFilterComposer get senseId {
    final $$WordSensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.senseId,
      referencedTable: $db.wordSenses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordSensesTableFilterComposer(
            $db: $db,
            $table: $db.wordSenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordExamplesTableOrderingComposer
    extends Composer<_$AppDatabase, $WordExamplesTable> {
  $$WordExamplesTableOrderingComposer({
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

  ColumnOrderings<String> get exampleType => $composableBuilder(
    column: $table.exampleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceReference => $composableBuilder(
    column: $table.sourceReference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get verse => $composableBuilder(
    column: $table.verse,
    builder: (column) => ColumnOrderings(column),
  );

  $$WordSensesTableOrderingComposer get senseId {
    final $$WordSensesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.senseId,
      referencedTable: $db.wordSenses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordSensesTableOrderingComposer(
            $db: $db,
            $table: $db.wordSenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordExamplesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordExamplesTable> {
  $$WordExamplesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get exampleType => $composableBuilder(
    column: $table.exampleType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceReference => $composableBuilder(
    column: $table.sourceReference,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bookId =>
      $composableBuilder(column: $table.bookId, builder: (column) => column);

  GeneratedColumn<int> get chapter =>
      $composableBuilder(column: $table.chapter, builder: (column) => column);

  GeneratedColumn<int> get verse =>
      $composableBuilder(column: $table.verse, builder: (column) => column);

  $$WordSensesTableAnnotationComposer get senseId {
    final $$WordSensesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.senseId,
      referencedTable: $db.wordSenses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordSensesTableAnnotationComposer(
            $db: $db,
            $table: $db.wordSenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordExamplesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordExamplesTable,
          WordExampleData,
          $$WordExamplesTableFilterComposer,
          $$WordExamplesTableOrderingComposer,
          $$WordExamplesTableAnnotationComposer,
          $$WordExamplesTableCreateCompanionBuilder,
          $$WordExamplesTableUpdateCompanionBuilder,
          (WordExampleData, $$WordExamplesTableReferences),
          WordExampleData,
          PrefetchHooks Function({bool senseId})
        > {
  $$WordExamplesTableTableManager(_$AppDatabase db, $WordExamplesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$WordExamplesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$WordExamplesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$WordExamplesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> senseId = const Value.absent(),
                Value<String> exampleType = const Value.absent(),
                Value<String> textContent = const Value.absent(),
                Value<String> sourceReference = const Value.absent(),
                Value<int?> bookId = const Value.absent(),
                Value<int?> chapter = const Value.absent(),
                Value<int?> verse = const Value.absent(),
              }) => WordExamplesCompanion(
                id: id,
                senseId: senseId,
                exampleType: exampleType,
                textContent: textContent,
                sourceReference: sourceReference,
                bookId: bookId,
                chapter: chapter,
                verse: verse,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int senseId,
                required String exampleType,
                required String textContent,
                Value<String> sourceReference = const Value.absent(),
                Value<int?> bookId = const Value.absent(),
                Value<int?> chapter = const Value.absent(),
                Value<int?> verse = const Value.absent(),
              }) => WordExamplesCompanion.insert(
                id: id,
                senseId: senseId,
                exampleType: exampleType,
                textContent: textContent,
                sourceReference: sourceReference,
                bookId: bookId,
                chapter: chapter,
                verse: verse,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$WordExamplesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({senseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                if (senseId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.senseId,
                            referencedTable: $$WordExamplesTableReferences
                                ._senseIdTable(db),
                            referencedColumn:
                                $$WordExamplesTableReferences
                                    ._senseIdTable(db)
                                    .id,
                          )
                          as T;
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

typedef $$WordExamplesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordExamplesTable,
      WordExampleData,
      $$WordExamplesTableFilterComposer,
      $$WordExamplesTableOrderingComposer,
      $$WordExamplesTableAnnotationComposer,
      $$WordExamplesTableCreateCompanionBuilder,
      $$WordExamplesTableUpdateCompanionBuilder,
      (WordExampleData, $$WordExamplesTableReferences),
      WordExampleData,
      PrefetchHooks Function({bool senseId})
    >;
typedef $$WordFormsTableCreateCompanionBuilder =
    WordFormsCompanion Function({
      Value<int> id,
      required int entryId,
      required String formType,
      required String form,
    });
typedef $$WordFormsTableUpdateCompanionBuilder =
    WordFormsCompanion Function({
      Value<int> id,
      Value<int> entryId,
      Value<String> formType,
      Value<String> form,
    });

final class $$WordFormsTableReferences
    extends BaseReferences<_$AppDatabase, $WordFormsTable, WordFormData> {
  $$WordFormsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DictionaryEntriesTable _entryIdTable(_$AppDatabase db) =>
      db.dictionaryEntries.createAlias(
        $_aliasNameGenerator(db.wordForms.entryId, db.dictionaryEntries.id),
      );

  $$DictionaryEntriesTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<int>('entry_id')!;

    final manager = $$DictionaryEntriesTableTableManager(
      $_db,
      $_db.dictionaryEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WordFormsTableFilterComposer
    extends Composer<_$AppDatabase, $WordFormsTable> {
  $$WordFormsTableFilterComposer({
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

  ColumnFilters<String> get formType => $composableBuilder(
    column: $table.formType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get form => $composableBuilder(
    column: $table.form,
    builder: (column) => ColumnFilters(column),
  );

  $$DictionaryEntriesTableFilterComposer get entryId {
    final $$DictionaryEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.dictionaryEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DictionaryEntriesTableFilterComposer(
            $db: $db,
            $table: $db.dictionaryEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordFormsTableOrderingComposer
    extends Composer<_$AppDatabase, $WordFormsTable> {
  $$WordFormsTableOrderingComposer({
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

  ColumnOrderings<String> get formType => $composableBuilder(
    column: $table.formType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get form => $composableBuilder(
    column: $table.form,
    builder: (column) => ColumnOrderings(column),
  );

  $$DictionaryEntriesTableOrderingComposer get entryId {
    final $$DictionaryEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.dictionaryEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DictionaryEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.dictionaryEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordFormsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordFormsTable> {
  $$WordFormsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get formType =>
      $composableBuilder(column: $table.formType, builder: (column) => column);

  GeneratedColumn<String> get form =>
      $composableBuilder(column: $table.form, builder: (column) => column);

  $$DictionaryEntriesTableAnnotationComposer get entryId {
    final $$DictionaryEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.entryId,
          referencedTable: $db.dictionaryEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DictionaryEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.dictionaryEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$WordFormsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordFormsTable,
          WordFormData,
          $$WordFormsTableFilterComposer,
          $$WordFormsTableOrderingComposer,
          $$WordFormsTableAnnotationComposer,
          $$WordFormsTableCreateCompanionBuilder,
          $$WordFormsTableUpdateCompanionBuilder,
          (WordFormData, $$WordFormsTableReferences),
          WordFormData,
          PrefetchHooks Function({bool entryId})
        > {
  $$WordFormsTableTableManager(_$AppDatabase db, $WordFormsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$WordFormsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$WordFormsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$WordFormsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> entryId = const Value.absent(),
                Value<String> formType = const Value.absent(),
                Value<String> form = const Value.absent(),
              }) => WordFormsCompanion(
                id: id,
                entryId: entryId,
                formType: formType,
                form: form,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int entryId,
                required String formType,
                required String form,
              }) => WordFormsCompanion.insert(
                id: id,
                entryId: entryId,
                formType: formType,
                form: form,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$WordFormsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({entryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                if (entryId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.entryId,
                            referencedTable: $$WordFormsTableReferences
                                ._entryIdTable(db),
                            referencedColumn:
                                $$WordFormsTableReferences._entryIdTable(db).id,
                          )
                          as T;
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

typedef $$WordFormsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordFormsTable,
      WordFormData,
      $$WordFormsTableFilterComposer,
      $$WordFormsTableOrderingComposer,
      $$WordFormsTableAnnotationComposer,
      $$WordFormsTableCreateCompanionBuilder,
      $$WordFormsTableUpdateCompanionBuilder,
      (WordFormData, $$WordFormsTableReferences),
      WordFormData,
      PrefetchHooks Function({bool entryId})
    >;
typedef $$WordnetSynsetsTableCreateCompanionBuilder =
    WordnetSynsetsCompanion Function({
      Value<int> id,
      required String synsetId,
      required String posCode,
      required String definition,
      Value<String> examples,
    });
typedef $$WordnetSynsetsTableUpdateCompanionBuilder =
    WordnetSynsetsCompanion Function({
      Value<int> id,
      Value<String> synsetId,
      Value<String> posCode,
      Value<String> definition,
      Value<String> examples,
    });

final class $$WordnetSynsetsTableReferences
    extends
        BaseReferences<_$AppDatabase, $WordnetSynsetsTable, WordnetSynsetData> {
  $$WordnetSynsetsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$WordnetLemmasTable, List<WordnetLemmaData>>
  _wordnetLemmasRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.wordnetLemmas,
    aliasName: $_aliasNameGenerator(
      db.wordnetSynsets.id,
      db.wordnetLemmas.synsetId,
    ),
  );

  $$WordnetLemmasTableProcessedTableManager get wordnetLemmasRefs {
    final manager = $$WordnetLemmasTableTableManager(
      $_db,
      $_db.wordnetLemmas,
    ).filter((f) => f.synsetId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_wordnetLemmasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WordnetSynsetsTableFilterComposer
    extends Composer<_$AppDatabase, $WordnetSynsetsTable> {
  $$WordnetSynsetsTableFilterComposer({
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

  ColumnFilters<String> get synsetId => $composableBuilder(
    column: $table.synsetId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get posCode => $composableBuilder(
    column: $table.posCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get examples => $composableBuilder(
    column: $table.examples,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> wordnetLemmasRefs(
    Expression<bool> Function($$WordnetLemmasTableFilterComposer f) f,
  ) {
    final $$WordnetLemmasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordnetLemmas,
      getReferencedColumn: (t) => t.synsetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordnetLemmasTableFilterComposer(
            $db: $db,
            $table: $db.wordnetLemmas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WordnetSynsetsTableOrderingComposer
    extends Composer<_$AppDatabase, $WordnetSynsetsTable> {
  $$WordnetSynsetsTableOrderingComposer({
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

  ColumnOrderings<String> get synsetId => $composableBuilder(
    column: $table.synsetId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get posCode => $composableBuilder(
    column: $table.posCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get examples => $composableBuilder(
    column: $table.examples,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WordnetSynsetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordnetSynsetsTable> {
  $$WordnetSynsetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get synsetId =>
      $composableBuilder(column: $table.synsetId, builder: (column) => column);

  GeneratedColumn<String> get posCode =>
      $composableBuilder(column: $table.posCode, builder: (column) => column);

  GeneratedColumn<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => column,
  );

  GeneratedColumn<String> get examples =>
      $composableBuilder(column: $table.examples, builder: (column) => column);

  Expression<T> wordnetLemmasRefs<T extends Object>(
    Expression<T> Function($$WordnetLemmasTableAnnotationComposer a) f,
  ) {
    final $$WordnetLemmasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordnetLemmas,
      getReferencedColumn: (t) => t.synsetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordnetLemmasTableAnnotationComposer(
            $db: $db,
            $table: $db.wordnetLemmas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WordnetSynsetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordnetSynsetsTable,
          WordnetSynsetData,
          $$WordnetSynsetsTableFilterComposer,
          $$WordnetSynsetsTableOrderingComposer,
          $$WordnetSynsetsTableAnnotationComposer,
          $$WordnetSynsetsTableCreateCompanionBuilder,
          $$WordnetSynsetsTableUpdateCompanionBuilder,
          (WordnetSynsetData, $$WordnetSynsetsTableReferences),
          WordnetSynsetData,
          PrefetchHooks Function({bool wordnetLemmasRefs})
        > {
  $$WordnetSynsetsTableTableManager(
    _$AppDatabase db,
    $WordnetSynsetsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$WordnetSynsetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$WordnetSynsetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$WordnetSynsetsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> synsetId = const Value.absent(),
                Value<String> posCode = const Value.absent(),
                Value<String> definition = const Value.absent(),
                Value<String> examples = const Value.absent(),
              }) => WordnetSynsetsCompanion(
                id: id,
                synsetId: synsetId,
                posCode: posCode,
                definition: definition,
                examples: examples,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String synsetId,
                required String posCode,
                required String definition,
                Value<String> examples = const Value.absent(),
              }) => WordnetSynsetsCompanion.insert(
                id: id,
                synsetId: synsetId,
                posCode: posCode,
                definition: definition,
                examples: examples,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$WordnetSynsetsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({wordnetLemmasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (wordnetLemmasRefs) db.wordnetLemmas,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (wordnetLemmasRefs)
                    await $_getPrefetchedData<
                      WordnetSynsetData,
                      $WordnetSynsetsTable,
                      WordnetLemmaData
                    >(
                      currentTable: table,
                      referencedTable: $$WordnetSynsetsTableReferences
                          ._wordnetLemmasRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$WordnetSynsetsTableReferences(
                                db,
                                table,
                                p0,
                              ).wordnetLemmasRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.synsetId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$WordnetSynsetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordnetSynsetsTable,
      WordnetSynsetData,
      $$WordnetSynsetsTableFilterComposer,
      $$WordnetSynsetsTableOrderingComposer,
      $$WordnetSynsetsTableAnnotationComposer,
      $$WordnetSynsetsTableCreateCompanionBuilder,
      $$WordnetSynsetsTableUpdateCompanionBuilder,
      (WordnetSynsetData, $$WordnetSynsetsTableReferences),
      WordnetSynsetData,
      PrefetchHooks Function({bool wordnetLemmasRefs})
    >;
typedef $$WordnetLemmasTableCreateCompanionBuilder =
    WordnetLemmasCompanion Function({
      Value<int> id,
      required int entryId,
      required int synsetId,
      Value<int> lemmaOrder,
    });
typedef $$WordnetLemmasTableUpdateCompanionBuilder =
    WordnetLemmasCompanion Function({
      Value<int> id,
      Value<int> entryId,
      Value<int> synsetId,
      Value<int> lemmaOrder,
    });

final class $$WordnetLemmasTableReferences
    extends
        BaseReferences<_$AppDatabase, $WordnetLemmasTable, WordnetLemmaData> {
  $$WordnetLemmasTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DictionaryEntriesTable _entryIdTable(_$AppDatabase db) =>
      db.dictionaryEntries.createAlias(
        $_aliasNameGenerator(db.wordnetLemmas.entryId, db.dictionaryEntries.id),
      );

  $$DictionaryEntriesTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<int>('entry_id')!;

    final manager = $$DictionaryEntriesTableTableManager(
      $_db,
      $_db.dictionaryEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $WordnetSynsetsTable _synsetIdTable(_$AppDatabase db) =>
      db.wordnetSynsets.createAlias(
        $_aliasNameGenerator(db.wordnetLemmas.synsetId, db.wordnetSynsets.id),
      );

  $$WordnetSynsetsTableProcessedTableManager get synsetId {
    final $_column = $_itemColumn<int>('synset_id')!;

    final manager = $$WordnetSynsetsTableTableManager(
      $_db,
      $_db.wordnetSynsets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_synsetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WordnetLemmasTableFilterComposer
    extends Composer<_$AppDatabase, $WordnetLemmasTable> {
  $$WordnetLemmasTableFilterComposer({
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

  ColumnFilters<int> get lemmaOrder => $composableBuilder(
    column: $table.lemmaOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$DictionaryEntriesTableFilterComposer get entryId {
    final $$DictionaryEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.dictionaryEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DictionaryEntriesTableFilterComposer(
            $db: $db,
            $table: $db.dictionaryEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WordnetSynsetsTableFilterComposer get synsetId {
    final $$WordnetSynsetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.synsetId,
      referencedTable: $db.wordnetSynsets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordnetSynsetsTableFilterComposer(
            $db: $db,
            $table: $db.wordnetSynsets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordnetLemmasTableOrderingComposer
    extends Composer<_$AppDatabase, $WordnetLemmasTable> {
  $$WordnetLemmasTableOrderingComposer({
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

  ColumnOrderings<int> get lemmaOrder => $composableBuilder(
    column: $table.lemmaOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$DictionaryEntriesTableOrderingComposer get entryId {
    final $$DictionaryEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.dictionaryEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DictionaryEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.dictionaryEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WordnetSynsetsTableOrderingComposer get synsetId {
    final $$WordnetSynsetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.synsetId,
      referencedTable: $db.wordnetSynsets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordnetSynsetsTableOrderingComposer(
            $db: $db,
            $table: $db.wordnetSynsets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordnetLemmasTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordnetLemmasTable> {
  $$WordnetLemmasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get lemmaOrder => $composableBuilder(
    column: $table.lemmaOrder,
    builder: (column) => column,
  );

  $$DictionaryEntriesTableAnnotationComposer get entryId {
    final $$DictionaryEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.entryId,
          referencedTable: $db.dictionaryEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DictionaryEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.dictionaryEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$WordnetSynsetsTableAnnotationComposer get synsetId {
    final $$WordnetSynsetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.synsetId,
      referencedTable: $db.wordnetSynsets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordnetSynsetsTableAnnotationComposer(
            $db: $db,
            $table: $db.wordnetSynsets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordnetLemmasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordnetLemmasTable,
          WordnetLemmaData,
          $$WordnetLemmasTableFilterComposer,
          $$WordnetLemmasTableOrderingComposer,
          $$WordnetLemmasTableAnnotationComposer,
          $$WordnetLemmasTableCreateCompanionBuilder,
          $$WordnetLemmasTableUpdateCompanionBuilder,
          (WordnetLemmaData, $$WordnetLemmasTableReferences),
          WordnetLemmaData,
          PrefetchHooks Function({bool entryId, bool synsetId})
        > {
  $$WordnetLemmasTableTableManager(_$AppDatabase db, $WordnetLemmasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$WordnetLemmasTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$WordnetLemmasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$WordnetLemmasTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> entryId = const Value.absent(),
                Value<int> synsetId = const Value.absent(),
                Value<int> lemmaOrder = const Value.absent(),
              }) => WordnetLemmasCompanion(
                id: id,
                entryId: entryId,
                synsetId: synsetId,
                lemmaOrder: lemmaOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int entryId,
                required int synsetId,
                Value<int> lemmaOrder = const Value.absent(),
              }) => WordnetLemmasCompanion.insert(
                id: id,
                entryId: entryId,
                synsetId: synsetId,
                lemmaOrder: lemmaOrder,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$WordnetLemmasTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({entryId = false, synsetId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                if (entryId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.entryId,
                            referencedTable: $$WordnetLemmasTableReferences
                                ._entryIdTable(db),
                            referencedColumn:
                                $$WordnetLemmasTableReferences
                                    ._entryIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (synsetId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.synsetId,
                            referencedTable: $$WordnetLemmasTableReferences
                                ._synsetIdTable(db),
                            referencedColumn:
                                $$WordnetLemmasTableReferences
                                    ._synsetIdTable(db)
                                    .id,
                          )
                          as T;
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

typedef $$WordnetLemmasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordnetLemmasTable,
      WordnetLemmaData,
      $$WordnetLemmasTableFilterComposer,
      $$WordnetLemmasTableOrderingComposer,
      $$WordnetLemmasTableAnnotationComposer,
      $$WordnetLemmasTableCreateCompanionBuilder,
      $$WordnetLemmasTableUpdateCompanionBuilder,
      (WordnetLemmaData, $$WordnetLemmasTableReferences),
      WordnetLemmaData,
      PrefetchHooks Function({bool entryId, bool synsetId})
    >;
typedef $$WordnetRelationsTableCreateCompanionBuilder =
    WordnetRelationsCompanion Function({
      Value<int> id,
      required int fromSynsetId,
      required int toSynsetId,
      required String relationType,
    });
typedef $$WordnetRelationsTableUpdateCompanionBuilder =
    WordnetRelationsCompanion Function({
      Value<int> id,
      Value<int> fromSynsetId,
      Value<int> toSynsetId,
      Value<String> relationType,
    });

final class $$WordnetRelationsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $WordnetRelationsTable,
          WordnetRelationData
        > {
  $$WordnetRelationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WordnetSynsetsTable _fromSynsetIdTable(_$AppDatabase db) =>
      db.wordnetSynsets.createAlias(
        $_aliasNameGenerator(
          db.wordnetRelations.fromSynsetId,
          db.wordnetSynsets.id,
        ),
      );

  $$WordnetSynsetsTableProcessedTableManager get fromSynsetId {
    final $_column = $_itemColumn<int>('from_synset_id')!;

    final manager = $$WordnetSynsetsTableTableManager(
      $_db,
      $_db.wordnetSynsets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fromSynsetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $WordnetSynsetsTable _toSynsetIdTable(_$AppDatabase db) =>
      db.wordnetSynsets.createAlias(
        $_aliasNameGenerator(
          db.wordnetRelations.toSynsetId,
          db.wordnetSynsets.id,
        ),
      );

  $$WordnetSynsetsTableProcessedTableManager get toSynsetId {
    final $_column = $_itemColumn<int>('to_synset_id')!;

    final manager = $$WordnetSynsetsTableTableManager(
      $_db,
      $_db.wordnetSynsets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_toSynsetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WordnetRelationsTableFilterComposer
    extends Composer<_$AppDatabase, $WordnetRelationsTable> {
  $$WordnetRelationsTableFilterComposer({
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

  ColumnFilters<String> get relationType => $composableBuilder(
    column: $table.relationType,
    builder: (column) => ColumnFilters(column),
  );

  $$WordnetSynsetsTableFilterComposer get fromSynsetId {
    final $$WordnetSynsetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromSynsetId,
      referencedTable: $db.wordnetSynsets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordnetSynsetsTableFilterComposer(
            $db: $db,
            $table: $db.wordnetSynsets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WordnetSynsetsTableFilterComposer get toSynsetId {
    final $$WordnetSynsetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toSynsetId,
      referencedTable: $db.wordnetSynsets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordnetSynsetsTableFilterComposer(
            $db: $db,
            $table: $db.wordnetSynsets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordnetRelationsTableOrderingComposer
    extends Composer<_$AppDatabase, $WordnetRelationsTable> {
  $$WordnetRelationsTableOrderingComposer({
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

  ColumnOrderings<String> get relationType => $composableBuilder(
    column: $table.relationType,
    builder: (column) => ColumnOrderings(column),
  );

  $$WordnetSynsetsTableOrderingComposer get fromSynsetId {
    final $$WordnetSynsetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromSynsetId,
      referencedTable: $db.wordnetSynsets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordnetSynsetsTableOrderingComposer(
            $db: $db,
            $table: $db.wordnetSynsets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WordnetSynsetsTableOrderingComposer get toSynsetId {
    final $$WordnetSynsetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toSynsetId,
      referencedTable: $db.wordnetSynsets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordnetSynsetsTableOrderingComposer(
            $db: $db,
            $table: $db.wordnetSynsets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordnetRelationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordnetRelationsTable> {
  $$WordnetRelationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get relationType => $composableBuilder(
    column: $table.relationType,
    builder: (column) => column,
  );

  $$WordnetSynsetsTableAnnotationComposer get fromSynsetId {
    final $$WordnetSynsetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromSynsetId,
      referencedTable: $db.wordnetSynsets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordnetSynsetsTableAnnotationComposer(
            $db: $db,
            $table: $db.wordnetSynsets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WordnetSynsetsTableAnnotationComposer get toSynsetId {
    final $$WordnetSynsetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toSynsetId,
      referencedTable: $db.wordnetSynsets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordnetSynsetsTableAnnotationComposer(
            $db: $db,
            $table: $db.wordnetSynsets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordnetRelationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordnetRelationsTable,
          WordnetRelationData,
          $$WordnetRelationsTableFilterComposer,
          $$WordnetRelationsTableOrderingComposer,
          $$WordnetRelationsTableAnnotationComposer,
          $$WordnetRelationsTableCreateCompanionBuilder,
          $$WordnetRelationsTableUpdateCompanionBuilder,
          (WordnetRelationData, $$WordnetRelationsTableReferences),
          WordnetRelationData,
          PrefetchHooks Function({bool fromSynsetId, bool toSynsetId})
        > {
  $$WordnetRelationsTableTableManager(
    _$AppDatabase db,
    $WordnetRelationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$WordnetRelationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$WordnetRelationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$WordnetRelationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> fromSynsetId = const Value.absent(),
                Value<int> toSynsetId = const Value.absent(),
                Value<String> relationType = const Value.absent(),
              }) => WordnetRelationsCompanion(
                id: id,
                fromSynsetId: fromSynsetId,
                toSynsetId: toSynsetId,
                relationType: relationType,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int fromSynsetId,
                required int toSynsetId,
                required String relationType,
              }) => WordnetRelationsCompanion.insert(
                id: id,
                fromSynsetId: fromSynsetId,
                toSynsetId: toSynsetId,
                relationType: relationType,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$WordnetRelationsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({fromSynsetId = false, toSynsetId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                if (fromSynsetId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.fromSynsetId,
                            referencedTable: $$WordnetRelationsTableReferences
                                ._fromSynsetIdTable(db),
                            referencedColumn:
                                $$WordnetRelationsTableReferences
                                    ._fromSynsetIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (toSynsetId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.toSynsetId,
                            referencedTable: $$WordnetRelationsTableReferences
                                ._toSynsetIdTable(db),
                            referencedColumn:
                                $$WordnetRelationsTableReferences
                                    ._toSynsetIdTable(db)
                                    .id,
                          )
                          as T;
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

typedef $$WordnetRelationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordnetRelationsTable,
      WordnetRelationData,
      $$WordnetRelationsTableFilterComposer,
      $$WordnetRelationsTableOrderingComposer,
      $$WordnetRelationsTableAnnotationComposer,
      $$WordnetRelationsTableCreateCompanionBuilder,
      $$WordnetRelationsTableUpdateCompanionBuilder,
      (WordnetRelationData, $$WordnetRelationsTableReferences),
      WordnetRelationData,
      PrefetchHooks Function({bool fromSynsetId, bool toSynsetId})
    >;
typedef $$StrongEntriesTableCreateCompanionBuilder =
    StrongEntriesCompanion Function({
      Value<int> id,
      required String strongNumber,
      required String testament,
      required String originalWord,
      Value<String> transliteration,
      Value<String> pronunciation,
      Value<String> partOfSpeech,
      required String shortDefinition,
      required String fullDefinition,
      Value<String> derivation,
      Value<int> kjvFrequency,
    });
typedef $$StrongEntriesTableUpdateCompanionBuilder =
    StrongEntriesCompanion Function({
      Value<int> id,
      Value<String> strongNumber,
      Value<String> testament,
      Value<String> originalWord,
      Value<String> transliteration,
      Value<String> pronunciation,
      Value<String> partOfSpeech,
      Value<String> shortDefinition,
      Value<String> fullDefinition,
      Value<String> derivation,
      Value<int> kjvFrequency,
    });

class $$StrongEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $StrongEntriesTable> {
  $$StrongEntriesTableFilterComposer({
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

  ColumnFilters<String> get strongNumber => $composableBuilder(
    column: $table.strongNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get testament => $composableBuilder(
    column: $table.testament,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalWord => $composableBuilder(
    column: $table.originalWord,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transliteration => $composableBuilder(
    column: $table.transliteration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pronunciation => $composableBuilder(
    column: $table.pronunciation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shortDefinition => $composableBuilder(
    column: $table.shortDefinition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullDefinition => $composableBuilder(
    column: $table.fullDefinition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get derivation => $composableBuilder(
    column: $table.derivation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get kjvFrequency => $composableBuilder(
    column: $table.kjvFrequency,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StrongEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $StrongEntriesTable> {
  $$StrongEntriesTableOrderingComposer({
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

  ColumnOrderings<String> get strongNumber => $composableBuilder(
    column: $table.strongNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get testament => $composableBuilder(
    column: $table.testament,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalWord => $composableBuilder(
    column: $table.originalWord,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transliteration => $composableBuilder(
    column: $table.transliteration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pronunciation => $composableBuilder(
    column: $table.pronunciation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shortDefinition => $composableBuilder(
    column: $table.shortDefinition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullDefinition => $composableBuilder(
    column: $table.fullDefinition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get derivation => $composableBuilder(
    column: $table.derivation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kjvFrequency => $composableBuilder(
    column: $table.kjvFrequency,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StrongEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $StrongEntriesTable> {
  $$StrongEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get strongNumber => $composableBuilder(
    column: $table.strongNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get testament =>
      $composableBuilder(column: $table.testament, builder: (column) => column);

  GeneratedColumn<String> get originalWord => $composableBuilder(
    column: $table.originalWord,
    builder: (column) => column,
  );

  GeneratedColumn<String> get transliteration => $composableBuilder(
    column: $table.transliteration,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pronunciation => $composableBuilder(
    column: $table.pronunciation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => column,
  );

  GeneratedColumn<String> get shortDefinition => $composableBuilder(
    column: $table.shortDefinition,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fullDefinition => $composableBuilder(
    column: $table.fullDefinition,
    builder: (column) => column,
  );

  GeneratedColumn<String> get derivation => $composableBuilder(
    column: $table.derivation,
    builder: (column) => column,
  );

  GeneratedColumn<int> get kjvFrequency => $composableBuilder(
    column: $table.kjvFrequency,
    builder: (column) => column,
  );
}

class $$StrongEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StrongEntriesTable,
          StrongEntry,
          $$StrongEntriesTableFilterComposer,
          $$StrongEntriesTableOrderingComposer,
          $$StrongEntriesTableAnnotationComposer,
          $$StrongEntriesTableCreateCompanionBuilder,
          $$StrongEntriesTableUpdateCompanionBuilder,
          (
            StrongEntry,
            BaseReferences<_$AppDatabase, $StrongEntriesTable, StrongEntry>,
          ),
          StrongEntry,
          PrefetchHooks Function()
        > {
  $$StrongEntriesTableTableManager(_$AppDatabase db, $StrongEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$StrongEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$StrongEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$StrongEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> strongNumber = const Value.absent(),
                Value<String> testament = const Value.absent(),
                Value<String> originalWord = const Value.absent(),
                Value<String> transliteration = const Value.absent(),
                Value<String> pronunciation = const Value.absent(),
                Value<String> partOfSpeech = const Value.absent(),
                Value<String> shortDefinition = const Value.absent(),
                Value<String> fullDefinition = const Value.absent(),
                Value<String> derivation = const Value.absent(),
                Value<int> kjvFrequency = const Value.absent(),
              }) => StrongEntriesCompanion(
                id: id,
                strongNumber: strongNumber,
                testament: testament,
                originalWord: originalWord,
                transliteration: transliteration,
                pronunciation: pronunciation,
                partOfSpeech: partOfSpeech,
                shortDefinition: shortDefinition,
                fullDefinition: fullDefinition,
                derivation: derivation,
                kjvFrequency: kjvFrequency,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String strongNumber,
                required String testament,
                required String originalWord,
                Value<String> transliteration = const Value.absent(),
                Value<String> pronunciation = const Value.absent(),
                Value<String> partOfSpeech = const Value.absent(),
                required String shortDefinition,
                required String fullDefinition,
                Value<String> derivation = const Value.absent(),
                Value<int> kjvFrequency = const Value.absent(),
              }) => StrongEntriesCompanion.insert(
                id: id,
                strongNumber: strongNumber,
                testament: testament,
                originalWord: originalWord,
                transliteration: transliteration,
                pronunciation: pronunciation,
                partOfSpeech: partOfSpeech,
                shortDefinition: shortDefinition,
                fullDefinition: fullDefinition,
                derivation: derivation,
                kjvFrequency: kjvFrequency,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StrongEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StrongEntriesTable,
      StrongEntry,
      $$StrongEntriesTableFilterComposer,
      $$StrongEntriesTableOrderingComposer,
      $$StrongEntriesTableAnnotationComposer,
      $$StrongEntriesTableCreateCompanionBuilder,
      $$StrongEntriesTableUpdateCompanionBuilder,
      (
        StrongEntry,
        BaseReferences<_$AppDatabase, $StrongEntriesTable, StrongEntry>,
      ),
      StrongEntry,
      PrefetchHooks Function()
    >;
typedef $$VerseStrongMappingsTableCreateCompanionBuilder =
    VerseStrongMappingsCompanion Function({
      Value<int> id,
      required int bookId,
      required int chapter,
      required int verse,
      required int wordPosition,
      required String kjvWord,
      required String strongNumber,
    });
typedef $$VerseStrongMappingsTableUpdateCompanionBuilder =
    VerseStrongMappingsCompanion Function({
      Value<int> id,
      Value<int> bookId,
      Value<int> chapter,
      Value<int> verse,
      Value<int> wordPosition,
      Value<String> kjvWord,
      Value<String> strongNumber,
    });

class $$VerseStrongMappingsTableFilterComposer
    extends Composer<_$AppDatabase, $VerseStrongMappingsTable> {
  $$VerseStrongMappingsTableFilterComposer({
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

  ColumnFilters<int> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get verse => $composableBuilder(
    column: $table.verse,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wordPosition => $composableBuilder(
    column: $table.wordPosition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kjvWord => $composableBuilder(
    column: $table.kjvWord,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get strongNumber => $composableBuilder(
    column: $table.strongNumber,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VerseStrongMappingsTableOrderingComposer
    extends Composer<_$AppDatabase, $VerseStrongMappingsTable> {
  $$VerseStrongMappingsTableOrderingComposer({
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

  ColumnOrderings<int> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get verse => $composableBuilder(
    column: $table.verse,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wordPosition => $composableBuilder(
    column: $table.wordPosition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kjvWord => $composableBuilder(
    column: $table.kjvWord,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get strongNumber => $composableBuilder(
    column: $table.strongNumber,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VerseStrongMappingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VerseStrongMappingsTable> {
  $$VerseStrongMappingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get bookId =>
      $composableBuilder(column: $table.bookId, builder: (column) => column);

  GeneratedColumn<int> get chapter =>
      $composableBuilder(column: $table.chapter, builder: (column) => column);

  GeneratedColumn<int> get verse =>
      $composableBuilder(column: $table.verse, builder: (column) => column);

  GeneratedColumn<int> get wordPosition => $composableBuilder(
    column: $table.wordPosition,
    builder: (column) => column,
  );

  GeneratedColumn<String> get kjvWord =>
      $composableBuilder(column: $table.kjvWord, builder: (column) => column);

  GeneratedColumn<String> get strongNumber => $composableBuilder(
    column: $table.strongNumber,
    builder: (column) => column,
  );
}

class $$VerseStrongMappingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VerseStrongMappingsTable,
          VerseStrongMapping,
          $$VerseStrongMappingsTableFilterComposer,
          $$VerseStrongMappingsTableOrderingComposer,
          $$VerseStrongMappingsTableAnnotationComposer,
          $$VerseStrongMappingsTableCreateCompanionBuilder,
          $$VerseStrongMappingsTableUpdateCompanionBuilder,
          (
            VerseStrongMapping,
            BaseReferences<
              _$AppDatabase,
              $VerseStrongMappingsTable,
              VerseStrongMapping
            >,
          ),
          VerseStrongMapping,
          PrefetchHooks Function()
        > {
  $$VerseStrongMappingsTableTableManager(
    _$AppDatabase db,
    $VerseStrongMappingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$VerseStrongMappingsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$VerseStrongMappingsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$VerseStrongMappingsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> bookId = const Value.absent(),
                Value<int> chapter = const Value.absent(),
                Value<int> verse = const Value.absent(),
                Value<int> wordPosition = const Value.absent(),
                Value<String> kjvWord = const Value.absent(),
                Value<String> strongNumber = const Value.absent(),
              }) => VerseStrongMappingsCompanion(
                id: id,
                bookId: bookId,
                chapter: chapter,
                verse: verse,
                wordPosition: wordPosition,
                kjvWord: kjvWord,
                strongNumber: strongNumber,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int bookId,
                required int chapter,
                required int verse,
                required int wordPosition,
                required String kjvWord,
                required String strongNumber,
              }) => VerseStrongMappingsCompanion.insert(
                id: id,
                bookId: bookId,
                chapter: chapter,
                verse: verse,
                wordPosition: wordPosition,
                kjvWord: kjvWord,
                strongNumber: strongNumber,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VerseStrongMappingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VerseStrongMappingsTable,
      VerseStrongMapping,
      $$VerseStrongMappingsTableFilterComposer,
      $$VerseStrongMappingsTableOrderingComposer,
      $$VerseStrongMappingsTableAnnotationComposer,
      $$VerseStrongMappingsTableCreateCompanionBuilder,
      $$VerseStrongMappingsTableUpdateCompanionBuilder,
      (
        VerseStrongMapping,
        BaseReferences<
          _$AppDatabase,
          $VerseStrongMappingsTable,
          VerseStrongMapping
        >,
      ),
      VerseStrongMapping,
      PrefetchHooks Function()
    >;
typedef $$GrammarRulesTableCreateCompanionBuilder =
    GrammarRulesCompanion Function({
      Value<int> id,
      required String ruleType,
      required String pattern,
      required String label,
      Value<String> description,
      Value<int> priority,
    });
typedef $$GrammarRulesTableUpdateCompanionBuilder =
    GrammarRulesCompanion Function({
      Value<int> id,
      Value<String> ruleType,
      Value<String> pattern,
      Value<String> label,
      Value<String> description,
      Value<int> priority,
    });

class $$GrammarRulesTableFilterComposer
    extends Composer<_$AppDatabase, $GrammarRulesTable> {
  $$GrammarRulesTableFilterComposer({
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

  ColumnFilters<String> get ruleType => $composableBuilder(
    column: $table.ruleType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pattern => $composableBuilder(
    column: $table.pattern,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GrammarRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $GrammarRulesTable> {
  $$GrammarRulesTableOrderingComposer({
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

  ColumnOrderings<String> get ruleType => $composableBuilder(
    column: $table.ruleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pattern => $composableBuilder(
    column: $table.pattern,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GrammarRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GrammarRulesTable> {
  $$GrammarRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ruleType =>
      $composableBuilder(column: $table.ruleType, builder: (column) => column);

  GeneratedColumn<String> get pattern =>
      $composableBuilder(column: $table.pattern, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);
}

class $$GrammarRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GrammarRulesTable,
          GrammarRule,
          $$GrammarRulesTableFilterComposer,
          $$GrammarRulesTableOrderingComposer,
          $$GrammarRulesTableAnnotationComposer,
          $$GrammarRulesTableCreateCompanionBuilder,
          $$GrammarRulesTableUpdateCompanionBuilder,
          (
            GrammarRule,
            BaseReferences<_$AppDatabase, $GrammarRulesTable, GrammarRule>,
          ),
          GrammarRule,
          PrefetchHooks Function()
        > {
  $$GrammarRulesTableTableManager(_$AppDatabase db, $GrammarRulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$GrammarRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$GrammarRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$GrammarRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> ruleType = const Value.absent(),
                Value<String> pattern = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> priority = const Value.absent(),
              }) => GrammarRulesCompanion(
                id: id,
                ruleType: ruleType,
                pattern: pattern,
                label: label,
                description: description,
                priority: priority,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String ruleType,
                required String pattern,
                required String label,
                Value<String> description = const Value.absent(),
                Value<int> priority = const Value.absent(),
              }) => GrammarRulesCompanion.insert(
                id: id,
                ruleType: ruleType,
                pattern: pattern,
                label: label,
                description: description,
                priority: priority,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GrammarRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GrammarRulesTable,
      GrammarRule,
      $$GrammarRulesTableFilterComposer,
      $$GrammarRulesTableOrderingComposer,
      $$GrammarRulesTableAnnotationComposer,
      $$GrammarRulesTableCreateCompanionBuilder,
      $$GrammarRulesTableUpdateCompanionBuilder,
      (
        GrammarRule,
        BaseReferences<_$AppDatabase, $GrammarRulesTable, GrammarRule>,
      ),
      GrammarRule,
      PrefetchHooks Function()
    >;
typedef $$PosLookupTableCreateCompanionBuilder =
    PosLookupCompanion Function({
      Value<int> id,
      required String word,
      required String wordNormalized,
      required String primaryPos,
      Value<String> allPos,
    });
typedef $$PosLookupTableUpdateCompanionBuilder =
    PosLookupCompanion Function({
      Value<int> id,
      Value<String> word,
      Value<String> wordNormalized,
      Value<String> primaryPos,
      Value<String> allPos,
    });

class $$PosLookupTableFilterComposer
    extends Composer<_$AppDatabase, $PosLookupTable> {
  $$PosLookupTableFilterComposer({
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

  ColumnFilters<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wordNormalized => $composableBuilder(
    column: $table.wordNormalized,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryPos => $composableBuilder(
    column: $table.primaryPos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get allPos => $composableBuilder(
    column: $table.allPos,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PosLookupTableOrderingComposer
    extends Composer<_$AppDatabase, $PosLookupTable> {
  $$PosLookupTableOrderingComposer({
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

  ColumnOrderings<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wordNormalized => $composableBuilder(
    column: $table.wordNormalized,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryPos => $composableBuilder(
    column: $table.primaryPos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get allPos => $composableBuilder(
    column: $table.allPos,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PosLookupTableAnnotationComposer
    extends Composer<_$AppDatabase, $PosLookupTable> {
  $$PosLookupTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<String> get wordNormalized => $composableBuilder(
    column: $table.wordNormalized,
    builder: (column) => column,
  );

  GeneratedColumn<String> get primaryPos => $composableBuilder(
    column: $table.primaryPos,
    builder: (column) => column,
  );

  GeneratedColumn<String> get allPos =>
      $composableBuilder(column: $table.allPos, builder: (column) => column);
}

class $$PosLookupTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PosLookupTable,
          PosLookupData,
          $$PosLookupTableFilterComposer,
          $$PosLookupTableOrderingComposer,
          $$PosLookupTableAnnotationComposer,
          $$PosLookupTableCreateCompanionBuilder,
          $$PosLookupTableUpdateCompanionBuilder,
          (
            PosLookupData,
            BaseReferences<_$AppDatabase, $PosLookupTable, PosLookupData>,
          ),
          PosLookupData,
          PrefetchHooks Function()
        > {
  $$PosLookupTableTableManager(_$AppDatabase db, $PosLookupTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$PosLookupTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$PosLookupTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$PosLookupTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> word = const Value.absent(),
                Value<String> wordNormalized = const Value.absent(),
                Value<String> primaryPos = const Value.absent(),
                Value<String> allPos = const Value.absent(),
              }) => PosLookupCompanion(
                id: id,
                word: word,
                wordNormalized: wordNormalized,
                primaryPos: primaryPos,
                allPos: allPos,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String word,
                required String wordNormalized,
                required String primaryPos,
                Value<String> allPos = const Value.absent(),
              }) => PosLookupCompanion.insert(
                id: id,
                word: word,
                wordNormalized: wordNormalized,
                primaryPos: primaryPos,
                allPos: allPos,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PosLookupTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PosLookupTable,
      PosLookupData,
      $$PosLookupTableFilterComposer,
      $$PosLookupTableOrderingComposer,
      $$PosLookupTableAnnotationComposer,
      $$PosLookupTableCreateCompanionBuilder,
      $$PosLookupTableUpdateCompanionBuilder,
      (
        PosLookupData,
        BaseReferences<_$AppDatabase, $PosLookupTable, PosLookupData>,
      ),
      PosLookupData,
      PrefetchHooks Function()
    >;
typedef $$BookmarksTableCreateCompanionBuilder =
    BookmarksCompanion Function({
      Value<int> id,
      required String translationCode,
      required int bookId,
      required int chapter,
      required int verse,
      Value<String> note,
      required DateTime createdAt,
      Value<String?> serverId,
      Value<bool> syncPending,
    });
typedef $$BookmarksTableUpdateCompanionBuilder =
    BookmarksCompanion Function({
      Value<int> id,
      Value<String> translationCode,
      Value<int> bookId,
      Value<int> chapter,
      Value<int> verse,
      Value<String> note,
      Value<DateTime> createdAt,
      Value<String?> serverId,
      Value<bool> syncPending,
    });

class $$BookmarksTableFilterComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableFilterComposer({
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

  ColumnFilters<String> get translationCode => $composableBuilder(
    column: $table.translationCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get verse => $composableBuilder(
    column: $table.verse,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get syncPending => $composableBuilder(
    column: $table.syncPending,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BookmarksTableOrderingComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableOrderingComposer({
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

  ColumnOrderings<String> get translationCode => $composableBuilder(
    column: $table.translationCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get verse => $composableBuilder(
    column: $table.verse,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get syncPending => $composableBuilder(
    column: $table.syncPending,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BookmarksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get translationCode => $composableBuilder(
    column: $table.translationCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bookId =>
      $composableBuilder(column: $table.bookId, builder: (column) => column);

  GeneratedColumn<int> get chapter =>
      $composableBuilder(column: $table.chapter, builder: (column) => column);

  GeneratedColumn<int> get verse =>
      $composableBuilder(column: $table.verse, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<bool> get syncPending => $composableBuilder(
    column: $table.syncPending,
    builder: (column) => column,
  );
}

class $$BookmarksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookmarksTable,
          Bookmark,
          $$BookmarksTableFilterComposer,
          $$BookmarksTableOrderingComposer,
          $$BookmarksTableAnnotationComposer,
          $$BookmarksTableCreateCompanionBuilder,
          $$BookmarksTableUpdateCompanionBuilder,
          (Bookmark, BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark>),
          Bookmark,
          PrefetchHooks Function()
        > {
  $$BookmarksTableTableManager(_$AppDatabase db, $BookmarksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$BookmarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$BookmarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$BookmarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> translationCode = const Value.absent(),
                Value<int> bookId = const Value.absent(),
                Value<int> chapter = const Value.absent(),
                Value<int> verse = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<bool> syncPending = const Value.absent(),
              }) => BookmarksCompanion(
                id: id,
                translationCode: translationCode,
                bookId: bookId,
                chapter: chapter,
                verse: verse,
                note: note,
                createdAt: createdAt,
                serverId: serverId,
                syncPending: syncPending,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String translationCode,
                required int bookId,
                required int chapter,
                required int verse,
                Value<String> note = const Value.absent(),
                required DateTime createdAt,
                Value<String?> serverId = const Value.absent(),
                Value<bool> syncPending = const Value.absent(),
              }) => BookmarksCompanion.insert(
                id: id,
                translationCode: translationCode,
                bookId: bookId,
                chapter: chapter,
                verse: verse,
                note: note,
                createdAt: createdAt,
                serverId: serverId,
                syncPending: syncPending,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BookmarksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookmarksTable,
      Bookmark,
      $$BookmarksTableFilterComposer,
      $$BookmarksTableOrderingComposer,
      $$BookmarksTableAnnotationComposer,
      $$BookmarksTableCreateCompanionBuilder,
      $$BookmarksTableUpdateCompanionBuilder,
      (Bookmark, BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark>),
      Bookmark,
      PrefetchHooks Function()
    >;
typedef $$MemosTableCreateCompanionBuilder =
    MemosCompanion Function({
      Value<int> id,
      required int bookId,
      required int chapter,
      required int verse,
      required String content,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<String?> serverId,
      Value<bool> syncPending,
    });
typedef $$MemosTableUpdateCompanionBuilder =
    MemosCompanion Function({
      Value<int> id,
      Value<int> bookId,
      Value<int> chapter,
      Value<int> verse,
      Value<String> content,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> serverId,
      Value<bool> syncPending,
    });

class $$MemosTableFilterComposer extends Composer<_$AppDatabase, $MemosTable> {
  $$MemosTableFilterComposer({
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

  ColumnFilters<int> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get verse => $composableBuilder(
    column: $table.verse,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get syncPending => $composableBuilder(
    column: $table.syncPending,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MemosTableOrderingComposer
    extends Composer<_$AppDatabase, $MemosTable> {
  $$MemosTableOrderingComposer({
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

  ColumnOrderings<int> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get verse => $composableBuilder(
    column: $table.verse,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get syncPending => $composableBuilder(
    column: $table.syncPending,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MemosTableAnnotationComposer
    extends Composer<_$AppDatabase, $MemosTable> {
  $$MemosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get bookId =>
      $composableBuilder(column: $table.bookId, builder: (column) => column);

  GeneratedColumn<int> get chapter =>
      $composableBuilder(column: $table.chapter, builder: (column) => column);

  GeneratedColumn<int> get verse =>
      $composableBuilder(column: $table.verse, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<bool> get syncPending => $composableBuilder(
    column: $table.syncPending,
    builder: (column) => column,
  );
}

class $$MemosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MemosTable,
          Memo,
          $$MemosTableFilterComposer,
          $$MemosTableOrderingComposer,
          $$MemosTableAnnotationComposer,
          $$MemosTableCreateCompanionBuilder,
          $$MemosTableUpdateCompanionBuilder,
          (Memo, BaseReferences<_$AppDatabase, $MemosTable, Memo>),
          Memo,
          PrefetchHooks Function()
        > {
  $$MemosTableTableManager(_$AppDatabase db, $MemosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$MemosTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$MemosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$MemosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> bookId = const Value.absent(),
                Value<int> chapter = const Value.absent(),
                Value<int> verse = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<bool> syncPending = const Value.absent(),
              }) => MemosCompanion(
                id: id,
                bookId: bookId,
                chapter: chapter,
                verse: verse,
                content: content,
                createdAt: createdAt,
                updatedAt: updatedAt,
                serverId: serverId,
                syncPending: syncPending,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int bookId,
                required int chapter,
                required int verse,
                required String content,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<String?> serverId = const Value.absent(),
                Value<bool> syncPending = const Value.absent(),
              }) => MemosCompanion.insert(
                id: id,
                bookId: bookId,
                chapter: chapter,
                verse: verse,
                content: content,
                createdAt: createdAt,
                updatedAt: updatedAt,
                serverId: serverId,
                syncPending: syncPending,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MemosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MemosTable,
      Memo,
      $$MemosTableFilterComposer,
      $$MemosTableOrderingComposer,
      $$MemosTableAnnotationComposer,
      $$MemosTableCreateCompanionBuilder,
      $$MemosTableUpdateCompanionBuilder,
      (Memo, BaseReferences<_$AppDatabase, $MemosTable, Memo>),
      Memo,
      PrefetchHooks Function()
    >;
typedef $$HighlightsTableCreateCompanionBuilder =
    HighlightsCompanion Function({
      Value<int> id,
      required int bookId,
      required int chapter,
      required int verse,
      required String translationCode,
      required int wordStart,
      required int wordEnd,
      required String color,
      required DateTime createdAt,
    });
typedef $$HighlightsTableUpdateCompanionBuilder =
    HighlightsCompanion Function({
      Value<int> id,
      Value<int> bookId,
      Value<int> chapter,
      Value<int> verse,
      Value<String> translationCode,
      Value<int> wordStart,
      Value<int> wordEnd,
      Value<String> color,
      Value<DateTime> createdAt,
    });

class $$HighlightsTableFilterComposer
    extends Composer<_$AppDatabase, $HighlightsTable> {
  $$HighlightsTableFilterComposer({
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

  ColumnFilters<int> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get verse => $composableBuilder(
    column: $table.verse,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translationCode => $composableBuilder(
    column: $table.translationCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wordStart => $composableBuilder(
    column: $table.wordStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wordEnd => $composableBuilder(
    column: $table.wordEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HighlightsTableOrderingComposer
    extends Composer<_$AppDatabase, $HighlightsTable> {
  $$HighlightsTableOrderingComposer({
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

  ColumnOrderings<int> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get verse => $composableBuilder(
    column: $table.verse,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translationCode => $composableBuilder(
    column: $table.translationCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wordStart => $composableBuilder(
    column: $table.wordStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wordEnd => $composableBuilder(
    column: $table.wordEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HighlightsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HighlightsTable> {
  $$HighlightsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get bookId =>
      $composableBuilder(column: $table.bookId, builder: (column) => column);

  GeneratedColumn<int> get chapter =>
      $composableBuilder(column: $table.chapter, builder: (column) => column);

  GeneratedColumn<int> get verse =>
      $composableBuilder(column: $table.verse, builder: (column) => column);

  GeneratedColumn<String> get translationCode => $composableBuilder(
    column: $table.translationCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get wordStart =>
      $composableBuilder(column: $table.wordStart, builder: (column) => column);

  GeneratedColumn<int> get wordEnd =>
      $composableBuilder(column: $table.wordEnd, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$HighlightsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HighlightsTable,
          Highlight,
          $$HighlightsTableFilterComposer,
          $$HighlightsTableOrderingComposer,
          $$HighlightsTableAnnotationComposer,
          $$HighlightsTableCreateCompanionBuilder,
          $$HighlightsTableUpdateCompanionBuilder,
          (
            Highlight,
            BaseReferences<_$AppDatabase, $HighlightsTable, Highlight>,
          ),
          Highlight,
          PrefetchHooks Function()
        > {
  $$HighlightsTableTableManager(_$AppDatabase db, $HighlightsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$HighlightsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$HighlightsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$HighlightsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> bookId = const Value.absent(),
                Value<int> chapter = const Value.absent(),
                Value<int> verse = const Value.absent(),
                Value<String> translationCode = const Value.absent(),
                Value<int> wordStart = const Value.absent(),
                Value<int> wordEnd = const Value.absent(),
                Value<String> color = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => HighlightsCompanion(
                id: id,
                bookId: bookId,
                chapter: chapter,
                verse: verse,
                translationCode: translationCode,
                wordStart: wordStart,
                wordEnd: wordEnd,
                color: color,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int bookId,
                required int chapter,
                required int verse,
                required String translationCode,
                required int wordStart,
                required int wordEnd,
                required String color,
                required DateTime createdAt,
              }) => HighlightsCompanion.insert(
                id: id,
                bookId: bookId,
                chapter: chapter,
                verse: verse,
                translationCode: translationCode,
                wordStart: wordStart,
                wordEnd: wordEnd,
                color: color,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HighlightsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HighlightsTable,
      Highlight,
      $$HighlightsTableFilterComposer,
      $$HighlightsTableOrderingComposer,
      $$HighlightsTableAnnotationComposer,
      $$HighlightsTableCreateCompanionBuilder,
      $$HighlightsTableUpdateCompanionBuilder,
      (Highlight, BaseReferences<_$AppDatabase, $HighlightsTable, Highlight>),
      Highlight,
      PrefetchHooks Function()
    >;
typedef $$VocabularyItemsTableCreateCompanionBuilder =
    VocabularyItemsCompanion Function({
      Value<int> id,
      required String word,
      required String wordNormalized,
      required String partOfSpeech,
      required String definition,
      Value<String> bibleDefinition,
      Value<String> ipa,
      Value<int> bookId,
      Value<int> chapter,
      Value<int> verse,
      Value<String> translationCode,
      Value<String> note,
      Value<int> masteryLevel,
      Value<int> reviewCount,
      Value<int> correctCount,
      Value<int> repetitions,
      Value<double> easeFactor,
      Value<int> intervalDays,
      required DateTime addedAt,
      Value<DateTime?> nextReviewAt,
      Value<DateTime?> lastReviewedAt,
      Value<bool> isLearned,
      Value<bool> isFavorite,
    });
typedef $$VocabularyItemsTableUpdateCompanionBuilder =
    VocabularyItemsCompanion Function({
      Value<int> id,
      Value<String> word,
      Value<String> wordNormalized,
      Value<String> partOfSpeech,
      Value<String> definition,
      Value<String> bibleDefinition,
      Value<String> ipa,
      Value<int> bookId,
      Value<int> chapter,
      Value<int> verse,
      Value<String> translationCode,
      Value<String> note,
      Value<int> masteryLevel,
      Value<int> reviewCount,
      Value<int> correctCount,
      Value<int> repetitions,
      Value<double> easeFactor,
      Value<int> intervalDays,
      Value<DateTime> addedAt,
      Value<DateTime?> nextReviewAt,
      Value<DateTime?> lastReviewedAt,
      Value<bool> isLearned,
      Value<bool> isFavorite,
    });

final class $$VocabularyItemsTableReferences
    extends
        BaseReferences<_$AppDatabase, $VocabularyItemsTable, VocabularyItem> {
  $$VocabularyItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ReviewAnswersTable, List<ReviewAnswer>>
  _reviewAnswersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reviewAnswers,
    aliasName: $_aliasNameGenerator(
      db.vocabularyItems.id,
      db.reviewAnswers.vocabularyId,
    ),
  );

  $$ReviewAnswersTableProcessedTableManager get reviewAnswersRefs {
    final manager = $$ReviewAnswersTableTableManager(
      $_db,
      $_db.reviewAnswers,
    ).filter((f) => f.vocabularyId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_reviewAnswersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VocabularyItemsTableFilterComposer
    extends Composer<_$AppDatabase, $VocabularyItemsTable> {
  $$VocabularyItemsTableFilterComposer({
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

  ColumnFilters<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wordNormalized => $composableBuilder(
    column: $table.wordNormalized,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bibleDefinition => $composableBuilder(
    column: $table.bibleDefinition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ipa => $composableBuilder(
    column: $table.ipa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get verse => $composableBuilder(
    column: $table.verse,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translationCode => $composableBuilder(
    column: $table.translationCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get masteryLevel => $composableBuilder(
    column: $table.masteryLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get easeFactor => $composableBuilder(
    column: $table.easeFactor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isLearned => $composableBuilder(
    column: $table.isLearned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> reviewAnswersRefs(
    Expression<bool> Function($$ReviewAnswersTableFilterComposer f) f,
  ) {
    final $$ReviewAnswersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewAnswers,
      getReferencedColumn: (t) => t.vocabularyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewAnswersTableFilterComposer(
            $db: $db,
            $table: $db.reviewAnswers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VocabularyItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $VocabularyItemsTable> {
  $$VocabularyItemsTableOrderingComposer({
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

  ColumnOrderings<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wordNormalized => $composableBuilder(
    column: $table.wordNormalized,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bibleDefinition => $composableBuilder(
    column: $table.bibleDefinition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ipa => $composableBuilder(
    column: $table.ipa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get verse => $composableBuilder(
    column: $table.verse,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translationCode => $composableBuilder(
    column: $table.translationCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get masteryLevel => $composableBuilder(
    column: $table.masteryLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get easeFactor => $composableBuilder(
    column: $table.easeFactor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isLearned => $composableBuilder(
    column: $table.isLearned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VocabularyItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VocabularyItemsTable> {
  $$VocabularyItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<String> get wordNormalized => $composableBuilder(
    column: $table.wordNormalized,
    builder: (column) => column,
  );

  GeneratedColumn<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => column,
  );

  GeneratedColumn<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bibleDefinition => $composableBuilder(
    column: $table.bibleDefinition,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ipa =>
      $composableBuilder(column: $table.ipa, builder: (column) => column);

  GeneratedColumn<int> get bookId =>
      $composableBuilder(column: $table.bookId, builder: (column) => column);

  GeneratedColumn<int> get chapter =>
      $composableBuilder(column: $table.chapter, builder: (column) => column);

  GeneratedColumn<int> get verse =>
      $composableBuilder(column: $table.verse, builder: (column) => column);

  GeneratedColumn<String> get translationCode => $composableBuilder(
    column: $table.translationCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get masteryLevel => $composableBuilder(
    column: $table.masteryLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => column,
  );

  GeneratedColumn<double> get easeFactor => $composableBuilder(
    column: $table.easeFactor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isLearned =>
      $composableBuilder(column: $table.isLearned, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  Expression<T> reviewAnswersRefs<T extends Object>(
    Expression<T> Function($$ReviewAnswersTableAnnotationComposer a) f,
  ) {
    final $$ReviewAnswersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewAnswers,
      getReferencedColumn: (t) => t.vocabularyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewAnswersTableAnnotationComposer(
            $db: $db,
            $table: $db.reviewAnswers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VocabularyItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VocabularyItemsTable,
          VocabularyItem,
          $$VocabularyItemsTableFilterComposer,
          $$VocabularyItemsTableOrderingComposer,
          $$VocabularyItemsTableAnnotationComposer,
          $$VocabularyItemsTableCreateCompanionBuilder,
          $$VocabularyItemsTableUpdateCompanionBuilder,
          (VocabularyItem, $$VocabularyItemsTableReferences),
          VocabularyItem,
          PrefetchHooks Function({bool reviewAnswersRefs})
        > {
  $$VocabularyItemsTableTableManager(
    _$AppDatabase db,
    $VocabularyItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$VocabularyItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$VocabularyItemsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$VocabularyItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> word = const Value.absent(),
                Value<String> wordNormalized = const Value.absent(),
                Value<String> partOfSpeech = const Value.absent(),
                Value<String> definition = const Value.absent(),
                Value<String> bibleDefinition = const Value.absent(),
                Value<String> ipa = const Value.absent(),
                Value<int> bookId = const Value.absent(),
                Value<int> chapter = const Value.absent(),
                Value<int> verse = const Value.absent(),
                Value<String> translationCode = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<int> masteryLevel = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                Value<int> correctCount = const Value.absent(),
                Value<int> repetitions = const Value.absent(),
                Value<double> easeFactor = const Value.absent(),
                Value<int> intervalDays = const Value.absent(),
                Value<DateTime> addedAt = const Value.absent(),
                Value<DateTime?> nextReviewAt = const Value.absent(),
                Value<DateTime?> lastReviewedAt = const Value.absent(),
                Value<bool> isLearned = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
              }) => VocabularyItemsCompanion(
                id: id,
                word: word,
                wordNormalized: wordNormalized,
                partOfSpeech: partOfSpeech,
                definition: definition,
                bibleDefinition: bibleDefinition,
                ipa: ipa,
                bookId: bookId,
                chapter: chapter,
                verse: verse,
                translationCode: translationCode,
                note: note,
                masteryLevel: masteryLevel,
                reviewCount: reviewCount,
                correctCount: correctCount,
                repetitions: repetitions,
                easeFactor: easeFactor,
                intervalDays: intervalDays,
                addedAt: addedAt,
                nextReviewAt: nextReviewAt,
                lastReviewedAt: lastReviewedAt,
                isLearned: isLearned,
                isFavorite: isFavorite,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String word,
                required String wordNormalized,
                required String partOfSpeech,
                required String definition,
                Value<String> bibleDefinition = const Value.absent(),
                Value<String> ipa = const Value.absent(),
                Value<int> bookId = const Value.absent(),
                Value<int> chapter = const Value.absent(),
                Value<int> verse = const Value.absent(),
                Value<String> translationCode = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<int> masteryLevel = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                Value<int> correctCount = const Value.absent(),
                Value<int> repetitions = const Value.absent(),
                Value<double> easeFactor = const Value.absent(),
                Value<int> intervalDays = const Value.absent(),
                required DateTime addedAt,
                Value<DateTime?> nextReviewAt = const Value.absent(),
                Value<DateTime?> lastReviewedAt = const Value.absent(),
                Value<bool> isLearned = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
              }) => VocabularyItemsCompanion.insert(
                id: id,
                word: word,
                wordNormalized: wordNormalized,
                partOfSpeech: partOfSpeech,
                definition: definition,
                bibleDefinition: bibleDefinition,
                ipa: ipa,
                bookId: bookId,
                chapter: chapter,
                verse: verse,
                translationCode: translationCode,
                note: note,
                masteryLevel: masteryLevel,
                reviewCount: reviewCount,
                correctCount: correctCount,
                repetitions: repetitions,
                easeFactor: easeFactor,
                intervalDays: intervalDays,
                addedAt: addedAt,
                nextReviewAt: nextReviewAt,
                lastReviewedAt: lastReviewedAt,
                isLearned: isLearned,
                isFavorite: isFavorite,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$VocabularyItemsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({reviewAnswersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (reviewAnswersRefs) db.reviewAnswers,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (reviewAnswersRefs)
                    await $_getPrefetchedData<
                      VocabularyItem,
                      $VocabularyItemsTable,
                      ReviewAnswer
                    >(
                      currentTable: table,
                      referencedTable: $$VocabularyItemsTableReferences
                          ._reviewAnswersRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$VocabularyItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).reviewAnswersRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.vocabularyId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$VocabularyItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VocabularyItemsTable,
      VocabularyItem,
      $$VocabularyItemsTableFilterComposer,
      $$VocabularyItemsTableOrderingComposer,
      $$VocabularyItemsTableAnnotationComposer,
      $$VocabularyItemsTableCreateCompanionBuilder,
      $$VocabularyItemsTableUpdateCompanionBuilder,
      (VocabularyItem, $$VocabularyItemsTableReferences),
      VocabularyItem,
      PrefetchHooks Function({bool reviewAnswersRefs})
    >;
typedef $$ReviewSessionsTableCreateCompanionBuilder =
    ReviewSessionsCompanion Function({
      Value<int> id,
      required DateTime startedAt,
      Value<DateTime?> completedAt,
      required int totalCount,
      Value<int> correctCount,
      required String sessionType,
    });
typedef $$ReviewSessionsTableUpdateCompanionBuilder =
    ReviewSessionsCompanion Function({
      Value<int> id,
      Value<DateTime> startedAt,
      Value<DateTime?> completedAt,
      Value<int> totalCount,
      Value<int> correctCount,
      Value<String> sessionType,
    });

final class $$ReviewSessionsTableReferences
    extends BaseReferences<_$AppDatabase, $ReviewSessionsTable, ReviewSession> {
  $$ReviewSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ReviewAnswersTable, List<ReviewAnswer>>
  _reviewAnswersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reviewAnswers,
    aliasName: $_aliasNameGenerator(
      db.reviewSessions.id,
      db.reviewAnswers.sessionId,
    ),
  );

  $$ReviewAnswersTableProcessedTableManager get reviewAnswersRefs {
    final manager = $$ReviewAnswersTableTableManager(
      $_db,
      $_db.reviewAnswers,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_reviewAnswersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ReviewSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewSessionsTable> {
  $$ReviewSessionsTableFilterComposer({
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

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCount => $composableBuilder(
    column: $table.totalCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionType => $composableBuilder(
    column: $table.sessionType,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> reviewAnswersRefs(
    Expression<bool> Function($$ReviewAnswersTableFilterComposer f) f,
  ) {
    final $$ReviewAnswersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewAnswers,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewAnswersTableFilterComposer(
            $db: $db,
            $table: $db.reviewAnswers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ReviewSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewSessionsTable> {
  $$ReviewSessionsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCount => $composableBuilder(
    column: $table.totalCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionType => $composableBuilder(
    column: $table.sessionType,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReviewSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewSessionsTable> {
  $$ReviewSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalCount => $composableBuilder(
    column: $table.totalCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sessionType => $composableBuilder(
    column: $table.sessionType,
    builder: (column) => column,
  );

  Expression<T> reviewAnswersRefs<T extends Object>(
    Expression<T> Function($$ReviewAnswersTableAnnotationComposer a) f,
  ) {
    final $$ReviewAnswersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewAnswers,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewAnswersTableAnnotationComposer(
            $db: $db,
            $table: $db.reviewAnswers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ReviewSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReviewSessionsTable,
          ReviewSession,
          $$ReviewSessionsTableFilterComposer,
          $$ReviewSessionsTableOrderingComposer,
          $$ReviewSessionsTableAnnotationComposer,
          $$ReviewSessionsTableCreateCompanionBuilder,
          $$ReviewSessionsTableUpdateCompanionBuilder,
          (ReviewSession, $$ReviewSessionsTableReferences),
          ReviewSession,
          PrefetchHooks Function({bool reviewAnswersRefs})
        > {
  $$ReviewSessionsTableTableManager(
    _$AppDatabase db,
    $ReviewSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ReviewSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$ReviewSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$ReviewSessionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> totalCount = const Value.absent(),
                Value<int> correctCount = const Value.absent(),
                Value<String> sessionType = const Value.absent(),
              }) => ReviewSessionsCompanion(
                id: id,
                startedAt: startedAt,
                completedAt: completedAt,
                totalCount: totalCount,
                correctCount: correctCount,
                sessionType: sessionType,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime startedAt,
                Value<DateTime?> completedAt = const Value.absent(),
                required int totalCount,
                Value<int> correctCount = const Value.absent(),
                required String sessionType,
              }) => ReviewSessionsCompanion.insert(
                id: id,
                startedAt: startedAt,
                completedAt: completedAt,
                totalCount: totalCount,
                correctCount: correctCount,
                sessionType: sessionType,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$ReviewSessionsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({reviewAnswersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (reviewAnswersRefs) db.reviewAnswers,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (reviewAnswersRefs)
                    await $_getPrefetchedData<
                      ReviewSession,
                      $ReviewSessionsTable,
                      ReviewAnswer
                    >(
                      currentTable: table,
                      referencedTable: $$ReviewSessionsTableReferences
                          ._reviewAnswersRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$ReviewSessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).reviewAnswersRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.sessionId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ReviewSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReviewSessionsTable,
      ReviewSession,
      $$ReviewSessionsTableFilterComposer,
      $$ReviewSessionsTableOrderingComposer,
      $$ReviewSessionsTableAnnotationComposer,
      $$ReviewSessionsTableCreateCompanionBuilder,
      $$ReviewSessionsTableUpdateCompanionBuilder,
      (ReviewSession, $$ReviewSessionsTableReferences),
      ReviewSession,
      PrefetchHooks Function({bool reviewAnswersRefs})
    >;
typedef $$ReviewAnswersTableCreateCompanionBuilder =
    ReviewAnswersCompanion Function({
      Value<int> id,
      required int sessionId,
      required int vocabularyId,
      required bool isCorrect,
      required int responseTimeMs,
      required DateTime answeredAt,
    });
typedef $$ReviewAnswersTableUpdateCompanionBuilder =
    ReviewAnswersCompanion Function({
      Value<int> id,
      Value<int> sessionId,
      Value<int> vocabularyId,
      Value<bool> isCorrect,
      Value<int> responseTimeMs,
      Value<DateTime> answeredAt,
    });

final class $$ReviewAnswersTableReferences
    extends BaseReferences<_$AppDatabase, $ReviewAnswersTable, ReviewAnswer> {
  $$ReviewAnswersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ReviewSessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.reviewSessions.createAlias(
        $_aliasNameGenerator(db.reviewAnswers.sessionId, db.reviewSessions.id),
      );

  $$ReviewSessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<int>('session_id')!;

    final manager = $$ReviewSessionsTableTableManager(
      $_db,
      $_db.reviewSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $VocabularyItemsTable _vocabularyIdTable(_$AppDatabase db) =>
      db.vocabularyItems.createAlias(
        $_aliasNameGenerator(
          db.reviewAnswers.vocabularyId,
          db.vocabularyItems.id,
        ),
      );

  $$VocabularyItemsTableProcessedTableManager get vocabularyId {
    final $_column = $_itemColumn<int>('vocabulary_id')!;

    final manager = $$VocabularyItemsTableTableManager(
      $_db,
      $_db.vocabularyItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vocabularyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReviewAnswersTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewAnswersTable> {
  $$ReviewAnswersTableFilterComposer({
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

  ColumnFilters<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get responseTimeMs => $composableBuilder(
    column: $table.responseTimeMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get answeredAt => $composableBuilder(
    column: $table.answeredAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ReviewSessionsTableFilterComposer get sessionId {
    final $$ReviewSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.reviewSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewSessionsTableFilterComposer(
            $db: $db,
            $table: $db.reviewSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VocabularyItemsTableFilterComposer get vocabularyId {
    final $$VocabularyItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vocabularyId,
      referencedTable: $db.vocabularyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyItemsTableFilterComposer(
            $db: $db,
            $table: $db.vocabularyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewAnswersTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewAnswersTable> {
  $$ReviewAnswersTableOrderingComposer({
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

  ColumnOrderings<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get responseTimeMs => $composableBuilder(
    column: $table.responseTimeMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get answeredAt => $composableBuilder(
    column: $table.answeredAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ReviewSessionsTableOrderingComposer get sessionId {
    final $$ReviewSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.reviewSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.reviewSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VocabularyItemsTableOrderingComposer get vocabularyId {
    final $$VocabularyItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vocabularyId,
      referencedTable: $db.vocabularyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyItemsTableOrderingComposer(
            $db: $db,
            $table: $db.vocabularyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewAnswersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewAnswersTable> {
  $$ReviewAnswersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isCorrect =>
      $composableBuilder(column: $table.isCorrect, builder: (column) => column);

  GeneratedColumn<int> get responseTimeMs => $composableBuilder(
    column: $table.responseTimeMs,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get answeredAt => $composableBuilder(
    column: $table.answeredAt,
    builder: (column) => column,
  );

  $$ReviewSessionsTableAnnotationComposer get sessionId {
    final $$ReviewSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.reviewSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.reviewSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VocabularyItemsTableAnnotationComposer get vocabularyId {
    final $$VocabularyItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vocabularyId,
      referencedTable: $db.vocabularyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.vocabularyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewAnswersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReviewAnswersTable,
          ReviewAnswer,
          $$ReviewAnswersTableFilterComposer,
          $$ReviewAnswersTableOrderingComposer,
          $$ReviewAnswersTableAnnotationComposer,
          $$ReviewAnswersTableCreateCompanionBuilder,
          $$ReviewAnswersTableUpdateCompanionBuilder,
          (ReviewAnswer, $$ReviewAnswersTableReferences),
          ReviewAnswer,
          PrefetchHooks Function({bool sessionId, bool vocabularyId})
        > {
  $$ReviewAnswersTableTableManager(_$AppDatabase db, $ReviewAnswersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ReviewAnswersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$ReviewAnswersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$ReviewAnswersTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sessionId = const Value.absent(),
                Value<int> vocabularyId = const Value.absent(),
                Value<bool> isCorrect = const Value.absent(),
                Value<int> responseTimeMs = const Value.absent(),
                Value<DateTime> answeredAt = const Value.absent(),
              }) => ReviewAnswersCompanion(
                id: id,
                sessionId: sessionId,
                vocabularyId: vocabularyId,
                isCorrect: isCorrect,
                responseTimeMs: responseTimeMs,
                answeredAt: answeredAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int sessionId,
                required int vocabularyId,
                required bool isCorrect,
                required int responseTimeMs,
                required DateTime answeredAt,
              }) => ReviewAnswersCompanion.insert(
                id: id,
                sessionId: sessionId,
                vocabularyId: vocabularyId,
                isCorrect: isCorrect,
                responseTimeMs: responseTimeMs,
                answeredAt: answeredAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$ReviewAnswersTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({sessionId = false, vocabularyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                if (sessionId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.sessionId,
                            referencedTable: $$ReviewAnswersTableReferences
                                ._sessionIdTable(db),
                            referencedColumn:
                                $$ReviewAnswersTableReferences
                                    ._sessionIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (vocabularyId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.vocabularyId,
                            referencedTable: $$ReviewAnswersTableReferences
                                ._vocabularyIdTable(db),
                            referencedColumn:
                                $$ReviewAnswersTableReferences
                                    ._vocabularyIdTable(db)
                                    .id,
                          )
                          as T;
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

typedef $$ReviewAnswersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReviewAnswersTable,
      ReviewAnswer,
      $$ReviewAnswersTableFilterComposer,
      $$ReviewAnswersTableOrderingComposer,
      $$ReviewAnswersTableAnnotationComposer,
      $$ReviewAnswersTableCreateCompanionBuilder,
      $$ReviewAnswersTableUpdateCompanionBuilder,
      (ReviewAnswer, $$ReviewAnswersTableReferences),
      ReviewAnswer,
      PrefetchHooks Function({bool sessionId, bool vocabularyId})
    >;
typedef $$ReadingHistoryTableCreateCompanionBuilder =
    ReadingHistoryCompanion Function({
      Value<int> id,
      required int bookId,
      required int chapter,
      required String translationCode,
      required DateTime accessedAt,
      Value<int> durationSeconds,
      Value<int> lastVerseRead,
    });
typedef $$ReadingHistoryTableUpdateCompanionBuilder =
    ReadingHistoryCompanion Function({
      Value<int> id,
      Value<int> bookId,
      Value<int> chapter,
      Value<String> translationCode,
      Value<DateTime> accessedAt,
      Value<int> durationSeconds,
      Value<int> lastVerseRead,
    });

class $$ReadingHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $ReadingHistoryTable> {
  $$ReadingHistoryTableFilterComposer({
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

  ColumnFilters<int> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translationCode => $composableBuilder(
    column: $table.translationCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get accessedAt => $composableBuilder(
    column: $table.accessedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastVerseRead => $composableBuilder(
    column: $table.lastVerseRead,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReadingHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $ReadingHistoryTable> {
  $$ReadingHistoryTableOrderingComposer({
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

  ColumnOrderings<int> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translationCode => $composableBuilder(
    column: $table.translationCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get accessedAt => $composableBuilder(
    column: $table.accessedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastVerseRead => $composableBuilder(
    column: $table.lastVerseRead,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReadingHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReadingHistoryTable> {
  $$ReadingHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get bookId =>
      $composableBuilder(column: $table.bookId, builder: (column) => column);

  GeneratedColumn<int> get chapter =>
      $composableBuilder(column: $table.chapter, builder: (column) => column);

  GeneratedColumn<String> get translationCode => $composableBuilder(
    column: $table.translationCode,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get accessedAt => $composableBuilder(
    column: $table.accessedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastVerseRead => $composableBuilder(
    column: $table.lastVerseRead,
    builder: (column) => column,
  );
}

class $$ReadingHistoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReadingHistoryTable,
          ReadingHistoryData,
          $$ReadingHistoryTableFilterComposer,
          $$ReadingHistoryTableOrderingComposer,
          $$ReadingHistoryTableAnnotationComposer,
          $$ReadingHistoryTableCreateCompanionBuilder,
          $$ReadingHistoryTableUpdateCompanionBuilder,
          (
            ReadingHistoryData,
            BaseReferences<
              _$AppDatabase,
              $ReadingHistoryTable,
              ReadingHistoryData
            >,
          ),
          ReadingHistoryData,
          PrefetchHooks Function()
        > {
  $$ReadingHistoryTableTableManager(
    _$AppDatabase db,
    $ReadingHistoryTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ReadingHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$ReadingHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$ReadingHistoryTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> bookId = const Value.absent(),
                Value<int> chapter = const Value.absent(),
                Value<String> translationCode = const Value.absent(),
                Value<DateTime> accessedAt = const Value.absent(),
                Value<int> durationSeconds = const Value.absent(),
                Value<int> lastVerseRead = const Value.absent(),
              }) => ReadingHistoryCompanion(
                id: id,
                bookId: bookId,
                chapter: chapter,
                translationCode: translationCode,
                accessedAt: accessedAt,
                durationSeconds: durationSeconds,
                lastVerseRead: lastVerseRead,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int bookId,
                required int chapter,
                required String translationCode,
                required DateTime accessedAt,
                Value<int> durationSeconds = const Value.absent(),
                Value<int> lastVerseRead = const Value.absent(),
              }) => ReadingHistoryCompanion.insert(
                id: id,
                bookId: bookId,
                chapter: chapter,
                translationCode: translationCode,
                accessedAt: accessedAt,
                durationSeconds: durationSeconds,
                lastVerseRead: lastVerseRead,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReadingHistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReadingHistoryTable,
      ReadingHistoryData,
      $$ReadingHistoryTableFilterComposer,
      $$ReadingHistoryTableOrderingComposer,
      $$ReadingHistoryTableAnnotationComposer,
      $$ReadingHistoryTableCreateCompanionBuilder,
      $$ReadingHistoryTableUpdateCompanionBuilder,
      (
        ReadingHistoryData,
        BaseReferences<_$AppDatabase, $ReadingHistoryTable, ReadingHistoryData>,
      ),
      ReadingHistoryData,
      PrefetchHooks Function()
    >;
typedef $$ReadingTabsTableCreateCompanionBuilder =
    ReadingTabsCompanion Function({
      Value<int> id,
      Value<int> bookId,
      Value<int> chapter,
      Value<String> translationCode,
      Value<bool> isParallelView,
      Value<String> parallelTranslationCode,
      Value<int> scrollVerse,
      Value<double> scrollFraction,
      Value<double> scrollOffset,
      Value<int> sortOrder,
      Value<bool> isActive,
      required DateTime updatedAt,
    });
typedef $$ReadingTabsTableUpdateCompanionBuilder =
    ReadingTabsCompanion Function({
      Value<int> id,
      Value<int> bookId,
      Value<int> chapter,
      Value<String> translationCode,
      Value<bool> isParallelView,
      Value<String> parallelTranslationCode,
      Value<int> scrollVerse,
      Value<double> scrollFraction,
      Value<double> scrollOffset,
      Value<int> sortOrder,
      Value<bool> isActive,
      Value<DateTime> updatedAt,
    });

final class $$ReadingTabsTableReferences
    extends BaseReferences<_$AppDatabase, $ReadingTabsTable, ReadingTabData> {
  $$ReadingTabsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $ChapterReadingPositionsTable,
    List<ChapterReadingPositionData>
  >
  _chapterReadingPositionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.chapterReadingPositions,
        aliasName: $_aliasNameGenerator(
          db.readingTabs.id,
          db.chapterReadingPositions.readingTabId,
        ),
      );

  $$ChapterReadingPositionsTableProcessedTableManager
  get chapterReadingPositionsRefs {
    final manager = $$ChapterReadingPositionsTableTableManager(
      $_db,
      $_db.chapterReadingPositions,
    ).filter((f) => f.readingTabId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _chapterReadingPositionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ReadingTabsTableFilterComposer
    extends Composer<_$AppDatabase, $ReadingTabsTable> {
  $$ReadingTabsTableFilterComposer({
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

  ColumnFilters<int> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translationCode => $composableBuilder(
    column: $table.translationCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isParallelView => $composableBuilder(
    column: $table.isParallelView,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parallelTranslationCode => $composableBuilder(
    column: $table.parallelTranslationCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scrollVerse => $composableBuilder(
    column: $table.scrollVerse,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get scrollFraction => $composableBuilder(
    column: $table.scrollFraction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get scrollOffset => $composableBuilder(
    column: $table.scrollOffset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> chapterReadingPositionsRefs(
    Expression<bool> Function($$ChapterReadingPositionsTableFilterComposer f) f,
  ) {
    final $$ChapterReadingPositionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.chapterReadingPositions,
          getReferencedColumn: (t) => t.readingTabId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ChapterReadingPositionsTableFilterComposer(
                $db: $db,
                $table: $db.chapterReadingPositions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ReadingTabsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReadingTabsTable> {
  $$ReadingTabsTableOrderingComposer({
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

  ColumnOrderings<int> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translationCode => $composableBuilder(
    column: $table.translationCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isParallelView => $composableBuilder(
    column: $table.isParallelView,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parallelTranslationCode => $composableBuilder(
    column: $table.parallelTranslationCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scrollVerse => $composableBuilder(
    column: $table.scrollVerse,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get scrollFraction => $composableBuilder(
    column: $table.scrollFraction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get scrollOffset => $composableBuilder(
    column: $table.scrollOffset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReadingTabsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReadingTabsTable> {
  $$ReadingTabsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get bookId =>
      $composableBuilder(column: $table.bookId, builder: (column) => column);

  GeneratedColumn<int> get chapter =>
      $composableBuilder(column: $table.chapter, builder: (column) => column);

  GeneratedColumn<String> get translationCode => $composableBuilder(
    column: $table.translationCode,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isParallelView => $composableBuilder(
    column: $table.isParallelView,
    builder: (column) => column,
  );

  GeneratedColumn<String> get parallelTranslationCode => $composableBuilder(
    column: $table.parallelTranslationCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get scrollVerse => $composableBuilder(
    column: $table.scrollVerse,
    builder: (column) => column,
  );

  GeneratedColumn<double> get scrollFraction => $composableBuilder(
    column: $table.scrollFraction,
    builder: (column) => column,
  );

  GeneratedColumn<double> get scrollOffset => $composableBuilder(
    column: $table.scrollOffset,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> chapterReadingPositionsRefs<T extends Object>(
    Expression<T> Function($$ChapterReadingPositionsTableAnnotationComposer a)
    f,
  ) {
    final $$ChapterReadingPositionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.chapterReadingPositions,
          getReferencedColumn: (t) => t.readingTabId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ChapterReadingPositionsTableAnnotationComposer(
                $db: $db,
                $table: $db.chapterReadingPositions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ReadingTabsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReadingTabsTable,
          ReadingTabData,
          $$ReadingTabsTableFilterComposer,
          $$ReadingTabsTableOrderingComposer,
          $$ReadingTabsTableAnnotationComposer,
          $$ReadingTabsTableCreateCompanionBuilder,
          $$ReadingTabsTableUpdateCompanionBuilder,
          (ReadingTabData, $$ReadingTabsTableReferences),
          ReadingTabData,
          PrefetchHooks Function({bool chapterReadingPositionsRefs})
        > {
  $$ReadingTabsTableTableManager(_$AppDatabase db, $ReadingTabsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ReadingTabsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ReadingTabsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$ReadingTabsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> bookId = const Value.absent(),
                Value<int> chapter = const Value.absent(),
                Value<String> translationCode = const Value.absent(),
                Value<bool> isParallelView = const Value.absent(),
                Value<String> parallelTranslationCode = const Value.absent(),
                Value<int> scrollVerse = const Value.absent(),
                Value<double> scrollFraction = const Value.absent(),
                Value<double> scrollOffset = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ReadingTabsCompanion(
                id: id,
                bookId: bookId,
                chapter: chapter,
                translationCode: translationCode,
                isParallelView: isParallelView,
                parallelTranslationCode: parallelTranslationCode,
                scrollVerse: scrollVerse,
                scrollFraction: scrollFraction,
                scrollOffset: scrollOffset,
                sortOrder: sortOrder,
                isActive: isActive,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> bookId = const Value.absent(),
                Value<int> chapter = const Value.absent(),
                Value<String> translationCode = const Value.absent(),
                Value<bool> isParallelView = const Value.absent(),
                Value<String> parallelTranslationCode = const Value.absent(),
                Value<int> scrollVerse = const Value.absent(),
                Value<double> scrollFraction = const Value.absent(),
                Value<double> scrollOffset = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required DateTime updatedAt,
              }) => ReadingTabsCompanion.insert(
                id: id,
                bookId: bookId,
                chapter: chapter,
                translationCode: translationCode,
                isParallelView: isParallelView,
                parallelTranslationCode: parallelTranslationCode,
                scrollVerse: scrollVerse,
                scrollFraction: scrollFraction,
                scrollOffset: scrollOffset,
                sortOrder: sortOrder,
                isActive: isActive,
                updatedAt: updatedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$ReadingTabsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({chapterReadingPositionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (chapterReadingPositionsRefs) db.chapterReadingPositions,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (chapterReadingPositionsRefs)
                    await $_getPrefetchedData<
                      ReadingTabData,
                      $ReadingTabsTable,
                      ChapterReadingPositionData
                    >(
                      currentTable: table,
                      referencedTable: $$ReadingTabsTableReferences
                          ._chapterReadingPositionsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$ReadingTabsTableReferences(
                                db,
                                table,
                                p0,
                              ).chapterReadingPositionsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.readingTabId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ReadingTabsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReadingTabsTable,
      ReadingTabData,
      $$ReadingTabsTableFilterComposer,
      $$ReadingTabsTableOrderingComposer,
      $$ReadingTabsTableAnnotationComposer,
      $$ReadingTabsTableCreateCompanionBuilder,
      $$ReadingTabsTableUpdateCompanionBuilder,
      (ReadingTabData, $$ReadingTabsTableReferences),
      ReadingTabData,
      PrefetchHooks Function({bool chapterReadingPositionsRefs})
    >;
typedef $$ReadingPlansTableCreateCompanionBuilder =
    ReadingPlansCompanion Function({
      Value<int> id,
      required String name,
      Value<String> description,
      required DateTime startDate,
      required DateTime targetEndDate,
      Value<bool> isActive,
      required int totalDays,
      Value<int> completedDays,
    });
typedef $$ReadingPlansTableUpdateCompanionBuilder =
    ReadingPlansCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> description,
      Value<DateTime> startDate,
      Value<DateTime> targetEndDate,
      Value<bool> isActive,
      Value<int> totalDays,
      Value<int> completedDays,
    });

class $$ReadingPlansTableFilterComposer
    extends Composer<_$AppDatabase, $ReadingPlansTable> {
  $$ReadingPlansTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get targetEndDate => $composableBuilder(
    column: $table.targetEndDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalDays => $composableBuilder(
    column: $table.totalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completedDays => $composableBuilder(
    column: $table.completedDays,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReadingPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $ReadingPlansTable> {
  $$ReadingPlansTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get targetEndDate => $composableBuilder(
    column: $table.targetEndDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalDays => $composableBuilder(
    column: $table.totalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completedDays => $composableBuilder(
    column: $table.completedDays,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReadingPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReadingPlansTable> {
  $$ReadingPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get targetEndDate => $composableBuilder(
    column: $table.targetEndDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get totalDays =>
      $composableBuilder(column: $table.totalDays, builder: (column) => column);

  GeneratedColumn<int> get completedDays => $composableBuilder(
    column: $table.completedDays,
    builder: (column) => column,
  );
}

class $$ReadingPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReadingPlansTable,
          ReadingPlan,
          $$ReadingPlansTableFilterComposer,
          $$ReadingPlansTableOrderingComposer,
          $$ReadingPlansTableAnnotationComposer,
          $$ReadingPlansTableCreateCompanionBuilder,
          $$ReadingPlansTableUpdateCompanionBuilder,
          (
            ReadingPlan,
            BaseReferences<_$AppDatabase, $ReadingPlansTable, ReadingPlan>,
          ),
          ReadingPlan,
          PrefetchHooks Function()
        > {
  $$ReadingPlansTableTableManager(_$AppDatabase db, $ReadingPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ReadingPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ReadingPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$ReadingPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime> targetEndDate = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> totalDays = const Value.absent(),
                Value<int> completedDays = const Value.absent(),
              }) => ReadingPlansCompanion(
                id: id,
                name: name,
                description: description,
                startDate: startDate,
                targetEndDate: targetEndDate,
                isActive: isActive,
                totalDays: totalDays,
                completedDays: completedDays,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String> description = const Value.absent(),
                required DateTime startDate,
                required DateTime targetEndDate,
                Value<bool> isActive = const Value.absent(),
                required int totalDays,
                Value<int> completedDays = const Value.absent(),
              }) => ReadingPlansCompanion.insert(
                id: id,
                name: name,
                description: description,
                startDate: startDate,
                targetEndDate: targetEndDate,
                isActive: isActive,
                totalDays: totalDays,
                completedDays: completedDays,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReadingPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReadingPlansTable,
      ReadingPlan,
      $$ReadingPlansTableFilterComposer,
      $$ReadingPlansTableOrderingComposer,
      $$ReadingPlansTableAnnotationComposer,
      $$ReadingPlansTableCreateCompanionBuilder,
      $$ReadingPlansTableUpdateCompanionBuilder,
      (
        ReadingPlan,
        BaseReferences<_$AppDatabase, $ReadingPlansTable, ReadingPlan>,
      ),
      ReadingPlan,
      PrefetchHooks Function()
    >;
typedef $$ChapterReadingPositionsTableCreateCompanionBuilder =
    ChapterReadingPositionsCompanion Function({
      required int readingTabId,
      required int bookId,
      required int chapter,
      Value<int> scrollVerse,
      Value<double> scrollFraction,
      Value<double> scrollOffset,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ChapterReadingPositionsTableUpdateCompanionBuilder =
    ChapterReadingPositionsCompanion Function({
      Value<int> readingTabId,
      Value<int> bookId,
      Value<int> chapter,
      Value<int> scrollVerse,
      Value<double> scrollFraction,
      Value<double> scrollOffset,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ChapterReadingPositionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ChapterReadingPositionsTable,
          ChapterReadingPositionData
        > {
  $$ChapterReadingPositionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ReadingTabsTable _readingTabIdTable(_$AppDatabase db) =>
      db.readingTabs.createAlias(
        $_aliasNameGenerator(
          db.chapterReadingPositions.readingTabId,
          db.readingTabs.id,
        ),
      );

  $$ReadingTabsTableProcessedTableManager get readingTabId {
    final $_column = $_itemColumn<int>('reading_tab_id')!;

    final manager = $$ReadingTabsTableTableManager(
      $_db,
      $_db.readingTabs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_readingTabIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChapterReadingPositionsTableFilterComposer
    extends Composer<_$AppDatabase, $ChapterReadingPositionsTable> {
  $$ChapterReadingPositionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scrollVerse => $composableBuilder(
    column: $table.scrollVerse,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get scrollFraction => $composableBuilder(
    column: $table.scrollFraction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get scrollOffset => $composableBuilder(
    column: $table.scrollOffset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ReadingTabsTableFilterComposer get readingTabId {
    final $$ReadingTabsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.readingTabId,
      referencedTable: $db.readingTabs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReadingTabsTableFilterComposer(
            $db: $db,
            $table: $db.readingTabs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChapterReadingPositionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ChapterReadingPositionsTable> {
  $$ChapterReadingPositionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scrollVerse => $composableBuilder(
    column: $table.scrollVerse,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get scrollFraction => $composableBuilder(
    column: $table.scrollFraction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get scrollOffset => $composableBuilder(
    column: $table.scrollOffset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ReadingTabsTableOrderingComposer get readingTabId {
    final $$ReadingTabsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.readingTabId,
      referencedTable: $db.readingTabs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReadingTabsTableOrderingComposer(
            $db: $db,
            $table: $db.readingTabs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChapterReadingPositionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChapterReadingPositionsTable> {
  $$ChapterReadingPositionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get bookId =>
      $composableBuilder(column: $table.bookId, builder: (column) => column);

  GeneratedColumn<int> get chapter =>
      $composableBuilder(column: $table.chapter, builder: (column) => column);

  GeneratedColumn<int> get scrollVerse => $composableBuilder(
    column: $table.scrollVerse,
    builder: (column) => column,
  );

  GeneratedColumn<double> get scrollFraction => $composableBuilder(
    column: $table.scrollFraction,
    builder: (column) => column,
  );

  GeneratedColumn<double> get scrollOffset => $composableBuilder(
    column: $table.scrollOffset,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ReadingTabsTableAnnotationComposer get readingTabId {
    final $$ReadingTabsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.readingTabId,
      referencedTable: $db.readingTabs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReadingTabsTableAnnotationComposer(
            $db: $db,
            $table: $db.readingTabs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChapterReadingPositionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChapterReadingPositionsTable,
          ChapterReadingPositionData,
          $$ChapterReadingPositionsTableFilterComposer,
          $$ChapterReadingPositionsTableOrderingComposer,
          $$ChapterReadingPositionsTableAnnotationComposer,
          $$ChapterReadingPositionsTableCreateCompanionBuilder,
          $$ChapterReadingPositionsTableUpdateCompanionBuilder,
          (
            ChapterReadingPositionData,
            $$ChapterReadingPositionsTableReferences,
          ),
          ChapterReadingPositionData,
          PrefetchHooks Function({bool readingTabId})
        > {
  $$ChapterReadingPositionsTableTableManager(
    _$AppDatabase db,
    $ChapterReadingPositionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ChapterReadingPositionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$ChapterReadingPositionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$ChapterReadingPositionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> readingTabId = const Value.absent(),
                Value<int> bookId = const Value.absent(),
                Value<int> chapter = const Value.absent(),
                Value<int> scrollVerse = const Value.absent(),
                Value<double> scrollFraction = const Value.absent(),
                Value<double> scrollOffset = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChapterReadingPositionsCompanion(
                readingTabId: readingTabId,
                bookId: bookId,
                chapter: chapter,
                scrollVerse: scrollVerse,
                scrollFraction: scrollFraction,
                scrollOffset: scrollOffset,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int readingTabId,
                required int bookId,
                required int chapter,
                Value<int> scrollVerse = const Value.absent(),
                Value<double> scrollFraction = const Value.absent(),
                Value<double> scrollOffset = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ChapterReadingPositionsCompanion.insert(
                readingTabId: readingTabId,
                bookId: bookId,
                chapter: chapter,
                scrollVerse: scrollVerse,
                scrollFraction: scrollFraction,
                scrollOffset: scrollOffset,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$ChapterReadingPositionsTableReferences(
                            db,
                            table,
                            e,
                          ),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({readingTabId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                if (readingTabId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.readingTabId,
                            referencedTable:
                                $$ChapterReadingPositionsTableReferences
                                    ._readingTabIdTable(db),
                            referencedColumn:
                                $$ChapterReadingPositionsTableReferences
                                    ._readingTabIdTable(db)
                                    .id,
                          )
                          as T;
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

typedef $$ChapterReadingPositionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChapterReadingPositionsTable,
      ChapterReadingPositionData,
      $$ChapterReadingPositionsTableFilterComposer,
      $$ChapterReadingPositionsTableOrderingComposer,
      $$ChapterReadingPositionsTableAnnotationComposer,
      $$ChapterReadingPositionsTableCreateCompanionBuilder,
      $$ChapterReadingPositionsTableUpdateCompanionBuilder,
      (ChapterReadingPositionData, $$ChapterReadingPositionsTableReferences),
      ChapterReadingPositionData,
      PrefetchHooks Function({bool readingTabId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BibleBooksTableTableManager get bibleBooks =>
      $$BibleBooksTableTableManager(_db, _db.bibleBooks);
  $$BibleTranslationsTableTableManager get bibleTranslations =>
      $$BibleTranslationsTableTableManager(_db, _db.bibleTranslations);
  $$VerseTranslationsTableTableManager get verseTranslations =>
      $$VerseTranslationsTableTableManager(_db, _db.verseTranslations);
  $$CrossReferencesTableTableManager get crossReferences =>
      $$CrossReferencesTableTableManager(_db, _db.crossReferences);
  $$DictionaryEntriesTableTableManager get dictionaryEntries =>
      $$DictionaryEntriesTableTableManager(_db, _db.dictionaryEntries);
  $$WordSensesTableTableManager get wordSenses =>
      $$WordSensesTableTableManager(_db, _db.wordSenses);
  $$WordExamplesTableTableManager get wordExamples =>
      $$WordExamplesTableTableManager(_db, _db.wordExamples);
  $$WordFormsTableTableManager get wordForms =>
      $$WordFormsTableTableManager(_db, _db.wordForms);
  $$WordnetSynsetsTableTableManager get wordnetSynsets =>
      $$WordnetSynsetsTableTableManager(_db, _db.wordnetSynsets);
  $$WordnetLemmasTableTableManager get wordnetLemmas =>
      $$WordnetLemmasTableTableManager(_db, _db.wordnetLemmas);
  $$WordnetRelationsTableTableManager get wordnetRelations =>
      $$WordnetRelationsTableTableManager(_db, _db.wordnetRelations);
  $$StrongEntriesTableTableManager get strongEntries =>
      $$StrongEntriesTableTableManager(_db, _db.strongEntries);
  $$VerseStrongMappingsTableTableManager get verseStrongMappings =>
      $$VerseStrongMappingsTableTableManager(_db, _db.verseStrongMappings);
  $$GrammarRulesTableTableManager get grammarRules =>
      $$GrammarRulesTableTableManager(_db, _db.grammarRules);
  $$PosLookupTableTableManager get posLookup =>
      $$PosLookupTableTableManager(_db, _db.posLookup);
  $$BookmarksTableTableManager get bookmarks =>
      $$BookmarksTableTableManager(_db, _db.bookmarks);
  $$MemosTableTableManager get memos =>
      $$MemosTableTableManager(_db, _db.memos);
  $$HighlightsTableTableManager get highlights =>
      $$HighlightsTableTableManager(_db, _db.highlights);
  $$VocabularyItemsTableTableManager get vocabularyItems =>
      $$VocabularyItemsTableTableManager(_db, _db.vocabularyItems);
  $$ReviewSessionsTableTableManager get reviewSessions =>
      $$ReviewSessionsTableTableManager(_db, _db.reviewSessions);
  $$ReviewAnswersTableTableManager get reviewAnswers =>
      $$ReviewAnswersTableTableManager(_db, _db.reviewAnswers);
  $$ReadingHistoryTableTableManager get readingHistory =>
      $$ReadingHistoryTableTableManager(_db, _db.readingHistory);
  $$ReadingTabsTableTableManager get readingTabs =>
      $$ReadingTabsTableTableManager(_db, _db.readingTabs);
  $$ReadingPlansTableTableManager get readingPlans =>
      $$ReadingPlansTableTableManager(_db, _db.readingPlans);
  $$ChapterReadingPositionsTableTableManager get chapterReadingPositions =>
      $$ChapterReadingPositionsTableTableManager(
        _db,
        _db.chapterReadingPositions,
      );
}
