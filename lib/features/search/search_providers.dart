import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaballo/core/database/app_database.dart';
import 'package:kaballo/core/di/providers.dart';
import 'package:kaballo/core/constants/app_constants.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider =
    FutureProvider.autoDispose<List<ImportedItem>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.trim().length < AppConstants.minSearchLength) return [];

  await Future.delayed(const Duration(milliseconds: 120));

  final db = ref.watch(databaseProvider);
  return db.ftsSearch(query, limit: AppConstants.searchResultLimit);
});
