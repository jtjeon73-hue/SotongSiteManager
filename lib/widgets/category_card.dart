import 'package:flutter/material.dart';

import '../models/content_status.dart';
import '../models/knowledge_category.dart';
import '../theme/app_colors.dart';
import 'common_ui.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    required this.category,
    required this.siteCount,
    this.onTap,
    super.key,
  });

  final KnowledgeCategory category;
  final int siteCount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLive =
        category.contentStatus == ContentStatus.live && siteCount > 0;
    final statusLabel = isLive
        ? '${category.contentStatus.label} · 사이트 $siteCount개'
        : category.contentStatus.label;
    final statusColor = switch (category.contentStatus) {
      ContentStatus.live => AppColors.success,
      ContentStatus.expanding => AppColors.preparing,
      ContentStatus.preparing => AppColors.planned,
    };

    return Semantics(
      button: onTap != null,
      label: '${category.name}. $statusLabel',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: category.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(category.icon, color: category.color),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        category.name,
                        softWrap: true,
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(category.description, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 12),
                StatusChip(
                  label: statusLabel,
                  color: statusColor,
                  icon: isLive ? Icons.link : Icons.hourglass_bottom,
                ),
                if (!isLive) ...[
                  const SizedBox(height: 12),
                  Text('왜 필요한가', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    category.whyNeeded.isEmpty
                        ? category.futureDirection
                        : category.whyNeeded,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text('향후 방향', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    category.futureDirection,
                    style: theme.textTheme.bodyMedium,
                  ),
                  if (category.audienceHint.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      '도움 되는 사람: ${category.audienceHint}',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
