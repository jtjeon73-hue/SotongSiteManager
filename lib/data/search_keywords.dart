/// Synonym and related-keyword expansion for local search.
abstract final class SearchKeywords {
  static const Map<String, List<String>> synonyms = {
    '돈': ['금융', '저축', '가계', '자산'],
    '재테크': ['금융', '투자', '저축'],
    '차': ['자동차', '정비', '차량'],
    '자동차': ['차', '정비', '경고등'],
    '농기계': ['자동차', '정비', '트랙터'],
    '인공지능': ['AI', '프롬프트', 'LLM'],
    'AI': ['인공지능', '프롬프트', '챗봇'],
    '챗gpt': ['AI', '프롬프트', '인공지능'],
    '영어회화': ['생활영어', '회화', '영어'],
    '생활영어': ['영어', '회화', '문장'],
    '전기기사': ['전기', '자격증', '필기', '실기'],
    '자격증': ['전기기사', '시험', '필기'],
    '감전': ['전기', '안전'],
    '투자': ['금융', '주식', '위험'],
    '세금': ['금융', '연말정산'],
    '프롬프트': ['AI', '질문'],
    '경고등': ['자동차', '점검'],
    '회화': ['영어', '대화'],
  };

  static const List<String> popularTopics = [
    'AI',
    '전기기사',
    '자동차 점검',
    '금융 기초',
    '생활영어',
    '프롬프트',
    '경고등',
    '저축',
  ];

  static const List<String> suggestedKeywords = [
    '인공지능',
    '돈',
    '차',
    '영어회화',
    '안전',
    '자격증',
    '세금',
    '농기계',
  ];

  /// Expand query tokens with synonym mappings.
  static Set<String> expandTokens(Iterable<String> tokens) {
    final expanded = <String>{};
    for (final token in tokens) {
      final lower = token.toLowerCase();
      expanded.add(lower);
      synonyms.forEach((key, values) {
        if (key.toLowerCase() == lower ||
            values.any((v) => v.toLowerCase() == lower)) {
          expanded.add(key.toLowerCase());
          for (final value in values) {
            expanded.add(value.toLowerCase());
          }
        }
      });
    }
    return expanded;
  }
}
