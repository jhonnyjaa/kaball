import 'package:flutter/material.dart';

const _seed = Color(0xFF1565C0);

const sourceColors = {
  'MB52': Color(0xFF1E88E5),
  'ZFIR0241': Color(0xFFFF8F00),
  'ZMMR0080': Color(0xFFE53935),
  'ZMMR0105': Color(0xFF8E24AA),
};

const sourceLabels = {
  'MB52': 'MATERIAL',
  'ZFIR0241': 'ACTIVO FIJO',
  'ZMMR0080': 'BSU ACTIVO',
  'ZMMR0105': 'BSU MATERIAL',
};

const sourceIcons = {
  'MB52': Icons.inventory_2_outlined,
  'ZFIR0241': Icons.precision_manufacturing_outlined,
  'ZMMR0080': Icons.build_outlined,
  'ZMMR0105': Icons.category_outlined,
};

final appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorSchemeSeed: _seed,
  scaffoldBackgroundColor: const Color(0xFF0D1117),
  cardTheme: CardThemeData(
    color: const Color(0xFF161B22),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(color: Color(0xFF30363D), width: 1),
    ),
    margin: EdgeInsets.zero,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF0D1117),
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    titleTextStyle: TextStyle(
      color: Color(0xFFE6EDF3),
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: IconThemeData(color: Color(0xFF8B949E)),
  ),
  dividerTheme: const DividerThemeData(
    color: Color(0xFF21262D),
    thickness: 1,
    space: 0,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF161B22),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFF30363D)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFF30363D)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFF1E88E5), width: 1.5),
    ),
    hintStyle: const TextStyle(color: Color(0xFF8B949E)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF1E88E5),
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 52),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFFE6EDF3),
      minimumSize: const Size(double.infinity, 48),
      side: const BorderSide(color: Color(0xFF30363D)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    ),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: const Color(0xFF21262D),
    labelStyle: const TextStyle(color: Color(0xFFE6EDF3), fontSize: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(color: Color(0xFFE6EDF3), fontWeight: FontWeight.w700),
    headlineMedium: TextStyle(color: Color(0xFFE6EDF3), fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(color: Color(0xFFE6EDF3), fontWeight: FontWeight.w600),
    titleLarge: TextStyle(color: Color(0xFFE6EDF3), fontWeight: FontWeight.w600),
    titleMedium: TextStyle(color: Color(0xFFE6EDF3), fontWeight: FontWeight.w500),
    titleSmall: TextStyle(color: Color(0xFFCDD9E5), fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(color: Color(0xFFE6EDF3)),
    bodyMedium: TextStyle(color: Color(0xFFCDD9E5)),
    bodySmall: TextStyle(color: Color(0xFF8B949E)),
    labelLarge: TextStyle(color: Color(0xFFE6EDF3), fontWeight: FontWeight.w500),
    labelSmall: TextStyle(color: Color(0xFF8B949E), fontSize: 11),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF1E88E5),
    foregroundColor: Colors.white,
    elevation: 2,
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: Color(0xFF8B949E),
    textColor: Color(0xFFE6EDF3),
    tileColor: Colors.transparent,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF161B22),
    selectedItemColor: Color(0xFF1E88E5),
    unselectedItemColor: Color(0xFF8B949E),
  ),
);

Color sourceColor(String sourceType) =>
    sourceColors[sourceType] ?? const Color(0xFF8B949E);

String sourceLabel(String sourceType) =>
    sourceLabels[sourceType] ?? sourceType;

IconData sourceIcon(String sourceType) =>
    sourceIcons[sourceType] ?? Icons.help_outline;
