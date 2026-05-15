import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaballo/core/database/app_database.dart';
import 'package:kaballo/core/di/providers.dart';
import 'import_service.dart';

final importedItemByIdProvider =
    FutureProvider.family<ImportedItem?, int?>((ref, id) async {
  if (id == null) return null;
  return ref.watch(importedItemsDaoProvider).getById(id);
});

final importServiceProvider = Provider<ImportService>((ref) {
  return ImportService(ref.watch(importedItemsDaoProvider));
});

final sourceCountsProvider = FutureProvider<Map<String, int>>((ref) {
  return ref.watch(importServiceProvider).getSourceCounts();
});

final totalImportedProvider = FutureProvider<int>((ref) {
  return ref.watch(importServiceProvider).getTotalCount();
});

enum ImportStatus { idle, importing, success, error }

class ImportState {
  final ImportStatus status;
  final String? message;
  final int? count;

  const ImportState({
    this.status = ImportStatus.idle,
    this.message,
    this.count,
  });
}

class ImportNotifier extends StateNotifier<ImportState> {
  final ImportService _service;
  final Ref _ref;

  ImportNotifier(this._service, this._ref) : super(const ImportState());

  Future<void> importFile({
    required List<int> bytes,
    required String sourceType,
    bool replaceExisting = true,
  }) async {
    state = const ImportState(status: ImportStatus.importing);
    final result = await _service.importFile(
      bytes: bytes,
      sourceType: sourceType,
      replaceExisting: replaceExisting,
    );
    if (result.success) {
      _ref.invalidate(sourceCountsProvider);
      _ref.invalidate(totalImportedProvider);
      state = ImportState(
        status: ImportStatus.success,
        message: '${result.count} registros importados',
        count: result.count,
      );
    } else {
      state = ImportState(
        status: ImportStatus.error,
        message: result.error,
      );
    }
  }

  void reset() => state = const ImportState();
}

final importNotifierProvider =
    StateNotifierProvider<ImportNotifier, ImportState>((ref) {
  return ImportNotifier(ref.watch(importServiceProvider), ref);
});
