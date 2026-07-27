import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/knowledge_data.dart';
import '../theme/app_colors.dart';
import '../utils/app_routes.dart';
import '../utils/breakpoints.dart';
import '../widgets/app_scope.dart';
import '../widgets/common_ui.dart';
import '../widgets/knowledge_site_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = AppScope.repositoryOf(context);
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final siteColumns = width >= 1000 ? 2 : 1;
    final categoryColumns = width >= 1100 ? 3 : (width >= 700 ? 2 : 1);

    return PageContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeroBanner(
            onSearch: () => context.go(AppRoutes.search),
            onSites: () => context.go(AppRoutes.sites),
            onLearning: () => context.go(AppRoutes.learning),
          ),
          const SizedBox(height: 28),
          SectionHeader(
            title: '통합 검색으로 시작하기',
            subtitle: '사이트명, 분야, 주제, 추천 대상, 키워드로 필요한 지식을 찾습니다.',
            action: TextButton(
              onPressed: () => context.go(AppRoutes.search),
              child: const Text('검색 열기'),
            ),
          ),
          _SearchEntry(onTap: () => context.go(AppRoutes.search)),
          const SizedBox(height: 32),
          SectionHeader(
            title: '현재 운영 중인 전문 지식 사이트',
            subtitle: '지금은 5개 사이트를 연결했으며, 데이터만 추가하면 허브에 바로 반영됩니다.',
            action: TextButton(
              onPressed: () => context.go(AppRoutes.sites),
              child: const Text('전체 보기'),
            ),
          ),
          _ResponsiveGrid(
            columns: siteColumns,
            children: [
              for (final site in repo.liveSites)
                KnowledgeSiteCard(
                  site: site,
                  categoryName: repo.categoryForSite(site).name,
                  compact: true,
                ),
            ],
          ),
          const SizedBox(height: 32),
          SectionHeader(
            title: '오늘의 추천 지식',
            subtitle: '전문 사이트로 이어지기 좋은 오늘의 출발점입니다.',
          ),
          ...repo.featuredKnowledge.take(3).map((item) {
            final site = repo.findSiteById(item.siteId);
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(item.title, softWrap: true),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      '${item.summary}\n왜 중요한가: ${item.whyItMatters}',
                      softWrap: true,
                    ),
                  ),
                  isThreeLine: true,
                  trailing: site == null
                      ? null
                      : IconButton(
                          tooltip: '${site.name} 방문',
                          onPressed: () => AppScope.linkServiceOf(
                            context,
                          ).openExternal(site.url),
                          icon: const Icon(Icons.open_in_new),
                        ),
                ),
              ),
            );
          }),
          const SizedBox(height: 20),
          SectionHeader(
            title: '분야별 탐색',
            subtitle: '관심 분야를 고르면 연결된 사이트나 준비 중 방향을 확인할 수 있습니다.',
            action: TextButton(
              onPressed: () => context.go(AppRoutes.categories),
              child: const Text('분야 전체'),
            ),
          ),
          _ResponsiveGrid(
            columns: categoryColumns,
            children: [
              for (final category in repo.categories.take(6))
                _HomeCategoryTile(
                  title: category.name,
                  description: category.description,
                  color: category.color,
                  icon: category.icon,
                  onTap: () => context.go(AppRoutes.categories),
                ),
            ],
          ),
          const SizedBox(height: 32),
          SectionHeader(
            title: '처음 방문한 사람을 위한 추천 시작점',
            subtitle: '목적만 골라보세요. 자세한 학습 순서는 학습 길잡이에서 이어집니다.',
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final line in KnowledgeData.starterPaths)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.north_east, color: AppColors.teal),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(line, style: theme.textTheme.bodyLarge),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () => context.go(AppRoutes.learning),
                    child: const Text('학습 길잡이 보기'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          SectionHeader(
            title: '최근 추가된 지식',
            subtitle: '새롭게 강조된 주제부터 가볍게 살펴보세요.',
          ),
          if (repo.recentKnowledge.isEmpty)
            const EmptyState(
              title: '최근 추가 항목이 없습니다',
              message: '새 추천 지식이 등록되면 이 영역에 표시됩니다.',
            )
          else
            ...repo.recentKnowledge.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  tileColor: AppColors.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: const BorderSide(color: AppColors.border),
                  ),
                  leading: const Icon(Icons.fiber_new, color: AppColors.warm),
                  title: Text(item.title, softWrap: true),
                  subtitle: Text(item.summary, softWrap: true),
                ),
              ),
            ),
          const SizedBox(height: 32),
          SectionHeader(
            title: '소통 지식 플랫폼의 운영 철학',
            subtitle: '쉬운 시작과 깊은 이해를 동시에 지향합니다.',
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    KnowledgeData.philosophy,
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Text('콘텐츠 발전 단계', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (
                        var i = 0;
                        i < KnowledgeData.contentPrinciples.length;
                        i++
                      )
                        Chip(
                          label: Text(
                            '${i + 1}. ${KnowledgeData.contentPrinciples[i]}',
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => context.go(AppRoutes.about),
                    child: const Text('소개 더 읽기'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          SectionHeader(
            title: '앞으로 확장할 분야',
            subtitle: '관심 분야가 늘어날수록 허브는 더 넓고 깊게 성장합니다.',
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final field in KnowledgeData.expansionFields)
                Chip(
                  avatar: const Icon(Icons.add, size: 16),
                  label: Text(field),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({
    required this.onSearch,
    required this.onSites,
    required this.onLearning,
  });

  final VoidCallback onSearch;
  final VoidCallback onSites;
  final VoidCallback onLearning;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final isNarrow = Breakpoints.isMobile(width);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isNarrow ? 20 : 28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F2744), Color(0xFF1A3A5C), Color(0xFF0F766E)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            KnowledgeData.brandName,
            style: theme.textTheme.headlineLarge?.copyWith(
              color: Colors.white,
              fontSize: isNarrow ? 28 : 34,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            KnowledgeData.brandNameEn,
            style: theme.textTheme.titleMedium?.copyWith(
              color: const Color(0xFFB7E4DE),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            KnowledgeData.tagline,
            softWrap: true,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            KnowledgeData.supportLine,
            softWrap: true,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.92),
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.navy,
                ),
                onPressed: onSearch,
                child: const Text('지식 검색하기'),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white70),
                ),
                onPressed: onSites,
                child: const Text('전문 사이트 보기'),
              ),
              TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.white),
                onPressed: onLearning,
                child: const Text('학습 길잡이'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SearchEntry extends StatelessWidget {
  const _SearchEntry({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '통합 검색 화면으로 이동',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: const Row(
            children: [
              Icon(Icons.search, color: AppColors.teal),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  '예: 전기기사, 자동차 점검, 생활영어, 프롬프트…',
                  softWrap: true,
                  style: TextStyle(color: AppColors.textMuted, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeCategoryTile extends StatelessWidget {
  const _HomeCategoryTile({
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String description;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              softWrap: true,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(
              description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _ResponsiveGrid extends StatelessWidget {
  const _ResponsiveGrid({required this.columns, required this.children});

  final int columns;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    if (columns <= 1) {
      return Column(
        children: [
          for (final child in children)
            Padding(padding: const EdgeInsets.only(bottom: 12), child: child),
        ],
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final gap = 12.0;
        final itemWidth =
            (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final child in children)
              SizedBox(width: itemWidth, child: child),
          ],
        );
      },
    );
  }
}
