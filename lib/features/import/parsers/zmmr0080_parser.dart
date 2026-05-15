import 'package:excel/excel.dart';
import 'package:kaballo/core/database/app_database.dart';
import 'base_parser.dart';

class Zmmr0080Parser extends BaseParser {
  @override
  String get sourceType => 'ZMMR0080';

  @override
  List<String> get searchableColumns => [
        'Material',
        'Lote',
        'Descripción del bien',
        'Marca',
        'Modelo',
        'Nro. de serie',
        'Ubicación',
      ];

  @override
  bool isHeaderRow(List<String> row) {
    return row.any((c) => c.contains('descripci') && c.contains('bien')) ||
        (row.any((c) => c.contains('material')) &&
            row.any((c) => c.contains('estado')));
  }

  @override
  ImportedItemsCompanion? parseRow(
    List<Data?> row,
    Map<String, int> colMap,
    String batchId,
  ) {
    final material = col(row, colMap, 'Material');
    final descripcion = col(row, colMap, 'Descripción del bien');
    if (material == null && descripcion == null) return null;

    final ubicacion = col(row, colMap, 'Ubicación');
    final centro = col(row, colMap, 'Centro');
    final almacen = col(row, colMap, 'Almacén');
    final lote = col(row, colMap, 'Lote');
    final libreUt = col(row, colMap, 'Libre utilización');
    final unidadMedida = col(row, colMap, 'Unidad de medida');
    final estadoBien = col(row, colMap, 'Estado del bien');
    final marca = col(row, colMap, 'Marca');
    final modelo = col(row, colMap, 'Modelo');
    final nroSerie = col(row, colMap, 'Nro. de serie');
    final unidadNeg = col(row, colMap, 'Unidad de negocio');
    final area = col(row, colMap, 'Area de la unidad');
    final nroPieza = col(row, colMap, 'N° pieza fabric.');
    final fechaRev = col(row, colMap, 'Fecha de revisión');
    final responsable = col(row, colMap, 'Responsable de revisión');
    final datosAd = col(row, colMap, 'Datos adicionales de inventari');

    final rawData = {
      'Ubicación': ubicacion,
      'Centro': centro,
      'Almacén': almacen,
      'Material': material,
      'Lote': lote,
      'Descripción del bien': descripcion,
      'Libre utilización': libreUt,
      'Unidad de medida': unidadMedida,
      'Estado del bien': estadoBien,
      'Marca': marca,
      'Modelo': modelo,
      'Nro. de serie': nroSerie,
      'Unidad de negocio': unidadNeg,
      'Area de la unidad': area,
      'N° pieza fabric.': nroPieza,
      'Fecha de revisión': fechaRev,
      'Responsable de revisión': responsable,
      'Datos adicionales de inventari': datosAd,
    };

    final searchText = buildSearchText([
      material,
      lote,
      descripcion,
      marca,
      modelo,
      nroSerie,
      ubicacion,
      unidadNeg,
      area,
    ]);
    if (searchText.isEmpty) return null;

    return makeCompanion(
      batchId: batchId,
      primaryId: material ?? descripcion!,
      secondaryId: lote,
      description: descripcion ?? material!,
      location: ubicacion,
      rawData: rawData,
      searchText: searchText,
    );
  }
}
