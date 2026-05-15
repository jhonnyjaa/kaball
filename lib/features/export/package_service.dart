import 'dart:convert';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:intl/intl.dart';
import 'package:kaballo/core/database/app_database.dart';

const _packageVersion = '1.0';

class PackageService {
  Future<File> exportPackage({
    required Inventory inventory,
    required List<InventoryRecord> records,
  }) async {
    final invJson = jsonEncode(_inventoryToJson(inventory));
    final recordsJson = jsonEncode(records.map(_recordToJson).toList());
    final metaJson = jsonEncode({
      'version': _packageVersion,
      'exported_at': DateTime.now().toIso8601String(),
      'record_count': records.length,
    });

    final archive = Archive();
    archive.addFile(ArchiveFile(
        'inventory.json', invJson.length, utf8.encode(invJson)));
    archive.addFile(ArchiveFile(
        'records.json', recordsJson.length, utf8.encode(recordsJson)));
    archive.addFile(ArchiveFile(
        'metadata.json', metaJson.length, utf8.encode(metaJson)));

    final bytes = ZipEncoder().encode(archive)!;

    final dir = await getApplicationDocumentsDirectory();
    final ts = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final safeName = inventory.name
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(' ', '_');
    final file = File(p.join(dir.path, '${safeName}_$ts.invpack'));
    await file.writeAsBytes(bytes);
    return file;
  }

  Future<({Inventory inventory, List<InventoryRecordsCompanion> records})?>
      importPackage(List<int> bytes) async {
    try {
      final archive = ZipDecoder().decodeBytes(bytes);

      final invFile =
          archive.files.firstWhere((f) => f.name == 'inventory.json');
      final recFile =
          archive.files.firstWhere((f) => f.name == 'records.json');

      final invJson =
          jsonDecode(utf8.decode(invFile.content as List<int>)) as Map;
      final recJsonList =
          jsonDecode(utf8.decode(recFile.content as List<int>)) as List;

      final inventory = _inventoryFromJson(invJson);
      final records =
          recJsonList.map((r) => _recordFromJson(r as Map)).toList();

      return (inventory: inventory, records: records);
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic> _inventoryToJson(Inventory inv) => {
        'id': inv.id,
        'name': inv.name,
        'operator_name': inv.operatorName,
        'device_id': inv.deviceId,
        'created_at': inv.createdAt.toIso8601String(),
        'updated_at': inv.updatedAt.toIso8601String(),
        'status': inv.status,
        'target_count': inv.targetCount,
        'description': inv.description,
      };

  Inventory _inventoryFromJson(Map json) => Inventory(
        id: json['id'] as String,
        name: json['name'] as String,
        operatorName: json['operator_name'] as String,
        deviceId: json['device_id'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
        status: json['status'] as String,
        targetCount: json['target_count'] as int?,
        description: json['description'] as String?,
      );

  Map<String, dynamic> _recordToJson(InventoryRecord r) => {
        'id': r.id,
        'inventory_id': r.inventoryId,
        'source_type': r.sourceType,
        'imported_item_id': r.importedItemId,
        'primary_id': r.primaryId,
        'secondary_id': r.secondaryId,
        'description': r.description,
        'quantity_found': r.quantityFound,
        'physical_location': r.physicalLocation,
        'sap_location': r.sapLocation,
        'note': r.note,
        'metadata_enrichment': r.metadataEnrichment,
        'operator_name': r.operatorName,
        'device_id': r.deviceId,
        'created_at': r.createdAt.toIso8601String(),
        'updated_at': r.updatedAt.toIso8601String(),
      };

  InventoryRecordsCompanion _recordFromJson(Map json) =>
      InventoryRecordsCompanion.insert(
        id: json['id'] as String,
        inventoryId: json['inventory_id'] as String,
        sourceType: json['source_type'] as String,
        importedItemId: Value(json['imported_item_id'] as int?),
        primaryId: json['primary_id'] as String,
        secondaryId: Value(json['secondary_id'] as String?),
        description: json['description'] as String,
        quantityFound:
            Value((json['quantity_found'] as num).toDouble()),
        physicalLocation: json['physical_location'] as String,
        sapLocation: Value(json['sap_location'] as String?),
        note: Value(json['note'] as String?),
        metadataEnrichment:
            Value(json['metadata_enrichment'] as String?),
        operatorName: json['operator_name'] as String,
        deviceId: json['device_id'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );
}
