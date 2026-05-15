import 'package:excel/excel.dart';
import 'package:kaballo/core/database/app_database.dart';
import 'base_parser.dart';

class Mb52Parser extends BaseParser {
  @override
  String get sourceType => 'MB52';

  @override
  List<String> get searchableColumns => [
        'Material',
        'Texto breve de material',
        'Lote',
        'Ubicación',
      ];

  @override
  bool isHeaderRow(List<String> row) {
    return row.any((c) => c.contains('material')) &&
        row.any((c) => c.contains('ubicaci'));
  }

  @override
  ImportedItemsCompanion? parseRow(
    List<Data?> row,
    Map<String, int> colMap,
    String batchId,
  ) {
    final material = col(row, colMap, 'Material');
    final description = col(row, colMap, 'Texto breve de material');
    if (material == null && description == null) return null;

    final lote = col(row, colMap, 'Lote');
    final ubicacion = col(row, colMap, 'Ubicación');
    final centro = col(row, colMap, 'Centro');
    final almacen = col(row, colMap, 'Almacén');
    final libreUt = col(row, colMap, 'Libre utilización');
    final umBase = col(row, colMap, 'Unidad medida base');
    final fechaFab = col(row, colMap, 'Fec. Fabric.');
    final cadFpc = col(row, colMap, 'Cad./FPC');
    final inspeccion = col(row, colMap, 'Inspecc.de calidad');

    final rawData = {
      'Ubicación': ubicacion,
      'Centro': centro,
      'Almacén': almacen,
      'Material': material,
      'Texto breve de material': description,
      'Libre utilización': libreUt,
      'Inspecc.de calidad': inspeccion,
      'Unidad medida base': umBase,
      'Lote': lote,
      'Fec. Fabric.': fechaFab,
      'Cad./FPC': cadFpc,
    };

    final searchText = buildSearchText([
      material,
      description,
      lote,
      ubicacion,
      centro,
      almacen,
    ]);
    if (searchText.isEmpty) return null;

    return makeCompanion(
      batchId: batchId,
      primaryId: material ?? description!,
      secondaryId: lote,
      description: description ?? material!,
      location: ubicacion,
      rawData: rawData,
      searchText: searchText,
    );
  }
}
