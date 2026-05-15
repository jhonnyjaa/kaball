import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaballo/core/theme/app_theme.dart';
import 'package:kaballo/features/import/import_providers.dart';

class ImportScreen extends ConsumerWidget {
  const ImportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sourceCounts = ref.watch(sourceCountsProvider);
    final importState = ref.watch(importNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Importar datos SAP')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF161B22),
                borderRadius: BorderRadius.circular(10),
                border: const Border.fromBorderSide(
                    BorderSide(color: Color(0xFF30363D))),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline,
                      size: 16, color: Color(0xFF8B949E)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Selecciona el tipo de reporte SAP y luego el archivo .xlsx correspondiente.',
                      style: TextStyle(
                          color: Color(0xFF8B949E), fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            if (importState.status == ImportStatus.importing)
              const _ImportingIndicator(),

            if (importState.status == ImportStatus.success)
              _FeedbackBanner(
                message: importState.message ?? 'Importado',
                color: const Color(0xFF4CAF50),
                onDismiss: () => ref.read(importNotifierProvider.notifier).reset(),
              ),

            if (importState.status == ImportStatus.error)
              _FeedbackBanner(
                message: importState.message ?? 'Error',
                color: Colors.red,
                onDismiss: () => ref.read(importNotifierProvider.notifier).reset(),
              ),

            if (importState.status != ImportStatus.importing)
              ...['MB52', 'ZFIR0241', 'ZMMR0080', 'ZMMR0105'].map(
                (src) => _SourceTile(
                  sourceType: src,
                  count: sourceCounts.value?[src],
                  onImport: () => _pickAndImport(context, ref, src),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickAndImport(
      BuildContext context, WidgetRef ref, String sourceType) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
      allowMultiple: false,
      withData: true,
    );

    if (result == null || result.files.isEmpty) return;

    final bytes = result.files.first.bytes;
    if (bytes == null) {
      // fallback: read from path
      final path = result.files.first.path;
      if (path == null) return;
      final fileBytes = await File(path).readAsBytes();
      await ref.read(importNotifierProvider.notifier).importFile(
            bytes: fileBytes,
            sourceType: sourceType,
          );
      return;
    }

    await ref.read(importNotifierProvider.notifier).importFile(
          bytes: bytes,
          sourceType: sourceType,
        );
  }
}

class _SourceTile extends StatelessWidget {
  final String sourceType;
  final int? count;
  final VoidCallback onImport;

  const _SourceTile({
    required this.sourceType,
    required this.count,
    required this.onImport,
  });

  @override
  Widget build(BuildContext context) {
    final color = sourceColor(sourceType);
    final label = sourceLabel(sourceType);
    final icon = sourceIcon(sourceType);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF30363D)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFE6EDF3),
                    fontSize: 14,
                  ),
                ),
                Text(
                  sourceType,
                  style: const TextStyle(
                      color: Color(0xFF8B949E), fontSize: 11),
                ),
              ],
            ),
          ),
          if (count != null && count! > 0)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                children: [
                  Text(
                    '$count',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF4CAF50),
                      fontSize: 16,
                    ),
                  ),
                  const Text('cargados',
                      style: TextStyle(
                          fontSize: 9, color: Color(0xFF8B949E))),
                ],
              ),
            ),
          ElevatedButton.icon(
            onPressed: onImport,
            icon: const Icon(Icons.upload_file_outlined, size: 16),
            label: Text(count != null && count! > 0
                ? 'Reimportar'
                : 'Importar'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 10),
              backgroundColor: color.withValues(alpha: 0.15),
              foregroundColor: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _ImportingIndicator extends StatelessWidget {
  const _ImportingIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E88E5).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: const Color(0xFF1E88E5).withValues(alpha: 0.3)),
      ),
      child: const Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          SizedBox(width: 12),
          Text('Importando datos...'),
        ],
      ),
    );
  }
}

class _FeedbackBanner extends StatelessWidget {
  final String message;
  final Color color;
  final VoidCallback onDismiss;

  const _FeedbackBanner({
    required this.message,
    required this.color,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(
            color == const Color(0xFF4CAF50)
                ? Icons.check_circle_outline
                : Icons.error_outline,
            color: color,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(message)),
          IconButton(
            icon: const Icon(Icons.close, size: 16),
            onPressed: onDismiss,
            color: const Color(0xFF8B949E),
          ),
        ],
      ),
    );
  }
}
