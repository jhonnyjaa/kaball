import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaballo/core/database/app_database.dart';
import 'package:kaballo/features/inventories/inventory_providers.dart';
import 'package:kaballo/features/inventories/inventory_service.dart';
import 'package:kaballo/features/settings/settings_providers.dart';

class CaptureNotifier extends StateNotifier<AsyncValue<void>> {
  final InventoryService _service;
  final Ref _ref;

  CaptureNotifier(this._service, this._ref) : super(const AsyncValue.data(null));

  Future<bool> capture({
    required ImportedItem item,
    required String inventoryId,
    required double quantity,
    required String physicalLocation,
    String? note,
    Map<String, dynamic>? metadata,
    required String operatorName,
    required String deviceId,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _service.addRecord(
        inventoryId: inventoryId,
        sourceType: item.sourceType,
        importedItemId: item.id,
        primaryId: item.primaryId,
        secondaryId: item.secondaryId,
        description: item.description,
        quantityFound: quantity,
        physicalLocation: physicalLocation,
        sapLocation: item.location,
        note: note,
        metadataEnrichment: metadata,
        operatorName: operatorName,
        deviceId: deviceId,
      );

      if (physicalLocation.isNotEmpty) {
        await _ref.read(currentLocationProvider.notifier).set(physicalLocation);
      }

      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> captureManual({
    required String inventoryId,
    required String sourceType,
    required String primaryId,
    String? secondaryId,
    required String description,
    required double quantity,
    required String physicalLocation,
    String? note,
    Map<String, dynamic>? metadata,
    required String operatorName,
    required String deviceId,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _service.addRecord(
        inventoryId: inventoryId,
        sourceType: sourceType,
        importedItemId: null,
        primaryId: primaryId,
        secondaryId: secondaryId,
        description: description,
        quantityFound: quantity,
        physicalLocation: physicalLocation,
        sapLocation: null,
        note: note,
        metadataEnrichment: metadata,
        operatorName: operatorName,
        deviceId: deviceId,
      );
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  void reset() => state = const AsyncValue.data(null);
}

final captureNotifierProvider =
    StateNotifierProvider.autoDispose<CaptureNotifier, AsyncValue<void>>((ref) {
  return CaptureNotifier(ref.watch(inventoryServiceProvider), ref);
});
