import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kaballo/core/database/app_database.dart';
import 'package:kaballo/features/inventories/inventory_providers.dart';
import 'package:kaballo/navigation/app_router.dart';

class InventoryDetailScreen extends ConsumerWidget {
  final String inventoryId;
  const InventoryDetailScreen({super.key, required this.inventoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invAsync = ref.watch(activeInventoryProvider);
    final recordsAsync = ref.watch(inventoryRecordsProvider(inventoryId));

    return Scaffold(
      appBar: AppBar(
        title: invAsync.when(
          data: (inv) => Text(inv?.name ?? 'Inventario'),
          loading: () => const Text('...'),
          error: (_, __) => const Text('Inventario'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_upload_outlined),
            tooltip: 'Exportar',
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.export_, arguments: inventoryId),
          ),
          PopupMenuButton<String>(
            onSelected: (v) => _onMenu(context, ref, v),
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'archive', child: Text('Archivar')),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Eliminar', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ],
      ),
      body: invAsync.when(
        data: (inv) => inv == null
            ? const Center(child: Text('Inventario no encontrado'))
            : _Body(inventory: inv, recordsAsync: recordsAsync),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).pushNamed(
          AppRoutes.search,
          arguments: {'inventoryId': inventoryId},
        ),
        icon: const Icon(Icons.search),
        label: const Text('Buscar y capturar'),
      ),
    );
  }

  Future<void> _onMenu(
      BuildContext context, WidgetRef ref, String action) async {
    final svc = ref.read(inventoryServiceProvider);
    if (action == 'archive') {
      await svc.archive(inventoryId);
      if (context.mounted) Navigator.of(context).pop();
    } else if (action == 'delete') {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Eliminar inventario'),
          content: const Text(
              'Se eliminarán todos los registros. Esta acción no se puede deshacer.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancelar')),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Eliminar',
                  style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
      if (confirm == true) {
        await svc.delete(inventoryId);
        if (context.mounted) Navigator.of(context).pop();
      }
    }
  }
}

class _Body extends ConsumerWidget {
  final Inventory inventory;
  final AsyncValue<List<InventoryRecord>> recordsAsync;

  const _Body({required this.inventory, required this.recordsAsync});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _StatsHeader(inventory: inventory, recordsAsync: recordsAsync),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Row(
              children: [
                Text(
                  'Registros recientes',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: const Color(0xFF8B949E),
                      ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AppRoutes.recordsList, arguments: inventory.id),
                  child: const Text('Ver todos'),
                ),
              ],
            ),
          ),
        ),
        recordsAsync.when(
          data: (records) {
            if (records.isEmpty) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: Text(
                      'Sin registros aún.\nUsa BUSCAR Y CAPTURAR para añadir items.',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }
            final preview = records.take(20).toList();
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => _RecordTile(record: preview[i]),
                childCount: preview.length,
              ),
            );
          },
          loading: () => const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator())),
          error: (e, _) =>
              SliverToBoxAdapter(child: Text('Error: $e')),
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
      ],
    );
  }
}

class _StatsHeader extends StatelessWidget {
  final Inventory inventory;
  final AsyncValue<List<InventoryRecord>> recordsAsync;

  const _StatsHeader({required this.inventory, required this.recordsAsync});

  @override
  Widget build(BuildContext context) {
    final count = recordsAsync.value?.length ?? 0;
    final target = inventory.targetCount;
    final progress = target != null && target > 0 ? count / target : null;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(14),
        border: const Border.fromBorderSide(
            BorderSide(color: Color(0xFF30363D))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$count',
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFE6EDF3),
                        height: 1,
                      ),
                    ),
                    Text(
                      target != null
                          ? 'de $target registros'
                          : 'registros capturados',
                      style: const TextStyle(
                          color: Color(0xFF8B949E), fontSize: 13),
                    ),
                  ],
                ),
              ),
              _StatChip(
                icon: Icons.person_outline,
                label: inventory.operatorName,
              ),
            ],
          ),
          if (progress != null) ...[
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                minHeight: 6,
                backgroundColor: const Color(0xFF21262D),
                color: const Color(0xFF1E88E5),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${(progress * 100).clamp(0, 100).toStringAsFixed(1)}%',
              style: const TextStyle(
                  color: Color(0xFF8B949E), fontSize: 11),
            ),
          ],
          const SizedBox(height: 14),
          Text(
            'Creado ${DateFormat('dd/MM/yyyy HH:mm').format(inventory.createdAt.toLocal())}',
            style: const TextStyle(
                color: Color(0xFF8B949E), fontSize: 11),
          ),
          if (inventory.description != null) ...[
            const SizedBox(height: 6),
            Text(
              inventory.description!,
              style: const TextStyle(
                  color: Color(0xFF8B949E), fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _StatChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF21262D),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: const Color(0xFF8B949E)),
          const SizedBox(width: 5),
          Text(label,
              style: const TextStyle(
                  fontSize: 12, color: Color(0xFF8B949E))),
        ],
      ),
    );
  }
}

class _RecordTile extends StatelessWidget {
  final InventoryRecord record;
  const _RecordTile({required this.record});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        record.quantityFound.toStringAsFixed(
            record.quantityFound == record.quantityFound.truncateToDouble()
                ? 0
                : 1),
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1E88E5),
        ),
      ),
      title: Text(
        record.description,
        style: Theme.of(context).textTheme.bodyMedium,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${record.physicalLocation}  ·  ${record.primaryId}',
        style: Theme.of(context).textTheme.bodySmall,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        DateFormat('HH:mm').format(record.createdAt.toLocal()),
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
