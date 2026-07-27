import 'package:flutter/material.dart';

import '../models/learning_goal.dart';
import '../theme/app_colors.dart';
import '../widgets/app_scope.dart';
import '../widgets/common_ui.dart';
import '../widgets/knowledge_site_card.dart';

class LearningGuideScreen extends StatefulWidget {
  const LearningGuideScreen({super.key});

  @override
  State<LearningGuideScreen> createState() => _LearningGuideScreenState();
}

class _LearningGuideScreenState extends State<LearningGuideScreen> {
  String? _selectedGoalId;

  @override
  Widget build(BuildContext context) {
    final repo = AppScope.repositoryOf(context);
    final selected = _selectedGoalId == null
        ? null
        : repo.findGoalById(_selectedGoalId!);
    final relatedSites = selected == null
        ? const []
        : repo.sitesForGoal(selected);

    return PageContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: '학습 길잡이',
            subtitle:
                '목적을 고르면 관련 전문 사이트와 추천 학습 순서를 안내합니다. '
                '아직 사이트가 없는 목표도 앞으로의 학습 방향을 미리 확인할 수 있습니다.',
          ),
          for (final goal in repo.learningGoals)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _GoalTile(
                goal: goal,
                selected: _selectedGoalId == goal.id,
                onTap: () => setState(() => _selectedGoalId = goal.id),
              ),
            ),
          const SizedBox(height: 12),
          if (selected == null)
            const EmptyState(
              title: '목적을 선택해 주세요',
              message:
                  '예: AI를 처음 배우고 싶어요, 전기기사 공부를 하고 싶어요처럼 '
                  '나와 가까운 목표를 고르면 학습 순서가 나타납니다.',
              icon: Icons.explore_outlined,
            )
          else ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selected.title,
                      softWrap: true,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(selected.description),
                    const SizedBox(height: 16),
                    Text(
                      '추천 학습 순서',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    for (var i = 0; i < selected.learningOrder.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
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
                            Expanded(child: Text(selected.learningOrder[i])),
                          ],
                        ),
                      ),
                    const SizedBox(height: 12),
                    Text(
                      '학습 팁',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 6),
                    for (final tip in selected.tips)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.lightbulb_outline,
                              color: AppColors.warm,
                            ),
                            const SizedBox(width: 8),
                            Expanded(child: Text(tip)),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('관련 사이트', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            if (relatedSites.isEmpty)
              EmptyState(
                title: '연결 사이트가 준비 중입니다',
                message:
                    '이 목표는 아직 전문 사이트가 연결되지 않았습니다. '
                    '학습 순서와 팁을 먼저 참고하고, 관련 기반 지식을 탐색해 보세요.',
                icon: Icons.hourglass_top,
              )
            else
              for (final site in relatedSites)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: KnowledgeSiteCard(
                    site: site,
                    categoryName: repo.categoryForSite(site).name,
                  ),
                ),
          ],
        ],
      ),
    );
  }
}

class _GoalTile extends StatelessWidget {
  const _GoalTile({
    required this.goal,
    required this.selected,
    required this.onTap,
  });

  final LearningGoal goal;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: goal.title,
      child: Material(
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
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: selected ? AppColors.teal : AppColors.border,
                width: selected ? 1.6 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(goal.icon, color: AppColors.navy),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    goal.title,
                    softWrap: true,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Icon(
                  selected ? Icons.check_circle : Icons.chevron_right,
                  color: selected ? AppColors.teal : AppColors.textMuted,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
