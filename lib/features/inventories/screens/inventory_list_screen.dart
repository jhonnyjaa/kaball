import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kaballo/core/database/app_database.dart';
import 'package:kaballo/features/inventories/inventory_providers.dart';
import 'package:kaballo/features/import/import_providers.dart';
import 'package:kaballo/navigation/app_router.dart';

class InventoryListScreen extends ConsumerWidget {
  const InventoryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventories = ref.watch(inventoriesProvider);
    final totalImported = ref.watch(totalImportedProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kaballo'),
        actions: [
          totalImported.when(
            data: (n) => n > 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Chip(
                      label: Text('$n SAP'),
                      labelStyle: const TextStyle(
                          fontSize: 11, color: Color(0xFF8B949E)),
                      backgroundColor: const Color(0xFF21262D),
                    ),
                  )
                : const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          IconButton(
            icon: const Icon(Icons.upload_file_outlined),
            tooltip: 'Importar datos SAP',
            onPressed: () async {
              await Navigator.of(context).pushNamed(AppRoutes.import_);
              ref.invalidate(totalImportedProvider);
              ref.invalidate(sourceCountsProvider);
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Ajustes',
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.settings),
          ),
        ],
      ),
      body: inventories.when(
        data: (list) => list.isEmpty
            ? _EmptyState(onImport: () async {
                await Navigator.of(context).pushNamed(AppRoutes.import_);
                ref.invalidate(totalImportedProvider);
              })
            : _InventoryList(inventories: list),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            Navigator.of(context).pushNamed(AppRoutes.createInventory),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo inventario'),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onImport;
  const _EmptyState({required this.onImport});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.inventory_2_outlined,
              size: 64, color: Colors.white.withValues(alpha: 0.12)),
          const SizedBox(height: 16),
          Text(
            'Sin inventarios',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Importa los archivos SAP y crea tu primer inventario',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: onImport,
            icon: const Icon(Icons.upload_file_outlined, size: 18),
            label: const Text('Importar datos SAP'),
          ),
        ],
      ),
    );
  }
}

class _InventoryList extends StatelessWidget {
  final List<Inventory> inventories;
  const _InventoryList({required this.inventories});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: inventories.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (ctx, i) => _InventoryCard(inventory: inventories[i]),
    );
  }
}

class _InventoryCard extends ConsumerWidget {
  final Inventory inventory;
  const _InventoryCard({required this.inventory});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = inventory.status == 'active';
    final countAsync = ref.watch(inventoryRecordCountProvider(inventory.id));

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          ref.read(activeInventoryIdProvider.notifier).state = inventory.id;
          Navigator.of(context)
              .pushNamed(AppRoutes.inventoryDetail, arguments: inventory.id);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFF1E88E5).withValues(alpha: 0.15)
                      : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  isActive
                      ? Icons.folder_open_outlined
                      : Icons.folder_outlined,
                  color: isActive
                      ? const Color(0xFF1E88E5)
                      : const Color(0xFF8B949E),
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      inventory.name,
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${inventory.operatorName}  ·  '
                      '${DateFormat('dd/MM/yy').format(inventory.createdAt.toLocal())}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  countAsync.when(
                    data: (c) => Text(
                      '$c',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFE6EDF3),
                      ),
                    ),
                    loading: () => const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 1.5)),
                    error: (_, __) => const Text('—'),
                  ),
                  Text(
                    'registros',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
