import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaballo/core/database/app_database.dart';
import 'package:kaballo/core/di/providers.dart';
import 'inventory_service.dart';

final inventoryServiceProvider = Provider<InventoryService>((ref) {
  return InventoryService(
    ref.watch(inventoriesDaoProvider),
    ref.watch(inventoryRecordsDaoProvider),
  );
});

final inventoriesProvider = StreamProvider<List<Inventory>>((ref) {
  return ref.watch(inventoryServiceProvider).watchAll();
});

final activeInventoryIdProvider = StateProvider<String?>((ref) => null);

final activeInventoryProvider = FutureProvider<Inventory?>((ref) async {
  final id = ref.watch(activeInventoryIdProvider);
  if (id == null) return null;
  return ref.watch(inventoryServiceProvider).getById(id);
});

final inventoryRecordsProvider =
    StreamProvider.family<List<InventoryRecord>, String>((ref, inventoryId) {
  return ref.watch(inventoryServiceProvider).watchRecords(inventoryId);
});

final inventoryRecordCountProvider =
    FutureProvider.family<int, String>((ref, inventoryId) {
  return ref.watch(inventoryServiceProvider).getRecordCount(inventoryId);
});
