import 'package:flutter/material.dart';

class _Field {
  final String key;
  final String label;
  final IconData icon;
  const _Field(this.key, this.label, this.icon);
}

const _fields = [
  _Field('marca', 'Marca', Icons.business_outlined),
  _Field('modelo', 'Modelo', Icons.category_outlined),
  _Field('nro_serie', 'N° de serie', Icons.tag_outlined),
  _Field('unidad_negocio', 'Unidad de negocio', Icons.account_tree_outlined),
  _Field('area', 'Área', Icons.grid_view_outlined),
  _Field('estado', 'Estado del bien', Icons.info_outline),
  _Field('notas_adicionales', 'Notas adicionales', Icons.note_outlined),
];

class MetadataEnrichmentScreen extends StatefulWidget {
  final Map<String, dynamic>? initial;
  final void Function(Map<String, dynamic>) onSave;

  const MetadataEnrichmentScreen({
    super.key,
    this.initial,
    required this.onSave,
  });

  @override
  State<MetadataEnrichmentScreen> createState() =>
      _MetadataEnrichmentScreenState();
}

class _MetadataEnrichmentScreenState
    extends State<MetadataEnrichmentScreen> {
  late final Map<String, TextEditingController> _ctrls;

  @override
  void initState() {
    super.initState();
    _ctrls = {
      for (final f in _fields)
        f.key: TextEditingController(
            text: widget.initial?[f.key]?.toString() ?? ''),
    };
  }

  void _save() {
    final data = {
      for (final f in _fields)
        if (_ctrls[f.key]!.text.trim().isNotEmpty)
          f.key: _ctrls[f.key]!.text.trim(),
    };
    widget.onSave(data);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información BSU'),
        actions: [
          TextButton(
            onPressed: _save,
            child: const Text(
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
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF21262D),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline,
                      size: 16, color: Color(0xFF8B949E)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Todos los campos son opcionales. Completa los que puedas identificar físicamente.',
                      style: TextStyle(
                          color: Color(0xFF8B949E), fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            for (final f in _fields) ...[
              Text(
                f.label,
                style: const TextStyle(
                    color: Color(0xFF8B949E),
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _ctrls[f.key],
                textCapitalization:
                    f.key == 'nro_serie' || f.key == 'modelo'
                        ? TextCapitalization.characters
                        : TextCapitalization.sentences,
                decoration: InputDecoration(
                  prefixIcon: Icon(f.icon,
                      color: const Color(0xFF8B949E), size: 18),
                  hintText: f.label,
                ),
              ),
              const SizedBox(height: 16),
            ],
            ElevatedButton(
              onPressed: _save,
              child: const Text('Guardar información'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final c in _ctrls.values) {
      c.dispose();
    }
    super.dispose();
  }
}
