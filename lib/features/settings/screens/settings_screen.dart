import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaballo/features/settings/settings_providers.dart';
import 'package:kaballo/features/import/import_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final operatorAsync = ref.watch(operatorNameProvider);
    final deviceIdAsync = ref.watch(deviceIdProvider);
    final sourceCounts = ref.watch(sourceCountsProvider);
    final total = ref.watch(totalImportedProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Ajustes')),
      body: ListView(
        children: [
          _Section('Operador'),
          operatorAsync.when(
            data: (name) => ListTile(
              leading: const Icon(Icons.person_outline),
              title: Text(name ?? 'Sin nombre'),
              subtitle: const Text('Nombre del operador'),
              trailing: const Icon(Icons.edit_outlined,
                  size: 18, color: Color(0xFF8B949E)),
              onTap: () => _editName(context, ref, name),
            ),
            loading: () => const ListTile(title: Text('...')),
            error: (_, __) => const ListTile(title: Text('Error')),
          ),
          deviceIdAsync.when(
            data: (id) => ListTile(
              leading: const Icon(Icons.devices_outlined),
              title: Text(id),
              subtitle: const Text('ID de dispositivo'),
            ),
            loading: () => const ListTile(title: Text('...')),
            error: (_, __) => const ListTile(title: Text('Error')),
          ),
          const Divider(),
          _Section('Datos SAP importados'),
          total.when(
            data: (n) => ListTile(
              leading: const Icon(Icons.storage_outlined),
              title: Text('$n registros totales'),
              subtitle: const Text('Total importado de todas las fuentes'),
            ),
            loading: () => const ListTile(title: Text('...')),
            error: (_, __) => const ListTile(title: Text('Error')),
          ),
          sourceCounts.when(
            data: (counts) => Column(
              children: counts.entries.map((e) => ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 0),
                    title: Text(e.key,
                        style: const TextStyle(fontSize: 13)),
                    trailing: Text(
                      '${e.value}',
                      style: TextStyle(
                        color: e.value > 0
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFF8B949E),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )).toList(),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          const Divider(),
          _Section('Aplicación'),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Versión'),
            trailing: const Text('1.0.0',
                style: TextStyle(color: Color(0xFF8B949E))),
          ),
          ListTile(
            leading: const Icon(Icons.code_outlined),
            title: const Text('Kaballo'),
            subtitle:
                const Text('Inventario al barrido — Offline First'),
          ),
        ],
      ),
    );
  }

  Future<void> _editName(
      BuildContext context, WidgetRef ref, String? current) async {
    final ctrl = TextEditingController(text: current);
    final result = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Nombre del operador'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(hintText: 'Nombre completo'),
          onSubmitted: (v) => Navigator.pop(context, v),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar')),
          TextButton(
              onPressed: () => Navigator.pop(context, ctrl.text),
              child: const Text('Guardar')),
        ],
      ),
    );
    if (result != null && result.trim().isNotEmpty) {
      await ref
          .read(settingsServiceProvider)
          .setOperatorName(result.trim());
      ref.invalidate(operatorNameProvider);
    }
  }
}

class _Section extends StatelessWidget {
  final String title;
  const _Section(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: Color(0xFF8B949E),
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
