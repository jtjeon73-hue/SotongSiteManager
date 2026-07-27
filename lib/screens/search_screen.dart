import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/content_status.dart';
import '../models/typed_search_result.dart';
import '../theme/app_colors.dart';
import '../utils/app_routes.dart';
import '../widgets/app_scope.dart';
import '../widgets/common_ui.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({this.initialQuery = '', super.key});

  final String initialQuery;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _controller;
  List<TypedSearchResult> _results = const [];
  String _query = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
    _query = widget.initialQuery;
    if (_query.trim().isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _runSearch(_query));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _runSearch(String value) {
    final repo = AppScope.repositoryOf(context);
    setState(() {
      _query = value;
      _results = repo.searchTyped(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final repo = AppScope.repositoryOf(context);
    final hasQuery = _query.trim().isNotEmpty;
    final grouped = <SearchResultType, List<TypedSearchResult>>{};
    for (final result in _results) {
      grouped.putIfAbsent(result.type, () => []).add(result);
    }

    return PageContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: '통합 검색',
            subtitle: '전문관·분야·학습 코스·추천 목적·주요 주제를 로컬 메타데이터와 동의어 매핑으로 찾습니다.',
          ),
          TextField(
            controller: _controller,
            textInputAction: TextInputAction.search,
            onChanged: _runSearch,
            onSubmitted: _runSearch,
            decoration: const InputDecoration(
              hintText: '예: 돈, 차, 인공지능, 영어회화, 전기기사',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 18),
          if (!hasQuery) ...[
            const EmptyState(
              title: '무엇을 찾고 계신가요?',
              message: '인기 주제나 추천 키워드로 빠르게 시작할 수 있습니다.',
              icon: Icons.manage_search,
            ),
            const SizedBox(height: 14),
            Text('인기 검색 주제', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final topic in repo.popularSearchTopics)
                  ActionChip(
                    label: Text(topic),
                    onPressed: () {
                      _controller.text = topic;
                      _runSearch(topic);
                    },
                  ),
              ],
            ),
            const SizedBox(height: 14),
            Text('추천 키워드', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final keyword in repo.suggestedSearchKeywords)
                  ActionChip(
                    label: Text(keyword),
                    onPressed: () {
                      _controller.text = keyword;
                      _runSearch(keyword);
                    },
                  ),
              ],
            ),
            const SizedBox(height: 14),
            Text('분야별 빠른 검색', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final category in repo.categories.where(
                  (c) => c.contentStatus == ContentStatus.live,
                ))
                  ActionChip(
                    label: Text(category.name),
                    onPressed: () {
                      _controller.text = category.name;
                      _runSearch(category.name);
                    },
                  ),
              ],
            ),
          ] else if (_results.isEmpty)
            EmptyState(
              title: '검색 결과가 없습니다',
              message:
                  '“$_query”와 일치하는 항목을 찾지 못했습니다. '
                  '비슷한 키워드를 쓰거나 분야를 둘러보세요. '
                  '앞으로 건강·PLC·스마트팜 등 분야도 계속 추가됩니다.',
              icon: Icons.search_off,
              action: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final keyword in repo.suggestedSearchKeywords.take(4))
                    ActionChip(
                      label: Text(keyword),
                      onPressed: () {
                        _controller.text = keyword;
                        _runSearch(keyword);
                      },
                    ),
                  OutlinedButton(
                    onPressed: () => context.go(AppRoutes.categories),
                    child: const Text('전체 분야 보기'),
                  ),
                ],
              ),
            )
          else ...[
            Text(
              '검색 결과 ${_results.length}건',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            for (final type in SearchResultType.values)
              if (grouped[type]?.isNotEmpty ?? false) ...[
                Text(type.label, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                for (final result in grouped[type]!)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _ResultCard(result: result),
                  ),
                const SizedBox(height: 8),
              ],
          ],
        ],
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.result});

  final TypedSearchResult result;

  @override
  Widget build(BuildContext context) {
    final repo = AppScope.repositoryOf(context);
    final site = result.siteId == null
        ? null
        : repo.findSiteById(result.siteId!);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatusChip(
              label: result.type.label,
              color: AppColors.teal,
              icon: Icons.label_outline,
            ),
            const SizedBox(height: 8),
            Text(
              result.title,
              softWrap: true,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 6),
            Text(result.description),
            const SizedBox(height: 8),
            Text('관련 이유: ${result.reasons.join(' · ')}'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (result.routePath != null)
                  ElevatedButton(
                    onPressed: () => context.go(result.routePath!),
                    child: const Text('이동'),
                  ),
                if (site != null && site.isLive)
                  OutlinedButton.icon(
                    onPressed: () =>
                        AppScope.linkServiceOf(context).openExternal(site.url),
                    icon: const Icon(Icons.open_in_new, size: 16),
                    label: const Text('사이트 방문'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
