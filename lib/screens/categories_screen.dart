import 'package:flutter/material.dart';

import '../models/site_status.dart';
import '../theme/app_colors.dart';
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
            title: '분야별 지식',
            subtitle: '관심 분야를 고르면 연결된 전문 사이트나, 아직 준비 중인 콘텐츠 방향을 확인할 수 있습니다.',
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
                final gap = 12.0;
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
                    const SizedBox(height: 12),
                    StatusChip(
                      label: selected.status.label,
                      color: selected.status == SiteStatus.live
                          ? AppColors.success
                          : AppColors.preparing,
                    ),
                    if (filteredSites.isEmpty) ...[
                      const SizedBox(height: 16),
                      EmptyState(
                        title: '${selected.name}은 준비 중입니다',
                        message: selected.futureDirection,
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
                child: KnowledgeSiteCard(
                  site: site,
                  categoryName: selected.name,
                ),
              ),
          ],
        ],
      ),
    );
  }
}
