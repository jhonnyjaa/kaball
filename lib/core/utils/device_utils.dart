import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

Future<String> getDeviceDisplayName() async {
  final info = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      final a = await info.androidInfo;
      return '${a.manufacturer} ${a.model}';
    } else if (Platform.isWindows) {
      final w = await info.windowsInfo;
      return w.computerName;
    }
  } catch (_) {}
  return 'Dispositivo';
}
