import 'dart:io';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:kaballo/core/database/app_database.dart';
import 'package:kaballo/core/di/providers.dart';
import 'package:kaballo/features/inventories/inventory_providers.dart';
import 'package:kaballo/features/inventories/inventory_service.dart';
import 'excel_export_service.dart';
import 'package:kaballo/features/export/package_service.dart';

final excelExportServiceProvider = Provider<ExcelExportService>((ref) {
  return ExcelExportService();
});

final packageServiceProvider = Provider<PackageService>((ref) {
  return PackageService();
});

enum ExportStatus { idle, exporting, done, error }

class ExportState {
  final ExportStatus status;
  final String? message;
  final File? file;

  const ExportState({
    this.status = ExportStatus.idle,
    this.message,
    this.file,
  });
}

class ExportNotifier extends StateNotifier<ExportState> {
  final ExcelExportService _excelService;
  final PackageService _packageService;
  final InventoryService _invService;
  final ImportedItemsDao _itemsDao;

  ExportNotifier(
      this._excelService, this._packageService, this._invService, this._itemsDao)
      : super(const ExportState());

  Future<void> exportExcel(String inventoryId) async {
    state = const ExportState(status: ExportStatus.exporting);
    try {
      final inv = await _invService.getById(inventoryId);
      if (inv == null) throw Exception('Inventario no encontrado');
      final records = await _invService.getRecords(inventoryId);

      // Load all referenced ImportedItems for full field export
      final ids = records
          .map((r) => r.importedItemId)
          .whereType<int>()
          .toSet()
          .toList();
      final Map<int, ImportedItem> itemsById = {};
      for (final id in ids) {
        final item = await _itemsDao.getById(id);
        if (item != null) itemsById[id] = item;
      }

      final file = await _excelService.exportInventoryFull(
          inventory: inv, records: records, itemsById: itemsById);
      state = ExportState(status: ExportStatus.done, file: file);
      await _shareFile(file,
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
    } catch (e) {
      state = ExportState(status: ExportStatus.error, message: e.toString());
    }
  }

  Future<void> exportPackage(String inventoryId) async {
    state = const ExportState(status: ExportStatus.exporting);
    try {
      final inv = await _invService.getById(inventoryId);
      if (inv == null) throw Exception('Inventario no encontrado');
      final records = await _invService.getRecords(inventoryId);
      final file = await _packageService.exportPackage(
          inventory: inv, records: records);
      state = ExportState(status: ExportStatus.done, file: file);
      await _shareFile(file, 'application/zip');
    } catch (e) {
      state = ExportState(status: ExportStatus.error, message: e.toString());
    }
  }

  Future<void> importPackage({
    required List<int> bytes,
    required String targetInventoryId,
  }) async {
    state = const ExportState(status: ExportStatus.exporting);
    try {
      final result = await _packageService.importPackage(bytes);
      if (result == null) throw Exception('Archivo de paquete inválido');
      final updated = result.records
          .map((r) => r.copyWith(inventoryId: Value(targetInventoryId)))
          .toList();
      await _invService.mergeRecords(updated);
      state = ExportState(
        status: ExportStatus.done,
        message: '${result.records.length} registros importados',
      );
    } catch (e) {
      state = ExportState(status: ExportStatus.error, message: e.toString());
    }
  }

  Future<void> _shareFile(File file, String mimeType) async {
    try {
      await Share.shareXFiles(
        [XFile(file.path, mimeType: mimeType)],
      );
    } catch (_) {}
  }

  void reset() => state = const ExportState();
}

final exportNotifierProvider =
    StateNotifierProvider.autoDispose<ExportNotifier, ExportState>((ref) {
  return ExportNotifier(
    ref.watch(excelExportServiceProvider),
    ref.watch(packageServiceProvider),
    ref.watch(inventoryServiceProvider),
    ref.watch(importedItemsDaoProvider),
  );
});
