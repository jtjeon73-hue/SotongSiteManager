import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/knowledge_site.dart';
import '../theme/app_colors.dart';
import '../utils/app_routes.dart';
import '../widgets/app_scope.dart';
import '../widgets/common_ui.dart';

class SiteDetailScreen extends StatelessWidget {
  const SiteDetailScreen({required this.slug, super.key});

  final String slug;

  @override
  Widget build(BuildContext context) {
    final repo = AppScope.repositoryOf(context);
    final site = repo.findSiteBySlug(slug);
    if (site == null) {
      return PageContainer(
        child: EmptyState(
          title: '전문관을 찾을 수 없습니다',
          message: '주소가 올바른지 확인하거나 전체 사이트 목록에서 다시 선택해 주세요.',
          action: OutlinedButton(
            onPressed: () => context.go(AppRoutes.sites),
            child: const Text('전체 사이트 보기'),
          ),
        ),
      );
    }

    final category = repo.categoryForSite(site);
    final related = site.relatedSiteIds
        .map(repo.findSiteById)
        .whereType<KnowledgeSite>()
        .toList();

    return PageContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(AppRoutes.sites);
              }
            },
            icon: const Icon(Icons.arrow_back),
            label: const Text('이전으로'),
          ),
          const SizedBox(height: 8),
          _Hero(site: site, categoryName: category.name),
          const SizedBox(height: 16),
          if (site.safetyNotice.isNotEmpty)
            _NoticeCard(title: '안전·책임 안내', body: site.safetyNotice),
          _Section(title: '전문관 소개', child: Text(site.detailedDescription)),
          _Section(title: '이 지식이 중요한 이유', child: Text(site.whyMatters)),
          _Section(
            title: '이런 분에게 추천',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final user in site.targetUsers) Chip(label: Text(user)),
              ],
            ),
          ),
          _Section(
            title: '무엇을 배울 수 있는가',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final item in site.learningOutcomes)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: AppColors.teal,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(child: Text(item)),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          _Section(
            title: '대표 주제',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final topic in site.topics) Chip(label: Text(topic)),
              ],
            ),
          ),
          if (site.menuHighlights.isNotEmpty)
            _Section(
              title: '실제 사이트에서 확인된 주요 메뉴·기능',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final menu in site.menuHighlights)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text('· $menu'),
                    ),
                ],
              ),
            ),
          _Section(
            title: '처음 시작하는 순서',
            child: Column(
              children: [
                for (var i = 0; i < site.recommendedPath.length; i++)
                  _StepTile(index: i + 1, text: site.recommendedPath[i]),
              ],
            ),
          ),
          _Section(
            title: '기초 · 중급 · 심화',
            child: Column(
              children: [
                _LevelCard(title: '기초', items: site.beginnerFocus),
                const SizedBox(height: 10),
                _LevelCard(title: '중급', items: site.intermediateFocus),
                const SizedBox(height: 10),
                _LevelCard(title: '심화', items: site.advancedFocus),
              ],
            ),
          ),
          _Section(
            title: '생활 또는 실무 활용 사례',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final useCase in site.useCases)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text('· $useCase'),
                  ),
              ],
            ),
          ),
          if (related.isNotEmpty)
            _Section(
              title: '다른 전문관과 연결되는 지식',
              child: Column(
                children: [
                  for (final item in related)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(item.icon, color: item.color),
                      title: Text(item.name),
                      subtitle: Text(item.valueProposition),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () =>
                          context.go(AppRoutes.siteDetail(item.routeSlug)),
                    ),
                ],
              ),
            ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () =>
                  AppScope.linkServiceOf(context).openExternal(site.url),
              icon: const Icon(Icons.open_in_new),
              label: const Text('전문 사이트 방문'),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => context.go(AppRoutes.sites),
              child: const Text('전체 전문관 목록'),
            ),
          ),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.site, required this.categoryName});

  final KnowledgeSite site;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [site.color.withValues(alpha: 0.95), AppColors.navy],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            site.name,
            softWrap: true,
            style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            site.coreQuestion,
            softWrap: true,
            style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            site.valueProposition,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.92),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              StatusChip(
                label: categoryName,
                color: Colors.white,
                icon: Icons.category_outlined,
              ),
              StatusChip(
                label: '난이도 ${site.difficulty.label}',
                color: Colors.white,
              ),
              StatusChip(
                label: site.status.label,
                color: Colors.white,
                icon: Icons.check_circle_outline,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '예상 시작점: ${site.startPoint}',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 10),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _NoticeCard extends StatelessWidget {
  const _NoticeCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.warmSoft.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.warm),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.info_outline, color: AppColors.preparing),
                const SizedBox(width: 8),
                Text(title, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 8),
            Text(body),
          ],
        ),
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  const _StepTile({required this.index, required this.text});

  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: AppColors.teal,
            child: Text(
              '$index',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  const _LevelCard({required this.title, required this.items});

  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          for (final item in items) Text('· $item'),
        ],
      ),
    );
  }
}
