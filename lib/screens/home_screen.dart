import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/knowledge_data.dart';
import '../models/knowledge_site.dart';
import '../theme/app_colors.dart';
import '../utils/app_routes.dart';
import '../utils/breakpoints.dart';
import '../widgets/app_scope.dart';
import '../widgets/common_ui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = AppScope.repositoryOf(context);
    final width = MediaQuery.sizeOf(context).width;
    final hallColumns = width >= 1000 ? 2 : 1;

    return PageContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Hero(
            onFind: () => context.go(AppRoutes.find),
            onCategories: () => context.go(AppRoutes.categories),
            onSites: () => context.go(AppRoutes.sites),
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: '오늘 무엇을 배우고 싶으신가요?',
            subtitle: '관심 목적을 고르면 학습 길잡이 또는 전문관으로 이동합니다.',
          ),
          for (final goal in repo.learningGoals.take(5))
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Material(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    final sites = repo.sitesForGoal(goal);
                    if (sites.isNotEmpty) {
                      context.go(AppRoutes.siteDetail(sites.first.routeSlug));
                    } else {
                      context.go(AppRoutes.learning);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 52),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        Icon(goal.icon, color: AppColors.navy),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            goal.title,
                            softWrap: true,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => context.go(AppRoutes.find),
              child: const Text('더 자세한 추천 받기'),
            ),
          ),
          const SizedBox(height: 16),
          SectionHeader(
            title: '열 개 지식 전문관',
            subtitle: '생활·기술·AI·지역으로 묶어, 필요한 전문관만 골라 보세요.',
            action: TextButton(
              onPressed: () => context.go(AppRoutes.sites),
              child: const Text('전체 전문관 보기'),
            ),
          ),
          for (final group in KnowledgeData.homeGroups) ...[
            const SizedBox(height: 8),
            Text(group.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(
              group.subtitle,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
            ),
            const SizedBox(height: 10),
            _Grid(
              columns: hallColumns,
              children: [
                for (final siteId in group.siteIds)
                  if (repo.findSiteById(siteId) case final site?)
                    _CompactHallCard(site: site),
              ],
            ),
          ],
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => context.go(AppRoutes.sites),
              child: const Text('전체 전문관 목록 보기'),
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: '소통 지식 학습 방식',
            subtitle: '관심에서 시작해 이해·사례·심화·활용으로 이어집니다.',
          ),
          _LearningMethod(),
          const SizedBox(height: 24),
          const SectionHeader(
            title: '분야를 넘나드는 추천 학습',
            subtitle: '실제 전문관 내용으로 연결 가능한 다리만 안내합니다.',
          ),
          for (final item in repo.relatedKnowledge)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(item.title, softWrap: true),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.description, softWrap: true),
                        if (item.startHint.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(
                            '시작: ${item.startHint}',
                            style: const TextStyle(color: AppColors.textMuted),
                          ),
                        ],
                        if (item.nextHint.isNotEmpty)
                          Text(
                            '다음: ${item.nextHint}',
                            style: const TextStyle(color: AppColors.textMuted),
                          ),
                      ],
                    ),
                  ),
                  onTap: () {
                    final to = repo.findSiteById(item.toSiteId);
                    if (to != null) {
                      context.go(AppRoutes.siteDetail(to.routeSlug));
                    }
                  },
                ),
              ),
            ),
          const SizedBox(height: 16),
          SectionHeader(
            title: '통합 검색으로 시작하기',
            subtitle: '사이트·분야·코스·주제·키워드를 로컬에서 검색합니다.',
            action: TextButton(
              onPressed: () => context.go(AppRoutes.search),
              child: const Text('검색 열기'),
            ),
          ),
          _SearchEntry(onTap: () => context.go(AppRoutes.search)),
          const SizedBox(height: 24),
          const SectionHeader(
            title: '소통 지식 플랫폼의 운영 철학',
            subtitle: '쉬운 시작과 깊은 이해를 동시에 지향합니다.',
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(KnowledgeData.philosophy),
                  TextButton(
                    onPressed: () => context.go(AppRoutes.about),
                    child: const Text('소개 더 읽기'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({
    required this.onFind,
    required this.onCategories,
    required this.onSites,
  });

  final VoidCallback onFind;
  final VoidCallback onCategories;
  final VoidCallback onSites;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final narrow = Breakpoints.isMobile(MediaQuery.sizeOf(context).width);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(narrow ? 16 : 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
            style: theme.textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontSize: narrow ? 24 : 28,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            KnowledgeData.brandNameEn,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFFB7E4DE),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            KnowledgeData.tagline,
            softWrap: true,
            style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            KnowledgeData.supportLine,
            softWrap: true,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.92),
              height: 1.55,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.navy,
                  minimumSize: const Size(44, 44),
                ),
                onPressed: onFind,
                child: const Text('내게 맞는 지식 찾기'),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white70),
                  minimumSize: const Size(44, 44),
                ),
                onPressed: onCategories,
                child: const Text('분야별 둘러보기'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  minimumSize: const Size(44, 44),
                ),
                onPressed: onSites,
                child: const Text('전체 전문 사이트 보기'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CompactHallCard extends StatelessWidget {
  const _CompactHallCard({required this.site});

  final KnowledgeSite site;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(site.icon, color: site.color),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    site.name,
                    softWrap: true,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              site.valueProposition,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final topic in site.topics.take(3))
                  Chip(
                    label: Text(topic, style: const TextStyle(fontSize: 12)),
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              '추천: ${site.targetUsers.take(2).join(' · ')}',
              softWrap: true,
              style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () =>
                    context.go(AppRoutes.siteDetail(site.routeSlug)),
                child: const Text('상세 보기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LearningMethod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < KnowledgeData.learningMethodSteps.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.teal,
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      KnowledgeData.learningMethodSteps[i],
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _SearchEntry extends StatelessWidget {
  const _SearchEntry({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                '예: 건강, PLC, 스마트팜, 코딩, 귀촌…',
                softWrap: true,
                style: TextStyle(color: AppColors.textMuted, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  const _Grid({required this.columns, required this.children});

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
        const gap = 12.0;
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
