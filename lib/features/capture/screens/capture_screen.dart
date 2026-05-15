import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaballo/core/database/app_database.dart';
import 'package:kaballo/core/theme/app_theme.dart';
import 'package:kaballo/core/utils/sap_fields.dart';
import 'package:kaballo/features/capture/capture_providers.dart';
import 'package:kaballo/features/search/widgets/source_badge.dart';
import 'package:kaballo/features/settings/settings_providers.dart';
import 'package:kaballo/navigation/app_router.dart';

class CaptureScreen extends ConsumerStatefulWidget {
  final ImportedItem item;
  final String inventoryId;

  const CaptureScreen({
    super.key,
    required this.item,
    required this.inventoryId,
  });

  @override
  ConsumerState<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends ConsumerState<CaptureScreen> {
  late TextEditingController _qtyCtrl;
  late TextEditingController _locCtrl;
  final _noteCtrl = TextEditingController();
  Map<String, dynamic>? _metadata;
  bool _showNote = false;

  @override
  void initState() {
    super.initState();
    _qtyCtrl = TextEditingController(text: '1');
    final location = ref.read(currentLocationProvider);
    _locCtrl = TextEditingController(
      text: location.isNotEmpty
          ? location
          : widget.item.location ?? '',
    );
  }

  Future<void> _save() async {
    final qty = double.tryParse(_qtyCtrl.text.replaceAll(',', '.'));
    if (qty == null) return;
    final location = _locCtrl.text.trim();
    if (location.isEmpty) {
      _showLocationError();
      return;
    }

    final svc = ref.read(settingsServiceProvider);
    final operatorName = await svc.getOperatorName() ?? 'Operador';
    final deviceId = await svc.getDeviceId();

    final success = await ref.read(captureNotifierProvider.notifier).capture(
          item: widget.item,
          inventoryId: widget.inventoryId,
          quantity: qty,
          physicalLocation: location,
          note: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
          metadata: _metadata,
          operatorName: operatorName,
          deviceId: deviceId,
        );

    if (success && mounted) {
      Navigator.of(context).pop();
    }
  }

  void _showLocationError() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Ingresa una ubicación física'),
          backgroundColor: Colors.red),
    );
  }

  Future<void> _openMetadata() async {
    await Navigator.of(context).pushNamed(
      AppRoutes.metadataEnrichment,
      arguments: {
        'initial': _metadata,
        'onSave': (Map<String, dynamic> data) {
          setState(() => _metadata = data);
        },
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final captureState = ref.watch(captureNotifierProvider);
    final color = sourceColor(widget.item.sourceType);
    final isBsu = widget.item.sourceType == 'ZMMR0080' ||
        widget.item.sourceType == 'ZMMR0105';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Capturar'),
        actions: [
          TextButton(
            onPressed: captureState.isLoading ? null : _save,
            child: captureState.isLoading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : const Text(
                    'GUARDAR',
                    style: TextStyle(
                      color: Color(0xFF1E88E5),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item card — campos SAP con etiquetas
            _ItemCard(item: widget.item, color: color),

            const SizedBox(height: 24),

            // Quantity
            _SectionLabel('Cantidad'),
            const SizedBox(height: 8),
            Row(
              children: [
                _QtyButton(
                    icon: Icons.remove,
                    onTap: () {
                      final v =
                          double.tryParse(_qtyCtrl.text) ?? 1;
                      if (v > 1) {
                        _qtyCtrl.text =
                            (v - 1).toStringAsFixed(0);
                      }
                    }),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _qtyCtrl,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[\d,.]'))
                    ],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFE6EDF3),
                    ),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                _QtyButton(
                    icon: Icons.add,
                    onTap: () {
                      final v =
                          double.tryParse(_qtyCtrl.text) ?? 0;
                      _qtyCtrl.text = (v + 1).toStringAsFixed(0);
                    }),
              ],
            ),

            const SizedBox(height: 20),

            // Physical location
            _SectionLabel('Ubicación física'),
            const SizedBox(height: 8),
            TextField(
              controller: _locCtrl,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                hintText: 'Ej. 65-B-4',
                prefixIcon: Icon(Icons.location_on_outlined,
                    color: Color(0xFF8B949E), size: 18),
              ),
            ),

            const SizedBox(height: 20),

            // Note (progressive)
            if (!_showNote)
              TextButton.icon(
                onPressed: () => setState(() => _showNote = true),
                icon: const Icon(Icons.note_add_outlined, size: 16),
                label: const Text('Agregar nota'),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF8B949E),
                  padding: EdgeInsets.zero,
                ),
              )
            else ...[
              _SectionLabel('Nota'),
              const SizedBox(height: 8),
              TextField(
                controller: _noteCtrl,
                maxLines: 2,
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: 'Observaciones...',
                ),
              ),
            ],

            // BSU metadata enrichment
            if (isBsu) ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _openMetadata,
                icon: Icon(
                  _metadata != null
                      ? Icons.check_circle_outline
                      : Icons.add_circle_outline,
                  size: 18,
                  color: _metadata != null
                      ? const Color(0xFF4CAF50)
                      : null,
                ),
                label: Text(
                  _metadata != null
                      ? 'Metadatos BSU completados'
                      : 'Completar información BSU (opcional)',
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: _metadata != null
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFF8B949E),
                  side: BorderSide(
                    color: _metadata != null
                        ? const Color(0xFF4CAF50).withValues(alpha: 0.4)
                        : const Color(0xFF30363D),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: ElevatedButton(
            onPressed: captureState.isLoading ? null : _save,
            child: captureState.isLoading
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : const Text('Confirmar captura'),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _qtyCtrl.dispose();
    _locCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }
}

class _ItemCard extends StatelessWidget {
  final ImportedItem item;
  final Color color;
  const _ItemCard({required this.item, required this.color});

  @override
  Widget build(BuildContext context) {
    final fields = SapFields.summary(item.sourceType, item.rawData);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SourceBadge(sourceType: item.sourceType),
          const SizedBox(height: 10),
          Text(
            item.description,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFFE6EDF3)),
          ),
          const SizedBox(height: 8),
          // Campos SAP etiquetados
          Wrap(
            spacing: 12,
            runSpacing: 4,
            children: fields
                .map((f) => RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: '${f.label}: ',
                          style: const TextStyle(
                              color: Color(0xFF8B949E), fontSize: 12),
                        ),
                        TextSpan(
                          text: f.value,
                          style: TextStyle(
                            color: color,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ]),
                    ))
                .toList(),
          ),
          if (item.location != null) ...[
            const SizedBox(height: 6),
            Row(children: [
              const Icon(Icons.location_on_outlined,
                  size: 11, color: Color(0xFF8B949E)),
              const SizedBox(width: 3),
              Text(
                'Ubicación SAP: ${item.location}',
                style: const TextStyle(
                    color: Color(0xFF8B949E), fontSize: 11),
              ),
            ]),
          ],
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: const Color(0xFF8B949E)),
      );
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFF21262D),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xFF8B949E)),
      ),
    );
  }
}
