import 'dart:convert';

typedef SapField = ({String label, String value});

/// Extracts labeled SAP fields from rawData JSON, keyed by source type.
class SapFields {
  static List<SapField> summary(String sourceType, String rawDataJson) {
    final raw = _decode(rawDataJson);
    return switch (sourceType) {
      'MB52' => _mb52Summary(raw),
      'ZFIR0241' => _zfir0241Summary(raw),
      'ZMMR0080' => _zmmr0080Summary(raw),
      'ZMMR0105' => _zmmr0105Summary(raw),
      _ => [],
    };
  }

  static List<SapField> allFields(String sourceType, String rawDataJson) {
    final raw = _decode(rawDataJson);
    return switch (sourceType) {
      'MB52' => _mb52All(raw),
      'ZFIR0241' => _zfir0241All(raw),
      'ZMMR0080' => _zmmr0080All(raw),
      'ZMMR0105' => _zmmr0105All(raw),
      _ => [],
    };
  }

  // ── MB52 ──────────────────────────────────────────────────────────────────

  static List<SapField> _mb52Summary(Map<String, dynamic> raw) {
    final unit = _s(raw, 'Unidad medida base');
    final qty = _s(raw, 'Libre utilización');
    return [
      if (_s(raw, 'Material') case final v?) (label: 'Material', value: v),
      if (_s(raw, 'Lote') case final v?) (label: 'Lote', value: v),
      if (qty != null)
        (label: 'Cant. SAP', value: unit != null ? '$qty $unit' : qty),
    ];
  }

  static List<SapField> _mb52All(Map<String, dynamic> raw) {
    final unit = _s(raw, 'Unidad medida base');
    final qty = _s(raw, 'Libre utilización');
    final qc = _s(raw, 'Inspecc.de calidad');
    return [
      if (_s(raw, 'Material') case final v?) (label: 'Material', value: v),
      if (_s(raw, 'Lote') case final v?) (label: 'Lote', value: v),
      if (qty != null)
        (label: 'Libre utilización', value: unit != null ? '$qty $unit' : qty),
      if (qc != null && qc != '0')
        (label: 'Inspecc. calidad', value: unit != null ? '$qc $unit' : qc),
      if (_s(raw, 'Ubicación') case final v?) (label: 'Ubicación SAP', value: v),
      if (_s(raw, 'Centro') case final v?) (label: 'Centro', value: v),
      if (_s(raw, 'Almacén') case final v?) (label: 'Almacén', value: v),
      if (_s(raw, 'Fec. Fabric.') case final v?) (label: 'Fec. Fabricación', value: v),
      if (_s(raw, 'Cad./FPC') case final v?) (label: 'Caducidad', value: v),
    ];
  }

  // ── ZFIR0241 ──────────────────────────────────────────────────────────────

  static List<SapField> _zfir0241Summary(Map<String, dynamic> raw) {
    return [
      if (_s(raw, 'Act.Fijo') case final v?) (label: 'Act.Fijo', value: v),
      if (_s(raw, 'Cod.Antiguo') case final v?)
        (label: 'Cód.Antiguo', value: v),
      if (_s(raw, 'Nro.Inven.') case final v?) (label: 'Nro.Inven.', value: v),
    ];
  }

  static List<SapField> _zfir0241All(Map<String, dynamic> raw) {
    return [
      if (_s(raw, 'Act.Fijo') case final v?) (label: 'Act.Fijo', value: v),
      if (_s(raw, 'Cod.Antiguo') case final v?)
        (label: 'Cód.Antiguo', value: v),
      if (_s(raw, 'Nro.Inven.') case final v?)
        (label: 'Nro.Inventario', value: v),
      if (_s(raw, 'Denominación') case final v?)
        (label: 'Denominación', value: v),
      if (_s(raw, 'Denominación extra') case final v?)
        (label: 'Denominación extra', value: v),
      if (_s(raw, 'Txt.núm.pral.AF') case final v?)
        (label: 'Txt. pral. AF', value: v),
      if (_s(raw, 'Ubi.Física') case final v?)
        (label: 'Ubi. Física SAP', value: v),
      if (_s(raw, 'Centro') case final v?) (label: 'Centro', value: v),
      if (_s(raw, 'Emplazamiento') case final v?)
        (label: 'Emplazamiento', value: v),
    ];
  }

  // ── ZMMR0080 ──────────────────────────────────────────────────────────────

  static List<SapField> _zmmr0080Summary(Map<String, dynamic> raw) {
    final unit = _s(raw, 'Unidad de medida');
    final qty = _s(raw, 'Libre utilización');
    return [
      if (_s(raw, 'Material') case final v?) (label: 'Material', value: v),
      if (_s(raw, 'Lote') case final v?) (label: 'Lote', value: v),
      if (qty != null)
        (label: 'Cant. SAP', value: unit != null ? '$qty $unit' : qty),
    ];
  }

  static List<SapField> _zmmr0080All(Map<String, dynamic> raw) {
    final unit = _s(raw, 'Unidad de medida');
    final qty = _s(raw, 'Libre utilización');
    return [
      if (_s(raw, 'Material') case final v?) (label: 'Material', value: v),
      if (_s(raw, 'Lote') case final v?) (label: 'Lote', value: v),
      if (qty != null)
        (label: 'Libre utilización', value: unit != null ? '$qty $unit' : qty),
      if (_s(raw, 'Estado del bien') case final v?) (label: 'Estado', value: v),
      if (_s(raw, 'Marca') case final v?) (label: 'Marca', value: v),
      if (_s(raw, 'Modelo') case final v?) (label: 'Modelo', value: v),
      if (_s(raw, 'Nro. de serie') case final v?) (label: 'N° Serie', value: v),
      if (_s(raw, 'Unidad de negocio') case final v?)
        (label: 'Unidad negocio', value: v),
      if (_s(raw, 'Area de la unidad') case final v?) (label: 'Área', value: v),
      if (_s(raw, 'N° pieza fabric.') case final v?)
        (label: 'N° pieza fabric.', value: v),
      if (_s(raw, 'Fecha de revisión') case final v?)
        (label: 'Fecha revisión', value: v),
      if (_s(raw, 'Ubicación') case final v?) (label: 'Ubicación SAP', value: v),
      if (_s(raw, 'Centro') case final v?) (label: 'Centro', value: v),
      if (_s(raw, 'Almacén') case final v?) (label: 'Almacén', value: v),
    ];
  }

  // ── ZMMR0105 ──────────────────────────────────────────────────────────────

  static List<SapField> _zmmr0105Summary(Map<String, dynamic> raw) {
    final unit = _s(raw, 'Unidad medida base');
    final stock = _s(raw, 'Stock no Val');
    return [
      if (_s(raw, 'Material') case final v?) (label: 'Material BSU', value: v),
      if (_s(raw, 'Lote') case final v?) (label: 'Lote', value: v),
      if (_s(raw, 'Material SAP') case final v?)
        (label: 'Material SAP', value: v),
      if (stock != null)
        (label: 'Stock', value: unit != null ? '$stock $unit' : stock),
    ];
  }

  static List<SapField> _zmmr0105All(Map<String, dynamic> raw) {
    final unit = _s(raw, 'Unidad medida base');
    final stock = _s(raw, 'Stock no Val');
    final importe = _s(raw, 'Importe');
    final moneda = _s(raw, 'Moneda');
    return [
      if (_s(raw, 'Material') case final v?) (label: 'Material BSU', value: v),
      if (_s(raw, 'Lote') case final v?) (label: 'Lote', value: v),
      if (_s(raw, 'Material SAP') case final v?)
        (label: 'Material SAP', value: v),
      if (stock != null)
        (label: 'Stock no Val', value: unit != null ? '$stock $unit' : stock),
      if (importe != null)
        (label: 'Importe', value: moneda != null ? '$moneda $importe' : importe),
      if (_s(raw, 'Nº reserva') case final v?) (label: 'N° Reserva', value: v),
      if (_s(raw, 'Nº pos.reserva traslado') case final v?)
        (label: 'Pos. Reserva', value: v),
      if (_s(raw, 'Ubicación') case final v?) (label: 'Ubicación SAP', value: v),
      if (_s(raw, 'Centro') case final v?) (label: 'Centro', value: v),
    ];
  }

  // ── Utils ─────────────────────────────────────────────────────────────────

  static Map<String, dynamic> _decode(String json) {
    try {
      return jsonDecode(json) as Map<String, dynamic>;
    } catch (_) {
      return {};
    }
  }

  static String? _s(Map<String, dynamic> raw, String key) {
    final v = raw[key];
    if (v == null) return null;
    final s = v.toString().trim();
    return s.isEmpty ? null : s;
  }
}
