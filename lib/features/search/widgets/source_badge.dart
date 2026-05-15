import 'package:flutter/material.dart';
import 'package:kaballo/core/theme/app_theme.dart';

class SourceBadge extends StatelessWidget {
  final String sourceType;
  final bool compact;

  const SourceBadge({
    super.key,
    required this.sourceType,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = sourceColor(sourceType);
    final label = sourceLabel(sourceType);
    final icon = sourceIcon(sourceType);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 6 : 8,
        vertical: compact ? 2 : 3,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: compact ? 10 : 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: compact ? 9 : 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}
