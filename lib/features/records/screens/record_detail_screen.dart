import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kaballo/core/database/app_database.dart';
import 'package:kaballo/core/theme/app_theme.dart';
import 'package:kaballo/core/utils/sap_fields.dart';
import 'package:kaballo/features/capture/screens/metadata_enrichment_screen.dart';
import 'package:kaballo/features/import/import_providers.dart';
import 'package:kaballo/features/inventories/inventory_providers.dart';
import 'package:kaballo/features/search/widgets/source_badge.dart';

class RecordDetailScreen extends ConsumerStatefulWidget {
  final InventoryRecord record;
  const RecordDetailScreen({super.key, required this.record});

  @override
  ConsumerState<RecordDetailScreen> createState() =>
      _RecordDetailScreenState();
}

class _RecordDetailScreenState extends ConsumerState<RecordDetailScreen> {
  bool _editing = false;
  bool _saving = false;

  // Mutable display state — updated after each save
  late double _qty;
  late String _location;
  late String? _note;
  Map<String, dynamic> _meta = {};

  late TextEditingController _qtyCtrl;
  late TextEditingController _locCtrl;
  late TextEditingController _noteCtrl;

  @override
  void initState() {
    super.initState();
    _qty = widget.record.quantityFound;
    _location = widget.record.physicalLocation;
    _note = widget.record.note;
    if (widget.record.metadataEnrichment != null) {
      try {
        _meta = jsonDecode(widget.record.metadataEnrichment!)
            as Map<String, dynamic>;
      } catch (_) {}
    }
    _qtyCtrl = TextEditingController(text: _fmtQty(_qty));
    _locCtrl = TextEditingController(text: _location);
    _noteCtrl = TextEditingController(text: _note ?? '');
  }

  String _fmtQty(double v) =>
      v == v.truncateToDouble() ? v.toStringAsFixed(0) : v.toStringAsFixed(2);

  Future<void> _save() async {
    final qty = double.tryParse(_qtyCtrl.text.replaceAll(',', '.'));
    if (qty == null || qty <= 0) return;
    final loc = _locCtrl.text.trim();
    if (loc.isEmpty) return;
    final note =
        _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim();

    setState(() => _saving = true);
    await ref.read(inventoryServiceProvider).updateRecord(
          widget.record.id,
          quantityFound: qty,
          physicalLocation: loc,
          note: note,
          metadataEnrichment: _meta.isEmpty ? null : _meta,
        );
    if (mounted) {
      setState(() {
        _qty = qty;
        _location = loc;
        _note = note;
        _editing = false;
        _saving = false;
      });
    }
  }

  void _cancelEdit() {
    _qtyCtrl.text = _fmtQty(_qty);
    _locCtrl.text = _location;
    _noteCtrl.text = _note ?? '';
    setState(() => _editing = false);
  }

  @override
  Widget build(BuildContext context) {
    final color = sourceColor(widget.record.sourceType);
    final isBsu = widget.record.sourceType == 'ZMMR0080' ||
        widget.record.sourceType == 'ZMMR0105';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
        actions: [
          if (_editing) ...[
            TextButton(
              onPressed: _saving ? null : _cancelEdit,
              child: const Text('Cancelar',
                  style: TextStyle(color: Color(0xFF8B949E))),
            ),
            TextButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child:
                          CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF1E88E5)),
                    )
                  : const Text('GUARDAR',
                      style: TextStyle(
                          color: Color(0xFF1E88E5),
                          fontWeight: FontWeight.w700)),
            ),
          ] else
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              tooltip: 'Editar registro',
              onPressed: () => setState(() => _editing = true),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item identity card (always read-only)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withValues(alpha: 0.25)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SourceBadge(sourceType: widget.record.sourceType),
                  const SizedBox(height: 10),
                  Text(
                    widget.record.description,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFE6EDF3)),
                  ),
                  const SizedBox(height: 6),
                  _CodeRow(
                      label: 'ID',
                      value: widget.record.primaryId,
                      color: color),
                  if (widget.record.secondaryId != null)
                    _CodeRow(
                        label: 'Lote/Inv',
                        value: widget.record.secondaryId!,
                        color: const Color(0xFF8B949E)),
                  if (widget.record.sapLocation != null) ...[
                    const SizedBox(height: 4),
                    Row(children: [
                      const Icon(Icons.business_outlined,
                          size: 12, color: Color(0xFF8B949E)),
                      const SizedBox(width: 4),
                      Text('SAP: ${widget.record.sapLocation}',
                          style: const TextStyle(
                              color: Color(0xFF8B949E), fontSize: 11)),
                    ]),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 20),

            if (_editing) ...[
              // ── EDIT MODE ──────────────────────────────────────────
              _Label('Cantidad'),
              const SizedBox(height: 6),
              Row(
                children: [
                  _QtyBtn(
                    icon: Icons.remove,
                    onTap: () {
                      final v = double.tryParse(_qtyCtrl.text) ?? 1;
                      if (v > 1) _qtyCtrl.text = (v - 1).toStringAsFixed(0);
                    },
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _qtyCtrl,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d,.]'))],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFE6EDF3)),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  _QtyBtn(
                    icon: Icons.add,
                    onTap: () {
                      final v = double.tryParse(_qtyCtrl.text) ?? 0;
                      _qtyCtrl.text = (v + 1).toStringAsFixed(0);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _Label('Ubicación física'),
              const SizedBox(height: 6),
              TextField(
                controller: _locCtrl,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_on_outlined,
                      color: Color(0xFF8B949E), size: 18),
                  hintText: 'Ej. 65-B-4',
                ),
              ),
              const SizedBox(height: 18),
              _Label('Nota'),
              const SizedBox(height: 6),
              TextField(
                controller: _noteCtrl,
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: 'Observaciones...',
                ),
              ),
              if (isBsu) ...[
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () => _openMetadata(context),
                  icon: Icon(
                    _meta.isNotEmpty
                        ? Icons.check_circle_outline
                        : Icons.add_circle_outline,
                    size: 18,
                    color: _meta.isNotEmpty
                        ? const Color(0xFF4CAF50)
                        : null,
                  ),
                  label: Text(_meta.isNotEmpty
                      ? 'Metadatos BSU completados'
                      : 'Editar información BSU'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _meta.isNotEmpty
                        ? const Color(0xFF4CAF50)
                        : const Color(0xFF8B949E),
                    side: BorderSide(
                      color: _meta.isNotEmpty
                          ? const Color(0xFF4CAF50).withValues(alpha: 0.4)
                          : const Color(0xFF30363D),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: _saving ? null : _save,
                child: _saving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Guardar cambios'),
              ),
            ] else ...[
              // ── VIEW MODE ──────────────────────────────────────────
              _InfoGrid(qty: _qty, location: _location),

              if (_note != null) ...[
                const SizedBox(height: 16),
                _SectionTitle('Nota'),
                const SizedBox(height: 6),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161B22),
                    borderRadius: BorderRadius.circular(10),
                    border: const Border.fromBorderSide(
                        BorderSide(color: Color(0xFF30363D))),
                  ),
                  child: Text(_note!,
                      style: const TextStyle(
                          color: Color(0xFFCDD9E5), fontSize: 14)),
                ),
              ],

              if (_meta.isNotEmpty) ...[
                const SizedBox(height: 16),
                _SectionTitle('Información BSU'),
                const SizedBox(height: 6),
                ..._meta.entries.map((e) => _MetaRow(
                      key_: _prettyKey(e.key),
                      value: e.value.toString(),
                    )),
              ],

              // Datos SAP originales
              _SapDataSection(record: widget.record),

              const SizedBox(height: 16),
              _SectionTitle('Auditoría'),
              const SizedBox(height: 6),
              _MetaRow(key_: 'Operador', value: widget.record.operatorName),
              _MetaRow(key_: 'Dispositivo', value: widget.record.deviceId),
              _MetaRow(
                  key_: 'Capturado',
                  value: DateFormat('dd/MM/yyyy HH:mm:ss')
                      .format(widget.record.createdAt.toLocal())),
              if (widget.record.updatedAt != widget.record.createdAt)
                _MetaRow(
                    key_: 'Editado',
                    value: DateFormat('dd/MM/yyyy HH:mm:ss')
                        .format(widget.record.updatedAt.toLocal())),
            ],

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Future<void> _openMetadata(BuildContext context) async {
    await Navigator.of(context).pushNamed(
      '/capture/metadata',
      arguments: {
        'initial': _meta.isEmpty ? null : Map<String, dynamic>.from(_meta),
        'onSave': (Map<String, dynamic> data) {
          setState(() => _meta = data);
        },
      },
    );
  }

  String _prettyKey(String key) => key
      .split('_')
      .map((w) => w.isEmpty ? '' : w[0].toUpperCase() + w.substring(1))
      .join(' ');

  @override
  void dispose() {
    _qtyCtrl.dispose();
    _locCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }
}

// ── Shared view-mode widgets ────────────────────────────────────────────────

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);
  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(
            color: Color(0xFF8B949E),
            fontSize: 12,
            fontWeight: FontWeight.w600),
      );
}

class _QtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyBtn({required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: const Color(0xFF21262D),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFF8B949E)),
        ),
      );
}

class _CodeRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _CodeRow({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Text('$label: ',
              style: const TextStyle(color: Color(0xFF8B949E), fontSize: 12)),
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: value));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Copiado'),
                    duration: Duration(seconds: 1)),
              );
            },
            child: Text(
              value,
              style: TextStyle(
                  fontFamily: 'monospace',
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoGrid extends StatelessWidget {
  final double qty;
  final String location;
  const _InfoGrid({required this.qty, required this.location});

  @override
  Widget build(BuildContext context) {
    final qtyStr = qty == qty.truncateToDouble()
        ? qty.toStringAsFixed(0)
        : qty.toStringAsFixed(2);
    return Row(
      children: [
        Expanded(
          child: _InfoTile(
            label: 'Cantidad',
            value: qtyStr,
            icon: Icons.numbers_outlined,
            color: const Color(0xFF1E88E5),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _InfoTile(
            label: 'Ubicación física',
            value: location,
            icon: Icons.location_on_outlined,
            color: const Color(0xFF4CAF50),
          ),
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _InfoTile(
      {required this.label,
      required this.value,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 15, color: color),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: color),
            overflow: TextOverflow.ellipsis,
          ),
          Text(label,
              style: const TextStyle(
                  color: Color(0xFF8B949E), fontSize: 10)),
        ],
      ),
    );
  }
}

/// Loads the original ImportedItem and shows all SAP fields with labels.
class _SapDataSection extends ConsumerWidget {
  final InventoryRecord record;
  const _SapDataSection({required this.record});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(importedItemByIdProvider(record.importedItemId));

    return itemAsync.when(
      data: (item) {
        if (item == null) return const SizedBox.shrink();
        final fields = SapFields.allFields(item.sourceType, item.rawData);
        if (fields.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const _SectionTitle('Datos SAP'),
            const SizedBox(height: 8),
            ...fields.map((f) => _MetaRow(key_: f.label, value: f.value)),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(
          color: Color(0xFF8B949E),
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      );
}

class _MetaRow extends StatelessWidget {
  final String key_;
  final String value;
  const _MetaRow({required this.key_, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 120,
              child: Text(key_,
                  style: const TextStyle(
                      color: Color(0xFF8B949E), fontSize: 12))),
          Expanded(
              child: Text(value,
                  style: const TextStyle(
                      color: Color(0xFFCDD9E5), fontSize: 12))),
        ],
      ),
    );
  }
}
