import '../models/knowledge_category.dart';
import '../models/knowledge_site.dart';
import '../models/search_result.dart';

/// Local metadata search without external APIs.
class SearchService {
  const SearchService();

  List<SearchResult> search({
    required String query,
    required List<KnowledgeSite> sites,
    required List<KnowledgeCategory> categories,
  }) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) {
      return const [];
    }

    final tokens = normalized
        .split(RegExp(r'\s+'))
        .where((token) => token.isNotEmpty)
        .toList();

    final categoryById = {
      for (final category in categories) category.id: category,
    };

    final results = <SearchResult>[];
    for (final site in sites) {
      final category = categoryById[site.categoryId];
      if (category == null) {
        continue;
      }

      final reasons = <String>[];
      var score = 0;

      void hit(String label, String value, int weight) {
        final lower = value.toLowerCase();
        for (final token in tokens) {
          if (lower.contains(token)) {
            score += weight;
            final reason = '$label 일치';
            if (!reasons.contains(reason)) {
              reasons.add(reason);
            }
          }
        }
      }

      hit('사이트명', site.name, 12);
      hit('사이트명', site.shortName, 10);
      hit('분야', category.name, 9);
      hit('설명', site.description, 6);
      hit('상세 설명', site.detailedDescription, 4);
      hit('난이도', site.difficulty.label, 3);
      hit('운영 상태', site.status.label, 2);

      for (final topic in site.topics) {
        hit('주요 주제', topic, 7);
      }
      for (final user in site.targetUsers) {
        hit('추천 대상', user, 6);
      }
      for (final keyword in site.keywords) {
        hit('키워드', keyword, 8);
      }
      for (final keyword in category.keywords) {
        hit('분야 키워드', keyword, 5);
      }

      if (score > 0) {
        results.add(
          SearchResult(
            site: site,
            category: category,
            reasons: reasons,
            score: score,
          ),
        );
      }
    }

    results.sort((a, b) {
      final byScore = b.score.compareTo(a.score);
      if (byScore != 0) {
        return byScore;
      }
      return a.site.sortOrder.compareTo(b.site.sortOrder);
    });
    return results;
  }
}
