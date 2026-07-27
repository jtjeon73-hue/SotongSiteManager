import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/knowledge_path.dart';
import '../theme/app_colors.dart';
import '../utils/app_routes.dart';
import '../widgets/app_scope.dart';
import '../widgets/common_ui.dart';
import '../widgets/knowledge_site_card.dart';

class LearningGuideScreen extends StatefulWidget {
  const LearningGuideScreen({this.initialCourseId, super.key});

  final String? initialCourseId;

  @override
  State<LearningGuideScreen> createState() => _LearningGuideScreenState();
}

class _LearningGuideScreenState extends State<LearningGuideScreen> {
  String? _selectedPathId;
  String? _selectedGoalId;
  String _groupFilter = '전체';

  @override
  void initState() {
    super.initState();
    _selectedPathId = widget.initialCourseId;
  }

  @override
  Widget build(BuildContext context) {
    final repo = AppScope.repositoryOf(context);
    final groups = <String>{
      '전체',
      ...repo.learningPaths.map((p) => p.groupLabel),
    }.toList();
    final filteredPaths = _groupFilter == '전체'
        ? repo.learningPaths
        : repo.learningPaths
              .where((path) => path.groupLabel == _groupFilter)
              .toList();
    final selectedPath = _selectedPathId == null
        ? null
        : repo.findPathById(_selectedPathId!);
    final selectedGoal = _selectedGoalId == null
        ? null
        : repo.findGoalById(_selectedGoalId!);

    return PageContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: '학습 길잡이',
            subtitle:
                '구체적인 학습 코스와 목적별 안내를 제공합니다. '
                '실제 강의 URL이 확인되지 않은 경우 전문 사이트 홈으로 안내합니다.',
          ),
          Text('학습 코스', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final group in groups)
                FilterChip(
                  label: Text(group),
                  selected: _groupFilter == group,
                  onSelected: (_) => setState(() {
                    _groupFilter = group;
                    if (selectedPath != null &&
                        group != '전체' &&
                        selectedPath.groupLabel != group) {
                      _selectedPathId = null;
                    }
                  }),
                ),
            ],
          ),
          const SizedBox(height: 10),
          for (final path in filteredPaths)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _PathTile(
                path: path,
                selected: _selectedPathId == path.id,
                onTap: () => setState(() {
                  _selectedPathId = path.id;
                  _selectedGoalId = null;
                }),
              ),
            ),
          if (selectedPath != null) ...[
            const SizedBox(height: 8),
            _PathDetail(path: selectedPath),
          ],
          const SizedBox(height: 24),
          Text('목적별 빠른 길잡이', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 10),
          for (final goal in repo.learningGoals)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: _selectedGoalId == goal.id
                        ? AppColors.teal
                        : AppColors.border,
                  ),
                ),
                leading: Icon(goal.icon),
                title: Text(goal.title, softWrap: true),
                onTap: () => setState(() {
                  _selectedGoalId = goal.id;
                  _selectedPathId = null;
                }),
              ),
            ),
          if (selectedGoal != null) ...[
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(selectedGoal.description),
                    const SizedBox(height: 10),
                    for (var i = 0; i < selectedGoal.learningOrder.length; i++)
                      Text('${i + 1}. ${selectedGoal.learningOrder[i]}'),
                    const SizedBox(height: 10),
                    for (final site in repo.sitesForGoal(selectedGoal))
                      KnowledgeSiteCard(
                        site: site,
                        categoryName: repo.categoryForSite(site).name,
                        compact: true,
                      ),
                    if (repo.sitesForGoal(selectedGoal).isEmpty)
                      const EmptyState(
                        title: '연결 사이트가 준비 중입니다',
                        message: '학습 순서와 팁을 먼저 참고해 주세요.',
                      ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PathTile extends StatelessWidget {
  const _PathTile({
    required this.path,
    required this.selected,
    required this.onTap,
  });

  final KnowledgePath path;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? AppColors.teal.withValues(alpha: 0.1)
          : AppColors.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 56),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? AppColors.teal : AppColors.border,
            ),
          ),
          child: Row(
            children: [
              Icon(path.icon, color: AppColors.navy),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      path.title,
                      softWrap: true,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '${path.durationLabel} · ${path.dailyMinutesLabel}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Icon(selected ? Icons.expand_less : Icons.expand_more),
            ],
          ),
        ),
      ),
    );
  }
}

class _PathDetail extends StatelessWidget {
  const _PathDetail({required this.path});

  final KnowledgePath path;

  @override
  Widget build(BuildContext context) {
    final repo = AppScope.repositoryOf(context);
    final sites = repo.sitesForPath(path);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('코스 목적', style: Theme.of(context).textTheme.titleMedium),
            Text(path.purpose),
            const SizedBox(height: 8),
            Text('추천 대상: ${path.targetUsers.join(' · ')}'),
            Text('예상 기간: ${path.durationLabel}'),
            Text('하루 권장 시간: ${path.dailyMinutesLabel}'),
            if (path.cautionNotice.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text('주의사항', style: Theme.of(context).textTheme.titleMedium),
              Text(path.cautionNotice, softWrap: true),
            ],
            const SizedBox(height: 12),
            Text('학습 단계', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            for (var i = 0; i < path.steps.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: AppColors.teal,
                      child: Text(
                        '${i + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            path.steps[i].title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(path.steps[i].reason),
                          if (path.steps[i].hint.isNotEmpty)
                            Text(
                              path.steps[i].hint,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            Text('연결되는 전문 사이트', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            for (final site in sites) ...[
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(site.name),
                subtitle: Text(site.startPoint),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.go(AppRoutes.siteDetail(site.routeSlug)),
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () =>
                      AppScope.linkServiceOf(context).openExternal(site.url),
                  icon: const Icon(Icons.open_in_new, size: 16),
                  label: Text('${site.name} 시작하기'),
                ),
              ),
              const SizedBox(height: 8),
            ],
            if (path.relatedSiteIds.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                '함께 연결할 전문관',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              for (final id in path.relatedSiteIds)
                if (repo.findSiteById(id) case final related?)
                  TextButton(
                    onPressed: () =>
                        context.go(AppRoutes.siteDetail(related.routeSlug)),
                    child: Text(related.name),
                  ),
            ],
          ],
        ),
      ),
    );
  }
}
