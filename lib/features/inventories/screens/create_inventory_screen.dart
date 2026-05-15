import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaballo/features/inventories/inventory_providers.dart';
import 'package:kaballo/features/settings/settings_providers.dart';
import 'package:kaballo/navigation/app_router.dart';

class CreateInventoryScreen extends ConsumerStatefulWidget {
  const CreateInventoryScreen({super.key});

  @override
  ConsumerState<CreateInventoryScreen> createState() =>
      _CreateInventoryScreenState();
}

class _CreateInventoryScreenState
    extends ConsumerState<CreateInventoryScreen> {
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _targetCtrl = TextEditingController();
  bool _saving = false;

  Future<void> _create() async {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) return;
    setState(() => _saving = true);

    final operatorName =
        await ref.read(settingsServiceProvider).getOperatorName() ?? 'Operador';
    final deviceId = await ref.read(settingsServiceProvider).getDeviceId();
    final target = int.tryParse(_targetCtrl.text.trim());

    final inv = await ref.read(inventoryServiceProvider).create(
          name: name,
          operatorName: operatorName,
          deviceId: deviceId,
          description: _descCtrl.text.trim().isEmpty
              ? null
              : _descCtrl.text.trim(),
          targetCount: target,
        );

    if (mounted) {
      ref.read(activeInventoryIdProvider.notifier).state = inv.id;
      Navigator.of(context).pushReplacementNamed(
        AppRoutes.inventoryDetail,
        arguments: inv.id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo inventario')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label(context, 'Nombre *'),
              const SizedBox(height: 6),
              TextField(
                controller: _nameCtrl,
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: 'Ej. Barrido Almacén L001 — Mayo 2026',
                ),
              ),
              const SizedBox(height: 20),
              _label(context, 'Descripción (opcional)'),
              const SizedBox(height: 6),
              TextField(
                controller: _descCtrl,
                maxLines: 2,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: 'Notas sobre este inventario...',
                ),
              ),
              const SizedBox(height: 20),
              _label(context, 'Meta de registros (opcional)'),
              const SizedBox(height: 6),
              TextField(
                controller: _targetCtrl,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  hintText: 'Ej. 500',
                  suffixText: 'registros',
                ),
              ),
              const SizedBox(height: 36),
              ElevatedButton(
                onPressed: _saving ? null : _create,
                child: _saving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Crear inventario'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(BuildContext context, String text) => Text(
        text,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: const Color(0xFF8B949E)),
      );

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _targetCtrl.dispose();
    super.dispose();
  }
}
