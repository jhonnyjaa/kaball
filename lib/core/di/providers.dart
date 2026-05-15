import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('Override in ProviderScope');
});

final settingsDaoProvider = Provider<SettingsDao>((ref) {
  return ref.watch(databaseProvider).settingsDao;
});

final importedItemsDaoProvider = Provider<ImportedItemsDao>((ref) {
  return ref.watch(databaseProvider).importedItemsDao;
});

final inventoriesDaoProvider = Provider<InventoriesDao>((ref) {
  return ref.watch(databaseProvider).inventoriesDao;
});

final inventoryRecordsDaoProvider = Provider<InventoryRecordsDao>((ref) {
  return ref.watch(databaseProvider).inventoryRecordsDao;
});
