import 'package:flutter/material.dart';

import '../utils/breakpoints.dart';
import '../widgets/app_scope.dart';
import '../widgets/common_ui.dart';
import '../widgets/knowledge_site_card.dart';

class SitesScreen extends StatelessWidget {
  const SitesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = AppScope.repositoryOf(context);
    final width = MediaQuery.sizeOf(context).width;
    final columns = width >= 1100 ? 2 : 1;

    return PageContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: '전체 사이트',
            subtitle:
                '소통회장이 운영하는 전문 지식 사이트를 분야 카드로 모았습니다. '
                '각 사이트는 새 탭에서 안전하게 열립니다.',
          ),
          Text(
            '현재 연결 ${repo.liveSites.length}곳 · 전체 등록 ${repo.allSites.length}곳',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              if (columns == 1 || Breakpoints.isMobile(width)) {
                return Column(
                  children: [
                    for (final site in repo.allSites)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: KnowledgeSiteCard(
                          site: site,
                          categoryName: repo.categoryForSite(site).name,
                        ),
                      ),
                  ],
                );
              }

              final gap = 14.0;
              final itemWidth = (constraints.maxWidth - gap) / 2;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final site in repo.allSites)
                    SizedBox(
                      width: itemWidth,
                      child: KnowledgeSiteCard(
                        site: site,
                        categoryName: repo.categoryForSite(site).name,
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
