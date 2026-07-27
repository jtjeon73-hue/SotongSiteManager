import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/content_status.dart';
import '../theme/app_colors.dart';
import '../utils/app_routes.dart';
import '../widgets/app_scope.dart';
import '../widgets/category_card.dart';
import '../widgets/common_ui.dart';
import '../widgets/knowledge_site_card.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String? _selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    final repo = AppScope.repositoryOf(context);
    final width = MediaQuery.sizeOf(context).width;
    final columns = width >= 1100 ? 3 : (width >= 720 ? 2 : 1);
    final selected = _selectedCategoryId == null
        ? null
        : repo.findCategoryById(_selectedCategoryId!);
    final filteredSites = selected == null
        ? const []
        : repo.sitesByCategory(selected.id);

    return PageContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: '분야별 지식 지도',
            subtitle: '운영 중·확장 중·준비 중 상태를 구분해, 현재 배울 수 있는 분야와 앞으로의 방향을 보여줍니다.',
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilterChip(
                label: const Text('전체 분야'),
                selected: _selectedCategoryId == null,
                onSelected: (_) => setState(() => _selectedCategoryId = null),
              ),
              for (final category in repo.categories)
                FilterChip(
                  label: Text(category.name),
                  selected: _selectedCategoryId == category.id,
                  onSelected: (_) =>
                      setState(() => _selectedCategoryId = category.id),
                ),
            ],
          ),
          const SizedBox(height: 20),
          if (selected == null)
            LayoutBuilder(
              builder: (context, constraints) {
                const gap = 12.0;
                final itemWidth = columns == 1
                    ? constraints.maxWidth
                    : (constraints.maxWidth - gap * (columns - 1)) / columns;
                return Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    for (final category in repo.categories)
                      SizedBox(
                        width: itemWidth,
                        child: CategoryCard(
                          category: category,
                          siteCount: repo.sitesByCategory(category.id).length,
                          onTap: () =>
                              setState(() => _selectedCategoryId = category.id),
                        ),
                      ),
                  ],
                );
              },
            )
          else ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selected.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(selected.description),
                    if (selected.whyNeeded.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Text(
                        '왜 필요한가',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(selected.whyNeeded),
                    ],
                    if (selected.audienceHint.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text('도움 되는 사람: ${selected.audienceHint}'),
                    ],
                    const SizedBox(height: 12),
                    StatusChip(
                      label: selected.contentStatus.label,
                      color: switch (selected.contentStatus) {
                        ContentStatus.live => AppColors.success,
                        ContentStatus.expanding => AppColors.preparing,
                        ContentStatus.preparing => AppColors.planned,
                      },
                      icon: selected.contentStatus == ContentStatus.live
                          ? Icons.check_circle_outline
                          : Icons.hourglass_bottom,
                    ),
                    if (filteredSites.isEmpty) ...[
                      const SizedBox(height: 16),
                      EmptyState(
                        title: '${selected.name}은 준비 중입니다',
                        message:
                            '${selected.futureDirection}\n'
                            '현재는 바로가기가 없으며, 전문관이 열리면 이 지도에 연결됩니다.',
                        icon: Icons.construction_outlined,
                        action: TextButton(
                          onPressed: () =>
                              setState(() => _selectedCategoryId = null),
                          child: const Text('다른 분야 보기'),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            for (final site in filteredSites)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  children: [
                    KnowledgeSiteCard(site: site, categoryName: selected.name),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () =>
                            context.go(AppRoutes.siteDetail(site.routeSlug)),
                        child: const Text('전문관 자세히 보기'),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}
