import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/database/app_database.dart';
import 'core/di/providers.dart';
import 'core/theme/app_theme.dart';
import 'features/settings/settings_providers.dart';
import 'navigation/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await openDatabase();
  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(db),
      ],
      child: const KaballoApp(),
    ),
  );
}

class KaballoApp extends ConsumerWidget {
  const KaballoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Kaballo',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      onGenerateRoute: generateRoute,
      home: const _Splash(),
    );
  }
}

class _Splash extends ConsumerWidget {
  const _Splash();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setup = ref.watch(isSetupCompleteProvider);

    return setup.when(
      data: (complete) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacementNamed(
            complete ? AppRoutes.inventoryList : AppRoutes.operatorSetup,
          );
        });
        return const _SplashBody();
      },
      loading: () => const _SplashBody(),
      error: (_, __) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context)
              .pushReplacementNamed(AppRoutes.operatorSetup);
        });
        return const _SplashBody();
      },
    );
  }
}

class _SplashBody extends StatelessWidget {
  const _SplashBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0xFF1E88E5).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.warehouse_outlined,
                color: Color(0xFF1E88E5),
                size: 36,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Kaballo',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Color(0xFFE6EDF3),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Inventario al barrido',
              style: TextStyle(color: Color(0xFF8B949E), fontSize: 13),
            ),
            const SizedBox(height: 32),
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ],
        ),
      ),
    );
  }
}
