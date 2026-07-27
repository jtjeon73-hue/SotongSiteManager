import 'package:flutter/material.dart';

import '../models/search_result.dart';
import '../theme/app_colors.dart';
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
  List<SearchResult> _results = const [];
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
      _results = repo.search(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasQuery = _query.trim().isNotEmpty;

    return PageContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: '통합 검색',
            subtitle: '외부 검색 API 없이 로컬 메타데이터로 사이트, 분야, 주제, 추천 대상, 키워드를 찾습니다.',
          ),
          TextField(
            controller: _controller,
            textInputAction: TextInputAction.search,
            onChanged: _runSearch,
            onSubmitted: _runSearch,
            decoration: const InputDecoration(
              hintText: '예: 전기, 자동차 점검, 생활영어, 투자, AI',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 18),
          if (!hasQuery)
            const EmptyState(
              title: '무엇을 찾고 계신가요?',
              message:
                  '사이트명(소통전기), 분야(금융·경제), 주제(프롬프트), '
                  '추천 대상(어르신), 키워드(배터리)처럼 자유롭게 입력해 보세요.',
              icon: Icons.manage_search,
            )
          else if (_results.isEmpty)
            EmptyState(
              title: '검색 결과가 없습니다',
              message:
                  '“$_query”와 일치하는 항목을 찾지 못했습니다. '
                  '다른 키워드를 쓰거나 학습 길잡이에서 목적별로 탐색해 보세요.',
              icon: Icons.search_off,
            )
          else ...[
            Text(
              '검색 결과 ${_results.length}건',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            for (final result in _results)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _SearchResultCard(result: result),
              ),
          ],
        ],
      ),
    );
  }
}

class _SearchResultCard extends StatelessWidget {
  const _SearchResultCard({required this.result});

  final SearchResult result;

  @override
  Widget build(BuildContext context) {
    final site = result.site;
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(site.name, softWrap: true, style: theme.textTheme.titleLarge),
            const SizedBox(height: 6),
            Text(site.description, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                StatusChip(
                  label: result.category.name,
                  color: AppColors.teal,
                  icon: Icons.category_outlined,
                ),
                StatusChip(label: site.status.label, color: AppColors.navySoft),
              ],
            ),
            const SizedBox(height: 12),
            Text('관련 이유', style: theme.textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(result.reasons.join(' · ')),
            const SizedBox(height: 14),
            if (site.isLive)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () =>
                      AppScope.linkServiceOf(context).openExternal(site.url),
                  icon: const Icon(Icons.open_in_new, size: 18),
                  label: const Text('사이트 방문'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
