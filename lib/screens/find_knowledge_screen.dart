import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/recommendation.dart';
import '../theme/app_colors.dart';
import '../utils/app_routes.dart';
import '../widgets/app_scope.dart';
import '../widgets/common_ui.dart';

class FindKnowledgeScreen extends StatefulWidget {
  const FindKnowledgeScreen({super.key});

  @override
  State<FindKnowledgeScreen> createState() => _FindKnowledgeScreenState();
}

class _FindKnowledgeScreenState extends State<FindKnowledgeScreen> {
  int _step = 0;
  RecommendationPurpose? _purpose;
  RecommendationLevel? _level;
  RecommendationTime? _time;
  RecommendationResult? _result;

  void _reset() {
    setState(() {
      _step = 0;
      _purpose = null;
      _level = null;
      _time = null;
      _result = null;
    });
  }

  void _compute() {
    if (_purpose == null || _level == null || _time == null) return;
    final result = AppScope.repositoryOf(context).recommend(
      RecommendationProfile(
        purpose: _purpose!,
        level: _level!,
        timeBudget: _time!,
      ),
    );
    setState(() {
      _result = result;
      _step = 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: '내게 맞는 지식 찾기',
            subtitle:
                '관심 목적·현재 수준·학습 시간을 고르면, 규칙 기반으로 전문관과 시작점을 안내합니다. '
                '생성형 AI 분석이 아닙니다.',
          ),
          _Progress(step: _step),
          const SizedBox(height: 16),
          if (_step == 0) ...[
            Text('A. 관심 목적', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            for (final purpose in RecommendationPurpose.values)
              _ChoiceTile(
                label: purpose.label,
                selected: _purpose == purpose,
                onTap: () => setState(() {
                  _purpose = purpose;
                  _step = 1;
                }),
              ),
          ] else if (_step == 1) ...[
            Text('B. 현재 수준', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            for (final level in RecommendationLevel.values)
              _ChoiceTile(
                label: level.label,
                selected: _level == level,
                onTap: () => setState(() {
                  _level = level;
                  _step = 2;
                }),
              ),
            TextButton(
              onPressed: () => setState(() => _step = 0),
              child: const Text('이전'),
            ),
          ] else if (_step == 2) ...[
            Text(
              'C. 사용할 수 있는 시간',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            for (final time in RecommendationTime.values)
              _ChoiceTile(
                label: time.label,
                selected: _time == time,
                onTap: () {
                  setState(() => _time = time);
                  _compute();
                },
              ),
            TextButton(
              onPressed: () => setState(() => _step = 1),
              child: const Text('이전'),
            ),
          ] else if (_result != null)
            _ResultView(result: _result!, onReset: _reset),
        ],
      ),
    );
  }
}

class _Progress extends StatelessWidget {
  const _Progress({required this.step});

  final int step;

  @override
  Widget build(BuildContext context) {
    final labels = ['목적', '수준', '시간', '결과'];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (var i = 0; i < labels.length; i++)
          StatusChip(
            label: '${i + 1}. ${labels[i]}',
            color: i <= step ? AppColors.teal : AppColors.planned,
            icon: i < step ? Icons.check : Icons.circle_outlined,
          ),
      ],
    );
  }
}

class _ChoiceTile extends StatelessWidget {
  const _ChoiceTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: selected
            ? AppColors.teal.withValues(alpha: 0.12)
            : AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 52),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: selected ? AppColors.teal : AppColors.border,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label,
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

class _ResultView extends StatelessWidget {
  const _ResultView({required this.result, required this.onReset});

  final RecommendationResult result;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final repo = AppScope.repositoryOf(context);
    final site = repo.findSiteById(result.primarySiteId);
    final next = result.nextSiteId == null
        ? null
        : repo.findSiteById(result.nextSiteId!);
    final path = result.pathId == null
        ? null
        : repo.findPathById(result.pathId!);

    if (site == null) {
      return const EmptyState(
        title: '추천 결과를 표시할 수 없습니다',
        message: '데이터 구성을 확인해 주세요.',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '가장 잘 맞는 전문관',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  site.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(site.valueProposition),
                const SizedBox(height: 14),
                Text('추천 이유', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                for (final reason in result.reasons)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text('· $reason'),
                  ),
                const SizedBox(height: 10),
                Text(
                  '첫 번째로 볼 내용',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(result.firstFocus),
                const SizedBox(height: 8),
                Text(
                  '두 번째 학습 단계',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(result.secondFocus),
                if (next != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    '다음에 연결할 전문관',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(next.name),
                ],
                if (path != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    '추천 학습 코스',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(path.title),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => context.go(AppRoutes.siteDetail(site.routeSlug)),
            child: const Text('전문관 미리보기'),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () =>
                AppScope.linkServiceOf(context).openExternal(site.url),
            icon: const Icon(Icons.open_in_new),
            label: const Text('실제 사이트 방문'),
          ),
        ),
        if (path != null) ...[
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () =>
                  context.go('${AppRoutes.learning}?course=${path.id}'),
              child: const Text('관련 학습 코스 보기'),
            ),
          ),
        ],
        TextButton(onPressed: onReset, child: const Text('다시 선택하기')),
      ],
    );
  }
}
