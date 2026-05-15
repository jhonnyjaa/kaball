import 'package:uuid/uuid.dart';
import 'package:kaballo/core/constants/app_constants.dart';
import 'package:kaballo/core/database/app_database.dart';

class SettingsService {
  final SettingsDao _dao;
  static const _uuid = Uuid();

  SettingsService(this._dao);

  Future<String?> getOperatorName() => _dao.get(AppConstants.keyOperatorName);

  Future<void> setOperatorName(String name) =>
      _dao.set(AppConstants.keyOperatorName, name);

  Future<String> getDeviceId() async {
    var id = await _dao.get(AppConstants.keyDeviceId);
    if (id == null) {
      id = _uuid.v4().substring(0, 8).toUpperCase();
      await _dao.set(AppConstants.keyDeviceId, id);
    }
    return id;
  }

  Future<String?> getCurrentInventoryId() =>
      _dao.get(AppConstants.keyCurrentInventoryId);

  Future<void> setCurrentInventoryId(String? id) async {
    if (id == null) {
      await _dao.delete_(AppConstants.keyCurrentInventoryId);
    } else {
      await _dao.set(AppConstants.keyCurrentInventoryId, id);
    }
  }

  Future<String> getCurrentLocation() async {
    return await _dao.get(AppConstants.keyCurrentLocation) ?? '';
  }

  Future<void> setCurrentLocation(String location) =>
      _dao.set(AppConstants.keyCurrentLocation, location);

  Future<bool> isSetupComplete() async {
    final name = await getOperatorName();
    return name != null && name.isNotEmpty;
  }
}
