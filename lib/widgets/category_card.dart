import 'package:flutter/material.dart';

import '../models/knowledge_category.dart';
import '../models/site_status.dart';
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
    final isLive = category.status == SiteStatus.live && siteCount > 0;
    final statusLabel = isLive
        ? '연결됨 · 사이트 $siteCount개'
        : category.status.label;
    final statusColor = isLive
        ? AppColors.success
        : (category.status == SiteStatus.preparing
              ? AppColors.preparing
              : AppColors.planned);

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
                  Text('향후 방향', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    category.futureDirection,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
