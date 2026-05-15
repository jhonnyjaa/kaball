import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaballo/features/inventories/inventory_providers.dart';
import 'package:kaballo/features/inventories/inventory_service.dart';

final recordDeleteNotifierProvider =
    StateNotifierProvider.autoDispose<RecordDeleteNotifier, AsyncValue<void>>(
        (ref) {
  return RecordDeleteNotifier(ref.watch(inventoryServiceProvider));
});

class RecordDeleteNotifier extends StateNotifier<AsyncValue<void>> {
  final InventoryService _service;
  RecordDeleteNotifier(this._service) : super(const AsyncValue.data(null));

  Future<void> delete(String recordId) async {
    state = const AsyncValue.loading();
    try {
      await _service.deleteRecord(recordId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
