import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kaballo/core/database/app_database.dart';
import 'package:kaballo/core/theme/app_theme.dart';
import 'package:kaballo/features/inventories/inventory_providers.dart';
import 'package:kaballo/features/records/records_providers.dart';
import 'package:kaballo/features/search/widgets/source_badge.dart';
import 'package:kaballo/navigation/app_router.dart';

class RecordsListScreen extends ConsumerWidget {
  final String inventoryId;
  const RecordsListScreen({super.key, required this.inventoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordsAsync = ref.watch(inventoryRecordsProvider(inventoryId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registros'),
        actions: [
          recordsAsync.when(
            data: (r) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Text(
                '${r.length}',
                style: const TextStyle(
                    color: Color(0xFF8B949E), fontSize: 16),
              ),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: recordsAsync.when(
        data: (records) => records.isEmpty
            ? const Center(
                child: Text('Sin registros',
                    style: TextStyle(color: Color(0xFF8B949E))))
            : _RecordsList(records: records),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _RecordsList extends StatelessWidget {
  final List<InventoryRecord> records;
  const _RecordsList({required this.records});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: records.length,
      itemBuilder: (_, i) => _RecordTile(record: records[i]),
    );
  }
}

class _RecordTile extends ConsumerWidget {
  final InventoryRecord record;
  const _RecordTile({required this.record});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = sourceColor(record.sourceType);

    return Dismissible(
      key: ValueKey(record.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red.withValues(alpha: 0.15),
        child: const Icon(Icons.delete_outline, color: Colors.red),
      ),
      confirmDismiss: (_) => showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Eliminar registro'),
          content: Text('¿Eliminar "${record.description}"?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancelar')),
            TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Eliminar',
                    style: TextStyle(color: Colors.red))),
          ],
        ),
      ),
      onDismissed: (_) =>
          ref.read(recordDeleteNotifierProvider.notifier).delete(record.id),
      child: InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed(AppRoutes.recordDetail, arguments: record),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Color(0xFF21262D), width: 0.5)),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    record.quantityFound.toStringAsFixed(
                        record.quantityFound ==
                                record.quantityFound.truncateToDouble()
                            ? 0
                            : 1),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SourceBadge(sourceType: record.sourceType, compact: true),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            record.physicalLocation,
                            style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF1E88E5),
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      record.description,
                      style: const TextStyle(
                          fontSize: 13, color: Color(0xFFE6EDF3)),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      record.primaryId,
                      style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF8B949E),
                          fontFamily: 'monospace'),
                    ),
                  ],
                ),
              ),
              Text(
                DateFormat('HH:mm').format(record.createdAt.toLocal()),
                style: const TextStyle(
                    color: Color(0xFF8B949E), fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
