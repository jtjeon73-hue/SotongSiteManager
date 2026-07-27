import 'package:flutter/material.dart';

import '../models/knowledge_site.dart';
import '../models/site_status.dart';
import '../services/link_service.dart';
import '../theme/app_colors.dart';
import 'app_scope.dart';
import 'common_ui.dart';

class KnowledgeSiteCard extends StatelessWidget {
  const KnowledgeSiteCard({
    required this.site,
    required this.categoryName,
    this.compact = false,
    super.key,
  });

  final KnowledgeSite site;
  final String categoryName;
  final bool compact;

  Color get _statusColor => switch (site.status) {
    SiteStatus.live => AppColors.success,
    SiteStatus.preparing => AppColors.preparing,
    SiteStatus.planned => AppColors.planned,
  };

  IconData get _statusIcon => switch (site.status) {
    SiteStatus.live => Icons.check_circle_outline,
    SiteStatus.preparing => Icons.hourglass_bottom,
    SiteStatus.planned => Icons.flag_outlined,
  };

  Future<void> _open(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final linkService = AppScope.linkServiceOf(context);
    final ok = await linkService.openExternal(site.url);
    if (!ok) {
      messenger.showSnackBar(
        const SnackBar(content: Text('사이트를 열 수 없습니다. 주소와 네트워크를 확인해 주세요.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      container: true,
      label: '${site.name}. ${site.description}. 상태 ${site.status.label}',
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(compact ? 16 : 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: site.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(site.icon, color: site.color),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          site.name,
                          softWrap: true,
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          site.description,
                          softWrap: true,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  StatusChip(
                    label: site.status.label,
                    color: _statusColor,
                    icon: _statusIcon,
                  ),
                  StatusChip(
                    label: '난이도 ${site.difficulty.label}',
                    color: AppColors.navySoft,
                    icon: Icons.stairs_outlined,
                  ),
                  StatusChip(
                    label: categoryName,
                    color: AppColors.teal,
                    icon: Icons.category_outlined,
                  ),
                ],
              ),
              if (!compact) ...[
                const SizedBox(height: 14),
                Text('배울 수 있는 내용', style: theme.textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(
                  site.detailedDescription,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                Text('추천 대상', style: theme.textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(
                  site.targetUsers.join(' · '),
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                Text('주요 주제', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final topic in site.topics) Chip(label: Text(topic)),
                  ],
                ),
              ],
              const SizedBox(height: 16),
              if (site.isLive)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _open(context),
                    icon: const Icon(Icons.open_in_new, size: 18),
                    label: const Text('사이트 방문'),
                  ),
                )
              else
                const EmptyState(
                  title: '준비 중인 사이트',
                  message: '이 분야는 곧 전문 사이트로 연결될 예정입니다.',
                  icon: Icons.hourglass_top,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Visible anchor used by tests and web crawlers for external hrefs.
class ExternalSiteLink extends StatelessWidget {
  const ExternalSiteLink({
    required this.url,
    required this.label,
    this.onPressed,
    super.key,
  });

  final String url;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      link: true,
      label: label,
      child: TextButton(
        onPressed: onPressed ?? () => const LinkService().openExternal(url),
        child: Text(label),
      ),
    );
  }
}
