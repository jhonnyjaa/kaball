import 'package:flutter/material.dart';
import 'package:kaballo/core/database/app_database.dart';
import 'package:kaballo/features/operator_setup/screens/operator_setup_screen.dart';
import 'package:kaballo/features/inventories/screens/inventory_list_screen.dart';
import 'package:kaballo/features/inventories/screens/create_inventory_screen.dart';
import 'package:kaballo/features/inventories/screens/inventory_detail_screen.dart';
import 'package:kaballo/features/search/screens/search_screen.dart';
import 'package:kaballo/features/capture/screens/capture_screen.dart';
import 'package:kaballo/features/capture/screens/metadata_enrichment_screen.dart';
import 'package:kaballo/features/records/screens/records_list_screen.dart';
import 'package:kaballo/features/records/screens/record_detail_screen.dart';
import 'package:kaballo/features/import/screens/import_screen.dart';
import 'package:kaballo/features/export/screens/export_screen.dart';
import 'package:kaballo/features/settings/screens/settings_screen.dart';

class AppRoutes {
  static const operatorSetup = '/setup';
  static const inventoryList = '/inventories';
  static const createInventory = '/inventories/create';
  static const inventoryDetail = '/inventories/detail';
  static const search = '/search';
  static const capture = '/capture';
  static const metadataEnrichment = '/capture/metadata';
  static const recordsList = '/records';
  static const recordDetail = '/records/detail';
  static const import_ = '/import';
  static const export_ = '/export';
  static const settings = '/settings';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.operatorSetup:
      return _fade(const OperatorSetupScreen());

    case AppRoutes.inventoryList:
      return _fade(const InventoryListScreen());

    case AppRoutes.createInventory:
      return _slide(const CreateInventoryScreen());

    case AppRoutes.inventoryDetail:
      final id = settings.arguments as String;
      return _slide(InventoryDetailScreen(inventoryId: id));

    case AppRoutes.search:
      final args = settings.arguments as Map<String, dynamic>;
      return _slide(SearchScreen(
        inventoryId: args['inventoryId'] as String,
      ));

    case AppRoutes.capture:
      final args = settings.arguments as Map<String, dynamic>;
      return _slide(CaptureScreen(
        item: args['item'] as ImportedItem,
        inventoryId: args['inventoryId'] as String,
      ));

    case AppRoutes.metadataEnrichment:
      final args = settings.arguments as Map<String, dynamic>;
      return _slide(MetadataEnrichmentScreen(
        initial: args['initial'] as Map<String, dynamic>?,
        onSave: args['onSave'] as void Function(Map<String, dynamic>),
      ));

    case AppRoutes.recordsList:
      final id = settings.arguments as String;
      return _slide(RecordsListScreen(inventoryId: id));

    case AppRoutes.recordDetail:
      final record = settings.arguments as InventoryRecord;
      return _slide(RecordDetailScreen(record: record));

    case AppRoutes.import_:
      return _slide(const ImportScreen());

    case AppRoutes.export_:
      final id = settings.arguments as String;
      return _slide(ExportScreen(inventoryId: id));

    case AppRoutes.settings:
      return _slide(const SettingsScreen());

    default:
      return _fade(const InventoryListScreen());
  }
}

PageRouteBuilder _fade(Widget page) => PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, a, __, child) =>
          FadeTransition(opacity: a, child: child),
      transitionDuration: const Duration(milliseconds: 200),
    );

PageRouteBuilder _slide(Widget page) => PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, a, __, child) => SlideTransition(
        position:
            Tween(begin: const Offset(1, 0), end: Offset.zero).animate(a),
        child: child,
      ),
      transitionDuration: const Duration(milliseconds: 220),
    );
