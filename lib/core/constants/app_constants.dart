class AppConstants {
  static const String appName = 'Kaballo';
  static const String dbName = 'kaballo.db';

  static const String keyOperatorName = 'operator_name';
  static const String keyDeviceId = 'device_id';
  static const String keyCurrentInventoryId = 'current_inventory_id';
  static const String keyCurrentLocation = 'current_location';

  static const String statusActive = 'active';
  static const String statusArchived = 'archived';

  static const String invpackExtension = '.invpack';
  static const String invpackMime = 'application/zip';

  static const List<String> sourceTypes = [
    'MB52',
    'ZFIR0241',
    'ZMMR0080',
    'ZMMR0105',
  ];

  static const int searchResultLimit = 150;
  static const int minSearchLength = 2;
}
