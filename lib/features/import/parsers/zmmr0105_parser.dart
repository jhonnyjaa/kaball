import 'package:excel/excel.dart';
import 'package:kaballo/core/database/app_database.dart';
import 'base_parser.dart';

class Zmmr0105Parser extends BaseParser {
  @override
  String get sourceType => 'ZMMR0105';

  @override
  List<String> get searchableColumns => [
        'Material',
        'Lote',
        'Material SAP',
        'Texto breve de material',
        'Ubicación',
      ];

  @override
  bool isHeaderRow(List<String> row) {
    // Must have at least one "material" and "importe" or "stock" or "reserva"
    return row.any((c) => c.contains('material')) &&
        (row.any((c) => c.contains('importe')) ||
            row.any((c) => c.contains('stock')) ||
            row.any((c) => c.contains('reserva')));
  }

  @override
  ImportedItemsCompanion? parseRow(
    List<Data?> row,
    Map<String, int> colMap,
    String batchId,
  ) {
    // The Excel has TWO columns named "Material":
    //   pos 1 → Material (BSU code, e.g. BSU-002024)  → colMap['Material']
    //   pos 2 → Material (SAP number, e.g. 33046370)  → colMap['Material (2)']
    final materialBsu = col(row, colMap, 'Material');
    final textoBreve = col(row, colMap, 'Texto breve de material');
    if (materialBsu == null && textoBreve == null) return null;

    final ubicacion = col(row, colMap, 'Ubicación');
    final centro = col(row, colMap, 'Centro');
    final lote = col(row, colMap, 'Lote');
    final materialSap = col(row, colMap, 'Material (2)');
    final umBase = col(row, colMap, 'Unidad medida base');
    final importe = col(row, colMap, 'Importe');
    final stockNoVal = col(row, colMap, 'Stock no Val');
    final moneda = col(row, colMap, 'Moneda');
    final nroReserva = col(row, colMap, 'Nº reserva');
    final nroPosReserva = col(row, colMap, 'Nº pos.reserva traslado');

    final rawData = {
      'Ubicación': ubicacion,
      'Centro': centro,
      'Material': materialBsu,
      'Lote': lote,
      'Material SAP': materialSap,
      'Texto breve de material': textoBreve,
      'Unidad medida base': umBase,
      'Importe': importe,
      'Stock no Val': stockNoVal,
      'Moneda': moneda,
      'Nº reserva': nroReserva,
      'Nº pos.reserva traslado': nroPosReserva,
    };

    final searchText = buildSearchText([
      materialBsu,
      lote,
      materialSap,
      textoBreve,
      ubicacion,
      centro,
    ]);
    if (searchText.isEmpty) return null;

    return makeCompanion(
      batchId: batchId,
      primaryId: materialBsu ?? textoBreve!,
      secondaryId: lote,
      description: textoBreve ?? materialBsu!,
      location: ubicacion,
      rawData: rawData,
      searchText: searchText,
    );
  }
}
