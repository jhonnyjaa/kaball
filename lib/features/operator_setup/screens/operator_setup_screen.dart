import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaballo/core/utils/device_utils.dart';
import 'package:kaballo/features/settings/settings_providers.dart';
import 'package:kaballo/navigation/app_router.dart';

class OperatorSetupScreen extends ConsumerStatefulWidget {
  const OperatorSetupScreen({super.key});

  @override
  ConsumerState<OperatorSetupScreen> createState() =>
      _OperatorSetupScreenState();
}

class _OperatorSetupScreenState extends ConsumerState<OperatorSetupScreen> {
  final _ctrl = TextEditingController();
  bool _saving = false;
  String _deviceName = '';

  @override
  void initState() {
    super.initState();
    _loadDevice();
  }

  Future<void> _loadDevice() async {
    final name = await getDeviceDisplayName();
    if (mounted) setState(() => _deviceName = name);
  }

  Future<void> _save() async {
    final name = _ctrl.text.trim();
    if (name.isEmpty) return;
    setState(() => _saving = true);
    final svc = ref.read(settingsServiceProvider);
    await svc.setOperatorName(name);
    ref.invalidate(operatorNameProvider);
    ref.invalidate(isSetupCompleteProvider);
    if (mounted) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.inventoryList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E88E5).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.warehouse_outlined,
                    color: Color(0xFF1E88E5), size: 28),
              ),
              const SizedBox(height: 24),
              Text(
                'Kaballo',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Inventario al barrido — Configuración inicial',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 48),
              Text(
                'Nombre del operador',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: const Color(0xFF8B949E)),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _ctrl,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                style: const TextStyle(
                    fontSize: 18, color: Color(0xFFE6EDF3)),
                decoration: const InputDecoration(
                  hintText: 'Ej. Juan Pérez',
                  prefixIcon:
                      Icon(Icons.person_outline, color: Color(0xFF8B949E)),
                ),
                onSubmitted: (_) => _save(),
              ),
              if (_deviceName.isNotEmpty) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.devices_outlined,
                        size: 14, color: Color(0xFF8B949E)),
                    const SizedBox(width: 6),
                    Text(
                      _deviceName,
                      style: const TextStyle(
                          color: Color(0xFF8B949E), fontSize: 12),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saving ? null : _save,
                child: _saving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Comenzar'),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }
}
