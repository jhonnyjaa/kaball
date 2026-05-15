import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import 'package:kaballo/core/database/app_database.dart';

class InventoryService {
  final InventoriesDao _inventoriesDao;
  final InventoryRecordsDao _recordsDao;
  static const _uuid = Uuid();

  InventoryService(this._inventoriesDao, this._recordsDao);

  Stream<List<Inventory>> watchAll() => _inventoriesDao.watchAll();
  Future<List<Inventory>> getAll() => _inventoriesDao.getAll();
  Future<Inventory?> getById(String id) => _inventoriesDao.getById(id);

  Future<Inventory> create({
    required String name,
    required String operatorName,
    required String deviceId,
    String? description,
    int? targetCount,
  }) async {
    final now = DateTime.now();
    final inv = InventoriesCompanion.insert(
      id: _uuid.v4(),
      name: name,
      operatorName: operatorName,
      deviceId: deviceId,
      createdAt: now,
      updatedAt: now,
      description: Value(description),
      targetCount: Value(targetCount),
    );
    await _inventoriesDao.insert(inv);
    return (await _inventoriesDao.getById(inv.id.value))!;
  }

  Future<void> update(String id, {String? name, String? description, int? targetCount}) async {
    await _inventoriesDao.update_(InventoriesCompanion(
      id: Value(id),
      name: name != null ? Value(name) : const Value.absent(),
      description: description != null ? Value(description) : const Value.absent(),
      targetCount: targetCount != null ? Value(targetCount) : const Value.absent(),
      updatedAt: Value(DateTime.now()),
    ));
  }

  Future<void> archive(String id) => _inventoriesDao.archive(id);

  Future<void> delete(String id) async {
    await _recordsDao.deleteByInventory(id);
    await _inventoriesDao.delete_(id);
  }

  Future<int> getRecordCount(String inventoryId) =>
      _recordsDao.countByInventory(inventoryId);

  Stream<List<InventoryRecord>> watchRecords(String inventoryId) =>
      _recordsDao.watchByInventory(inventoryId);

  Future<List<InventoryRecord>> getRecords(String inventoryId) =>
      _recordsDao.getByInventory(inventoryId);

  Future<InventoryRecord> addRecord({
    required String inventoryId,
    required String sourceType,
    required int? importedItemId,
    required String primaryId,
    String? secondaryId,
    required String description,
    required double quantityFound,
    required String physicalLocation,
    String? sapLocation,
    String? note,
    Map<String, dynamic>? metadataEnrichment,
    required String operatorName,
    required String deviceId,
  }) async {
    final now = DateTime.now();
    final record = InventoryRecordsCompanion.insert(
      id: _uuid.v4(),
      inventoryId: inventoryId,
      sourceType: sourceType,
      importedItemId: Value(importedItemId),
      primaryId: primaryId,
      secondaryId: Value(secondaryId),
      description: description,
      quantityFound: Value(quantityFound),
      physicalLocation: physicalLocation,
      sapLocation: Value(sapLocation),
      note: Value(note),
      metadataEnrichment:
          Value(metadataEnrichment != null ? jsonEncode(metadataEnrichment) : null),
      operatorName: operatorName,
      deviceId: deviceId,
      createdAt: now,
      updatedAt: now,
    );
    await _recordsDao.insert(record);
    await _inventoriesDao.update_(InventoriesCompanion(
      id: Value(inventoryId),
      updatedAt: Value(now),
    ));
    return (await _recordsDao.getById(record.id.value))!;
  }

  Future<void> updateRecord(
    String recordId, {
    double? quantityFound,
    String? physicalLocation,
    String? note,
    Map<String, dynamic>? metadataEnrichment,
  }) async {
    await _recordsDao.update_(InventoryRecordsCompanion(
      id: Value(recordId),
      quantityFound:
          quantityFound != null ? Value(quantityFound) : const Value.absent(),
      physicalLocation: physicalLocation != null
          ? Value(physicalLocation)
          : const Value.absent(),
      note: note != null ? Value(note) : const Value.absent(),
      metadataEnrichment: metadataEnrichment != null
          ? Value(jsonEncode(metadataEnrichment))
          : const Value.absent(),
      updatedAt: Value(DateTime.now()),
    ));
  }

  Future<void> deleteRecord(String recordId) => _recordsDao.delete_(recordId);

  Future<void> mergeRecords(List<InventoryRecordsCompanion> records) =>
      _recordsDao.insertBatch(records);
}
