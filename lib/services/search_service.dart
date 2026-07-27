import '../data/search_keywords.dart';
import '../models/knowledge_category.dart';
import '../models/knowledge_path.dart';
import '../models/knowledge_site.dart';
import '../models/learning_goal.dart';
import '../models/search_result.dart';
import '../models/typed_search_result.dart';
import '../utils/app_routes.dart';

class SearchService {
  const SearchService();

  List<SearchResult> search({
    required String query,
    required List<KnowledgeSite> sites,
    required List<KnowledgeCategory> categories,
  }) {
    final typed = searchTyped(
      query: query,
      sites: sites,
      categories: categories,
      goals: const [],
      paths: const [],
    );
    final categoryById = {
      for (final category in categories) category.id: category,
    };
    return typed.where((item) => item.type == SearchResultType.hall).map((
      item,
    ) {
      final site = sites.firstWhere((s) => s.id == item.id);
      return SearchResult(
        site: site,
        category: categoryById[site.categoryId]!,
        reasons: item.reasons,
        score: item.score,
      );
    }).toList();
  }

  List<TypedSearchResult> searchTyped({
    required String query,
    required List<KnowledgeSite> sites,
    required List<KnowledgeCategory> categories,
    required List<LearningGoal> goals,
    required List<KnowledgePath> paths,
  }) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return const [];

    final rawTokens = normalized
        .split(RegExp(r'\s+'))
        .where((token) => token.isNotEmpty);
    final tokens = SearchKeywords.expandTokens(rawTokens);
    final results = <TypedSearchResult>[];

    for (final site in sites) {
      final reasons = <String>[];
      var score = 0;
      void hit(String label, String value, int weight) {
        final lower = value.toLowerCase();
        for (final token in tokens) {
          if (lower.contains(token)) {
            score += weight;
            final reason = '$label 일치';
            if (!reasons.contains(reason)) reasons.add(reason);
          }
        }
      }

      hit('사이트명', site.name, 12);
      hit('설명', site.description, 6);
      hit('상세', site.detailedDescription, 4);
      hit('핵심 질문', site.coreQuestion, 8);
      hit('가치', site.valueProposition, 6);
      hit('시작점', site.startPoint, 5);
      hit('활용', site.useCases.join(' '), 5);
      hit('주의', site.safetyNotice, 3);
      for (final topic in site.topics) {
        hit('주요 주제', topic, 7);
      }
      for (final user in site.targetUsers) {
        hit('추천 대상', user, 6);
      }
      for (final keyword in site.keywords) {
        hit('키워드', keyword, 8);
      }
      for (final menu in site.menuHighlights) {
        hit('메뉴', menu, 5);
      }
      if (score > 0) {
        results.add(
          TypedSearchResult(
            type: SearchResultType.hall,
            id: site.id,
            title: site.name,
            description: site.description,
            reasons: reasons,
            score: score,
            routePath: AppRoutes.siteDetail(site.routeSlug),
            siteId: site.id,
          ),
        );
      }
    }

    for (final category in categories) {
      final reasons = <String>[];
      var score = 0;
      void hit(String label, String value, int weight) {
        final lower = value.toLowerCase();
        for (final token in tokens) {
          if (lower.contains(token)) {
            score += weight;
            final reason = '$label 일치';
            if (!reasons.contains(reason)) reasons.add(reason);
          }
        }
      }

      hit('분야', category.name, 10);
      hit('설명', category.description, 5);
      hit('향후', category.futureDirection, 3);
      for (final keyword in category.keywords) {
        hit('분야 키워드', keyword, 7);
      }
      if (score > 0) {
        results.add(
          TypedSearchResult(
            type: SearchResultType.category,
            id: category.id,
            title: category.name,
            description: category.description,
            reasons: reasons,
            score: score,
            routePath: AppRoutes.categories,
          ),
        );
      }
    }

    for (final goal in goals) {
      final reasons = <String>[];
      var score = 0;
      void hit(String label, String value, int weight) {
        final lower = value.toLowerCase();
        for (final token in tokens) {
          if (lower.contains(token)) {
            score += weight;
            final reason = '$label 일치';
            if (!reasons.contains(reason)) reasons.add(reason);
          }
        }
      }

      hit('목적', goal.title, 10);
      hit('설명', goal.description, 5);
      for (final keyword in goal.keywords) {
        hit('목적 키워드', keyword, 7);
      }
      if (score > 0) {
        results.add(
          TypedSearchResult(
            type: SearchResultType.goal,
            id: goal.id,
            title: goal.title,
            description: goal.description,
            reasons: reasons,
            score: score,
            routePath: AppRoutes.learning,
          ),
        );
      }
    }

    for (final path in paths) {
      final reasons = <String>[];
      var score = 0;
      void hit(String label, String value, int weight) {
        final lower = value.toLowerCase();
        for (final token in tokens) {
          if (lower.contains(token)) {
            score += weight;
            final reason = '$label 일치';
            if (!reasons.contains(reason)) reasons.add(reason);
          }
        }
      }

      hit('코스', path.title, 11);
      hit('목적', path.purpose, 6);
      for (final keyword in path.keywords) {
        hit('코스 키워드', keyword, 7);
      }
      for (final step in path.steps) {
        hit('학습 단계', '${step.title} ${step.reason}', 4);
      }
      if (score > 0) {
        results.add(
          TypedSearchResult(
            type: SearchResultType.course,
            id: path.id,
            title: path.title,
            description: path.purpose,
            reasons: reasons,
            score: score,
            routePath: '${AppRoutes.learning}?course=${path.id}',
          ),
        );
      }
    }

    // Topic-level hits from site topics.
    for (final site in sites) {
      for (final topic in site.topics) {
        final lower = topic.toLowerCase();
        final matched = tokens.any(lower.contains);
        if (!matched) continue;
        results.add(
          TypedSearchResult(
            type: SearchResultType.topic,
            id: '${site.id}-$topic',
            title: topic,
            description: '${site.name}의 주요 주제',
            reasons: const ['주요 주제 일치'],
            score: 6,
            routePath: AppRoutes.siteDetail(site.routeSlug),
            siteId: site.id,
          ),
        );
      }
    }

    results.sort((a, b) {
      final byScore = b.score.compareTo(a.score);
      if (byScore != 0) return byScore;
      return a.title.compareTo(b.title);
    });
    return results;
  }
}
