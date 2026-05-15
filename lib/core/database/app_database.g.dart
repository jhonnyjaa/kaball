// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
mixin _$SettingsDaoMixin on DatabaseAccessor<AppDatabase> {
  $SettingsTable get settings => attachedDatabase.settings;
  SettingsDaoManager get managers => SettingsDaoManager(this);
}

class SettingsDaoManager {
  final _$SettingsDaoMixin _db;
  SettingsDaoManager(this._db);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db.attachedDatabase, _db.settings);
}

mixin _$ImportedItemsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ImportedItemsTable get importedItems => attachedDatabase.importedItems;
  ImportedItemsDaoManager get managers => ImportedItemsDaoManager(this);
}

class ImportedItemsDaoManager {
  final _$ImportedItemsDaoMixin _db;
  ImportedItemsDaoManager(this._db);
  $$ImportedItemsTableTableManager get importedItems =>
      $$ImportedItemsTableTableManager(_db.attachedDatabase, _db.importedItems);
}

mixin _$InventoriesDaoMixin on DatabaseAccessor<AppDatabase> {
  $InventoriesTable get inventories => attachedDatabase.inventories;
  InventoriesDaoManager get managers => InventoriesDaoManager(this);
}

class InventoriesDaoManager {
  final _$InventoriesDaoMixin _db;
  InventoriesDaoManager(this._db);
  $$InventoriesTableTableManager get inventories =>
      $$InventoriesTableTableManager(_db.attachedDatabase, _db.inventories);
}

mixin _$InventoryRecordsDaoMixin on DatabaseAccessor<AppDatabase> {
  $InventoryRecordsTable get inventoryRecords =>
      attachedDatabase.inventoryRecords;
  InventoryRecordsDaoManager get managers => InventoryRecordsDaoManager(this);
}

class InventoryRecordsDaoManager {
  final _$InventoryRecordsDaoMixin _db;
  InventoryRecordsDaoManager(this._db);
  $$InventoryRecordsTableTableManager get inventoryRecords =>
      $$InventoryRecordsTableTableManager(
        _db.attachedDatabase,
        _db.inventoryRecords,
      );
}

class $ImportedItemsTable extends ImportedItems
    with TableInfo<$ImportedItemsTable, ImportedItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImportedItemsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _sourceTypeMeta = const VerificationMeta(
    'sourceType',
  );
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
    'source_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _primaryIdMeta = const VerificationMeta(
    'primaryId',
  );
  @override
  late final GeneratedColumn<String> primaryId = GeneratedColumn<String>(
    'primary_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _secondaryIdMeta = const VerificationMeta(
    'secondaryId',
  );
  @override
  late final GeneratedColumn<String> secondaryId = GeneratedColumn<String>(
    'secondary_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rawDataMeta = const VerificationMeta(
    'rawData',
  );
  @override
  late final GeneratedColumn<String> rawData = GeneratedColumn<String>(
    'raw_data',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _searchTextMeta = const VerificationMeta(
    'searchText',
  );
  @override
  late final GeneratedColumn<String> searchText = GeneratedColumn<String>(
    'search_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _importedAtMeta = const VerificationMeta(
    'importedAt',
  );
  @override
  late final GeneratedColumn<DateTime> importedAt = GeneratedColumn<DateTime>(
    'imported_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _importBatchIdMeta = const VerificationMeta(
    'importBatchId',
  );
  @override
  late final GeneratedColumn<String> importBatchId = GeneratedColumn<String>(
    'import_batch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sourceType,
    primaryId,
    secondaryId,
    description,
    location,
    rawData,
    searchText,
    importedAt,
    importBatchId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'imported_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ImportedItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('source_type')) {
      context.handle(
        _sourceTypeMeta,
        sourceType.isAcceptableOrUnknown(data['source_type']!, _sourceTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceTypeMeta);
    }
    if (data.containsKey('primary_id')) {
      context.handle(
        _primaryIdMeta,
        primaryId.isAcceptableOrUnknown(data['primary_id']!, _primaryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_primaryIdMeta);
    }
    if (data.containsKey('secondary_id')) {
      context.handle(
        _secondaryIdMeta,
        secondaryId.isAcceptableOrUnknown(
          data['secondary_id']!,
          _secondaryIdMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('raw_data')) {
      context.handle(
        _rawDataMeta,
        rawData.isAcceptableOrUnknown(data['raw_data']!, _rawDataMeta),
      );
    } else if (isInserting) {
      context.missing(_rawDataMeta);
    }
    if (data.containsKey('search_text')) {
      context.handle(
        _searchTextMeta,
        searchText.isAcceptableOrUnknown(data['search_text']!, _searchTextMeta),
      );
    } else if (isInserting) {
      context.missing(_searchTextMeta);
    }
    if (data.containsKey('imported_at')) {
      context.handle(
        _importedAtMeta,
        importedAt.isAcceptableOrUnknown(data['imported_at']!, _importedAtMeta),
      );
    }
    if (data.containsKey('import_batch_id')) {
      context.handle(
        _importBatchIdMeta,
        importBatchId.isAcceptableOrUnknown(
          data['import_batch_id']!,
          _importBatchIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_importBatchIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ImportedItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ImportedItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sourceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_type'],
      )!,
      primaryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_id'],
      )!,
      secondaryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}secondary_id'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      rawData: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_data'],
      )!,
      searchText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}search_text'],
      )!,
      importedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}imported_at'],
      )!,
      importBatchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}import_batch_id'],
      )!,
    );
  }

  @override
  $ImportedItemsTable createAlias(String alias) {
    return $ImportedItemsTable(attachedDatabase, alias);
  }
}

class ImportedItem extends DataClass implements Insertable<ImportedItem> {
  final int id;
  final String sourceType;
  final String primaryId;
  final String? secondaryId;
  final String description;
  final String? location;
  final String rawData;
  final String searchText;
  final DateTime importedAt;
  final String importBatchId;
  const ImportedItem({
    required this.id,
    required this.sourceType,
    required this.primaryId,
    this.secondaryId,
    required this.description,
    this.location,
    required this.rawData,
    required this.searchText,
    required this.importedAt,
    required this.importBatchId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['source_type'] = Variable<String>(sourceType);
    map['primary_id'] = Variable<String>(primaryId);
    if (!nullToAbsent || secondaryId != null) {
      map['secondary_id'] = Variable<String>(secondaryId);
    }
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    map['raw_data'] = Variable<String>(rawData);
    map['search_text'] = Variable<String>(searchText);
    map['imported_at'] = Variable<DateTime>(importedAt);
    map['import_batch_id'] = Variable<String>(importBatchId);
    return map;
  }

  ImportedItemsCompanion toCompanion(bool nullToAbsent) {
    return ImportedItemsCompanion(
      id: Value(id),
      sourceType: Value(sourceType),
      primaryId: Value(primaryId),
      secondaryId: secondaryId == null && nullToAbsent
          ? const Value.absent()
          : Value(secondaryId),
      description: Value(description),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      rawData: Value(rawData),
      searchText: Value(searchText),
      importedAt: Value(importedAt),
      importBatchId: Value(importBatchId),
    );
  }

  factory ImportedItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ImportedItem(
      id: serializer.fromJson<int>(json['id']),
      sourceType: serializer.fromJson<String>(json['sourceType']),
      primaryId: serializer.fromJson<String>(json['primaryId']),
      secondaryId: serializer.fromJson<String?>(json['secondaryId']),
      description: serializer.fromJson<String>(json['description']),
      location: serializer.fromJson<String?>(json['location']),
      rawData: serializer.fromJson<String>(json['rawData']),
      searchText: serializer.fromJson<String>(json['searchText']),
      importedAt: serializer.fromJson<DateTime>(json['importedAt']),
      importBatchId: serializer.fromJson<String>(json['importBatchId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sourceType': serializer.toJson<String>(sourceType),
      'primaryId': serializer.toJson<String>(primaryId),
      'secondaryId': serializer.toJson<String?>(secondaryId),
      'description': serializer.toJson<String>(description),
      'location': serializer.toJson<String?>(location),
      'rawData': serializer.toJson<String>(rawData),
      'searchText': serializer.toJson<String>(searchText),
      'importedAt': serializer.toJson<DateTime>(importedAt),
      'importBatchId': serializer.toJson<String>(importBatchId),
    };
  }

  ImportedItem copyWith({
    int? id,
    String? sourceType,
    String? primaryId,
    Value<String?> secondaryId = const Value.absent(),
    String? description,
    Value<String?> location = const Value.absent(),
    String? rawData,
    String? searchText,
    DateTime? importedAt,
    String? importBatchId,
  }) => ImportedItem(
    id: id ?? this.id,
    sourceType: sourceType ?? this.sourceType,
    primaryId: primaryId ?? this.primaryId,
    secondaryId: secondaryId.present ? secondaryId.value : this.secondaryId,
    description: description ?? this.description,
    location: location.present ? location.value : this.location,
    rawData: rawData ?? this.rawData,
    searchText: searchText ?? this.searchText,
    importedAt: importedAt ?? this.importedAt,
    importBatchId: importBatchId ?? this.importBatchId,
  );
  ImportedItem copyWithCompanion(ImportedItemsCompanion data) {
    return ImportedItem(
      id: data.id.present ? data.id.value : this.id,
      sourceType: data.sourceType.present
          ? data.sourceType.value
          : this.sourceType,
      primaryId: data.primaryId.present ? data.primaryId.value : this.primaryId,
      secondaryId: data.secondaryId.present
          ? data.secondaryId.value
          : this.secondaryId,
      description: data.description.present
          ? data.description.value
          : this.description,
      location: data.location.present ? data.location.value : this.location,
      rawData: data.rawData.present ? data.rawData.value : this.rawData,
      searchText: data.searchText.present
          ? data.searchText.value
          : this.searchText,
      importedAt: data.importedAt.present
          ? data.importedAt.value
          : this.importedAt,
      importBatchId: data.importBatchId.present
          ? data.importBatchId.value
          : this.importBatchId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ImportedItem(')
          ..write('id: $id, ')
          ..write('sourceType: $sourceType, ')
          ..write('primaryId: $primaryId, ')
          ..write('secondaryId: $secondaryId, ')
          ..write('description: $description, ')
          ..write('location: $location, ')
          ..write('rawData: $rawData, ')
          ..write('searchText: $searchText, ')
          ..write('importedAt: $importedAt, ')
          ..write('importBatchId: $importBatchId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sourceType,
    primaryId,
    secondaryId,
    description,
    location,
    rawData,
    searchText,
    importedAt,
    importBatchId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImportedItem &&
          other.id == this.id &&
          other.sourceType == this.sourceType &&
          other.primaryId == this.primaryId &&
          other.secondaryId == this.secondaryId &&
          other.description == this.description &&
          other.location == this.location &&
          other.rawData == this.rawData &&
          other.searchText == this.searchText &&
          other.importedAt == this.importedAt &&
          other.importBatchId == this.importBatchId);
}

class ImportedItemsCompanion extends UpdateCompanion<ImportedItem> {
  final Value<int> id;
  final Value<String> sourceType;
  final Value<String> primaryId;
  final Value<String?> secondaryId;
  final Value<String> description;
  final Value<String?> location;
  final Value<String> rawData;
  final Value<String> searchText;
  final Value<DateTime> importedAt;
  final Value<String> importBatchId;
  const ImportedItemsCompanion({
    this.id = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.primaryId = const Value.absent(),
    this.secondaryId = const Value.absent(),
    this.description = const Value.absent(),
    this.location = const Value.absent(),
    this.rawData = const Value.absent(),
    this.searchText = const Value.absent(),
    this.importedAt = const Value.absent(),
    this.importBatchId = const Value.absent(),
  });
  ImportedItemsCompanion.insert({
    this.id = const Value.absent(),
    required String sourceType,
    required String primaryId,
    this.secondaryId = const Value.absent(),
    required String description,
    this.location = const Value.absent(),
    required String rawData,
    required String searchText,
    this.importedAt = const Value.absent(),
    required String importBatchId,
  }) : sourceType = Value(sourceType),
       primaryId = Value(primaryId),
       description = Value(description),
       rawData = Value(rawData),
       searchText = Value(searchText),
       importBatchId = Value(importBatchId);
  static Insertable<ImportedItem> custom({
    Expression<int>? id,
    Expression<String>? sourceType,
    Expression<String>? primaryId,
    Expression<String>? secondaryId,
    Expression<String>? description,
    Expression<String>? location,
    Expression<String>? rawData,
    Expression<String>? searchText,
    Expression<DateTime>? importedAt,
    Expression<String>? importBatchId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceType != null) 'source_type': sourceType,
      if (primaryId != null) 'primary_id': primaryId,
      if (secondaryId != null) 'secondary_id': secondaryId,
      if (description != null) 'description': description,
      if (location != null) 'location': location,
      if (rawData != null) 'raw_data': rawData,
      if (searchText != null) 'search_text': searchText,
      if (importedAt != null) 'imported_at': importedAt,
      if (importBatchId != null) 'import_batch_id': importBatchId,
    });
  }

  ImportedItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? sourceType,
    Value<String>? primaryId,
    Value<String?>? secondaryId,
    Value<String>? description,
    Value<String?>? location,
    Value<String>? rawData,
    Value<String>? searchText,
    Value<DateTime>? importedAt,
    Value<String>? importBatchId,
  }) {
    return ImportedItemsCompanion(
      id: id ?? this.id,
      sourceType: sourceType ?? this.sourceType,
      primaryId: primaryId ?? this.primaryId,
      secondaryId: secondaryId ?? this.secondaryId,
      description: description ?? this.description,
      location: location ?? this.location,
      rawData: rawData ?? this.rawData,
      searchText: searchText ?? this.searchText,
      importedAt: importedAt ?? this.importedAt,
      importBatchId: importBatchId ?? this.importBatchId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (primaryId.present) {
      map['primary_id'] = Variable<String>(primaryId.value);
    }
    if (secondaryId.present) {
      map['secondary_id'] = Variable<String>(secondaryId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (rawData.present) {
      map['raw_data'] = Variable<String>(rawData.value);
    }
    if (searchText.present) {
      map['search_text'] = Variable<String>(searchText.value);
    }
    if (importedAt.present) {
      map['imported_at'] = Variable<DateTime>(importedAt.value);
    }
    if (importBatchId.present) {
      map['import_batch_id'] = Variable<String>(importBatchId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImportedItemsCompanion(')
          ..write('id: $id, ')
          ..write('sourceType: $sourceType, ')
          ..write('primaryId: $primaryId, ')
          ..write('secondaryId: $secondaryId, ')
          ..write('description: $description, ')
          ..write('location: $location, ')
          ..write('rawData: $rawData, ')
          ..write('searchText: $searchText, ')
          ..write('importedAt: $importedAt, ')
          ..write('importBatchId: $importBatchId')
          ..write(')'))
        .toString();
  }
}

class $InventoriesTable extends Inventories
    with TableInfo<$InventoriesTable, Inventory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operatorNameMeta = const VerificationMeta(
    'operatorName',
  );
  @override
  late final GeneratedColumn<String> operatorName = GeneratedColumn<String>(
    'operator_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
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
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _targetCountMeta = const VerificationMeta(
    'targetCount',
  );
  @override
  late final GeneratedColumn<int> targetCount = GeneratedColumn<int>(
    'target_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    operatorName,
    deviceId,
    createdAt,
    updatedAt,
    status,
    targetCount,
    description,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Inventory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('operator_name')) {
      context.handle(
        _operatorNameMeta,
        operatorName.isAcceptableOrUnknown(
          data['operator_name']!,
          _operatorNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_operatorNameMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
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
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('target_count')) {
      context.handle(
        _targetCountMeta,
        targetCount.isAcceptableOrUnknown(
          data['target_count']!,
          _targetCountMeta,
        ),
      );
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Inventory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Inventory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      operatorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operator_name'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      targetCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_count'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  $InventoriesTable createAlias(String alias) {
    return $InventoriesTable(attachedDatabase, alias);
  }
}

class Inventory extends DataClass implements Insertable<Inventory> {
  final String id;
  final String name;
  final String operatorName;
  final String deviceId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final int? targetCount;
  final String? description;
  const Inventory({
    required this.id,
    required this.name,
    required this.operatorName,
    required this.deviceId,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    this.targetCount,
    this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['operator_name'] = Variable<String>(operatorName);
    map['device_id'] = Variable<String>(deviceId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || targetCount != null) {
      map['target_count'] = Variable<int>(targetCount);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  InventoriesCompanion toCompanion(bool nullToAbsent) {
    return InventoriesCompanion(
      id: Value(id),
      name: Value(name),
      operatorName: Value(operatorName),
      deviceId: Value(deviceId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      status: Value(status),
      targetCount: targetCount == null && nullToAbsent
          ? const Value.absent()
          : Value(targetCount),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory Inventory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Inventory(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      operatorName: serializer.fromJson<String>(json['operatorName']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      status: serializer.fromJson<String>(json['status']),
      targetCount: serializer.fromJson<int?>(json['targetCount']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'operatorName': serializer.toJson<String>(operatorName),
      'deviceId': serializer.toJson<String>(deviceId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'status': serializer.toJson<String>(status),
      'targetCount': serializer.toJson<int?>(targetCount),
      'description': serializer.toJson<String?>(description),
    };
  }

  Inventory copyWith({
    String? id,
    String? name,
    String? operatorName,
    String? deviceId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? status,
    Value<int?> targetCount = const Value.absent(),
    Value<String?> description = const Value.absent(),
  }) => Inventory(
    id: id ?? this.id,
    name: name ?? this.name,
    operatorName: operatorName ?? this.operatorName,
    deviceId: deviceId ?? this.deviceId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    status: status ?? this.status,
    targetCount: targetCount.present ? targetCount.value : this.targetCount,
    description: description.present ? description.value : this.description,
  );
  Inventory copyWithCompanion(InventoriesCompanion data) {
    return Inventory(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      operatorName: data.operatorName.present
          ? data.operatorName.value
          : this.operatorName,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      status: data.status.present ? data.status.value : this.status,
      targetCount: data.targetCount.present
          ? data.targetCount.value
          : this.targetCount,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Inventory(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('operatorName: $operatorName, ')
          ..write('deviceId: $deviceId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('status: $status, ')
          ..write('targetCount: $targetCount, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    operatorName,
    deviceId,
    createdAt,
    updatedAt,
    status,
    targetCount,
    description,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Inventory &&
          other.id == this.id &&
          other.name == this.name &&
          other.operatorName == this.operatorName &&
          other.deviceId == this.deviceId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.status == this.status &&
          other.targetCount == this.targetCount &&
          other.description == this.description);
}

class InventoriesCompanion extends UpdateCompanion<Inventory> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> operatorName;
  final Value<String> deviceId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> status;
  final Value<int?> targetCount;
  final Value<String?> description;
  final Value<int> rowid;
  const InventoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.operatorName = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.targetCount = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventoriesCompanion.insert({
    required String id,
    required String name,
    required String operatorName,
    required String deviceId,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.status = const Value.absent(),
    this.targetCount = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       operatorName = Value(operatorName),
       deviceId = Value(deviceId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Inventory> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? operatorName,
    Expression<String>? deviceId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? status,
    Expression<int>? targetCount,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (operatorName != null) 'operator_name': operatorName,
      if (deviceId != null) 'device_id': deviceId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (status != null) 'status': status,
      if (targetCount != null) 'target_count': targetCount,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? operatorName,
    Value<String>? deviceId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? status,
    Value<int?>? targetCount,
    Value<String?>? description,
    Value<int>? rowid,
  }) {
    return InventoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      operatorName: operatorName ?? this.operatorName,
      deviceId: deviceId ?? this.deviceId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      targetCount: targetCount ?? this.targetCount,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (operatorName.present) {
      map['operator_name'] = Variable<String>(operatorName.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (targetCount.present) {
      map['target_count'] = Variable<int>(targetCount.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('operatorName: $operatorName, ')
          ..write('deviceId: $deviceId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('status: $status, ')
          ..write('targetCount: $targetCount, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InventoryRecordsTable extends InventoryRecords
    with TableInfo<$InventoryRecordsTable, InventoryRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inventoryIdMeta = const VerificationMeta(
    'inventoryId',
  );
  @override
  late final GeneratedColumn<String> inventoryId = GeneratedColumn<String>(
    'inventory_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceTypeMeta = const VerificationMeta(
    'sourceType',
  );
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
    'source_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _importedItemIdMeta = const VerificationMeta(
    'importedItemId',
  );
  @override
  late final GeneratedColumn<int> importedItemId = GeneratedColumn<int>(
    'imported_item_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _primaryIdMeta = const VerificationMeta(
    'primaryId',
  );
  @override
  late final GeneratedColumn<String> primaryId = GeneratedColumn<String>(
    'primary_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _secondaryIdMeta = const VerificationMeta(
    'secondaryId',
  );
  @override
  late final GeneratedColumn<String> secondaryId = GeneratedColumn<String>(
    'secondary_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityFoundMeta = const VerificationMeta(
    'quantityFound',
  );
  @override
  late final GeneratedColumn<double> quantityFound = GeneratedColumn<double>(
    'quantity_found',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _physicalLocationMeta = const VerificationMeta(
    'physicalLocation',
  );
  @override
  late final GeneratedColumn<String> physicalLocation = GeneratedColumn<String>(
    'physical_location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sapLocationMeta = const VerificationMeta(
    'sapLocation',
  );
  @override
  late final GeneratedColumn<String> sapLocation = GeneratedColumn<String>(
    'sap_location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _metadataEnrichmentMeta =
      const VerificationMeta('metadataEnrichment');
  @override
  late final GeneratedColumn<String> metadataEnrichment =
      GeneratedColumn<String>(
        'metadata_enrichment',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _operatorNameMeta = const VerificationMeta(
    'operatorName',
  );
  @override
  late final GeneratedColumn<String> operatorName = GeneratedColumn<String>(
    'operator_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    inventoryId,
    sourceType,
    importedItemId,
    primaryId,
    secondaryId,
    description,
    quantityFound,
    physicalLocation,
    sapLocation,
    note,
    metadataEnrichment,
    operatorName,
    deviceId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('inventory_id')) {
      context.handle(
        _inventoryIdMeta,
        inventoryId.isAcceptableOrUnknown(
          data['inventory_id']!,
          _inventoryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_inventoryIdMeta);
    }
    if (data.containsKey('source_type')) {
      context.handle(
        _sourceTypeMeta,
        sourceType.isAcceptableOrUnknown(data['source_type']!, _sourceTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceTypeMeta);
    }
    if (data.containsKey('imported_item_id')) {
      context.handle(
        _importedItemIdMeta,
        importedItemId.isAcceptableOrUnknown(
          data['imported_item_id']!,
          _importedItemIdMeta,
        ),
      );
    }
    if (data.containsKey('primary_id')) {
      context.handle(
        _primaryIdMeta,
        primaryId.isAcceptableOrUnknown(data['primary_id']!, _primaryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_primaryIdMeta);
    }
    if (data.containsKey('secondary_id')) {
      context.handle(
        _secondaryIdMeta,
        secondaryId.isAcceptableOrUnknown(
          data['secondary_id']!,
          _secondaryIdMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('quantity_found')) {
      context.handle(
        _quantityFoundMeta,
        quantityFound.isAcceptableOrUnknown(
          data['quantity_found']!,
          _quantityFoundMeta,
        ),
      );
    }
    if (data.containsKey('physical_location')) {
      context.handle(
        _physicalLocationMeta,
        physicalLocation.isAcceptableOrUnknown(
          data['physical_location']!,
          _physicalLocationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_physicalLocationMeta);
    }
    if (data.containsKey('sap_location')) {
      context.handle(
        _sapLocationMeta,
        sapLocation.isAcceptableOrUnknown(
          data['sap_location']!,
          _sapLocationMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('metadata_enrichment')) {
      context.handle(
        _metadataEnrichmentMeta,
        metadataEnrichment.isAcceptableOrUnknown(
          data['metadata_enrichment']!,
          _metadataEnrichmentMeta,
        ),
      );
    }
    if (data.containsKey('operator_name')) {
      context.handle(
        _operatorNameMeta,
        operatorName.isAcceptableOrUnknown(
          data['operator_name']!,
          _operatorNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_operatorNameMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventoryRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      inventoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}inventory_id'],
      )!,
      sourceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_type'],
      )!,
      importedItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}imported_item_id'],
      ),
      primaryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_id'],
      )!,
      secondaryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}secondary_id'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      quantityFound: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity_found'],
      )!,
      physicalLocation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}physical_location'],
      )!,
      sapLocation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sap_location'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      metadataEnrichment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_enrichment'],
      ),
      operatorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operator_name'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $InventoryRecordsTable createAlias(String alias) {
    return $InventoryRecordsTable(attachedDatabase, alias);
  }
}

class InventoryRecord extends DataClass implements Insertable<InventoryRecord> {
  final String id;
  final String inventoryId;
  final String sourceType;
  final int? importedItemId;
  final String primaryId;
  final String? secondaryId;
  final String description;
  final double quantityFound;
  final String physicalLocation;
  final String? sapLocation;
  final String? note;
  final String? metadataEnrichment;
  final String operatorName;
  final String deviceId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const InventoryRecord({
    required this.id,
    required this.inventoryId,
    required this.sourceType,
    this.importedItemId,
    required this.primaryId,
    this.secondaryId,
    required this.description,
    required this.quantityFound,
    required this.physicalLocation,
    this.sapLocation,
    this.note,
    this.metadataEnrichment,
    required this.operatorName,
    required this.deviceId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['inventory_id'] = Variable<String>(inventoryId);
    map['source_type'] = Variable<String>(sourceType);
    if (!nullToAbsent || importedItemId != null) {
      map['imported_item_id'] = Variable<int>(importedItemId);
    }
    map['primary_id'] = Variable<String>(primaryId);
    if (!nullToAbsent || secondaryId != null) {
      map['secondary_id'] = Variable<String>(secondaryId);
    }
    map['description'] = Variable<String>(description);
    map['quantity_found'] = Variable<double>(quantityFound);
    map['physical_location'] = Variable<String>(physicalLocation);
    if (!nullToAbsent || sapLocation != null) {
      map['sap_location'] = Variable<String>(sapLocation);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || metadataEnrichment != null) {
      map['metadata_enrichment'] = Variable<String>(metadataEnrichment);
    }
    map['operator_name'] = Variable<String>(operatorName);
    map['device_id'] = Variable<String>(deviceId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  InventoryRecordsCompanion toCompanion(bool nullToAbsent) {
    return InventoryRecordsCompanion(
      id: Value(id),
      inventoryId: Value(inventoryId),
      sourceType: Value(sourceType),
      importedItemId: importedItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(importedItemId),
      primaryId: Value(primaryId),
      secondaryId: secondaryId == null && nullToAbsent
          ? const Value.absent()
          : Value(secondaryId),
      description: Value(description),
      quantityFound: Value(quantityFound),
      physicalLocation: Value(physicalLocation),
      sapLocation: sapLocation == null && nullToAbsent
          ? const Value.absent()
          : Value(sapLocation),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      metadataEnrichment: metadataEnrichment == null && nullToAbsent
          ? const Value.absent()
          : Value(metadataEnrichment),
      operatorName: Value(operatorName),
      deviceId: Value(deviceId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory InventoryRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryRecord(
      id: serializer.fromJson<String>(json['id']),
      inventoryId: serializer.fromJson<String>(json['inventoryId']),
      sourceType: serializer.fromJson<String>(json['sourceType']),
      importedItemId: serializer.fromJson<int?>(json['importedItemId']),
      primaryId: serializer.fromJson<String>(json['primaryId']),
      secondaryId: serializer.fromJson<String?>(json['secondaryId']),
      description: serializer.fromJson<String>(json['description']),
      quantityFound: serializer.fromJson<double>(json['quantityFound']),
      physicalLocation: serializer.fromJson<String>(json['physicalLocation']),
      sapLocation: serializer.fromJson<String?>(json['sapLocation']),
      note: serializer.fromJson<String?>(json['note']),
      metadataEnrichment: serializer.fromJson<String?>(
        json['metadataEnrichment'],
      ),
      operatorName: serializer.fromJson<String>(json['operatorName']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'inventoryId': serializer.toJson<String>(inventoryId),
      'sourceType': serializer.toJson<String>(sourceType),
      'importedItemId': serializer.toJson<int?>(importedItemId),
      'primaryId': serializer.toJson<String>(primaryId),
      'secondaryId': serializer.toJson<String?>(secondaryId),
      'description': serializer.toJson<String>(description),
      'quantityFound': serializer.toJson<double>(quantityFound),
      'physicalLocation': serializer.toJson<String>(physicalLocation),
      'sapLocation': serializer.toJson<String?>(sapLocation),
      'note': serializer.toJson<String?>(note),
      'metadataEnrichment': serializer.toJson<String?>(metadataEnrichment),
      'operatorName': serializer.toJson<String>(operatorName),
      'deviceId': serializer.toJson<String>(deviceId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  InventoryRecord copyWith({
    String? id,
    String? inventoryId,
    String? sourceType,
    Value<int?> importedItemId = const Value.absent(),
    String? primaryId,
    Value<String?> secondaryId = const Value.absent(),
    String? description,
    double? quantityFound,
    String? physicalLocation,
    Value<String?> sapLocation = const Value.absent(),
    Value<String?> note = const Value.absent(),
    Value<String?> metadataEnrichment = const Value.absent(),
    String? operatorName,
    String? deviceId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => InventoryRecord(
    id: id ?? this.id,
    inventoryId: inventoryId ?? this.inventoryId,
    sourceType: sourceType ?? this.sourceType,
    importedItemId: importedItemId.present
        ? importedItemId.value
        : this.importedItemId,
    primaryId: primaryId ?? this.primaryId,
    secondaryId: secondaryId.present ? secondaryId.value : this.secondaryId,
    description: description ?? this.description,
    quantityFound: quantityFound ?? this.quantityFound,
    physicalLocation: physicalLocation ?? this.physicalLocation,
    sapLocation: sapLocation.present ? sapLocation.value : this.sapLocation,
    note: note.present ? note.value : this.note,
    metadataEnrichment: metadataEnrichment.present
        ? metadataEnrichment.value
        : this.metadataEnrichment,
    operatorName: operatorName ?? this.operatorName,
    deviceId: deviceId ?? this.deviceId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  InventoryRecord copyWithCompanion(InventoryRecordsCompanion data) {
    return InventoryRecord(
      id: data.id.present ? data.id.value : this.id,
      inventoryId: data.inventoryId.present
          ? data.inventoryId.value
          : this.inventoryId,
      sourceType: data.sourceType.present
          ? data.sourceType.value
          : this.sourceType,
      importedItemId: data.importedItemId.present
          ? data.importedItemId.value
          : this.importedItemId,
      primaryId: data.primaryId.present ? data.primaryId.value : this.primaryId,
      secondaryId: data.secondaryId.present
          ? data.secondaryId.value
          : this.secondaryId,
      description: data.description.present
          ? data.description.value
          : this.description,
      quantityFound: data.quantityFound.present
          ? data.quantityFound.value
          : this.quantityFound,
      physicalLocation: data.physicalLocation.present
          ? data.physicalLocation.value
          : this.physicalLocation,
      sapLocation: data.sapLocation.present
          ? data.sapLocation.value
          : this.sapLocation,
      note: data.note.present ? data.note.value : this.note,
      metadataEnrichment: data.metadataEnrichment.present
          ? data.metadataEnrichment.value
          : this.metadataEnrichment,
      operatorName: data.operatorName.present
          ? data.operatorName.value
          : this.operatorName,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryRecord(')
          ..write('id: $id, ')
          ..write('inventoryId: $inventoryId, ')
          ..write('sourceType: $sourceType, ')
          ..write('importedItemId: $importedItemId, ')
          ..write('primaryId: $primaryId, ')
          ..write('secondaryId: $secondaryId, ')
          ..write('description: $description, ')
          ..write('quantityFound: $quantityFound, ')
          ..write('physicalLocation: $physicalLocation, ')
          ..write('sapLocation: $sapLocation, ')
          ..write('note: $note, ')
          ..write('metadataEnrichment: $metadataEnrichment, ')
          ..write('operatorName: $operatorName, ')
          ..write('deviceId: $deviceId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    inventoryId,
    sourceType,
    importedItemId,
    primaryId,
    secondaryId,
    description,
    quantityFound,
    physicalLocation,
    sapLocation,
    note,
    metadataEnrichment,
    operatorName,
    deviceId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryRecord &&
          other.id == this.id &&
          other.inventoryId == this.inventoryId &&
          other.sourceType == this.sourceType &&
          other.importedItemId == this.importedItemId &&
          other.primaryId == this.primaryId &&
          other.secondaryId == this.secondaryId &&
          other.description == this.description &&
          other.quantityFound == this.quantityFound &&
          other.physicalLocation == this.physicalLocation &&
          other.sapLocation == this.sapLocation &&
          other.note == this.note &&
          other.metadataEnrichment == this.metadataEnrichment &&
          other.operatorName == this.operatorName &&
          other.deviceId == this.deviceId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class InventoryRecordsCompanion extends UpdateCompanion<InventoryRecord> {
  final Value<String> id;
  final Value<String> inventoryId;
  final Value<String> sourceType;
  final Value<int?> importedItemId;
  final Value<String> primaryId;
  final Value<String?> secondaryId;
  final Value<String> description;
  final Value<double> quantityFound;
  final Value<String> physicalLocation;
  final Value<String?> sapLocation;
  final Value<String?> note;
  final Value<String?> metadataEnrichment;
  final Value<String> operatorName;
  final Value<String> deviceId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const InventoryRecordsCompanion({
    this.id = const Value.absent(),
    this.inventoryId = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.importedItemId = const Value.absent(),
    this.primaryId = const Value.absent(),
    this.secondaryId = const Value.absent(),
    this.description = const Value.absent(),
    this.quantityFound = const Value.absent(),
    this.physicalLocation = const Value.absent(),
    this.sapLocation = const Value.absent(),
    this.note = const Value.absent(),
    this.metadataEnrichment = const Value.absent(),
    this.operatorName = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventoryRecordsCompanion.insert({
    required String id,
    required String inventoryId,
    required String sourceType,
    this.importedItemId = const Value.absent(),
    required String primaryId,
    this.secondaryId = const Value.absent(),
    required String description,
    this.quantityFound = const Value.absent(),
    required String physicalLocation,
    this.sapLocation = const Value.absent(),
    this.note = const Value.absent(),
    this.metadataEnrichment = const Value.absent(),
    required String operatorName,
    required String deviceId,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       inventoryId = Value(inventoryId),
       sourceType = Value(sourceType),
       primaryId = Value(primaryId),
       description = Value(description),
       physicalLocation = Value(physicalLocation),
       operatorName = Value(operatorName),
       deviceId = Value(deviceId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<InventoryRecord> custom({
    Expression<String>? id,
    Expression<String>? inventoryId,
    Expression<String>? sourceType,
    Expression<int>? importedItemId,
    Expression<String>? primaryId,
    Expression<String>? secondaryId,
    Expression<String>? description,
    Expression<double>? quantityFound,
    Expression<String>? physicalLocation,
    Expression<String>? sapLocation,
    Expression<String>? note,
    Expression<String>? metadataEnrichment,
    Expression<String>? operatorName,
    Expression<String>? deviceId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (inventoryId != null) 'inventory_id': inventoryId,
      if (sourceType != null) 'source_type': sourceType,
      if (importedItemId != null) 'imported_item_id': importedItemId,
      if (primaryId != null) 'primary_id': primaryId,
      if (secondaryId != null) 'secondary_id': secondaryId,
      if (description != null) 'description': description,
      if (quantityFound != null) 'quantity_found': quantityFound,
      if (physicalLocation != null) 'physical_location': physicalLocation,
      if (sapLocation != null) 'sap_location': sapLocation,
      if (note != null) 'note': note,
      if (metadataEnrichment != null) 'metadata_enrichment': metadataEnrichment,
      if (operatorName != null) 'operator_name': operatorName,
      if (deviceId != null) 'device_id': deviceId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventoryRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? inventoryId,
    Value<String>? sourceType,
    Value<int?>? importedItemId,
    Value<String>? primaryId,
    Value<String?>? secondaryId,
    Value<String>? description,
    Value<double>? quantityFound,
    Value<String>? physicalLocation,
    Value<String?>? sapLocation,
    Value<String?>? note,
    Value<String?>? metadataEnrichment,
    Value<String>? operatorName,
    Value<String>? deviceId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return InventoryRecordsCompanion(
      id: id ?? this.id,
      inventoryId: inventoryId ?? this.inventoryId,
      sourceType: sourceType ?? this.sourceType,
      importedItemId: importedItemId ?? this.importedItemId,
      primaryId: primaryId ?? this.primaryId,
      secondaryId: secondaryId ?? this.secondaryId,
      description: description ?? this.description,
      quantityFound: quantityFound ?? this.quantityFound,
      physicalLocation: physicalLocation ?? this.physicalLocation,
      sapLocation: sapLocation ?? this.sapLocation,
      note: note ?? this.note,
      metadataEnrichment: metadataEnrichment ?? this.metadataEnrichment,
      operatorName: operatorName ?? this.operatorName,
      deviceId: deviceId ?? this.deviceId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (inventoryId.present) {
      map['inventory_id'] = Variable<String>(inventoryId.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (importedItemId.present) {
      map['imported_item_id'] = Variable<int>(importedItemId.value);
    }
    if (primaryId.present) {
      map['primary_id'] = Variable<String>(primaryId.value);
    }
    if (secondaryId.present) {
      map['secondary_id'] = Variable<String>(secondaryId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (quantityFound.present) {
      map['quantity_found'] = Variable<double>(quantityFound.value);
    }
    if (physicalLocation.present) {
      map['physical_location'] = Variable<String>(physicalLocation.value);
    }
    if (sapLocation.present) {
      map['sap_location'] = Variable<String>(sapLocation.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (metadataEnrichment.present) {
      map['metadata_enrichment'] = Variable<String>(metadataEnrichment.value);
    }
    if (operatorName.present) {
      map['operator_name'] = Variable<String>(operatorName.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
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
    return (StringBuffer('InventoryRecordsCompanion(')
          ..write('id: $id, ')
          ..write('inventoryId: $inventoryId, ')
          ..write('sourceType: $sourceType, ')
          ..write('importedItemId: $importedItemId, ')
          ..write('primaryId: $primaryId, ')
          ..write('secondaryId: $secondaryId, ')
          ..write('description: $description, ')
          ..write('quantityFound: $quantityFound, ')
          ..write('physicalLocation: $physicalLocation, ')
          ..write('sapLocation: $sapLocation, ')
          ..write('note: $note, ')
          ..write('metadataEnrichment: $metadataEnrichment, ')
          ..write('operatorName: $operatorName, ')
          ..write('deviceId: $deviceId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Setting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final String key;
  final String value;
  const Setting({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(key: Value(key), value: Value(value));
  }

  factory Setting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  Setting copyWith({String? key, String? value}) =>
      Setting(key: key ?? this.key, value: value ?? this.value);
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting && other.key == this.key && other.value == this.value);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<Setting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return SettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ImportedItemsTable importedItems = $ImportedItemsTable(this);
  late final $InventoriesTable inventories = $InventoriesTable(this);
  late final $InventoryRecordsTable inventoryRecords = $InventoryRecordsTable(
    this,
  );
  late final $SettingsTable settings = $SettingsTable(this);
  late final SettingsDao settingsDao = SettingsDao(this as AppDatabase);
  late final ImportedItemsDao importedItemsDao = ImportedItemsDao(
    this as AppDatabase,
  );
  late final InventoriesDao inventoriesDao = InventoriesDao(
    this as AppDatabase,
  );
  late final InventoryRecordsDao inventoryRecordsDao = InventoryRecordsDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    importedItems,
    inventories,
    inventoryRecords,
    settings,
  ];
}

typedef $$ImportedItemsTableCreateCompanionBuilder =
    ImportedItemsCompanion Function({
      Value<int> id,
      required String sourceType,
      required String primaryId,
      Value<String?> secondaryId,
      required String description,
      Value<String?> location,
      required String rawData,
      required String searchText,
      Value<DateTime> importedAt,
      required String importBatchId,
    });
typedef $$ImportedItemsTableUpdateCompanionBuilder =
    ImportedItemsCompanion Function({
      Value<int> id,
      Value<String> sourceType,
      Value<String> primaryId,
      Value<String?> secondaryId,
      Value<String> description,
      Value<String?> location,
      Value<String> rawData,
      Value<String> searchText,
      Value<DateTime> importedAt,
      Value<String> importBatchId,
    });

class $$ImportedItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ImportedItemsTable> {
  $$ImportedItemsTableFilterComposer({
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

  ColumnFilters<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryId => $composableBuilder(
    column: $table.primaryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get secondaryId => $composableBuilder(
    column: $table.secondaryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawData => $composableBuilder(
    column: $table.rawData,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get importBatchId => $composableBuilder(
    column: $table.importBatchId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ImportedItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ImportedItemsTable> {
  $$ImportedItemsTableOrderingComposer({
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

  ColumnOrderings<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryId => $composableBuilder(
    column: $table.primaryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get secondaryId => $composableBuilder(
    column: $table.secondaryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawData => $composableBuilder(
    column: $table.rawData,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get importBatchId => $composableBuilder(
    column: $table.importBatchId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ImportedItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ImportedItemsTable> {
  $$ImportedItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get primaryId =>
      $composableBuilder(column: $table.primaryId, builder: (column) => column);

  GeneratedColumn<String> get secondaryId => $composableBuilder(
    column: $table.secondaryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get rawData =>
      $composableBuilder(column: $table.rawData, builder: (column) => column);

  GeneratedColumn<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get importBatchId => $composableBuilder(
    column: $table.importBatchId,
    builder: (column) => column,
  );
}

class $$ImportedItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ImportedItemsTable,
          ImportedItem,
          $$ImportedItemsTableFilterComposer,
          $$ImportedItemsTableOrderingComposer,
          $$ImportedItemsTableAnnotationComposer,
          $$ImportedItemsTableCreateCompanionBuilder,
          $$ImportedItemsTableUpdateCompanionBuilder,
          (
            ImportedItem,
            BaseReferences<_$AppDatabase, $ImportedItemsTable, ImportedItem>,
          ),
          ImportedItem,
          PrefetchHooks Function()
        > {
  $$ImportedItemsTableTableManager(_$AppDatabase db, $ImportedItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ImportedItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ImportedItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ImportedItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sourceType = const Value.absent(),
                Value<String> primaryId = const Value.absent(),
                Value<String?> secondaryId = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String> rawData = const Value.absent(),
                Value<String> searchText = const Value.absent(),
                Value<DateTime> importedAt = const Value.absent(),
                Value<String> importBatchId = const Value.absent(),
              }) => ImportedItemsCompanion(
                id: id,
                sourceType: sourceType,
                primaryId: primaryId,
                secondaryId: secondaryId,
                description: description,
                location: location,
                rawData: rawData,
                searchText: searchText,
                importedAt: importedAt,
                importBatchId: importBatchId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sourceType,
                required String primaryId,
                Value<String?> secondaryId = const Value.absent(),
                required String description,
                Value<String?> location = const Value.absent(),
                required String rawData,
                required String searchText,
                Value<DateTime> importedAt = const Value.absent(),
                required String importBatchId,
              }) => ImportedItemsCompanion.insert(
                id: id,
                sourceType: sourceType,
                primaryId: primaryId,
                secondaryId: secondaryId,
                description: description,
                location: location,
                rawData: rawData,
                searchText: searchText,
                importedAt: importedAt,
                importBatchId: importBatchId,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ImportedItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ImportedItemsTable,
      ImportedItem,
      $$ImportedItemsTableFilterComposer,
      $$ImportedItemsTableOrderingComposer,
      $$ImportedItemsTableAnnotationComposer,
      $$ImportedItemsTableCreateCompanionBuilder,
      $$ImportedItemsTableUpdateCompanionBuilder,
      (
        ImportedItem,
        BaseReferences<_$AppDatabase, $ImportedItemsTable, ImportedItem>,
      ),
      ImportedItem,
      PrefetchHooks Function()
    >;
typedef $$InventoriesTableCreateCompanionBuilder =
    InventoriesCompanion Function({
      required String id,
      required String name,
      required String operatorName,
      required String deviceId,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<String> status,
      Value<int?> targetCount,
      Value<String?> description,
      Value<int> rowid,
    });
typedef $$InventoriesTableUpdateCompanionBuilder =
    InventoriesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> operatorName,
      Value<String> deviceId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> status,
      Value<int?> targetCount,
      Value<String?> description,
      Value<int> rowid,
    });

class $$InventoriesTableFilterComposer
    extends Composer<_$AppDatabase, $InventoriesTable> {
  $$InventoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operatorName => $composableBuilder(
    column: $table.operatorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
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

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetCount => $composableBuilder(
    column: $table.targetCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InventoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoriesTable> {
  $$InventoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operatorName => $composableBuilder(
    column: $table.operatorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
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

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetCount => $composableBuilder(
    column: $table.targetCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InventoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoriesTable> {
  $$InventoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get operatorName => $composableBuilder(
    column: $table.operatorName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get targetCount => $composableBuilder(
    column: $table.targetCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );
}

class $$InventoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventoriesTable,
          Inventory,
          $$InventoriesTableFilterComposer,
          $$InventoriesTableOrderingComposer,
          $$InventoriesTableAnnotationComposer,
          $$InventoriesTableCreateCompanionBuilder,
          $$InventoriesTableUpdateCompanionBuilder,
          (
            Inventory,
            BaseReferences<_$AppDatabase, $InventoriesTable, Inventory>,
          ),
          Inventory,
          PrefetchHooks Function()
        > {
  $$InventoriesTableTableManager(_$AppDatabase db, $InventoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> operatorName = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int?> targetCount = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoriesCompanion(
                id: id,
                name: name,
                operatorName: operatorName,
                deviceId: deviceId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                status: status,
                targetCount: targetCount,
                description: description,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String operatorName,
                required String deviceId,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<String> status = const Value.absent(),
                Value<int?> targetCount = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoriesCompanion.insert(
                id: id,
                name: name,
                operatorName: operatorName,
                deviceId: deviceId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                status: status,
                targetCount: targetCount,
                description: description,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InventoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventoriesTable,
      Inventory,
      $$InventoriesTableFilterComposer,
      $$InventoriesTableOrderingComposer,
      $$InventoriesTableAnnotationComposer,
      $$InventoriesTableCreateCompanionBuilder,
      $$InventoriesTableUpdateCompanionBuilder,
      (Inventory, BaseReferences<_$AppDatabase, $InventoriesTable, Inventory>),
      Inventory,
      PrefetchHooks Function()
    >;
typedef $$InventoryRecordsTableCreateCompanionBuilder =
    InventoryRecordsCompanion Function({
      required String id,
      required String inventoryId,
      required String sourceType,
      Value<int?> importedItemId,
      required String primaryId,
      Value<String?> secondaryId,
      required String description,
      Value<double> quantityFound,
      required String physicalLocation,
      Value<String?> sapLocation,
      Value<String?> note,
      Value<String?> metadataEnrichment,
      required String operatorName,
      required String deviceId,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$InventoryRecordsTableUpdateCompanionBuilder =
    InventoryRecordsCompanion Function({
      Value<String> id,
      Value<String> inventoryId,
      Value<String> sourceType,
      Value<int?> importedItemId,
      Value<String> primaryId,
      Value<String?> secondaryId,
      Value<String> description,
      Value<double> quantityFound,
      Value<String> physicalLocation,
      Value<String?> sapLocation,
      Value<String?> note,
      Value<String?> metadataEnrichment,
      Value<String> operatorName,
      Value<String> deviceId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$InventoryRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryRecordsTable> {
  $$InventoryRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get inventoryId => $composableBuilder(
    column: $table.inventoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get importedItemId => $composableBuilder(
    column: $table.importedItemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryId => $composableBuilder(
    column: $table.primaryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get secondaryId => $composableBuilder(
    column: $table.secondaryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantityFound => $composableBuilder(
    column: $table.quantityFound,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get physicalLocation => $composableBuilder(
    column: $table.physicalLocation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sapLocation => $composableBuilder(
    column: $table.sapLocation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataEnrichment => $composableBuilder(
    column: $table.metadataEnrichment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operatorName => $composableBuilder(
    column: $table.operatorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
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
}

class $$InventoryRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryRecordsTable> {
  $$InventoryRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inventoryId => $composableBuilder(
    column: $table.inventoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get importedItemId => $composableBuilder(
    column: $table.importedItemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryId => $composableBuilder(
    column: $table.primaryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get secondaryId => $composableBuilder(
    column: $table.secondaryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantityFound => $composableBuilder(
    column: $table.quantityFound,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get physicalLocation => $composableBuilder(
    column: $table.physicalLocation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sapLocation => $composableBuilder(
    column: $table.sapLocation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataEnrichment => $composableBuilder(
    column: $table.metadataEnrichment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operatorName => $composableBuilder(
    column: $table.operatorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
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
}

class $$InventoryRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryRecordsTable> {
  $$InventoryRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get inventoryId => $composableBuilder(
    column: $table.inventoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get importedItemId => $composableBuilder(
    column: $table.importedItemId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get primaryId =>
      $composableBuilder(column: $table.primaryId, builder: (column) => column);

  GeneratedColumn<String> get secondaryId => $composableBuilder(
    column: $table.secondaryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quantityFound => $composableBuilder(
    column: $table.quantityFound,
    builder: (column) => column,
  );

  GeneratedColumn<String> get physicalLocation => $composableBuilder(
    column: $table.physicalLocation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sapLocation => $composableBuilder(
    column: $table.sapLocation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get metadataEnrichment => $composableBuilder(
    column: $table.metadataEnrichment,
    builder: (column) => column,
  );

  GeneratedColumn<String> get operatorName => $composableBuilder(
    column: $table.operatorName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$InventoryRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventoryRecordsTable,
          InventoryRecord,
          $$InventoryRecordsTableFilterComposer,
          $$InventoryRecordsTableOrderingComposer,
          $$InventoryRecordsTableAnnotationComposer,
          $$InventoryRecordsTableCreateCompanionBuilder,
          $$InventoryRecordsTableUpdateCompanionBuilder,
          (
            InventoryRecord,
            BaseReferences<
              _$AppDatabase,
              $InventoryRecordsTable,
              InventoryRecord
            >,
          ),
          InventoryRecord,
          PrefetchHooks Function()
        > {
  $$InventoryRecordsTableTableManager(
    _$AppDatabase db,
    $InventoryRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> inventoryId = const Value.absent(),
                Value<String> sourceType = const Value.absent(),
                Value<int?> importedItemId = const Value.absent(),
                Value<String> primaryId = const Value.absent(),
                Value<String?> secondaryId = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> quantityFound = const Value.absent(),
                Value<String> physicalLocation = const Value.absent(),
                Value<String?> sapLocation = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> metadataEnrichment = const Value.absent(),
                Value<String> operatorName = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryRecordsCompanion(
                id: id,
                inventoryId: inventoryId,
                sourceType: sourceType,
                importedItemId: importedItemId,
                primaryId: primaryId,
                secondaryId: secondaryId,
                description: description,
                quantityFound: quantityFound,
                physicalLocation: physicalLocation,
                sapLocation: sapLocation,
                note: note,
                metadataEnrichment: metadataEnrichment,
                operatorName: operatorName,
                deviceId: deviceId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String inventoryId,
                required String sourceType,
                Value<int?> importedItemId = const Value.absent(),
                required String primaryId,
                Value<String?> secondaryId = const Value.absent(),
                required String description,
                Value<double> quantityFound = const Value.absent(),
                required String physicalLocation,
                Value<String?> sapLocation = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> metadataEnrichment = const Value.absent(),
                required String operatorName,
                required String deviceId,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => InventoryRecordsCompanion.insert(
                id: id,
                inventoryId: inventoryId,
                sourceType: sourceType,
                importedItemId: importedItemId,
                primaryId: primaryId,
                secondaryId: secondaryId,
                description: description,
                quantityFound: quantityFound,
                physicalLocation: physicalLocation,
                sapLocation: sapLocation,
                note: note,
                metadataEnrichment: metadataEnrichment,
                operatorName: operatorName,
                deviceId: deviceId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InventoryRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventoryRecordsTable,
      InventoryRecord,
      $$InventoryRecordsTableFilterComposer,
      $$InventoryRecordsTableOrderingComposer,
      $$InventoryRecordsTableAnnotationComposer,
      $$InventoryRecordsTableCreateCompanionBuilder,
      $$InventoryRecordsTableUpdateCompanionBuilder,
      (
        InventoryRecord,
        BaseReferences<_$AppDatabase, $InventoryRecordsTable, InventoryRecord>,
      ),
      InventoryRecord,
      PrefetchHooks Function()
    >;
typedef $$SettingsTableCreateCompanionBuilder =
    SettingsCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$SettingsTableUpdateCompanionBuilder =
    SettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          Setting,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
          Setting,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      Setting,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
      Setting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ImportedItemsTableTableManager get importedItems =>
      $$ImportedItemsTableTableManager(_db, _db.importedItems);
  $$InventoriesTableTableManager get inventories =>
      $$InventoriesTableTableManager(_db, _db.inventories);
  $$InventoryRecordsTableTableManager get inventoryRecords =>
      $$InventoryRecordsTableTableManager(_db, _db.inventoryRecords);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
}
