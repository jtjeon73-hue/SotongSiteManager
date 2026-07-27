/// Typed local search hit for halls, categories, courses, goals, and topics.
enum SearchResultType {
  hall,
  category,
  course,
  goal,
  topic;

  String get label => switch (this) {
    SearchResultType.hall => '전문관',
    SearchResultType.category => '분야',
    SearchResultType.course => '학습 코스',
    SearchResultType.goal => '추천 목적',
    SearchResultType.topic => '주요 주제',
  };
}

class TypedSearchResult {
  const TypedSearchResult({
    required this.type,
    required this.id,
    required this.title,
    required this.description,
    required this.reasons,
    required this.score,
    this.routePath,
    this.siteId,
  });

  final SearchResultType type;
  final String id;
  final String title;
  final String description;
  final List<String> reasons;
  final int score;
  final String? routePath;
  final String? siteId;
}
