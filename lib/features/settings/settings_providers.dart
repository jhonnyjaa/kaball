import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaballo/core/di/providers.dart';
import 'settings_service.dart';

final settingsServiceProvider = Provider<SettingsService>((ref) {
  return SettingsService(ref.watch(settingsDaoProvider));
});

final operatorNameProvider = FutureProvider<String?>((ref) {
  return ref.watch(settingsServiceProvider).getOperatorName();
});

final deviceIdProvider = FutureProvider<String>((ref) {
  return ref.watch(settingsServiceProvider).getDeviceId();
});

final isSetupCompleteProvider = FutureProvider<bool>((ref) {
  return ref.watch(settingsServiceProvider).isSetupComplete();
});

final currentLocationProvider =
    StateNotifierProvider<CurrentLocationNotifier, String>((ref) {
  return CurrentLocationNotifier(ref.watch(settingsServiceProvider));
});

class CurrentLocationNotifier extends StateNotifier<String> {
  final SettingsService _service;

  CurrentLocationNotifier(this._service) : super('') {
    _load();
  }

  Future<void> _load() async {
    state = await _service.getCurrentLocation();
  }

  Future<void> set(String location) async {
    state = location;
    await _service.setCurrentLocation(location);
  }
}
