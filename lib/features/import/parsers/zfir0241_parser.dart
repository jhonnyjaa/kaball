import 'package:excel/excel.dart';
import 'package:kaballo/core/database/app_database.dart';
import 'base_parser.dart';

class Zfir0241Parser extends BaseParser {
  @override
  String get sourceType => 'ZFIR0241';

  @override
  List<String> get searchableColumns => [
        'Act.Fijo',
        'Cod.Antiguo',
        'Nro.Inven.',
        'Denominación',
        'Denominación extra',
        'Txt.núm.pral.AF',
        'Ubi.Física',
      ];

  @override
  bool isHeaderRow(List<String> row) {
    return row.any((c) => c.contains('act.fijo') || c.contains('activo')) &&
        (row.any((c) => c.contains('denominaci')) ||
            row.any((c) => c.contains('ubi')));
  }

  @override
  ImportedItemsCompanion? parseRow(
    List<Data?> row,
    Map<String, int> colMap,
    String batchId,
  ) {
    final actFijo = col(row, colMap, 'Act.Fijo');
    final denominacion = col(row, colMap, 'Denominación');
    if (actFijo == null && denominacion == null) return null;

    final ubiFisica = col(row, colMap, 'Ubi.Física');
    final centro = col(row, colMap, 'Centro');
    final codAntiguo = col(row, colMap, 'Cod.Antiguo');
    final nroInven = col(row, colMap, 'Nro.Inven.');
    final denomExtra = col(row, colMap, 'Denominación extra');
    final txtPral = col(row, colMap, 'Txt.núm.pral.AF');
    final emplazamiento = col(row, colMap, 'Emplazamiento');
    final capitalizado = col(row, colMap, 'Capitalizado el');

    final rawData = {
      'Ubi.Física': ubiFisica,
      'Centro': centro,
      'Cod.Antiguo': codAntiguo,
      'Act.Fijo': actFijo,
      'Nro.Inven.': nroInven,
      'Denominación': denominacion,
      'Denominación extra': denomExtra,
      'Txt.núm.pral.AF': txtPral,
      'Emplazamiento': emplazamiento,
      'Capitalizado el': capitalizado,
    };

    final searchText = buildSearchText([
      actFijo,
      codAntiguo,
      nroInven,
      denominacion,
      denomExtra,
      txtPral,
      ubiFisica,
      emplazamiento,
    ]);
    if (searchText.isEmpty) return null;

    final description = denominacion ?? txtPral ?? actFijo!;

    return makeCompanion(
      batchId: batchId,
      primaryId: actFijo ?? denominacion!,
      secondaryId: nroInven,
      description: description,
      location: ubiFisica,
      rawData: rawData,
      searchText: searchText,
    );
  }
}
