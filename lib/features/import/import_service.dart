import 'dart:isolate';
import 'package:uuid/uuid.dart';
import 'package:kaballo/core/database/app_database.dart';
import 'parsers/mb52_parser.dart';
import 'parsers/zfir0241_parser.dart';
import 'parsers/zmmr0080_parser.dart';
import 'parsers/zmmr0105_parser.dart';
import 'parsers/base_parser.dart';

class ImportResult {
  final int count;
  final String sourceType;
  final String batchId;
  final String? error;

  const ImportResult({
    required this.count,
    required this.sourceType,
    required this.batchId,
    this.error,
  });

  bool get success => error == null;
}

class ImportService {
  final ImportedItemsDao _dao;
  static const _uuid = Uuid();

  final Map<String, BaseParser> _parsers = {
    'MB52': Mb52Parser(),
    'ZFIR0241': Zfir0241Parser(),
    'ZMMR0080': Zmmr0080Parser(),
    'ZMMR0105': Zmmr0105Parser(),
  };

  ImportService(this._dao);

  Future<ImportResult> importFile({
    required List<int> bytes,
    required String sourceType,
    bool replaceExisting = true,
  }) async {
    final parser = _parsers[sourceType];
    if (parser == null) {
      return ImportResult(
        count: 0,
        sourceType: sourceType,
        batchId: '',
        error: 'Parser no disponible para $sourceType',
      );
    }

    final batchId = _uuid.v4();

    try {
      final companions = await Isolate.run(() async {
        return await parser.parse(bytes, batchId);
      });

      if (companions.isEmpty) {
        return ImportResult(
          count: 0,
          sourceType: sourceType,
          batchId: batchId,
          error: 'No se encontraron datos válidos en el archivo',
        );
      }

      if (replaceExisting) {
        await _dao.clearBySource(sourceType);
      }

      await _dao.insertBatch(companions);
      await _dao.populateFtsForBatch(batchId);

      return ImportResult(
        count: companions.length,
        sourceType: sourceType,
        batchId: batchId,
      );
    } catch (e) {
      return ImportResult(
        count: 0,
        sourceType: sourceType,
        batchId: batchId,
        error: e.toString(),
      );
    }
  }

  Future<Map<String, int>> getSourceCounts() async {
    final result = <String, int>{};
    for (final source in _parsers.keys) {
      result[source] = await _dao.countBySource(source);
    }
    return result;
  }

  Future<int> getTotalCount() => _dao.totalCount();
}
