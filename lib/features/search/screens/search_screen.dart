import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaballo/core/database/app_database.dart';
import 'package:kaballo/features/search/search_providers.dart';
import 'package:kaballo/features/search/widgets/search_result_item.dart';
import 'package:kaballo/features/settings/settings_providers.dart';
import 'package:kaballo/navigation/app_router.dart';

class SearchScreen extends ConsumerStatefulWidget {
  final String inventoryId;
  const SearchScreen({super.key, required this.inventoryId});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _ctrl = TextEditingController();
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focus.requestFocus();
    });
  }

  void _clearSearch() {
    _ctrl.clear();
    ref.read(searchQueryProvider.notifier).state = '';
    _focus.requestFocus();
  }

  void _onItemTap(ImportedItem item) {
    Navigator.of(context).pushNamed(
      AppRoutes.capture,
      arguments: {'item': item, 'inventoryId': widget.inventoryId},
    );
  }

  @override
  Widget build(BuildContext context) {
    final results = ref.watch(searchResultsProvider);
    final query = ref.watch(searchQueryProvider);
    final location = ref.watch(currentLocationProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1117),
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: TextField(
            controller: _ctrl,
            focusNode: _focus,
            autofocus: true,
            style: const TextStyle(
                fontSize: 16, color: Color(0xFFE6EDF3)),
            decoration: InputDecoration(
              hintText: 'Buscar material, activo, lote...',
              prefixIcon: const Icon(Icons.search,
                  color: Color(0xFF8B949E), size: 20),
              suffixIcon: query.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.close,
                          color: Color(0xFF8B949E), size: 18),
                      onPressed: _clearSearch,
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: Color(0xFF30363D)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: Color(0xFF30363D)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: Color(0xFF1E88E5), width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 10),
              filled: true,
              fillColor: const Color(0xFF161B22),
            ),
            onChanged: (v) =>
                ref.read(searchQueryProvider.notifier).state = v,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(36),
          child: _LocationBar(
            location: location,
            onTap: () => _editLocation(context, ref, location),
          ),
        ),
      ),
      body: query.isEmpty
          ? _EmptyQuery()
          : results.when(
              data: (items) => items.isEmpty
                  ? _NoResults(query: query)
                  : _ResultsList(items: items, onTap: _onItemTap),
              loading: () => const Center(
                  child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
    );
  }

  Future<void> _editLocation(
      BuildContext context, WidgetRef ref, String current) async {
    final ctrl = TextEditingController(text: current);
    final result = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Ubicación actual'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          textCapitalization: TextCapitalization.characters,
          decoration: const InputDecoration(
            hintText: 'Ej. 65-B-4',
          ),
          onSubmitted: (v) => Navigator.pop(context, v),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar')),
          TextButton(
              onPressed: () => Navigator.pop(context, ctrl.text),
              child: const Text('Aceptar')),
        ],
      ),
    );
    if (result != null) {
      await ref.read(currentLocationProvider.notifier).set(result.trim());
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _focus.dispose();
    super.dispose();
  }
}

class _LocationBar extends StatelessWidget {
  final String location;
  final VoidCallback onTap;
  const _LocationBar({required this.location, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        color: const Color(0xFF0D1117),
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            const Icon(Icons.location_on,
                size: 14, color: Color(0xFF1E88E5)),
            const SizedBox(width: 6),
            Text(
              location.isEmpty ? 'Sin ubicación — toca para cambiar' : location,
              style: TextStyle(
                fontSize: 12,
                color: location.isEmpty
                    ? const Color(0xFF8B949E)
                    : const Color(0xFF1E88E5),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.edit_outlined,
                size: 12, color: Color(0xFF8B949E)),
          ],
        ),
      ),
    );
  }
}

class _EmptyQuery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search,
              size: 56, color: Colors.white.withValues(alpha: 0.08)),
          const SizedBox(height: 12),
          Text(
            'Escribe para buscar',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: const Color(0xFF8B949E)),
          ),
          const SizedBox(height: 4),
          Text(
            'Código, descripción, lote, número de serie...',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _NoResults extends StatelessWidget {
  final String query;
  const _NoResults({required this.query});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off,
              size: 48, color: Colors.white.withValues(alpha: 0.08)),
          const SizedBox(height: 12),
          Text('"$query"',
              style: const TextStyle(
                  color: Color(0xFFE6EDF3),
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          const Text('Sin resultados en los datos importados',
              style: TextStyle(color: Color(0xFF8B949E), fontSize: 13)),
        ],
      ),
    );
  }
}

class _ResultsList extends StatelessWidget {
  final List<ImportedItem> items;
  final void Function(ImportedItem) onTap;
  const _ResultsList({required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            '${items.length} resultado${items.length != 1 ? 's' : ''}',
            style: const TextStyle(
                color: Color(0xFF8B949E), fontSize: 12),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, i) => SearchResultItem(
              item: items[i],
              onTap: () => onTap(items[i]),
            ),
          ),
        ),
      ],
    );
  }
}
