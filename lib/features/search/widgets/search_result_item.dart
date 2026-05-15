import 'package:flutter/material.dart';
import 'package:kaballo/core/database/app_database.dart';
import 'package:kaballo/core/theme/app_theme.dart';
import 'package:kaballo/core/utils/sap_fields.dart';
import 'source_badge.dart';

class SearchResultItem extends StatelessWidget {
  final ImportedItem item;
  final VoidCallback onTap;

  const SearchResultItem({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = sourceColor(item.sourceType);
    final summary = SapFields.summary(item.sourceType, item.rawData);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFF21262D), width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(sourceIcon(item.sourceType), size: 20, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge + ubicación SAP
                  Row(
                    children: [
                      SourceBadge(sourceType: item.sourceType, compact: true),
                      if (item.location != null) ...[
                        const SizedBox(width: 6),
                        const Icon(Icons.location_on_outlined,
                            size: 10, color: Color(0xFF8B949E)),
                        const SizedBox(width: 2),
                        Flexible(
                          child: Text(
                            item.location!,
                            style: const TextStyle(
                                fontSize: 10, color: Color(0xFF8B949E)),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Descripción
                  Text(
                    item.description,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFE6EDF3),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 3),
                  // Campos SAP con etiquetas
                  Wrap(
                    spacing: 10,
                    runSpacing: 1,
                    children: summary
                        .map((f) => RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: '${f.label}: ',
                                  style: const TextStyle(
                                      color: Color(0xFF8B949E),
                                      fontSize: 11),
                                ),
                                TextSpan(
                                  text: f.value,
                                  style: TextStyle(
                                    color: color.withValues(alpha: 0.9),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ]),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right,
                color: Color(0xFF30363D), size: 18),
          ],
        ),
      ),
    );
  }
}
