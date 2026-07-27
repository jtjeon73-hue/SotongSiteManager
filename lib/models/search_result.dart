import 'knowledge_category.dart';
import 'knowledge_site.dart';

/// A local search hit with an explanation of relevance.
class SearchResult {
  const SearchResult({
    required this.site,
    required this.category,
    required this.reasons,
    required this.score,
  });

  final KnowledgeSite site;
  final KnowledgeCategory category;
  final List<String> reasons;
  final int score;
}
