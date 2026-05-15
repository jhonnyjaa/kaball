import 'dart:convert';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:intl/intl.dart';
import 'package:kaballo/core/database/app_database.dart';
import 'package:kaballo/core/theme/app_theme.dart';
import 'package:kaballo/core/utils/sap_fields.dart';

class ExcelExportService {
  Future<File> exportInventory({
    required Inventory inventory,
    required List<InventoryRecord> records,
  }) async {
    final excel = Excel.createExcel();
    final sheetName = 'Inventario';
    excel.rename('Sheet1', sheetName);
    final sheet = excel[sheetName];

    _writeHeader(sheet);
    for (var i = 0; i < records.length; i++) {
      _writeRecord(sheet, i + 1, records[i]);
    }
    _styleHeader(sheet);

    final dir = await getApplicationDocumentsDirectory();
    final ts = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final safeName = inventory.name
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(' ', '_');
    final file = File(p.join(dir.path, 'inv_${safeName}_$ts.xlsx'));
    await file.writeAsBytes(excel.encode()!);
    return file;
  }

  // ── Columnas fijas comunes a todas las fuentes ──────────────────────────
  static const _baseHeaders = [
    'Fuente SAP',       // A
    'Descripción',      // B
    'Cant. Contada',    // C
    'Ub. Física',       // D
    'Nota',             // E
    // SAP data — campos clave por fuente
    'Material / Act.Fijo',  // F
    'Lote / Nro.Inven.',    // G
    'Cant. SAP',            // H
    'Unidad',               // I
    'Ub. SAP',              // J
    'Centro',               // K
    'Almacén / Empl.',      // L
    // Activos fijos
    'Cód.Antiguo',          // M
    'Denominación extra',   // N
    // Materiales — fechas
    'Fec. Fabricación',     // O
    'Caducidad',            // P
    // BSU
    'Estado del bien',      // Q
    'Marca',                // R
    'Modelo',               // S
    'N° Serie',             // T
    'Unidad negocio',       // U
    'Área',                 // V
    'Material SAP',         // W  (ZMMR0105: código SAP equivalente)
    'Importe',              // X
    'Moneda',               // Y
    'N° Reserva',           // Z
    // Metadatos enriquecidos (BSU manual)
    'Meta: Marca',
    'Meta: Modelo',
    'Meta: N° Serie',
    'Meta: Estado',
    'Meta: Notas',
    // Auditoría
    'Operador',
    'Dispositivo',
    'Fecha Captura',
    'Fecha Edición',
  ];

  void _writeHeader(Sheet sheet) {
    for (var i = 0; i < _baseHeaders.length; i++) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
          .value = TextCellValue(_baseHeaders[i]);
    }
  }

  void _writeRecord(Sheet sheet, int rowIdx, InventoryRecord rec) {
    Map<String, dynamic> raw = {};
    if (rec.sapLocation != null) {
      // Try to reconstruct raw from imported item via rawData on the record
      // (not stored on record — we read from DB in the service layer if needed)
    }

    // We don't have rawData on InventoryRecord, but we stored enough fields.
    // Use the record's own fields + metadataEnrichment for export.
    Map<String, dynamic> meta = {};
    if (rec.metadataEnrichment != null) {
      try {
        meta = jsonDecode(rec.metadataEnrichment!) as Map<String, dynamic>;
      } catch (_) {}
    }

    // Helpers to set a cell
    void set(int col, dynamic val) {
      if (val == null || val.toString().isEmpty) return;
      final cell = sheet.cell(
          CellIndex.indexByColumnRow(columnIndex: col, rowIndex: rowIdx));
      cell.value = val is double
          ? DoubleCellValue(val)
          : TextCellValue(val.toString());
    }

    set(0, '${sourceLabel(rec.sourceType)} (${rec.sourceType})');
    set(1, rec.description);
    set(2, rec.quantityFound);
    set(3, rec.physicalLocation);
    set(4, rec.note ?? '');
    set(5, rec.primaryId);
    set(6, rec.secondaryId ?? '');
    // cols 7-11 (Cant.SAP, Unidad, Ub.SAP, Centro, Almacén) need rawData —
    // populated in the enriched export method below
    set(9, rec.sapLocation ?? '');
    // BSU enrichment meta
    set(26, meta['marca'] ?? '');
    set(27, meta['modelo'] ?? '');
    set(28, meta['nro_serie'] ?? '');
    set(29, meta['estado'] ?? '');
    set(30, meta['notas_adicionales'] ?? '');
    // Auditoría
    set(31, rec.operatorName);
    set(32, rec.deviceId);
    set(33, DateFormat('dd/MM/yyyy HH:mm').format(rec.createdAt.toLocal()));
    if (rec.updatedAt != rec.createdAt) {
      set(34, DateFormat('dd/MM/yyyy HH:mm').format(rec.updatedAt.toLocal()));
    }
  }

  /// Full export with imported-item rawData for complete SAP fields.
  Future<File> exportInventoryFull({
    required Inventory inventory,
    required List<InventoryRecord> records,
    required Map<int, ImportedItem> itemsById,
  }) async {
    final excel = Excel.createExcel();
    final sheetName = 'Inventario';
    excel.rename('Sheet1', sheetName);
    final sheet = excel[sheetName];

    _writeHeader(sheet);
    for (var i = 0; i < records.length; i++) {
      _writeRecordFull(sheet, i + 1, records[i], itemsById[records[i].importedItemId]);
    }
    _styleHeader(sheet);

    final dir = await getApplicationDocumentsDirectory();
    final ts = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final safeName = inventory.name
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(' ', '_');
    final file = File(p.join(dir.path, 'inv_${safeName}_$ts.xlsx'));
    await file.writeAsBytes(excel.encode()!);
    return file;
  }

  void _writeRecordFull(
    Sheet sheet,
    int rowIdx,
    InventoryRecord rec,
    ImportedItem? item,
  ) {
    Map<String, dynamic> meta = {};
    if (rec.metadataEnrichment != null) {
      try {
        meta = jsonDecode(rec.metadataEnrichment!) as Map<String, dynamic>;
      } catch (_) {}
    }

    Map<String, dynamic> raw = {};
    if (item != null) {
      try {
        raw = jsonDecode(item.rawData) as Map<String, dynamic>;
      } catch (_) {}
    }

    String? r(String k) {
      final v = raw[k];
      if (v == null) return null;
      final s = v.toString().trim();
      return s.isEmpty ? null : s;
    }

    void set(int col, dynamic val) {
      if (val == null || val.toString().isEmpty) return;
      final cell = sheet.cell(
          CellIndex.indexByColumnRow(columnIndex: col, rowIndex: rowIdx));
      cell.value = val is double
          ? DoubleCellValue(val)
          : TextCellValue(val.toString());
    }

    set(0, '${sourceLabel(rec.sourceType)} (${rec.sourceType})');
    set(1, rec.description);
    set(2, rec.quantityFound);
    set(3, rec.physicalLocation);
    set(4, rec.note ?? '');
    set(5, rec.primaryId);
    set(6, rec.secondaryId ?? '');

    // Fuente-specific SAP fields
    switch (rec.sourceType) {
      case 'MB52':
        final qty = r('Libre utilización');
        final unit = r('Unidad medida base');
        if (qty != null) set(7, double.tryParse(qty) ?? qty);
        set(8, unit ?? '');
        set(9, r('Ubicación') ?? rec.sapLocation ?? '');
        set(10, r('Centro') ?? '');
        set(11, r('Almacén') ?? '');
        set(14, r('Fec. Fabric.') ?? '');
        set(15, r('Cad./FPC') ?? '');
      case 'ZFIR0241':
        set(9, r('Ubi.Física') ?? rec.sapLocation ?? '');
        set(10, r('Centro') ?? '');
        set(11, r('Emplazamiento') ?? '');
        set(12, r('Cod.Antiguo') ?? '');
        set(13, r('Denominación extra') ?? '');
      case 'ZMMR0080':
        final qty = r('Libre utilización');
        final unit = r('Unidad de medida');
        if (qty != null) set(7, double.tryParse(qty) ?? qty);
        set(8, unit ?? '');
        set(9, r('Ubicación') ?? rec.sapLocation ?? '');
        set(10, r('Centro') ?? '');
        set(11, r('Almacén') ?? '');
        set(16, r('Estado del bien') ?? '');
        set(17, r('Marca') ?? '');
        set(18, r('Modelo') ?? '');
        set(19, r('Nro. de serie') ?? '');
        set(20, r('Unidad de negocio') ?? '');
        set(21, r('Area de la unidad') ?? '');
      case 'ZMMR0105':
        final stock = r('Stock no Val');
        final unit = r('Unidad medida base');
        final importe = r('Importe');
        if (stock != null) set(7, double.tryParse(stock) ?? stock);
        set(8, unit ?? '');
        set(9, r('Ubicación') ?? rec.sapLocation ?? '');
        set(10, r('Centro') ?? '');
        set(22, r('Material SAP') ?? '');
        if (importe != null) set(23, double.tryParse(importe) ?? importe);
        set(24, r('Moneda') ?? '');
        set(25, r('Nº reserva') ?? '');
    }

    // BSU enrichment meta
    set(26, meta['marca'] ?? '');
    set(27, meta['modelo'] ?? '');
    set(28, meta['nro_serie'] ?? '');
    set(29, meta['estado'] ?? '');
    set(30, meta['notas_adicionales'] ?? '');
    // Auditoría
    set(31, rec.operatorName);
    set(32, rec.deviceId);
    set(33, DateFormat('dd/MM/yyyy HH:mm').format(rec.createdAt.toLocal()));
    if (rec.updatedAt != rec.createdAt) {
      set(34, DateFormat('dd/MM/yyyy HH:mm').format(rec.updatedAt.toLocal()));
    }
  }

  void _styleHeader(Sheet sheet) {
    for (var i = 0; i < _baseHeaders.length; i++) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
          .cellStyle = CellStyle(
        bold: true,
        backgroundColorHex: ExcelColor.fromHexString('#1E3A5F'),
        fontColorHex: ExcelColor.fromHexString('#FFFFFF'),
      );
    }
    sheet.setColumnWidth(1, 42);  // Descripción
    sheet.setColumnWidth(13, 30); // Denominación extra
  }
}
