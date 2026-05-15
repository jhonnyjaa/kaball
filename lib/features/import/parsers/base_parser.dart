import 'dart:convert';
import 'package:excel/excel.dart';
import 'package:kaballo/core/database/app_database.dart';
import 'package:drift/drift.dart';

abstract class BaseParser {
  String get sourceType;

  List<String> get searchableColumns;

  Future<List<ImportedItemsCompanion>> parse(
    List<int> bytes,
    String batchId,
  ) async {
    final excel = Excel.decodeBytes(bytes);
    final sheet = excel.tables.values.firstOrNull;
    if (sheet == null || sheet.rows.isEmpty) return [];

    final headerRow = _findHeaderRow(sheet.rows);
    if (headerRow == null) return [];

    final colMap = _buildColumnMap(headerRow);
    final dataRows = sheet.rows.skip(headerRow.index + 1).toList();

    final results = <ImportedItemsCompanion>[];
    for (final row in dataRows) {
      final companion = parseRow(row, colMap, batchId);
      if (companion != null) results.add(companion);
    }
    return results;
  }

  bool isHeaderRow(List<String> row);

  ({int index, List<Data?> cells})? _findHeaderRow(List<List<Data?>> rows) {
    for (var i = 0; i < rows.length && i < 20; i++) {
      final row = rows[i];
      final texts =
          row.map((c) => _cellText(c)?.toLowerCase() ?? '').toList();
      if (isHeaderRow(texts)) {
        return (index: i, cells: row);
      }
    }
    return null;
  }

  Map<String, int> _buildColumnMap(({int index, List<Data?> cells}) header) {
    final map = <String, int>{};
    final seen = <String, int>{};
    for (var i = 0; i < header.cells.length; i++) {
      final text = _cellText(header.cells[i]);
      if (text == null || text.isEmpty) continue;
      final key = text.trim();
      final count = (seen[key] ?? 0) + 1;
      seen[key] = count;
      // First occurrence keeps plain key; duplicates get suffix "(2)", "(3)"...
      map[count == 1 ? key : '$key ($count)'] = i;
    }
    return map;
  }

  ImportedItemsCompanion? parseRow(
    List<Data?> row,
    Map<String, int> colMap,
    String batchId,
  );

  String? col(List<Data?> row, Map<String, int> colMap, String name) {
    final idx = colMap[name];
    if (idx == null || idx >= row.length) return null;
    return _cellText(row[idx]);
  }

  String? _cellText(Data? cell) {
    if (cell == null) return null;
    final v = cell.value;
    if (v == null) return null;
    String text;
    if (v is TextCellValue) {
      text = _spanText(v.value).trim();
    } else if (v is IntCellValue) {
      text = v.value.toString();
    } else if (v is DoubleCellValue) {
      text = v.value.toString();
    } else if (v is DateCellValue) {
      text = '${v.day}/${v.month.toString().padLeft(2, '0')}/${v.year}';
    } else {
      text = v.toString().trim();
    }
    return text.isEmpty ? null : text;
  }

  String _spanText(TextSpan span) {
    final sb = StringBuffer();
    if (span.text != null) sb.write(span.text);
    span.children?.forEach((c) => sb.write(_spanText(c)));
    return sb.toString();
  }

  String buildSearchText(List<String?> values) {
    return values
        .where((v) => v != null && v.isNotEmpty)
        .map((v) => v!)
        .join(' ');
  }

  ImportedItemsCompanion makeCompanion({
    required String batchId,
    required String primaryId,
    String? secondaryId,
    required String description,
    String? location,
    required Map<String, dynamic> rawData,
    required String searchText,
  }) {
    return ImportedItemsCompanion.insert(
      sourceType: sourceType,
      primaryId: primaryId,
      secondaryId: Value(secondaryId),
      description: description,
      location: Value(location),
      rawData: jsonEncode(rawData),
      searchText: searchText,
      importBatchId: batchId,
    );
  }
}
