import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'app_database.g.dart';

// ─── Tables ────────────────────────────────────────────────────────────────

class ImportedItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sourceType => text()();
  TextColumn get primaryId => text()();
  TextColumn get secondaryId => text().nullable()();
  TextColumn get description => text()();
  TextColumn get location => text().nullable()();
  TextColumn get rawData => text()();
  TextColumn get searchText => text()();
  DateTimeColumn get importedAt =>
      dateTime().withDefault(currentDateAndTime)();
  TextColumn get importBatchId => text()();
}

class Inventories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get operatorName => text()();
  TextColumn get deviceId => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get status =>
      text().withDefault(const Constant('active'))();
  IntColumn get targetCount => integer().nullable()();
  TextColumn get description => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class InventoryRecords extends Table {
  TextColumn get id => text()();
  TextColumn get inventoryId => text()();
  TextColumn get sourceType => text()();
  IntColumn get importedItemId => integer().nullable()();
  TextColumn get primaryId => text()();
  TextColumn get secondaryId => text().nullable()();
  TextColumn get description => text()();
  RealColumn get quantityFound => real().withDefault(const Constant(1.0))();
  TextColumn get physicalLocation => text()();
  TextColumn get sapLocation => text().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get metadataEnrichment => text().nullable()();
  TextColumn get operatorName => text()();
  TextColumn get deviceId => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

// ─── DAOs ──────────────────────────────────────────────────────────────────

@DriftAccessor(tables: [Settings])
class SettingsDao extends DatabaseAccessor<AppDatabase>
    with _$SettingsDaoMixin {
  SettingsDao(super.db);

  Future<String?> get(String key) async {
    final row = await (select(settings)
          ..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }

  Future<void> set(String key, String value) async {
    await into(settings).insertOnConflictUpdate(
      SettingsCompanion.insert(key: key, value: value),
    );
  }

  Future<void> delete_(String key) async {
    await (delete(settings)..where((t) => t.key.equals(key))).go();
  }
}

@DriftAccessor(tables: [ImportedItems])
class ImportedItemsDao extends DatabaseAccessor<AppDatabase>
    with _$ImportedItemsDaoMixin {
  ImportedItemsDao(super.db);

  Future<int> insertItem(ImportedItemsCompanion item) =>
      into(importedItems).insert(item);

  Future<void> insertBatch(List<ImportedItemsCompanion> items) async {
    await batch((b) {
      b.insertAll(importedItems, items, mode: InsertMode.insertOrReplace);
    });
  }

  // Single INSERT…SELECT — O(1) round-trips instead of O(N)
  Future<void> populateFtsForBatch(String batchId) async {
    await db.customStatement(
      'INSERT INTO search_fts(item_id, search_text) '
      'SELECT CAST(id AS TEXT), search_text '
      'FROM imported_items WHERE import_batch_id = ?',
      [batchId],
    );
  }

  Future<int> countBySource(String sourceType) async {
    final result = await db.customSelect(
      'SELECT COUNT(*) as c FROM imported_items WHERE source_type = ?',
      variables: [Variable.withString(sourceType)],
    ).getSingle();
    return result.read<int>('c');
  }

  Future<int> totalCount() async {
    final result = await db
        .customSelect('SELECT COUNT(*) as c FROM imported_items')
        .getSingle();
    return result.read<int>('c');
  }

  Future<void> clearAll() async {
    await db.customStatement('DELETE FROM search_fts');
    await delete(importedItems).go();
  }

  Future<void> clearBySource(String sourceType) async {
    // Remove FTS entries via subquery — no N-round-trip ID fetch needed
    await db.customStatement(
      'DELETE FROM search_fts WHERE item_id IN '
      '(SELECT CAST(id AS TEXT) FROM imported_items WHERE source_type = ?)',
      [sourceType],
    );
    await (delete(importedItems)
          ..where((t) => t.sourceType.equals(sourceType)))
        .go();
  }

  Future<ImportedItem?> getById(int id) =>
      (select(importedItems)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<List<ImportedItem>> getBySource(String sourceType) =>
      (select(importedItems)
            ..where((t) => t.sourceType.equals(sourceType)))
          .get();
}

@DriftAccessor(tables: [Inventories])
class InventoriesDao extends DatabaseAccessor<AppDatabase>
    with _$InventoriesDaoMixin {
  InventoriesDao(super.db);

  Stream<List<Inventory>> watchAll() =>
      (select(inventories)
            ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
          .watch();

  Future<List<Inventory>> getAll() =>
      (select(inventories)
            ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
          .get();

  Future<Inventory?> getById(String id) =>
      (select(inventories)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<void> insert(InventoriesCompanion inv) =>
      into(inventories).insert(inv);

  Future<void> update_(InventoriesCompanion inv) =>
      (update(inventories)..where((t) => t.id.equals(inv.id.value)))
          .write(inv);

  Future<void> archive(String id) =>
      (update(inventories)..where((t) => t.id.equals(id)))
          .write(const InventoriesCompanion(status: Value('archived')));

  Future<void> delete_(String id) =>
      (delete(inventories)..where((t) => t.id.equals(id))).go();
}

@DriftAccessor(tables: [InventoryRecords])
class InventoryRecordsDao extends DatabaseAccessor<AppDatabase>
    with _$InventoryRecordsDaoMixin {
  InventoryRecordsDao(super.db);

  Stream<List<InventoryRecord>> watchByInventory(String inventoryId) =>
      (select(inventoryRecords)
            ..where((t) => t.inventoryId.equals(inventoryId))
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .watch();

  Future<List<InventoryRecord>> getByInventory(String inventoryId) =>
      (select(inventoryRecords)
            ..where((t) => t.inventoryId.equals(inventoryId))
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .get();

  Future<InventoryRecord?> getById(String id) =>
      (select(inventoryRecords)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<int> countByInventory(String inventoryId) async {
    final result = await db.customSelect(
      'SELECT COUNT(*) as c FROM inventory_records WHERE inventory_id = ?',
      variables: [Variable.withString(inventoryId)],
    ).getSingle();
    return result.read<int>('c');
  }

  Future<void> insert(InventoryRecordsCompanion record) =>
      into(inventoryRecords).insert(record);

  Future<void> update_(InventoryRecordsCompanion record) =>
      (update(inventoryRecords)
            ..where((t) => t.id.equals(record.id.value)))
          .write(record);

  Future<void> delete_(String id) =>
      (delete(inventoryRecords)..where((t) => t.id.equals(id))).go();

  Future<void> deleteByInventory(String inventoryId) =>
      (delete(inventoryRecords)
            ..where((t) => t.inventoryId.equals(inventoryId)))
          .go();

  Future<void> insertBatch(List<InventoryRecordsCompanion> records) async {
    await batch((b) {
      b.insertAll(inventoryRecords, records, mode: InsertMode.insertOrIgnore);
    });
  }
}

// ─── Database ──────────────────────────────────────────────────────────────

@DriftDatabase(
  tables: [ImportedItems, Inventories, InventoryRecords, Settings],
  daos: [SettingsDao, ImportedItemsDao, InventoriesDao, InventoryRecordsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          await _createFts5();
        },
      );

  Future<void> _createFts5() async {
    await customStatement('''
      CREATE VIRTUAL TABLE IF NOT EXISTS search_fts
      USING fts5(
        item_id UNINDEXED,
        search_text,
        tokenize = 'unicode61 remove_diacritics 2'
      )
    ''');
  }

  Future<List<ImportedItem>> ftsSearch(String query, {int limit = 150}) async {
    if (query.trim().isEmpty) return [];
    final ftsQuery = _buildFtsQuery(query);
    if (ftsQuery.isEmpty) return [];
    try {
      final rows = await customSelect(
        '''
        SELECT ii.*,
          CASE
            WHEN LOWER(ii.primary_id) = LOWER(:raw) THEN 0
            WHEN LOWER(ii.secondary_id) = LOWER(:raw) THEN 0
            WHEN LOWER(ii.primary_id) LIKE LOWER(:prefix) THEN 1
            ELSE 2
          END AS boost
        FROM imported_items ii
        JOIN search_fts f ON CAST(f.item_id AS INTEGER) = ii.id
        WHERE search_fts MATCH :q
        ORDER BY boost, rank
        LIMIT :lim
        ''',
        variables: [
          Variable.withString(query.trim()),
          Variable.withString('${query.trim()}%'),
          Variable.withString(ftsQuery),
          Variable.withInt(limit),
        ],
      ).get();

      return rows.map((row) {
        return ImportedItem(
          id: row.read<int>('id'),
          sourceType: row.read<String>('source_type'),
          primaryId: row.read<String>('primary_id'),
          secondaryId: row.readNullable<String>('secondary_id'),
          description: row.read<String>('description'),
          location: row.readNullable<String>('location'),
          rawData: row.read<String>('raw_data'),
          searchText: row.read<String>('search_text'),
          importedAt: row.read<DateTime>('imported_at'),
          importBatchId: row.read<String>('import_batch_id'),
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  String _buildFtsQuery(String input) {
    final words = input
        .trim()
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .toList();
    if (words.isEmpty) return '';
    return words
        .map((w) {
          final clean = w.replaceAll(RegExp(r'[^\w\d]'), '');
          return clean.isEmpty ? null : '$clean*';
        })
        .whereType<String>()
        .join(' ');
  }
}

// ─── Database factory ──────────────────────────────────────────────────────

Future<AppDatabase> openDatabase() async {
  if (Platform.isAndroid) {
    await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
  }
  final dbFolder = await getApplicationDocumentsDirectory();
  final file = File(p.join(dbFolder.path, 'kaballo.db'));
  return AppDatabase(NativeDatabase(file));
}
