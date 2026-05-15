import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:kaballo/features/export/export_providers.dart';
import 'package:kaballo/features/inventories/inventory_providers.dart';

class ExportScreen extends ConsumerWidget {
  final String inventoryId;
  const ExportScreen({super.key, required this.inventoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exportState = ref.watch(exportNotifierProvider);
    final recordsAsync = ref.watch(inventoryRecordsProvider(inventoryId));

    final count = recordsAsync.value?.length ?? 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Exportar / Compartir')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (exportState.status == ExportStatus.exporting)
              const _ExportingIndicator(),

            if (exportState.status == ExportStatus.done)
              _DoneBanner(
                file: exportState.file,
                message: exportState.message,
                onDismiss: () =>
                    ref.read(exportNotifierProvider.notifier).reset(),
              ),

            if (exportState.status == ExportStatus.error)
              _ErrorBanner(
                message: exportState.message ?? 'Error al exportar',
                onDismiss: () =>
                    ref.read(exportNotifierProvider.notifier).reset(),
              ),

            const SizedBox(height: 8),
            _ExportTile(
              icon: Icons.table_chart_outlined,
              color: const Color(0xFF4CAF50),
              title: 'Exportar a Excel',
              subtitle: 'Archivo .xlsx listo para SAP · $count registros',
              onTap: exportState.status == ExportStatus.exporting
                  ? null
                  : () => ref
                      .read(exportNotifierProvider.notifier)
                      .exportExcel(inventoryId),
            ),
            const SizedBox(height: 12),
            _ExportTile(
              icon: Icons.inventory_2_outlined,
              color: const Color(0xFF1E88E5),
              title: 'Exportar paquete .invpack',
              subtitle: 'Para compartir con otros dispositivos · $count registros',
              onTap: exportState.status == ExportStatus.exporting
                  ? null
                  : () => ref
                      .read(exportNotifierProvider.notifier)
                      .exportPackage(inventoryId),
            ),
            const Divider(height: 40),
            _ExportTile(
              icon: Icons.file_download_outlined,
              color: const Color(0xFFFF8F00),
              title: 'Importar paquete .invpack',
              subtitle: 'Fusionar registros de otro dispositivo',
              onTap: exportState.status == ExportStatus.exporting
                  ? null
                  : () => _importPackage(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _importPackage(BuildContext context, WidgetRef ref) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
      withData: true,
    );
    if (result == null || result.files.isEmpty) return;

    final bytes = result.files.first.bytes;
    List<int> fileBytes;
    if (bytes != null) {
      fileBytes = bytes;
    } else {
      final path = result.files.first.path;
      if (path == null) return;
      fileBytes = await File(path).readAsBytes();
    }

    await ref.read(exportNotifierProvider.notifier).importPackage(
          bytes: fileBytes,
          targetInventoryId: inventoryId,
        );
  }
}

class _ExportTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _ExportTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF161B22),
          borderRadius: BorderRadius.circular(12),
          border: const Border.fromBorderSide(
              BorderSide(color: Color(0xFF30363D))),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFE6EDF3),
                        fontSize: 14,
                      )),
                  const SizedBox(height: 3),
                  Text(subtitle,
                      style: const TextStyle(
                          color: Color(0xFF8B949E), fontSize: 12)),
                ],
              ),
            ),
            Icon(
              onTap == null
                  ? Icons.hourglass_empty_outlined
                  : Icons.chevron_right,
              color: const Color(0xFF30363D),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExportingIndicator extends StatelessWidget {
  const _ExportingIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
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
              child: CircularProgressIndicator(strokeWidth: 2)),
          SizedBox(width: 12),
          Text('Exportando...'),
        ],
      ),
    );
  }
}

class _DoneBanner extends StatelessWidget {
  final dynamic file;
  final String? message;
  final VoidCallback onDismiss;

  const _DoneBanner(
      {this.file, this.message, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: const Color(0xFF4CAF50).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline,
              color: Color(0xFF4CAF50), size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message ?? 'Completado',
              style: const TextStyle(color: Color(0xFF4CAF50)),
            ),
          ),
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

class _ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback onDismiss;
  const _ErrorBanner({required this.message, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 20),
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
